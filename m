References: <20170824075312.24801-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
Date: Thu, 24 Aug 2017 15:57:17 +0800
MIME-Version: 1.0
In-Reply-To: <20170824075312.24801-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aqoMARwqc8eHdUXd68BeberomtN5OQMbJ"
Subject: Re: [Openvpn-devel] [PATCH] avoid useless assignment
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
--aqoMARwqc8eHdUXd68BeberomtN5OQMbJ
Content-Type: multipart/mixed; boundary="x076waNqdW0vsk0DQawXU478lWcgiIMl0";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] avoid useless assignment
References: <20170824075312.24801-1-a@...2181...>
In-Reply-To: <20170824075312.24801-1-a@...2181...>

--x076waNqdW0vsk0DQawXU478lWcgiIMl0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

My effort in writing the commit message has been quite poor.

The assignment is useless because 'ret' is re-assigned a few lines later
without ever being read.

Cheers,

On 24/08/17 15:53, Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/multi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index 5892ac07..6cdb0110 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -633,7 +633,7 @@ multi_process_outgoing_tun(struct multi_context *m, c=
onst unsigned int mpp_flags
>  static inline bool
>  multi_process_outgoing_link_dowork(struct multi_context *m, struct multi=
_instance *mi, const unsigned int mpp_flags)
>  {
> -    bool ret =3D true;
> +    bool ret;
>      set_prefix(mi);
>      process_outgoing_link(&mi->context);
>      ret =3D multi_process_post(m, mi, mpp_flags);
>=20

--=20
Antonio Quartulli


--x076waNqdW0vsk0DQawXU478lWcgiIMl0--

--aqoMARwqc8eHdUXd68BeberomtN5OQMbJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmehuEACgkQ0+HICM1s
oFBn/w/+LCe1fMnYJS0jwOmyCo7SSf4iYvx/4ZrhdjiokwNFRpts4VGVwr7m+dZd
6BrMbsaZU0uCE4ysofBDlavNFl3eZqFBMGJSsLQGBNxp1r+1TAYGcqlIXjSjyB3h
606kUSMwyZIM6py3JvR07TkC/6vyHFpwrFG/OnT6MmlPaq8KWZKsiJZ2Xy8ertzJ
NumJfzSkwKq0oWRjjcAPoUk0mDpDxM7Bjozj7ECSKkmxps8I2n+SBLd6MBLI/HW+
pxBY8LBOO/dDq7mwUtJf7ncnhDyu4mQkkUTGZdbRwFtsZCiAztHs8dFc3/O9O1+m
JySU9Fr+y/B+QbR2W0h706iKpcX8uXms1XrnlEsXkD+SSMm8+BCczWNKxHaw3Xkj
oPp51pAcgQdqpx7TRisKBE2YcLaNADVfcTvhaDrHRvc0lOJpa51G30Vky3IId+y5
FDkMm7u8IOPCNY1cASY1ZbL246FkJyQe2T/NseEHwPSTVU57eelaYbSrLdPW3If5
a3xuR6knyNimQzhWsfR4J3ZCtyRzXJmdJeOAQWnjv46ObkRv+ChCmYr2VhHIVLUa
fyKlhbu+y6R7GGqJp9Gd1+iud1V1jyPm7h8+l+Kk8UyEdZmbs+BdguBvkqxCnw9M
AcjoNk44I7qh1gwFd5FDYT/mchMFfq0W+hJB4dANrbP+nTk4fss=
=Wz5w
-----END PGP SIGNATURE-----

--aqoMARwqc8eHdUXd68BeberomtN5OQMbJ--

