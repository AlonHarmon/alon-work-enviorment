FROM rust:buster

WORKDIR /home


RUN apt update
RUN apt install -y git python3-pip curl


# install rust
#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
RUN rustup update


# install helix
RUN git clone https://github.com/helix-editor/helix

RUN cargo install --path /home/helix/helix-term
RUN mkdir ~/.config
RUN mkdir  ~/.config/helix
RUN ln -s /home/helix/runtime ~/.config/helix/runtime

COPY helix ~/.config/helix/

# install lap servers 
RUN pip3 install "python-lsp-server[all]"

# install wanted apt packages

COPY apt-packages.txt apt-packages.txt
RUN xargs apt install -y < apt-packages.txt