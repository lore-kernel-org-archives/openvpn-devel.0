References: <20200813072923.24385-1-eric@...1918...>
 <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
 <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
 <CAKuzo_h_xWf-Jbkow=H3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...>
 <dc800745-efe3-0f10-d08f-046fc041c96a@...1918...>
 <CAKuzo_heHMcpRd31Lc=ZHDjPAb3GsQoBQB4iQvXCd7EPTnGEug@...278...>
 <294d779c-44a1-7f4c-c506-5f21dc76e8ac@...1918...>
 <9e1e0324-45a1-d6ab-068a-eff8bb75aef1@...1227...>
 <6d416208-e6f6-a0d9-e7e8-ef757f8893ba@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4f554f9d-cc69-6ba1-7f99-b3368d68f7ab@...1227...>
Date: Wed, 26 Aug 2020 10:45:38 +0200
MIME-Version: 1.0
In-Reply-To: <6d416208-e6f6-a0d9-e7e8-ef757f8893ba@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3pxcwDcSmM4uc8ZnKmWevFNvI4k0Dh6mR"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients
 on renegotiation failures via auth-token or user-pass expiry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3pxcwDcSmM4uc8ZnKmWevFNvI4k0Dh6mR
Content-Type: multipart/mixed; boundary="w1X2Q7xFE1lqjqrhFsuY2ZGBOojDSRzRH"

--w1X2Q7xFE1lqjqrhFsuY2ZGBOojDSRzRH
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 26.08.20 um 03:12 schrieb Eric Thorpe:
>> Management goes another code path and management_client_auth directly
>> calls send_auth_failed.
> I'm afraid in the case of renegotiation this is not relevant

That code/commit message is explicitly talking about renegotiation. So
if that is also broken, there seems to be something else wrong.

>=20
>> But I
>> also haven't digged deep enough to actually understand if your is
>> actually fixing the problem correctly.
> May I request that we resolve this first to ensure the content of the
> patch is correct, and then we can move onto finding a way to avoid this
> extra state?

Yeah but I as a said, I currently don't understand it well enough to
understand if your patch is correct or not and if the code path for
management sending AUTH_FAILED on renegotiation is also not working,
there is probably something else broken.

As I said:

- Do we send the AUTH_FAILED over the new or the old tls session?
- Do we establish the data channel (key_method_2_write) before writing
the key?

are questions that I don't have an answer to currently and you also
ignored those questions, so I assume you are not sure either. And I
don't want to merge a patch where neither I nor the author of the patch
really understand the implications and whether the patch is really
fixing the root cause or just band aiding the symptoms.

Arne


--w1X2Q7xFE1lqjqrhFsuY2ZGBOojDSRzRH--

--3pxcwDcSmM4uc8ZnKmWevFNvI4k0Dh6mR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9GITIACgkQFRhsZwKx
RFSZTA//cmZ7+mM3rcKudMqXwVB7My0tKrEKjUmto+/2S+LM94t4VrY6kyTY3uDU
JHGuB9+c/FJ+WkuqcJ9GPPAQhgbRaEgY4xJvmBaDc2xg2q83/2dbGqLiHzsVY9ni
ajVfvSqN0Fioukux92qEdS6rzsc1khRkg0I805gOfYgt8DzFHRwmzclF+x6rpdXN
W0710X6jwUH8mT/VvjYD/6LizvEFtan1d1UjPAAZ+Mb15wPVzHVIsgtfIyWsYvF9
/gBhd/O77+l5MrrBpHCWN4loAdZVwlRedNqgo336J/V0VJsKWTXIIgvAPwIaZ8D1
EgrWtG/TPsit0vKUhIeZNw+YJ8lIPeFbT8jBhfRsQOUqiQi2VoyrjVM8f9FBtX3a
+Gw7ytlik/w2PNqEkSYvTatGe2nhz1W7RZ1equynhqK7oLfzoarOvEn2uT0eWwff
NHAQdMf2NzFXWvPoIu6NI2dYaQ2jhhFHX/ID6gOA2pkA5X/wBtLBpOdNlQ9P9Qjn
bjl9Rd/QrDEq3hYTH5Ir/G8dxtkV6KteiQiUNnHbW3c2WNW/E0A3gnd5XKuk0LOB
KpjGyrvMsgnR7DdSEaO52O9xtKmfWxrXD0WwW/6k7GfxgpMYp8xKNG94QaBN3+G0
p5ISnlwBNDwF+myg8+Kb3+dswmK7+LfrPDPS9mkARYowRmjfn5U=
=xjN9
-----END PGP SIGNATURE-----

--3pxcwDcSmM4uc8ZnKmWevFNvI4k0Dh6mR--

