From: "James Yonan" <jim@...41...>
Message-ID: <twig.1066851217.87227@...41...>
In-Reply-To: <E1ACHzt-00089A-L1@...110...>
References: <twig.1066764048.56467@...41...>
Subject: [Openvpn-devel] RE: [Openvpn-users] connecting to multiple servers
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 22 12:57:03 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: peter@...115..., openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

Peter Sandström <peter@...115...> said:

> I'm currently working on this, but as James says. This patch will be
> far to intrusive to be merged into 1.5 this late.
> The entire socketlayer needs to be ripped out and redone since alot
> of the current code assumes that there is always exactly one local
> and one remote address. Also there needs to be some kind of funky
> autolearning iprouting in order for it to work properly (working like
> a switch instead of a hub for those that want it in ethernet lingo).

I'm not sure that you need to rip out a lot of code to make this work.  The
socket layer does assume one local and one remote address, but this provides a
benefit in terms of making the code easy to understand and debug.

I would leave this code as it is, and do the following:

(1) Write code (which executes as a separate thread or process) which
implements a port multiplexing proxy.

(2) Write code (also as a separate thread) which implements a tun/tap sharing
proxy.

(3) Modify the socket code so that rather than doing connect(), bind(),
recvfrom(), sendto(), etc., it forwards these requests to the (1) proxy using
some kind of RPC-like mechanism.

(4) Modify the tun/tap code so that rather than
opening/reading/writing/closing the tun/tap file handle directly, it forwards
these requests to the (2) proxy.

This would give us UDP port and tun/tap multiplexing capability without
needing significant structural changes to the existing OpenVPN code.

James


