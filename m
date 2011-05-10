Date: Tue, 10 May 2011 15:38:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110510133830.GD8496@...1296...>
References: <4DC936F3.6000509@...1458...> <4DC93E4C.5070606@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UdiMmEj9EzJj2jSc"
Content-Disposition: inline
In-Reply-To: <4DC93E4C.5070606@...1147...>
Subject: Re: [Openvpn-devel] Fwd: OpenVPN netsh.exe patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--UdiMmEj9EzJj2jSc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 10, 2011 at 03:31:56PM +0200, Jan Just Keijser wrote:
> Seth Mos wrote:
> > Here is the tun.c patch for correction of the netsh.exe commands.
> >
> > I've confirmed that the patch works on Windows XP SP2 and Windows 7.
> >
> > Patch!
> > http://iserv.nl/files/pfsense/0001-Change-the-netsh.exe-command-from-ad=
d-to-set-.-Th.patch
>=20
> please explain the rationale behind this patch: is something wrong when
> using 'ipv6 add address' ?=20

Without "store=3Dactive", address assignment is "sticky" and will even
survive reboots - thus making the next tunnel setup fail, because the
address is already there.  On WinXP, that was not needed, but Win7 seems
to have changed the default.

> why is the patch applied only for IPv6 addresses?

OpenVPN by default doesn't use netsh to configure IPv4 - so it might be
necessary there as well, but didn't show up yet.  For IPv6, there is only
a single method of configuration - netsh - and that breaks on Win7=20
otherwise.

I have not yet tested this, but Seth has, both on XP and Win7, so "ACK!"...

David: I think it's easiest in this case if I integrate it, and then send
it to you.  It needs to go to my "based on 2.2" branch as well.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UdiMmEj9EzJj2jSc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTck/1qkuBuNlUUl1AQJSVwQAg3pfGqJRHztjZSdosG8SThTDhlvogO/z
qeDeuRJoDzwNrUJiZVJY6dJrBxMsGT53TAl3VlhtL7u+ILFoNAI30Iu9L0mxx4nK
LLFzGJjkEdHvfksUSIygfWM0n+ci7gX2/K5UTayIk3loYrI6shsRq1wFzaLSOKMj
lpN67RpmyU4=
=ZITT
-----END PGP SIGNATURE-----

--UdiMmEj9EzJj2jSc--

