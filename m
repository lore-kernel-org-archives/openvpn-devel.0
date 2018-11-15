References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
 <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
 <c1ef90b8-27e9-6580-227f-b8684b5f905f@...1227...>
 <CAKuzo_iJa-geMOH8Jy_mBSMD+CVeRjdyFc1yq9902QcO14zR_g@...278...>
 <266d4464-5bfc-1b7e-9e81-a0b7a31b42ee@...1227...>
 <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
 <813ad24e-c28a-16bb-52fd-a6a73387b61c@...1227...>
 <CAKuzo_h33yOpZ9i8j=aLKoM9R05Jm8ArfykwJacLnLpeRZy_SA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <80e422f6-f344-4903-eb23-4c4fa18785c6@...1227...>
Date: Thu, 15 Nov 2018 15:13:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h33yOpZ9i8j=aLKoM9R05Jm8ArfykwJacLnLpeRZy_SA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mYwRst6GfKaI3CobvP0fxFIw3sJfPIQ2j"
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mYwRst6GfKaI3CobvP0fxFIw3sJfPIQ2j
Content-Type: multipart/mixed; boundary="3a5lfaPPcScsYTF7yFqECrEYYv213ZqQM";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <80e422f6-f344-4903-eb23-4c4fa18785c6@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
 <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
 <c1ef90b8-27e9-6580-227f-b8684b5f905f@...1227...>
 <CAKuzo_iJa-geMOH8Jy_mBSMD+CVeRjdyFc1yq9902QcO14zR_g@...278...>
 <266d4464-5bfc-1b7e-9e81-a0b7a31b42ee@...1227...>
 <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
 <813ad24e-c28a-16bb-52fd-a6a73387b61c@...1227...>
 <CAKuzo_h33yOpZ9i8j=aLKoM9R05Jm8ArfykwJacLnLpeRZy_SA@...278...>
In-Reply-To: <CAKuzo_h33yOpZ9i8j=aLKoM9R05Jm8ArfykwJacLnLpeRZy_SA@...278...>

--3a5lfaPPcScsYTF7yFqECrEYYv213ZqQM
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> =C2=A0
>=20
>     > (ii) tls version max is set 1.2 and openssl 1.1.1 is in use both on
>     > server and client.
>     > PSS signing will get negotiated but we will not error out early as =
TLS
>     > 1.3 is not in=C2=A0 use.
>     >
>     > That's why I say that this extension of management-external-key is
>     not worth it.
>     >
>     > Am I missing something?
>     >
>=20
>     tls_version_max will still report TLS 1.3 as it not affected by the
>     version set in config but really the max the library is capable of
>     irrespectable tls min/max version.
>=20
>=20
> Aha, I missed that. Still I really do not understand the need for
> erroring here
> instead of when prompting for PK_SIGN based on client version.
> Much simpler.

It did this because my initial OpenSSL 1.1.1 client did not have any
problem, only after I upgraded the server to 1.1.1. I want to avoid the
situation that OpenSSL 1.1.1 is used and then just "breaks for no
reason" and erroring out early and tell the "This will not really work"
is a better approach.

Arne


--3a5lfaPPcScsYTF7yFqECrEYYv213ZqQM--

--mYwRst6GfKaI3CobvP0fxFIw3sJfPIQ2j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlvtfvcACgkQFRhsZwKx
RFThXA/+I+T7R4p18TzcUFVLdDAZk/mUSJZT6dgZGi+TFUP6atxnjneTfqdT+UVi
9myo+Vw0vYrymCJaAMmszmUthH8PzqeUKNNiFgeLdqZfl86A/KUhe98ZKGLljUZH
R2wwz6XzEXDbU35GgS39k0TszePgMEkkIjwQkAL2faPWzl+he7DkoWS+lvUCZLiV
xqDfEsNbQo+CTCUapVT9zETmpzUyNkRvp9lPLgBsxJwsTYmdQblkqnqnNAL4O1ED
FE+YqoYLtrUF9KKRaWkumWObbD07PcAlMpTzkhOKmbp4DeTliIvNzM7wxiSKJmVI
24E1lRHOuGs4bgMi/6N9OiRydO4mnudSegGLbsWHATp0vif8QfkQz9352jWDrNZG
f26v24a1fXIOmbicXV00Lw4CN+wxBPAY9Tv9aQpshxd4fs4LwuI4IJLmZ91Hs/vi
ttb7LuCLisiGkvuSO1tiuMka9GOaTn88svmeDIgkO0UlzpQkmGnPA/j7lKGsS60W
ykIp2K5WP3T+6IktFxPiVJj6n0vALGCQkPg6Mix1offDCIdJ7vI7HJzjWxnYQH1N
BePL1mSqs5fgXdQTx4vSePNtoNBypG/HhB7/zQIvdAODvRqoOAGu4kbo/djEfhs/
8cG21MJuDvv6URoNfvH+4L+y4VJep9Ss84bW4KRhiyWM7MRpdnc=
=bWXS
-----END PGP SIGNATURE-----

--mYwRst6GfKaI3CobvP0fxFIw3sJfPIQ2j--

