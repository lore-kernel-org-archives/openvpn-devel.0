From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2004.12.20.13.43.43.545991@...294...>
References: <000f01c4e62e$4e5eb450$0200080a@...333...> <200412201123.57124@...187...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: openvpn server in client-to-client mode
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
Date: Mon Dec 20 05:56:01 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Mon, 20 Dec 2004 11:23:56 +0200, Doncho N. Gunchev wrote:

>     How from userspace you are going to access tap/tun device and insert
> IP/Ethernet packets?

He's not going to insert IP or ethernet packets at all -- he's only doing
client-to-client relaying, and so just using regular sockets will do. In
short, the host running a VPN is not in this instance an endpoint for the
VPN -- the only endpoints are the clients.

(I had a discussion w/ him about this on IRC before he posted to the list).


