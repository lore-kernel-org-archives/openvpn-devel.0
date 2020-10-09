References: <20200825073643.15920-1-arne@...1227...>
 <20200825073643.15920-2-arne@...1227...>
 <95be61ea-3ef4-4efe-94a4-95e3a0e58e12@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <914c0551-971c-6eba-10c1-eafba708ba19@...1227...>
Date: Fri, 9 Oct 2020 13:47:07 +0200
MIME-Version: 1.0
In-Reply-To: <95be61ea-3ef4-4efe-94a4-95e3a0e58e12@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ITLD7eTiJXsxtR0IdtEyW62dCGWOjrTFt"
Subject: Re: [Openvpn-devel] [PATCH v4 2/2] Implement generating data
 channel keys via EKM/RFC 5705
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
--ITLD7eTiJXsxtR0IdtEyW62dCGWOjrTFt
Content-Type: multipart/mixed; boundary="gS5QXblmqQA9oWyPjbR2iTvAoHE4Pt1YK"

--gS5QXblmqQA9oWyPjbR2iTvAoHE4Pt1YK
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.10.20 um 11:23 schrieb Steffan Karger:
> Hi,
>=20
> On 25-08-2020 09:36, Arne Schwabe wrote:
>> OpenVPN currently uses its own (based on TLS 1.0) key derivation
>> mechanism to generate the 256 bytes key data in key2 struct that
>> are then used used to generate encryption/hmac/iv vectors. While
>> this mechanism is still secure, it is not state of the art.
>>
>> Instead of modernising our own approach, this commit implements
>> key derivation using the Keying Material Exporters API introduced
>> by RFC 5705.
>=20
> Thanks! I'm glad to see you're picking up the work I haven't been able
> to find time for.
>=20
>> We also use an opportunistic approach of negotiating the use of
>> EKM (exported key material) through an IV_PROTO flag and prefer
>> EKM to our own PRF if both client and server support it. The
>> use of EKM is pushed to the client as part of NCP as
>> key-derivation tls-ekm.
>>
>> We still exchange the random data (112 bytes from client to server
>> and 64 byte from server to client) for the OpenVPN PRF but
>> do not use it. Removing that exchange would break the handshake
>> and make a key-method 3 or similar necessary.
>>
>> As a side effect, this makes a little bit easier to have a FIPS compatib=
le
>> version of OpenVPN since we do not rely on calling MD5 anymore.
>>
>> Side note: this commit breaks the (not yet merged) WolfSSL support as it
>> claims to support EKM in the OpenSSL compat API but always returns an er=
ror
>> if you try to use it.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>=20
> Signed off two times.
>=20
>> Patch v2: rebase/change to V2 of EKM refactoring
>>
>> Patch v3: add Changes.rst
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  Changes.rst                      | 11 +++++++
>>  doc/doxygen/doc_key_generation.h | 14 +++++++--
>>  src/openvpn/crypto.h             |  4 +++
>>  src/openvpn/init.c               |  1 +
>>  src/openvpn/multi.c              |  4 +++
>>  src/openvpn/options.c            | 14 +++++++++
>>  src/openvpn/options.h            |  3 ++
>>  src/openvpn/push.c               |  5 ++-
>>  src/openvpn/ssl.c                | 54 ++++++++++++++++++++++++++++----
>>  src/openvpn/ssl.h                |  2 ++
>>  src/openvpn/ssl_backend.h        |  2 ++
>>  src/openvpn/ssl_mbedtls.c        |  7 ++---
>>  12 files changed, 107 insertions(+), 14 deletions(-)
>>
>> diff --git a/Changes.rst b/Changes.rst
>> index f67e1d76..2a2829e7 100644
>> --- a/Changes.rst
>> +++ b/Changes.rst
>> @@ -1,3 +1,14 @@
>> +Overview of changes in 2.6
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> +
>> +
>> +New features
>> +------------
>> +Keying Material Exporters (RFC 5705) based key generation
>> +    As part of the cipher negotiation OpenVPN will automatically prefer
>> +    the RFC5705 based key material generation to the current custom
>> +    OpenVPN PRF. This feature requires OpenSSL or mbed TLS 2.18+.
>> +
>>  Overview of changes in 2.5
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>=20=20
>> diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_gene=
ration.h
>> index 4bb9c708..cef773a9 100644
>> --- a/doc/doxygen/doc_key_generation.h
>> +++ b/doc/doxygen/doc_key_generation.h
>> @@ -58,6 +58,12 @@
>>   *
>>   * @subsection key_generation_method_2 Key method 2
>>   *
>> + * There are two methods for generating key data when using key method 2
>> + * the first is OpenVPN's traditional approach that exchanges random
>> + * data and uses a PRF and the other is using the RFC5705 keying materi=
al
>> + * exporter to generate the key material. For both methods the random
>> + * data is exchange but only used in the traditional method.
>> + *
>>   * -# The client generates random material in the following amounts:
>>   *    - Pre-master secret: 48 bytes
>>   *    - Client's PRF seed for master secret: 32 bytes
>> @@ -73,8 +79,12 @@
>>   *    server's random material.
>>   *
>>   * %Key method 2 %key expansion is performed by the \c
>> - * generate_key_expansion() function.  Please refer to its source code =
for
>> - * details of the %key expansion process.
>> + * generate_key_expansion_openvpn_prf() function.  Please refer to its =
source
>> + * code for details of the %key expansion process.
>> + *
>> + * When the client sends the IV_PROTO_TLS_KEY_EXPORT flag and the serve=
r replies
>> + * with `key-derivation tls-ekm` the RFC5705 key material exporter with=
 the
>> + * label EXPORTER-OpenVPN-datakeys is used for the key data.
>=20
> Did you request this label with IANA?

It is not really described well how this actually works, from what I
interpreted you need to write to the mailing list, which I did:
https://mailarchive.ietf.org/arch/msg/tls/IWFb5hLsqNlCcIMnEDDuPAkzXvg/

but I am lost what the next step would be.

>=20
> Also, a user could now use --keying-material-exporter to export the data
> channel keys to a plugin. I'm inclined to say we should prevent that, by
> rejecting our internal label as a user label.



>=20
>>   * @subsection key_generation_random Source of random material
>>   *
>> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
>> index 999f643e..ec935ca5 100644
>> --- a/src/openvpn/crypto.h
>> +++ b/src/openvpn/crypto.h
>> @@ -254,6 +254,10 @@ struct crypto_options
>>  #define CO_MUTE_REPLAY_WARNINGS (1<<2)
>>      /**< Bit-flag indicating not to display
>>       *   replay warnings. */
>> +#define CO_USE_TLS_KEY_MATERIAL_EXPORT  (1<<3)
>> +    /**< Bit-flag indicating that key derivation
>=20
> Sugestion: "data channel key derivation".
>=20
>> +     * is done using TLS keying material export [RFC5705]
>> +     */
>>      unsigned int flags;         /**< Bit-flags determining behavior of
>>                                   *   security operation functions. */
>>  };
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index a785934a..dff090b1 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -676,6 +676,7 @@ restore_ncp_options(struct context *c)
>>      c->options.ciphername =3D c->c1.ciphername;
>>      c->options.authname =3D c->c1.authname;
>>      c->options.keysize =3D c->c1.keysize;
>> +    c->options.data_channel_use_ekm =3D false;
>>  }
>>=20=20
>>  void
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index 13738180..a5862020 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -1817,6 +1817,10 @@ multi_client_set_protocol_options(struct context =
*c)
>>          c->c2.push_request_received =3D true;
>>      }
>>=20=20
>> +#ifdef HAVE_EXPORT_KEYING_MATERIAL
>> +    o->data_channel_use_ekm =3D (proto & IV_PROTO_TLS_KEY_EXPORT);
>> +#endif
>> +
>>      /* Select cipher if client supports Negotiable Crypto Parameters */
>>      if (!o->ncp_enabled)
>>      {
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 8bf82c57..90e78a7b 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -7947,6 +7947,20 @@ add_option(struct options *options,
>>          }
>>          options->ncp_ciphers =3D p[1];
>>      }
>> +    else if (streq(p[0], "key-derivation") && p[1])
>> +    {
>> +        VERIFY_PERMISSION(OPT_P_NCP)
>> +#ifdef HAVE_EXPORT_KEYING_MATERIAL
>> +        if (streq(p[1], "tls-ekm"))
>> +        {
>> +            options->data_channel_use_ekm =3D true;
>> +        }
>> +        else
>> +#endif
>> +        {
>> +            msg(msglevel, "Unknown key-derivation method %s", p[1]);
>> +        }
>> +    }
>=20
> This option is also accepted on the command line or config file, but is
> not documented in the man page or --help text. It would probably be best
> to not accept is on the command line or config file, but I'm not sure we
> have the infra in place for that.

Sadly, we don't. Other options like peer-id or echo are also accepted
from command line or config. Or we have it and nobody is aware of how to
use it.

>=20
> So, looks good in general, but needs a bit more polishing :)
>

I will do the polishing and send a new version :)

Thanks for reviewing.

Arne


--gS5QXblmqQA9oWyPjbR2iTvAoHE4Pt1YK--

--ITLD7eTiJXsxtR0IdtEyW62dCGWOjrTFt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl+ATbsACgkQFRhsZwKx
RFRPKQ/9HTWoTpDRELtdETH2P4e+lvhs3wlK6IPZC6aXnY2l5oybFmu6jyrbn4z3
UKnSwd5yI4aeXB7BN4NQGJJAL4wra5M3ghF+D6EhbYjks4ndf8bzkKJBaykGp/Oy
rl/TbpIMPAnx+aK+pK9Gw71N2aFO5ho3kbVU0wlgtuiMfvylccdkJ6FOBtuke/B7
3PlVoWLlgpyeodnXR3053qsOmg+Y+Iljas+nyI7GQnSq5PGcOq+DFtkgj30TyNlA
BUBqazxDbkwO6gZOL2ua+miKFGaJtJxx6sJIxbGbcwRfzGDe0F6HSZtjI8xY61BM
F9USLKnJzK0MVgLbxHD+cLpEhuBz8F/Dub1no39hWHkNogSozFkBpJ8HQxEDSkV9
gBHdvx/Q7fdCvIfrJAxzeWwxtKxLxt3F2nDE7HCNjIQQ7/3PzX9t3iHrhscQniDT
3xP9znpvUrt5MdCZm2XKO3A1Vv4d6eoSWjJ/0LdTDMeo50eV/AWMdQYsoTkzjiAa
AAZ989MUCOnpmGjwGF4flDBlLw0lEWxJ2CPvifa3J0iuvL56UjuAvmXiJ19HtF7D
6zufCgveUuILaCFbWNZHjtm1ZW0TXRjxqkJQEMT29qYX5sLPrSxOrz8CgUqBscpi
BLFnOM2VQZ9ufFmbRpz/2bCHcSemKQCdMWgVhbgxP5FeJvvPhXo=
=R3I2
-----END PGP SIGNATURE-----

--ITLD7eTiJXsxtR0IdtEyW62dCGWOjrTFt--

