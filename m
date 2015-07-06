MIME-Version: 1.0
Date: Mon, 6 Jul 2015 18:01:25 +0530
Message-ID: <CANXi7D3zhBEs8horYZ8XQC6vWb+dTbY0dECu6i1NaA9hZ9Yo_w@...278...>
From: Arun Kumar <mailinform@...277...>
Subject: [Openvpn-devel] how to send real packets via openvpn tunnel.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,
i am new to openvpn.

i created tap tunnel between two hosts, both host have br0 which eth0 attached,
br0 has the IP address.
I attached the tap0 to br0 as given in example.
when i ping client machine to server br0 (192.168.18.110), the ping is going.
Client br0 IP address is 192.168.18.75.

Is the ping going via openvpn tunnel.
Because if i stop openvpn also ping is going.
Tap interfaces not have any IP address.
Is my setup correct?.

My client file is,
### Client configuration file for OpenVPN

# Specify that this is a client
client

# Bridge device setting
dev tap0
proto tcp
# Host name and port for the server (default port is 1194)
# note: replace with the correct values your server set up
remote 192.168.18.110 1194

# Client does not need to bind to a specific local port
nobind

# Keep trying to resolve the host name of OpenVPN server.
## The windows GUI seems to dislike the following rule.
##You may need to comment it out.
resolv-retry infinite

# Preserve state across restarts
persist-key
persist-tun

# SSL/TLS parameters - files created previously
ca ca.crt
cert client1.crt
key client1.key
#secret static.key
# Since we specified the tls-auth for server, we need it for the client
# note: 0 = server, 1 = client
tls-auth /etc/openvpn/ta.key 1

ns-cert-type server
# Specify same cipher as server
cipher BF-CBC
#--duplicate-cn
# Use compression
#comp-lzo

# Log verbosity (to help if there are problems)
verb 3


If I want to send from external host via client machine, which routing
address do I needs to give ,
Is it client br0 address?.
Please help me on this.

Thanks,

Kumar Raj

