Date: Wed, 8 Nov 2017 10:48:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171108094835.GK958@...1296...>
References: <1509540912-8739-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8Y8a5CJOPM/zJV44"
Content-Disposition: inline
In-Reply-To: <1509540912-8739-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] doxygen: use relative paths from
 the project root
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

--8Y8a5CJOPM/zJV44
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 01, 2017 at 01:55:11PM +0100, Steffan Karger wrote:
> Instead of genering docs with full path names (e.g.
> /home/steffan/dev/openvpn/src/openvpn/crypto.h), use a relative path wrt
> the project root (e.g. src/openvpn/crypto.h).  This makes the generated
> doxygen easier to read.

Feature-ACK, but since there is a patch 2 in the series that right
afterwards changes this very line=20

> -STRIP_FROM_PATH        =3D ""
> +STRIP_FROM_PATH        =3D "."

... again, maybe just folding these two patches together makes more sense.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8Y8a5CJOPM/zJV44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaAtLzAAoJEB2Cnv7KVigSl4EMAINhhX1kdBHklOj/q9QQRkwt
975Xttvmj0dmXZq7Jn2WdEnliB1uU4jy0fcoUde8QK7gpcT7XstuB//ZGZBstyRY
OqCgdlAynQif5lsmyWBAcCX/fhdN50ZJiwvqdFlq9myJeWfEHCw1DVVwggwPKIuU
SAD+h0ANNoCW6x7HHMXDHT8Ou2iZiFw2kaGmK+WsOpPlkBMMQZqCozEPQz9sHlHN
WDS7W9JqU1O9cEzxMLOwcV44jQ0ltKn0DV0M8ZHw0hOFJxA+/UOxonwu5SCVHzGo
ukWOsAb9KZXlMzyH/iQFJcbuNczmmcEN0czYs1kEZECQ3rrG9DPdZrnPFbVmNmbm
QUpQOiaxP9azoQ+WOzF8mq48ILqnjYy/6O7fc4EMF6GtdUOdaTpcak80t3doe/Pl
+iWcOf0WhS00sl2OShPqP/doHKkVo/iGhdi5Y7lwEkmwdQkaze9936b+jxLy8GOw
cAWPndWqVybVHg5Dwa+Y6F68CLVIw7/qGDQV7nnNDg==
=DqVs
-----END PGP SIGNATURE-----

--8Y8a5CJOPM/zJV44--

