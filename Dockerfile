FROM mkenney/npm
COPY ./ /code 
WORKDIR /code 
CMD ["./run.sh"]
