Date: Mon, 14 May 2012 09:47:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120514074729.GS1359@...1296...>
References: <4FB031B7.5010704@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vlv6EAyWma1guiG0"
Content-Disposition: inline
In-Reply-To: <4FB031B7.5010704@...1227...>
Subject: Re: [Openvpn-devel] Disable tun-ipv6 warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Vlv6EAyWma1guiG0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 14, 2012 at 12:12:07AM +0200, Arne Schwabe wrote:
> Openvpn will show the following warning, if I enable tun-ipv6 in the
> local config and not remote or vice versa:
>=20
> WARNING: 'tun-ipv6' is present in remote config but missing in local
> config, remote=3D'tun-ipv6'

If I remember correctly, if tun-ipv6 is not enabled on the client side,
the client will ignore pushed ipv6 ifconfig + routes.=20

So maybe the warning should not be tied to "tun-ipv6 is configured" but=20
to "the server pushed something that the local config will auto-ignore".

(Right now the warning is coming from the generic "compare the client
and server side config, and warn about differences" code - where it
might make sense to exclude this option, and add a specific warning
for those cases where it might cause surprises - namely: server with
IPv6, server pushing IPv6 options, client without tun-ipv6)

> >From my understanding a ipv6 capable tun interface is always capable of
> ipv4 only.=20

Yes.  On some systems, extra work is needed to make the tun interface
handle IPv6 as well, and that's triggered by tun-ipv6 - but IPv4 will
always work.

> Even without explicitly stating "tun-ipv6" openvpn will happily=20
> configure the ipv6 options.=20

You're sure of that?  This is what it shouldn't do, at least for pushed
options (it will accept the options but not use them).

But anyway.  I need to go through the code again and figure out what
exactly tun-ipv6 is doing today *on which platform*, and maybe document
that better...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Vlv6EAyWma1guiG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT7C4kakuBuNlUUl1AQIqQgP/aFRqeQVaFIqVIU/r+cymF/g2nZwDec/I
vMp6P89JCac8C3u67yt90VvfknVkdDTHtYnLsB9nM8sS0m8gz/ZrqaI92H4127eq
405vLUZhsSKKJ0tdkjW0yvMvD2pTnzo825XILZZ3O+BL05hyw2TJgDlz8YQsH8yO
7NZ0VQVUyXU=
=tuko
-----END PGP SIGNATURE-----

--Vlv6EAyWma1guiG0--

