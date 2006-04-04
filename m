From: Tony <kb2wjw@...277...>
Message-ID: <op.s7h42xkrioehzu@...596...>
Mime-Version: 1.0
Subject: [Openvpn-devel] A configuration improvement suggestion: to use "port/protocol" pair
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
Date: Tue Apr  4 14:22:01 2006
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I'm trying to create one "client.ovpn" file for all networking situations.
This is because I run OpenVPN on winXP-SP2 as non-admin user.

# Are we connecting to a TCP or
# UDP server?  Use the same setting as
# on the server.
;proto tcp
proto udp

# The hostname/IP and port of the server.
# You can have multiple remote entries
# to load balance between the servers.
remote my.server.net 1194
remote server 11194
remote my.server.net 443

With this (current) scheme I have to use "runas" to edit "client.ovpn" on  
the fly to switch from UDP to TCP.

What about making it this way:

# The hostname/IP and port of the server.
# You can have multiple remote entries
# to load balance between the servers.
remote my.server.net 1194/udp
remote server 11194/udp
remote my.server.net 443/tcp

Then, if server has three instances of corresponding configs - it would be  
possible to avoid editing client's configs.

My goal is to penetrate tightly filtered perimeters where only proxyed  
HTTP and HTTPS are allowed.

Please comment.

Tony.


