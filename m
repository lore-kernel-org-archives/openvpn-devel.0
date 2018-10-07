References: <20181005150032.16541-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <40100692-a1b7-61b0-df39-52965ced60f6@...2181...>
Date: Sun, 7 Oct 2018 20:23:19 +0800
MIME-Version: 1.0
In-Reply-To: <20181005150032.16541-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ifTbLDdY0hq93NQaFYb1wgmBdDTfsD3Z3"
Subject: Re: [Openvpn-devel] [PATCH] Simplify --genkey option syntax
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ifTbLDdY0hq93NQaFYb1wgmBdDTfsD3Z3
Content-Type: multipart/mixed; boundary="KgW9arFJX8Uabfgd7qPkLoaf2bmlrJKbP";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <40100692-a1b7-61b0-df39-52965ced60f6@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Simplify --genkey option syntax
References: <20181005150032.16541-1-steffan@...1856...>
In-Reply-To: <20181005150032.16541-1-steffan@...1856...>

--KgW9arFJX8Uabfgd7qPkLoaf2bmlrJKbP
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/10/18 23:00, Steffan Karger wrote:
> Instead of requiring users to do "--genkey --secret new.key", allow
> them to just do "--genkey new.key".  This has hit me often enough that I
> decided to write a patch for it.  Also, the upcoming tls-crypt-v2-genkey
> uses a similar syntax and Antonio suggested we should make them consisten=
t.
>=20
> The documentation is updated to no longer mention the old syntax, but it =
is
> still supported so people who are used to the old syntax can still use it.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>


I totally agree that having the "--genkey file.key" syntax makes the
command much more intuitive (I also hit this every time).

The patch looks good and it does what it says.
People used to the old format will still be happy as it is still
supported. (Maybe at some point we can get rid of it)

Acked-by: Antonio Quartulli <antonio@...515...>
Tested-by: Antonio Quartulli <antonio@...515...>



--=20
Antonio Quartulli


--KgW9arFJX8Uabfgd7qPkLoaf2bmlrJKbP--

--ifTbLDdY0hq93NQaFYb1wgmBdDTfsD3Z3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu5+rcACgkQ9FVsWUWD
Dm2YvBAAsszNZQWfjlEJq95XVNqYoepVc2SOYvRJf0kreVs0nOm2zNR9dm2E1Oey
+RfP3/nW2/32BqYRN6krYcm3//k13YXPgt9dZYAr76HkVjpxa5Ojd+p91RKIEBJ2
ZiGnqkAZypQdclmEDqMCPdU7WrEGZKpq4hZMkMuthO5tTGF2ioH0lkV/KFcKeBz3
7eFl4f3TnoisicyP2lkc4PpbjH7WaNenEVhNJ29V02VXPhBb9okHHj3jOTPv9Ir8
KZnRhYB/r+cGmMaShOoTCtwH+G2ad9pwS5E+ZjnudCV0MyTLxjs6DpZA7PGNYsQA
sgRI24f7MU+OVwLiPEyMj2j5kzfOudO/Pe7e1xZEErpPcAjkRvhaUyBy4GLlQIKF
KEdonH0oNgUg6fuRbn6OWPXfLY+B/Zvo6X1AfdtoqdfWSXsAwviExXTURVosqP/l
crFOKocXVa9evzdXm3iNbKW+Cap9H8qS9yfyoe9As4O9zAzQUhrn0lEs/9g5mTip
3v4ROEZv94Unlbd8+EYWUzrWzLQlHauZwbAMwNaSzAtpq4p4OgQ3rsBiB1QWdD6B
abRBLdRn63V4OL8nedfwFMj8PcOndL5z+wv8iMgrBCPeAlzhDcpeHPLRo6V0QP6v
rT3E0y3lGiGKBJEeBkiFcXz6ur5A0qGonkDiA8+9YWG4UaSNlJY=
=xqIp
-----END PGP SIGNATURE-----

--ifTbLDdY0hq93NQaFYb1wgmBdDTfsD3Z3--

