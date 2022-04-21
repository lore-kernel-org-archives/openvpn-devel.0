Date: Thu, 21 Apr 2022 10:16:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YmESwwvWq/IwpMg+@greenie.muc.de>
References: <20220420233148.2384208-1-heiko@...2662...>
 <866053733.106111.1650528089348@...2642...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="p2kZ0oHQmzhX9ftu"
Content-Disposition: inline
In-Reply-To: <866053733.106111.1650528089348@...2642...>
Subject: Re: [Openvpn-devel] [PATCH] Add git pre-commit hook script to
 uncrustify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

--p2kZ0oHQmzhX9ftu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 21, 2022 at 10:01:29AM +0200, Frank Lichtenheld wrote:
> Definitive NACK due to licensing concern mentioned below.

Streams crossed here, but I saw your NAK before pushing.

So, yes, all valid concerns and I withdraw my ACK.

> [...]
> > +# create a filename to store our generated patch
> > +prefix=3D"ovpn-fmt"
> > +suffix=3D"$(date +%C%y%m%d%H%M%S)"
> > +patch=3D"/tmp/$prefix-$suffix.patch"
>=20
> Are insecure tmp files still a concern? Because this is definitely an ins=
ecure tmp file...

Especially this one is something I only noticed after I sent my mail -
so this definitely needs to to mktemp-style temp files, or a private
tmp directory (in the local repo?)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--p2kZ0oHQmzhX9ftu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiYRLDAAoJEB2Cnv7KVigSrR0MAJdMUkUP9WdkSVWZMzLuesSx
GPqPWuUTIxSn3/fql+aAHmkIhmv9ivGFQEzw43nr4dcjKOFYitzHdROwaOGAy8uN
2Rz3gEyKNTZMQRu/0GKTypXVgKLwm93ZfTnvWxx+D3pXk//I1H9433HOc91UCSA/
9jXArWDhV9uqvaSripcFnzg6zPS3BJZ0oAphzG6D8tVxsocyQRVesWLVTIZsxe5m
Vp2mqUO6pxbEwU4F09mWpa4I99POFsXKFa3xHyOCX8VoGRD3pFvpAXpTEgImrQga
l4ZjWO8YLwOaO4rSF6QPXjMkC+H7SBXpquo371pdu+deOBQfQz8jY7/tBH9JhSSU
9a8V7mAJaGIVpPwgVoQsG9O59X96se9z61w7xItJp+62xh3EQX6Y6GBl4NztbpA3
rdAop2GWdOdx2+/itadC60ZYlT7n69LA/Dp85uGvLVbFvX0kwtxKORBufyaLsYsU
v8vQI4qfJzNWnCsLTqelUCFP/nXsgjNmG5i/SBMXzg==
=UFMc
-----END PGP SIGNATURE-----

--p2kZ0oHQmzhX9ftu--

