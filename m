From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Source IP for UDP connection left to ipstack
 which is wrong
In-Reply-To: <pae1h1lobr0ltvk3usckkeqg1rqvd17tt6@...105...>
Message-ID: <Pine.LNX.4.58.0508281047001.25011@...41...>
References: <pae1h1lobr0ltvk3usckkeqg1rqvd17tt6@...105...>
MIME-Version: 1.0
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
Date: Mon Aug 29 08:50:11 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Arkadiusz Patyk <areq@...104...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 27 Aug 2005, Arkadiusz Patyk wrote:

> Hi
> 
> I have the same problem as was descriptions
> http://sourceforge.net/tracker/index.php?func=detail&aid=1253117&group_id=48978&atid=454719
> 
> Where can I find this patch ?
> Please  merge this patch in next release - it's necessary.

http://openvpn.net/patch/openvpn-2.0_rc16MH.patch

Other than a couple trivial conflicts in ChangeLog and configure.ac, it 
merges fine with 2.0.2.

Note that the standard Berkeley Sockets API doesn't support getting the
dest address on received UDP packets or setting the source address on
outgoing UDP packets, functionality which is necessary for UDP multihoming
to work correctly, so this patch currently uses some nonportable
Linux-only syscalls.

James

> BTW:
> 
> In 2.x wishlist http://openvpn.net/wiki/OpenVPN_2.x_wishlist
> I found:
> #  Server support to listen on TCP/UDP simultaneously
> # Client support for multiple --remote directives to specify TCP or
> UDP usage
> 
> It's cool features - I'am waiting for it a long time ;)

It's a high priority for 2.1.

James


