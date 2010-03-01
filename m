Date: Sun, 28 Feb 2010 22:13:10 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100228145001.GM9556@...1296...> (from
	gert@...1296... on Sun Feb 28 08:50:01 2010)
Message-Id: <1267416790.30675.3@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] special-case code for OpenBSD - advice needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/28/2010 08:50:01 AM, Gert Doering wrote:
> Hi,
>=20
> while working on "make IPv6 payload work on Win32", I found something
> quite peculiar for OpenBSD in the OpenVPN code.


>=20
> Now, for all operatings systems *except* Win32 and OpenBSD, the
> sequence
> of execution is
>=20
>  open_tun()
>  do_ifconfig()
>=20
> and for the named two systems, it's=20
>=20
>  do_ifconfig()
>  open_tun()


> Question #1: why is OpenBSD treated differently?  Does anyone on this
> list=20
> know why this is so, and whether it needs to be kept that way?  (I
> have no=20
> OpenBSD system to test on, right now).

Random comments....

On OpenBSD 4.6 stable "man 4 tun" says:


     A tun interface can be created at runtime using the ifconfig tunN=20
create
     command or by opening the character special device /dev/tunN.

     Both layer 3 and layer 2 tunneling is supported.  Layer 3=20
tunneling is
     the default mode; to enable layer 2 tunneling mode the link0 flag=20
needs
     to be set with ifconfig(8), or by setting up a hostname.if(5)=20
configura-
     tion file for netstart(8).  In layer 2 mode the tun interface is=20
simulat-
     ing an Ethernet network interface.


So, you should not need to do the ifconfig at all unless you're
interested in tap functionality or there's other odd
frobbing going on.

I can't speak for older releases but all the old man pages are
on the OpenBSD.org site.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


