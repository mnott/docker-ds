# We will use Ubuntu for our image
FROM ubuntu:latest

# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade
RUN apt-get install -y emacs

# Adding wget and bzip2
RUN apt-get install -y wget bzip2

# Adding environment variables for TZ
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add sudo
RUN apt-get -y install sudo

# Add user ubuntu with no password, add to sudo group
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu/
RUN chmod a+rwx /home/ubuntu/
#RUN echo `pwd`

# Anaconda installing
RUN wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
RUN bash Anaconda3-5.0.1-Linux-x86_64.sh -b
RUN rm Anaconda3-5.0.1-Linux-x86_64.sh

# Set path to conda
#ENV PATH /root/anaconda3/bin:$PATH
ENV PATH /home/ubuntu/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all
RUN conda config --add channels r
RUN conda install --yes r-irkernel


# Configuring access to Jupyter
RUN mkdir /home/ubuntu/notebooks
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py

# Add conda and nbextensions to jupyter
RUN pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user
RUN conda install -c anaconda-nb-extensions nb_conda
# Creating this environment to avoid errors in the jupyter nb frontent
RUN conda create -n anaconda3

# Create a deep learning environment
RUN conda create -y -q --json -n deeplearning python=3 ipykernel
RUN echo ". ~/anaconda/etc/profile.d/conda.sh" >> ~/.bash_profile
RUN [ "/bin/bash", "-c", "source activate deeplearning && conda install keras && conda deactivate" ]
RUN echo "conda init bash" > ~/.bashrc
RUN tail +2 ~/.bashrc > ~/.bashrc2 && mv ~/.bashrc2 ~/.bashrc

# Jupyter listens port: 8888
EXPOSE 8888

# We create a second port for testing purposes
EXPOSE 8889

# Install LaTeX
RUN sudo apt-get -y install texlive-xetex

# Run Jupytewr notebook as Docker main process
# jupyter notebook --allow-root --notebook-dir=/home/ubuntu/notebooks --ip='0.0.0.0' --port=8888 --no-browser
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/home/ubuntu/notebooks", "--ip='0.0.0.0'", "--port=8888", "--no-browser"]
