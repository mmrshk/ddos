## Examine all 6 types of DDOS attacks

### UPD Flood
A UDP flood attack is a type of Denial of Service (DoS) attack where an attacker floods a target system with a large volume of User Datagram Protocol (UDP) packets. 
UDP is a connectionless protocol commonly used for lightweight and fast communication, such as DNS (Domain Name System) queries and video streaming.

Start containers: defender and attacker. Attacker sends UDP packets to defender. 
Defender uses tcpdump to monitor incoming UDP packets. Defender uses iptables to limit the number of UDP packets.

```console
cd udp
./run_and_monitor.sh
```

Add iptables rules to limit the number of UDP packets.
```
# Allow limited UDP packets to prevent flooding
sudo iptables -A INPUT -p udp -m limit --limit 1/s --limit-burst 10 -j ACCEPT

# Drop excessive UDP packets
sudo iptables -A INPUT -p udp -j DROP
```

### ICMP Flood
An ICMP flood attack is a type of Denial of Service (DoS) attack where an attacker overwhelms a target system with a large volume of Internet Control Message Protocol (ICMP) packets. 
ICMP is commonly used for diagnostic and control purposes in network communication.

In this scenario we will examine Ping Flood attack.
Ping Flood (ICMP Echo Request Flood): The attacker sends a flood of ICMP echo request (ping) packets to the victim's IP address. 
The victim's system responds to each ICMP echo request with an ICMP echo reply, leading to resource exhaustion.

```console
cd icmp
./run_and_monitor.sh
```

#### Monitor incoming ICMP packets
```
docker exec -it defender bash
tcpdump -i eth0

sudo iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 10/second -j ACCEPT
sudo iptables -A INPUT -p icmp -j DROP

sudo iptables -L -v -n
```

### HTTP Flood
An HTTP flood attack is a type of Denial of Service (DoS) or Distributed Denial of Service (DDoS) attack where an attacker floods a web server with a large volume of HTTP requests, overwhelming its resources and making it unavailable to legitimate users. 
This type of attack aims to exhaust the server's CPU, memory, and network bandwidth, thereby disrupting its ability to handle legitimate requests.

```console
cd http_flood
./run_and_monitor.sh
```

In this attack we will defend using Nginx rate limiting.
```
docker exec -it defender bash
tcpdump -i eth0 tcp port 80
```
![Screenshot 2024-05-19 at 13.28.29.png](..%2F..%2F..%2FDesktop%2FScreenshot%202024-05-19%20at%2013.28.29.png)

Analysis and Conclusion
The repeated SYN packets from the client followed by RST packets from the server indicate that the server is refusing new connections. 
This behavior aligns with Nginx’s rate limiting, which is configured to reject requests exceeding the defined rate limit. 

Here’s why:
- Rate Limiting in Action: Nginx rate limiting causes the server to refuse connections once the rate limit is exceeded, resulting in TCP reset packets (RST). 
- Status Code 503: If Nginx is configured to return a 503 status code for rate-limited requests, you would see these in the HTTP responses. However, since we are seeing TCP resets, it suggests that Nginx might be outright refusing connections at the TCP level, not even allowing HTTP processing to occur.

### Slowloris
A Slowloris attack is a type of Denial-of-Service (DoS) attack that attempts to keep many connections to the target web server open and hold them open as long as possible. It does this by sending partial HTTP requests, none of which are ever completed, thus tying up the server's resources.

```console
cd http_flood
./run_and_monitor.sh
```

```
docker exec -it defender bash
tcpdump -i eth0 tcp port 80
```

### SYN Flood
A SYN flood attack is a type of Denial-of-Service (DoS) attack where an attacker sends a succession of SYN requests to a target's system in an attempt to consume enough server resources to make the system unresponsive to legitimate traffic.


```console
cd syn
./run_and_monitor.sh
```

```
docker exec -it defender bash
iptables -A INPUT -p tcp --syn --dport 80 -m connlimit --connlimit-above 10 -j DROP
tcpdump -i eth0 tcp port 80
```

### Ping of Death
The Ping of Death is a type of Denial-of-Service (DoS) attack where an attacker sends malformed or oversized ping packets to a target. This can cause the target system to crash, freeze, or reboot. Modern systems are generally protected against such attacks, but it's useful to know how to simulate and protect against it for educational and testing purposes.

```console
cd syn
./run_and_monitor.sh
```

```
docker exec -it defender bash
iptables -A INPUT -p icmp --icmp-type echo-request -m length --length 1281:65535 -j DROP
```
