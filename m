Date: Tue, 15 Dec 2015 18:10:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151215171020.GS24952@...1296...>
References: <1450191626-24633-1-git-send-email-samuli@...515...>
	<A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1QL4jGRxByiKIEnz"
Content-Disposition: inline
In-Reply-To: <A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
Subject: Re: [Openvpn-devel] [PATCH] Updates to Changes.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t@...277...
Cc: openvpn-devel@lists.sourceforge.net

--1QL4jGRxByiKIEnz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2015 at 04:29:21PM -0000, debbie10t@...277... wrote:
> > From: Samuli Sepp=E4nen <samuli@...515...>
> >
> > This patch is for the release/2.3 branch
[..]
> > -Peer ID support
> > +Windows DNS leak fix
> > +    This feature allows blocking all out-of-tunnel communication on=20
> > TCP/UDP port
> > +    53 (except for OpenVPN itself), preventing DNS Leaks on Windows 8.=
1=20
> > and 10.
> > +
>=20
> is WXP no longer supported by git-master ?

"this patch is for release/2.3 branch" - nobody is talking about master her=
e.

[..]
> I thought I would give this a shot for WXP but I cannot get it to compile=
=20
> for win32

Just use 2.3.9 as will be released in binary tomorrow :-) - but more
comments below.

> Any clarity on what to expect of the --block-outside-dns option
> and what windows version it is/will be support would help.

It will work on Vista+, and give an error on XP.

[..]
>                  from /usr/share/mingw-w64/include/fwpmu.h:10,
>                  from win32.c:52:
> /usr/share/mingw-w64/include/iketypes.h:747:2: error: #endif without #if
>  #endif /* __iketypes_h__ */

This is a bug in the mingw header files.  You need a patch for it
(or upgrade to a newer version than contained in ubuntu).  Annoying
indeed.

> In file included from /usr/share/mingw-w64/include/fwpmu.h:10:0,
>                  from win32.c:52:
> /usr/share/mingw-w64/include/fwpmtypes.h:54:3: error: conflicting types f=
or=20
> ???FWPM_DISPLAY_DATA0???
>  } FWPM_DISPLAY_DATA0;
>    ^

Same thing: buggy header files that do not properly protect against
multi-inclusion.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1QL4jGRxByiKIEnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVnBJe6kuBuNlUUl1AQJPGgP/SlaqFw/dIiayl1SeZKroCGj6xbjZWPw2
yYWThd1xbZQXfHVGPhE11i/FjV7Esb9FU2TFhmnRg3P8TTIkJlWLhjdHAcCW3e6u
a+jBk6a6iZ6lhtZc+KeC4FjiH9DiWR15wi0LnuFLnb56bniF+Q17SfiMdi5WIqI6
PRGAJEfqkGc=
=H5EV
-----END PGP SIGNATURE-----

--1QL4jGRxByiKIEnz--

