# Notes

## Security

* ACL's 
* Endpoints privados de S3 e Dynamo ( latência, custo de transfer )
* VPC Flow Logs (Cloud Watch ou Elasticsearch + Kibana)
* CDE (Auditoria)
* VPC Peering 
* IPSec + VPN
* CIDR customizado
* WAF e Shield

## Performance e Disponibilidade
* Network Performance 
* Internal ELB (Crons)
* Enhanced Networking 
* SSL Offload
* DNS Failover no Route53
* Round Robin no Route53 * 

## Billing
* Transfer Out
* Instance 

## Best Pratices
* Bloquear a Main Route Table
* Considerar crescimento da região 
* CIDR Blocks não podem ser modigicados 
* Migrar os ELB para ALB (WAF + Shield)
* Black Friday (Avisar AWS antes pra fazer pré-warming)

## Planning 
* Multi-AZ
* Controle Granular de VPC
* Criar NACL (Processadas Top Down) 
* Tags em tudo 
* VPC Peering Connection entre Regiões
* Database MIgration Service - (Migrar da DMZ pra VPC)
* Healthcheck do Route 53





