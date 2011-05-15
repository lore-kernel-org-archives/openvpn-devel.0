Date: Sun, 15 May 2011 16:25:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110515142529.GR8496@...1296...>
References: <4DC936F3.6000509@...1458...> <4DC93E4C.5070606@...1147...>
	<20110510133830.GD8496@...1296...> <4DC94132.1040302@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eUJndGal4TJgqj0h"
Content-Disposition: inline
In-Reply-To: <4DC94132.1040302@...1147...>
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

--eUJndGal4TJgqj0h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 10, 2011 at 03:44:18PM +0200, Jan Just Keijser wrote:
> > Without "store=3Dactive", address assignment is "sticky" and will even
> > survive reboots - thus making the next tunnel setup fail, because the
> > address is already there.  On WinXP, that was not needed, but Win7 seems
> > to have changed the default.
> >=20=20=20
> but then why not use
>   add address <> store=3Dactive
> ? why switch to "set address" ? what's the difference?

Sorry for taking a while to come back to this.  I needed to re-read
the Windows reference docs to be sure.

I originally had "add address" there because that's what I tried and what
worked - and that's sort of based on "ip -6 addr add" thinking in the
back of my head, where there is basically only "add" and "delete" (and
"replace a *given* address").

OTOH, what I really want here is "whatever is on the interface, make it
go away and use only the address that I'm telling you to use!", and
that's "netsh interface ipv6 *set*"...

Reference is here:
  http://technet.microsoft.com/en-us/library/cc740203%28WS.10%29.aspx#BKMK_=
20


So, strictly speaking, the change "add" -> "set" is not required to make
it work on Win7, it actually better fits what the code is trying to do.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--eUJndGal4TJgqj0h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTc/iWakuBuNlUUl1AQJTfgP/UFr9ddkvlsds7bogCm+FSED5Y764Q6xe
2PSFP1tlGWWzlsO6owflCh6XqACDuUSiCSfivDINV/ZeSX0Ah/kNHexdNOsVr/1f
M8uzf/ucqLEaOvflMB43HQ4ttQrNE0yxhI7x9Is2ZqUjxf/mOPTrJBF9o9TojBVt
Zn6Xo499CiE=
=9k7Q
-----END PGP SIGNATURE-----

--eUJndGal4TJgqj0h--

