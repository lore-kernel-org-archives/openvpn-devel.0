Message-ID: <a6d145b20803201756v39c5045ai3f5febbc06a39fd@...278...>
Date: Fri, 21 Mar 2008 01:56:22 +0100
From: "Marcus geepunkt" <adesperateuser@...1030...>
In-Reply-To: <47E279C9.9060208@...1030...>
MIME-Version: 1.0
References: <47E279C9.9060208@...1030...>
Subject: Re: [Openvpn-devel] Unwanted behavior with "remote random" and
	"retry infinite" on 2.1rc7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

I'm sorry, i just forgot a "-" between "remote" and "random". Now it
seems to choose another server after a connection-breakdown, but well,
the tun/tap-interface doesn't set the correct default gateway on the
new connection. I'll do a little more research on this on the net.

Greetz,
 Marcus

---
Fri Mar 21 01:50:57 2008 us=437000 TEST ROUTES: 0/0 succeeded len=0
ret=0 a=0 u/d=down
Fri Mar 21 01:50:57 2008 us=437000 Route: Waiting for TUN/TAP
interface to come up...
Fri Mar 21 01:50:58 2008 us=609000 TEST ROUTES: 0/0 succeeded len=0
ret=0 a=0 u/d=down
Fri Mar 21 01:50:58 2008 us=609000 Route: Waiting for TUN/TAP
interface to come up...
Fri Mar 21 01:50:59 2008 us=781000 TEST ROUTES: 0/0 succeeded len=0
ret=0 a=0 u/d=down
Fri Mar 21 01:50:59 2008 us=781000 Route: Waiting for TUN/TAP
interface to come up...

