FROM orlandohohmeier/local-npm
COPY ./ /code 
WORKDIR /code 
CMD ["./run.sh"]
