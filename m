Message-ID: <ee2671e605020907063b5d4138@...278...>
From: Prem Kumar J <premkumarjayaram@...277...>
Reply-To: Prem Kumar J <premkumarjayaram@...277...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Openvpn 2.0 TAP installation on WindowsXP
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb  9 07:07:34 2005
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello Group,

I recently downloaded the OpenVPN 2.0 from the openvpn site and I
wanted to setup a TAP device in multi-client fashion on a Windows XP
box with SP2. As mentioned in the openvpn site, I selected the tap
interface ( tap0 ) and the ethernet adaptor and bridged it. Also, I
assigned the IP address and subnet of the ethernet adaptor to the
bidge interface.

Now, if I connect more than one client to the server I get connection
reset problem in few seconds just after the connection is extablished.
I took the sample conf files from the sample-config-files folder.

server TAP conf file:

port 1194
proto tcp
dev tap
ca sample-keys/tmp-ca.crt
cert sample-keys/server.crt
key sample-keys/server.key  
dh sample-keys/dh1024.pem
server-bridge 192.168.1.241 255.255.255.0 192.168.1.50 192.168.1.100
duplicate-cn

client conf file:

client
dev tap
proto tcp
remote 192.168.1.241 1194
ca sample-keys/tmp-ca.crt
cert sample-keys/client.crt
key sample-keys/client.key

In the above case 192.168.1.241 is the XP machine on which the TAP
server is installed.

Also, I tried to create more TAP adapters and created a bridge
assuming that openvpn might require a pool of ceated TAP adapters.
Even in this case I got "connection reset problem" just few minutes
after the client gets connected the server.

Am I missing any important setting in the conf file ?

Thanks in advance
-Prem

