Date: Wed, 1 Nov 2017 17:25:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171101162523.GQ958@...1296...>
References: <1481718210-15673-1-git-send-email-davids@...515...>
 <7a381eee-fd86-73ba-77c6-498710ad8cdb@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5OPIRG5sBUHnKBkK"
Content-Disposition: inline
In-Reply-To: <7a381eee-fd86-73ba-77c6-498710ad8cdb@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Further enhance async-push feature
 description
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--5OPIRG5sBUHnKBkK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

finding lost gems in my mailbox...

On Wed, Dec 14, 2016 at 01:45:09PM +0100, Steffan Karger wrote:
> >  AC_ARG_ENABLE(
> >  	[async-push],
> > -	[AS_HELP_STRING([--enable-async-push], [enable async-push support @<:=
@default=3Dno@:>@])],
> > +	[AS_HELP_STRING([--enable-async-push], [enable async-push support for=
 plugins providing deferred authentication @<:@default=3Dno@:>@])],
> >  	,
> >  	[enable_async_push=3D"no"]
>=20
> ACK.
>=20
> Related question:  looks both useful and harmless.  Should we enable
> this by default in 2.5?

Skimmed through the code, and generally speaking, this would make sense.

OTOH the code is currently linux only (inotify is not available on FreeBSD,
at least), so this would just change the default but won't get rid of=20
any #ifdef, unfortunately... :-(

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5OPIRG5sBUHnKBkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ+fVzAAoJEB2Cnv7KVigSPgsL/iRzy7UnguU69cVM+eHYjkmw
zZU4oQcmRHceBcfjvaXhj3j+/X8mTJ1VsBJUePoZxnlgk/lzV/mvH2TTOVRHrjCA
1qvwfqiQxGt3oUPFxQ/mw4GD9k5MCOTE+mYLlMdUTiPEHx+lAKkkTiGusOjSBWzW
FzRo0iYBsLbStHyX8JAIGCxl5J5wLvLyB5bC8OHcMfjUHdUqCFrk1CwsrioFspcb
VPsDm+w/ADJnW82zvNIhMkc6G0rs/2TF+NF+UDq4xqAyiKpIfy9Fv5DPgLjVPr7h
iUzMiB1y6+RhPsQ6gcAfcjJ1E9m7CRI8v+QqwYrw24nmXBr0DqYhrnFEooIX885v
8BK1OJsQdLyLGki1cit+4BIMlpEgJk2qWAcbwCJcpAzrlYiaVoQrYKGcpQCB8uWV
tEbMc6rqPinl7H4ts+hT5gvvDvvTpziYAtehyxzOjLZsEKiOsiKBdeGCVI9rAraQ
i4bLD/R+ANIyu4G9qsWXv91711klYHwwoX1OuJd82g==
=iTsu
-----END PGP SIGNATURE-----

--5OPIRG5sBUHnKBkK--

