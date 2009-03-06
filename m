Message-Id: <6.2.5.6.2.20090306024021.01d35ac8@...1200...>
Date: Fri, 06 Mar 2009 02:40:29 -0500
From: starlight@...1200...
Mime-Version: 1.0
Subject: [Openvpn-devel] https proxy blocking OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

Have a working Openvpn setup as a TCP server on port 443.  From 
one particular location everything works great through what 
appears to be a typial firewall--no proxy configuration 
statements are used.  Server is Openwrt running 2.0.8.1 and 
client is Windows 2.0.9.

At another location they have a web proxy and it rejects the 
Openvpn connection requests.  However IE successfully completes a 
connection, though the Openvpn server side of course then
rejects it.

Captured both with Wireshark and it looks like IE presents a TLS 
v3 handshake after the proxy commands.  However Openvpn sends a 
packet Wireshark describes as SSL, though it's not clear what 
type of SSL packet it actually is.  Clearly different than the IE 
TLS handshake though.

Is this a known issue?  If so will it be addressed?  If not does 
anyone have any helpful advice?

Can provide traces if they are of interest.

Thank you.

-----

dev tun

http-proxy 10.37.104.18 8080
http-proxy-option AGENT "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 Firefox/2.0.0.16"

remote 10.95.187.106
rport 443

pull

proto tcp-client

tls-client
ca cacert.pem
cert FLM_geileis_cert.pem
key FLM_geileis_cert_key.pem
ns-cert-type server


