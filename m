References: <CAEsd45RwFwUp84WJ9OXdtVy_cSvEw3vRMzgo9DWfyr43Ny+-dw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <51ef426c-c8ee-6019-c4c0-124558888fbc@...2080...>
Date: Fri, 19 May 2017 16:50:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAEsd45RwFwUp84WJ9OXdtVy_cSvEw3vRMzgo9DWfyr43Ny+-dw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NN5FT5AxS462WSnXJ5qCrXUPDvJXWd6C2"
Subject: Re: [Openvpn-devel] Problem with sig for 2.3.16?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NN5FT5AxS462WSnXJ5qCrXUPDvJXWd6C2
Content-Type: multipart/mixed; boundary="GojTeU3GumJimDi7W8KIDPkVPQphfUjpI";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "Jonathan K. Bullard" <jkbullard@...277...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <51ef426c-c8ee-6019-c4c0-124558888fbc@...2080...>
Subject: Re: [Openvpn-devel] Problem with sig for 2.3.16?
References: <CAEsd45RwFwUp84WJ9OXdtVy_cSvEw3vRMzgo9DWfyr43Ny+-dw@...278...>
In-Reply-To: <CAEsd45RwFwUp84WJ9OXdtVy_cSvEw3vRMzgo9DWfyr43Ny+-dw@...278...>

--GojTeU3GumJimDi7W8KIDPkVPQphfUjpI
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/05/17 16:28, Jonathan K. Bullard wrote:
> When I try to verify the signature on openvpn-2.3.16.tar.gz (using
> openvpn-2.3.16.tar.gz.asc) from the "Downloads" page [1], I get the
> following:
>=20
>      gpg: assuming signed data in `XXX/openvpn-2.3.16.tar.gz'
>      gpg: Signature made Thu May 18 16:56:48 2017 EDT using RSA key ID 8C=
C2B034
>      gpg: Can't check signature: public key not found
>=20
> The signatures on openvpn-2.3.15.tar.gz (downloaded last week) and on
> openvpn-2.4.2.tar.gz both verify fine.
>=20
> I think this is because Samuli's new key's ID is not 8CC2B034, it is
> 40864578 (if I understand correctly what is meant by "ID".)

Samuli have an old key (0x198D22A3, RSA-1024) and a new key (0x40864578,
RSA-2048).  He have switched to the new key and prefers to use that one.

We decided just a few days ago that we will switch to use the
security@...515... key for signing the officially released tarballs.


> Is 8CC2B034 the "Security mailing list GPGP key" on the "GnuPG Public
> Key" page [2]?=20
The proper key is:
pub   4096R/0x12F5F7B42F2B01E7 2017-02-09 [expires: 2027-02-07]
Key fingerprint =3D F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 01E7
uid   OpenVPN - Security Mailing List <security@...515...>

Which can also be found here:
<http://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x12F5F7B42F2B01E7>


> The link on that page to that key is broken (and includes
> Javascript!).

Yes!  I discovered the same issue and reported it internally a couple of
hours ago.  I expect it to be fixed in not too long.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--GojTeU3GumJimDi7W8KIDPkVPQphfUjpI--

--NN5FT5AxS462WSnXJ5qCrXUPDvJXWd6C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZHwZJAAoJEIbPlEyWcf3y4vwQAJSQNB7J243Lzggcqi9pu8+V
xKXmWqOi4sjdGXqr+7m3hf9Z8CDLZ48CqLBlZQqKFXDWXEMNeTiv7JXjh+4sZ07M
r8x8Utu+0Ppxn7Cy1gs0iA+fzAS7EpLbdtCe8xakMQxau4fMzP0UbKestwsfI91f
rhmATy1E1phCa/KBIMCis5ycv7K4pEyob+v92USXMK1m6FgxMLO4zLBAaGUKu3b8
PfZCFkzD10uXqo7t4hvQV50aTEJR1pz5GYkAHbOm6ARNbP9UgjVjnM90KCPVJwNB
M8Nbu/XnM381EUIr7g/s6aiKLHWa7kM1SnkHvPEuKKACK7wjukRTuNxEkDi1Mg26
1oFBxzFsFkN9ZfKNHsQYDoUIMoW+4E3VD0GEGNwtgvhbfMyuK00VEOvDE8dgB1lZ
9w6+YDO39c1AnCEQnRZZPz5lEtUk2YVfjKDAkNcZTwH9L/rdM3XqjU0agr32pbSB
XmFhGzycVAuhbDlnvR/g524JZ8mddRzEc2ZFge49LVgyD6GknGZij6wY4pLsGf+n
rfWQHX9H7IieAjXn7o594Ei/DtHN1SudhBlnvqPhiGiKbGH9tUSHpsGXUANbelmx
+wcuaUySUvTrRieN1XXLehPeQsLm60OPSjP9OA6BMYGlukEP1lEEyoLxoj8X16q3
kkm2/TrS3HT0mKRCRAWW
=bQO/
-----END PGP SIGNATURE-----

--NN5FT5AxS462WSnXJ5qCrXUPDvJXWd6C2--

