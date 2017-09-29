References: <20170919090311.1899-1-antonio@...515...>
 <20170929191117.26199-1-openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5918a9aa-0aba-7cfb-ec1c-ff618eb22ae9@...2080...>
Date: Fri, 29 Sep 2017 21:30:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170929191117.26199-1-openvpn@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QrehcVVw98TjuTRd9o4DJlJR8BncgBIEm"
Subject: Re: [Openvpn-devel] [PATCH applied] Fix short-option overlapping
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QrehcVVw98TjuTRd9o4DJlJR8BncgBIEm
Content-Type: multipart/mixed; boundary="FBK1v8hupNXGHjtApgcpeOCOTmhR9M7iQ";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5918a9aa-0aba-7cfb-ec1c-ff618eb22ae9@...2080...>
Subject: Re: [PATCH applied] Fix short-option overlapping
References: <20170919090311.1899-1-antonio@...515...>
 <20170929191117.26199-1-openvpn@...2080...>
In-Reply-To: <20170929191117.26199-1-openvpn@...2080...>

--FBK1v8hupNXGHjtApgcpeOCOTmhR9M7iQ
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 29/09/17 21:11, David Sommerseth wrote:
> From: David Sommerseth <dazo@...2108...>
>=20
> Your patch has been applied to the wip branch
>=20
> commit c41c677c36a105325728a6749885060e3095e845
> Author: Antonio Quartulli
> Date:   Tue Sep 19 17:03:10 2017 +0800
>=20
>      Fix short-option overlapping
>=20
>      Signed-off-by: Antonio Quartulli <antonio@...515...>
>      Signed-off-by: David Sommerseth <dazo@...2108...>

Sorry about this one; this was not intended to the openvpn-devel ML at
all, it is related to the work on a brand new Linux client using the
OpenVPN 3 code base.  We're not quite ready to open that one up to the
public, but it will be open sourced once we've reached a more reasonable
state.

The reason it happened was both due to a misconfigured local git
repository and an ugly forgotten detail in our git-regen-ackmsg script
which we also use for the openvpn 2.x development - this mailing list
address was hard coded.

So please disregard these mails.


--=20
kind regards,

David Sommerseth


--FBK1v8hupNXGHjtApgcpeOCOTmhR9M7iQ--

--QrehcVVw98TjuTRd9o4DJlJR8BncgBIEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZzp9sAAoJEIbPlEyWcf3yiOIQAMD3C2lwmxeA1EqLSBJcaLmb
29E/opYUj5EEsYWrCZf1bGq8b/OU4ckHcf7OX3Z4Exlwq6URcphxzNAN3+m72rQ5
13onvAtpKKNNu1lIWSIbZXZCiqUL/G0qUhJyxGxpWN1oWr/OeXZSlPGOfyRu4pW8
tILoW9NeTvh5viB0Y9oBYYk6Ic6rEnzBMsYpEi2YO/EhRLZC9ys0qYSou/57DtJt
sa9XknAfeTd9ztzKT2dcEXgg2Z/cg3ofRwJwm14Oj5WIUnx7OAWOb1dkM/BiT9j7
KOc5sZPnp1CeUn5z4zRtamJvR7wnOxgKhw9rpNIZ+pqkFmxlz36GT/Ye3s9QB+ft
vcAEg529bpiW0hdnOl/fB10YzNXKx9EhYZ2WF67V24FCGtg4YwdUmAISfyTgx3SY
Wn2QkS6N6jAz4Eu7BhZnhXlIwzScNXYgjYSvN9rsktBvyEPhbaPU+6pVj89xTi8s
a9C7BZ3oo2VAj/U+LFEPH8ILkSLazU7fTwbAriYBxENRiGwSzS1TUZD/z4tRnBck
U66yme0ruUqUzvGyMkLnaj+ECLHzAVXOIv7Ykk87AVHlZkehGKasUJSl+3YepDqs
zWB5RGfTqpa0YohbVV0SBnE+S4CvR4dCmeKnRIpz9hPbiZLlQ5g1IXJfwKbjPzIY
GK2JYdgjrs/OsV3erebX
=w2bA
-----END PGP SIGNATURE-----

--QrehcVVw98TjuTRd9o4DJlJR8BncgBIEm--

