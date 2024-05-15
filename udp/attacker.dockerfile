FROM redis:latest

RUN apt-get update && \
    apt-get install -y ruby && \
    gem install redis  && \
    gem install beanstalk-client && \
    gem install pry

# Set the working directory
WORKDIR /app

# Copy your Ruby script into the container
COPY attacker_script.rb /app/attacker_script.rb

# Command to run the attacker script
CMD ["ruby", "attacker_script.rb"]
