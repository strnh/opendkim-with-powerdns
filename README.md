PowerDNS does not allow TXT records to be represented as multiple lines. Editing when generating keys for multiple subdomains can be tedious, so I wrote code that uses a simple filter to change the TXT record created for ISC-BIND into a format readable by PowerDNS and save it.

# 2024/08/25 revise for Single-Domain 
# 2024/08/26 Refine for TXT RR for powerdns 
