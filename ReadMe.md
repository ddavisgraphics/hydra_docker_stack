# Configure Solr / Blacklight / Fedora 

Use the internal IP to get to each resource or the firewalls on the system will block you from the ports, at least locally.  These can be configured out and changed on the host machines.  

## SOLR IP

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' solr 

## FEDORA IP 

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' fedora


# Docker Containers Networking for Fedora and Solr 

By default Docker containers can make connections to the outside world, but the outside world cannot connect to containers. Each outgoing connection will appear to originate from one of the host machine’s own IP addresses thanks to an iptables masquerading rule on the host machine that the Docker server creates when it starts:

https://docs.docker.com/engine/userguide/networking/default_network/binding/


# Limiting to 1 hydra project 

This is done by customizing your search builder.  In the search_builder.rb file, add a method that takes the parameter of solr_params.  

```
  # looks for the project identifier and sets it to holt only 
  # helps to establish that only holt records will be coming form fedora and solr 
  def show_only_holt_records (solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << 'project_sim:holt'
  end


  ## DOCUMENTATION OF CUSTOM SOLR CHAIN
  # =====================================================================
  # @example Adding a new step to the processor chain
  #   self.default_processor_chain += [:add_custom_data_to_query]
  #
  #   def add_custom_data_to_query(solr_parameters)
  #     solr_parameters[:custom] = blacklight_params[:user_value]
  #   end
```

EX:: 