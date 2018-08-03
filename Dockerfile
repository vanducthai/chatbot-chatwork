FROM orlandohohmeier/local-npm
RUN apt install -y curl
COPY ./ /code 
WORKDIR /code 
CMD ["./run.sh"]
