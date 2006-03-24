From: Neal Becker <ndbecker2@...277...>
Message-ID: <e00pmm$tm3$1@...165...>
Mime-Version: 1.0
Subject: [Openvpn-devel] keepalive not working?
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
Date: Fri Mar 24 04:53:14 2006
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I am using:

keepalive 10 60
resolv-retry infinite

Yet, frequently the connection dies, and is not reestablished until I
manually restart the client (udp client/server).

The server is on dhcp and does change ip - I don't know if this is part of
the problem - but shouldn't the client keep trying to re-resolve the name
and restart the connection?  It doesn't seem to.

This is :
openvpn-2.1-0.7.beta11.fc5


