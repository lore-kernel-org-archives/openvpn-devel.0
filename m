References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
 <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
 <c1ef90b8-27e9-6580-227f-b8684b5f905f@...1227...>
 <CAKuzo_iJa-geMOH8Jy_mBSMD+CVeRjdyFc1yq9902QcO14zR_g@...278...>
 <266d4464-5bfc-1b7e-9e81-a0b7a31b42ee@...1227...>
 <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <813ad24e-c28a-16bb-52fd-a6a73387b61c@...1227...>
Date: Thu, 15 Nov 2018 08:21:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8T8Tig8TZgtwq0IOPAzELzzFc7cZJeWNq"
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
--8T8Tig8TZgtwq0IOPAzELzzFc7cZJeWNq
Content-Type: multipart/mixed; boundary="uZvXN95PDgw9xFLM5eI9nsdjSGu48PI5c";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <813ad24e-c28a-16bb-52fd-a6a73387b61c@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
 <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
 <c1ef90b8-27e9-6580-227f-b8684b5f905f@...1227...>
 <CAKuzo_iJa-geMOH8Jy_mBSMD+CVeRjdyFc1yq9902QcO14zR_g@...278...>
 <266d4464-5bfc-1b7e-9e81-a0b7a31b42ee@...1227...>
 <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>
In-Reply-To: <CAKuzo_hpots+Xy_FHZGFnw4wm3yDbouqykG3VWJ3vjbVs03r9w@...278...>

--uZvXN95PDgw9xFLM5eI9nsdjSGu48PI5c
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>> Unless I overlooked something, I don't see any situation in which we ask
>> for an unsupported signature.
>=20
> Consider this:
> (i) config has --management-external-key nopadding but client announces v=
ersion
> 2. We will not error out but send the signature request as
> PK_SIGN <base64data>
> without the ALG as client version is not 3 and fail

We can error out on version on the management line. But this is also a
kind of obscure misconfiguration since why would add nopadding to the
config if you cannot support it?

> (ii) tls version max is set 1.2 and openssl 1.1.1 is in use both on
> server and client.
> PSS signing will get negotiated but we will not error out early as TLS
> 1.3 is not in  use.
>=20
> That's why I say that this extension of management-external-key is not wo=
rth it.
>=20
> Am I missing something?
>=20

tls_version_max will still report TLS 1.3 as it not affected by the
version set in config but really the max the library is capable of
irrespectable tls min/max version.

Arne



--uZvXN95PDgw9xFLM5eI9nsdjSGu48PI5c--

--8T8Tig8TZgtwq0IOPAzELzzFc7cZJeWNq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlvtHqQACgkQFRhsZwKx
RFR1fw//Y9bLMf1VbfCd6JxT3XHuStV4vs9xdR/K0X66eBsGgp++CTmifZ7GGWIs
nAJRVyC4mWGJGaR0Ig3BlB7FRLk0/mf8ygRsFBz00YIUEUhLhYt/dtdJykGtlqBg
nBJPgPLHMx/l0ba7txw2+mIBvFHEeU2mhzRtnc/f3g3qccTXt3tExZyL6bVoqJoz
aAxHT1t1VgPa4eIYGR5eGZwUW4ZR31i6DMXxHC8jhnOP3JPpWNIoUxQIel45o41H
P+EYYeRySN/L9XRYBV6WbTq0tTfxo8KfuuQsazzP8q2bNOeahK5/ba2XZsBXmucj
0gmfrNfjENh6G0xfPy+oSl47RIJPYzcKABF6t6Xpj8UFMS+ZE7ocUWZZJV2Q2Bwp
tC9eFrpa/RuWSK8Bb5arAbKKKDqcjv8OWQFgrTyOaNB3jeMRPBOKg+kZAijI0ROb
HHQPq9TGqaU7hyNrMAuzE3R99XJUGBmzx+u9SfUdwkLAvBO5C9V6WjKcqJxkv3VI
efLMzRhiiTIbpfZsMz5SKkaln/bnRSJr+7or6csqrZJQ1B5ox7grlWbz6d/VaBeO
8z64pkCa9GnJVYdCwQ5lj99MAWVxHCklLIcZbGqgaolOEGx3MPNmGOdwmgye0xqu
P3NSyX5+kom5Pmf5qtWIR51FodIU8TFL0TiDOnm37LPrdbCsNIg=
=/Dwk
-----END PGP SIGNATURE-----

--8T8Tig8TZgtwq0IOPAzELzzFc7cZJeWNq--

