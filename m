Date: Tue, 13 Dec 2016 09:33:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161213083314.GS78624@...1296...>
References: <1481543265-21474-1-git-send-email-lstipakov@...277...>
	<8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0EgURHJLyMzpnI9B"
Content-Disposition: inline
In-Reply-To: <8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Make --enable-async-push depend on
 --enable-plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0EgURHJLyMzpnI9B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 13, 2016 at 01:15:03AM +0100, David Sommerseth wrote:
> But I am wondering if it would be better to just do this in syshead.h
> instead:
>=20
>   #if !defined(ENABLE_PLUGIN) && defined(ENABLE_ASYNC_PUSH)
>   #undef ENABLE_ASYNC_PUSH
>   #endif

We discussed this on IRC yesterday, and I like Lev's approach more.

Your approach will "silently not do what the user requested" - the user
configured "--enable-async-push", and the resulting binary will not
have that functionality because we turned it off again.

So erroring out in configure if incompatible build options are requested
sounds like a logical way to tell the caller "this is not what you want".

[..]
> My point is that there's no real point of screaming about missing
> --enable-plugins if you have added --enable-auth-push.=20=20

Someone added --enable-async-push to the configure command line, and they
expect this to have a different effect than "not putting it there".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0EgURHJLyMzpnI9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYT7JJAAoJEB2Cnv7KVigSp84L+wSzSNYtHrHK+ZOmipC6seMV
xF8/2k0HRwtEDI328C4AyUxErQhHeE5+mV/xGlPzj39KGspiMRR4B/MttdZp1ydR
ytBX6c1q458adULuo5Z5xMAzwHqA88w4cJB4MtO3GZ4D/O70AcQM5Z1+3kITdHgD
u43f5lstrhY2asH8ELShcr3AMTiw16van9zW63SUnl4Otqno7jaFcMsckl3om8oR
NKyriIvgzqGmphJAoU9K7s0fD0jcPrcpJXRwz+lYSIo3n6+JGjoSqfldvlonVxD1
QU7hGtV4tttNeMbPmOMpDU8I5dusB7ljHG8Z+wSj1tykkQ5UU/cSrduf9h/FkWcD
ed2URsavW6dHkfVldJyNWK/XIy3mwY7bk4CZSBFg5SvKSH2dHPUXeSUfrFrANNLU
4D8K2OdnympbOx7x/oEgF2iBnTsNqicRFNullb8JJWXjpmcmyC+Ucz9Jv9Tat2pC
WNRRphlOPxjNTkvmEXXl24MVJT5OLQcL21Ke0p0jSw==
=pjP9
-----END PGP SIGNATURE-----

--0EgURHJLyMzpnI9B--

