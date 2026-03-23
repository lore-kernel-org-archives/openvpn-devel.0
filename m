Date: Mon, 23 Mar 2026 13:57:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <acE4qHX_Eavkcn_H@...1296...>
References: <20260309133236.29732-1-frank@...2641...>
 <202603100827.62A8RJqm094150@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3E7xWZo8cYt5IrW6"
Content-Disposition: inline
In-Reply-To: <202603100827.62A8RJqm094150@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: ssl_verify_openssl: Clean
 up extract_x509_extension
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--3E7xWZo8cYt5IrW6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 10, 2026 at 09:27:19AM +0100, Gert Doering wrote:
> This looked good to me, but "OpenSSL innards" are still foreign territory,
> so thanks Arne for looking at the ia5/rfc822Name change (I found it=20
> surprising since we had an "ia5->length" before and now need to do
> ASN1_STRING_LENGTH(), but I'm sure there is a good reason behind this).
>=20
> Your patch has been applied to the master branch.
>=20
> commit 66060627a8cf05c8761d75985e76482d20df4f29
> Author: Frank Lichtenheld
> Date:   Mon Mar 9 14:32:36 2026 +0100
>=20
>      ssl_verify_openssl: Clean up extract_x509_extension

As suggested by Rudi Heitbaum in GH PR 1003, I have cherry-picked this
back to release/2.7 - it's "long term compat".  We expect OpenVPN 2.7.x
to be maintained for long enough that OpenSSL4 becomes a thing, and then
we need the patch - so we can do it right away, and be not surprised.

The patch is the same as in the master branch, except for the #pragma
removal - which git does not care much about ("you want it gone, it was
not there in the first place, so the net result is what you want").

Mildly tested via GH actions.

commit 5f0a168311a53b935f776d4c1566c4f2f3cde98b (release/2.7)
Author: Frank Lichtenheld <frank@...2641...>
Date:   Mon Mar 9 14:32:36 2026 +0100

    ssl_verify_openssl: Clean up extract_x509_extension
...
    (cherry picked from commit 66060627a8cf05c8761d75985e76482d20df4f29)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3E7xWZo8cYt5IrW6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmnBOKYACgkQHYKe/spW
KBK0dgv/eJ8MzxROV6epMnFAxIPzbd6acYro+yG43bEatwjX8d2IGo4fWjKQ6WLu
5TM+Xjb/d/G6xrgC6bp/ffWDTlm+1QN0FTQUYvjfGE4hZdZ0n7navxkyMbXHvHaB
Ccj4O9pAcbAWGrQfUQ7XrPD6DI+BXATBa4GtckGWIkosTKgpLrm/DUR/TXtpcSNg
BujK1zQ5djFi6GUmb74oqt5AiJbCOW7r/rWuKRckwxkToBIgjXUt/H4q2/HJEKvN
n8Ui+gA2tdylKcUDmOcNCUIdr76Yzm0nOydKPvwfCPeFVEWHX6Z6R2N51jLDMa+Z
5Enr6oF7ifmL6Tw3eVRU9JzkagHKO3+XA5Dxk0drI+Yf3VW5zwoijREi6gQGOFAU
mULP5IXT0R311IndblWq4h1VK3voPTcV5tHt9FOQUj40/fXIgrymzWsjzkAzJW8Z
ozLvSMqmYK7WDhCTh66n7fbnfZwD2b3bnbwVlzAaI9IYPRFLyiuzMDNTDxTZpjXD
q62a+B6/
=oRly
-----END PGP SIGNATURE-----

--3E7xWZo8cYt5IrW6--

