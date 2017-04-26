# Configure Solr / Blacklight / Fedora 

Use the internal IP to get to each resource or the firewalls on the system will block you from the ports, at least locally.  These can be configured out and changed on the host machines.  

## SOLR IP
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' solr 

## FEDORA IP 
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' fedora
