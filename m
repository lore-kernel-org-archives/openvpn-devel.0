References: <20181007215837.489-1-arne@...1227...>
 <CAKuzo_gpYNnLaBdaKwiUGsRbRJL0BnNceBUq37NPBughb8qKFw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <028e0036-d9bc-94ac-603d-64d9be6b2bc2@...1227...>
Date: Wed, 17 Oct 2018 11:59:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gpYNnLaBdaKwiUGsRbRJL0BnNceBUq37NPBughb8qKFw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rBKI0uKOOgp0wYnvy6mjoI1yiMdNWdaU1"
Subject: Re: [Openvpn-devel] [PATCH] Add support for OpenSSL TLS 1.3 when
 using management-external-key
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
--rBKI0uKOOgp0wYnvy6mjoI1yiMdNWdaU1
Content-Type: multipart/mixed; boundary="plZGxdB6mSnc9LpwLzDdn2LsU4AKkeUfA";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <028e0036-d9bc-94ac-603d-64d9be6b2bc2@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for OpenSSL TLS 1.3 when
 using management-external-key
References: <20181007215837.489-1-arne@...1227...>
 <CAKuzo_gpYNnLaBdaKwiUGsRbRJL0BnNceBUq37NPBughb8qKFw@...278...>
In-Reply-To: <CAKuzo_gpYNnLaBdaKwiUGsRbRJL0BnNceBUq37NPBughb8qKFw@...278...>

--plZGxdB6mSnc9LpwLzDdn2LsU4AKkeUfA
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 17.10.18 um 05:15 schrieb Selva Nair:
> Hi,
>=20
> Not a review, but some thoughts:
>=20
> On Sun, Oct 7, 2018 at 5:59 PM Arne Schwabe <arne@...1227...> wrote:
>>
>> For TLS 1.0 to 1.2 OpenSSL calls us and requires a PKCS1 padded
>> response, for TLS 1.3 it requires to an unpadded response. Since we
>> can PCKS1 pad an unpadded response, we prefer to always query for
>> an unpadded response from the management interface and add the PCKS1
>> padding ourselves when needed.
>=20
>=20
> First, one clarification:
>=20
> The reason for unpadded response is that when PSS padding is in use,
> OpenSSL adds the padding and, thus, asks for raw RSA encryption
> (unpadded). This is because RSA_sign or rsa_priv_enc callbacks
> do not support a way of indicating PSS padding. In fact, OpenSSL
> 1.1.1 client talking to 1.1.1 server prefers PSS padding even for
> TLS 1.2, so this is not a TLS 1.3-only problem.

Ah did not get that extra problem.

>> This patch adds an 'unpadded' parameter to the management-external-key
>> option to signal that it is uses the new unpadded API. Since we cannot
>=20
> I do not particularly like this new option:
> "management-external-key-unpadded". Apart from the confusing name,
> this doesn't really address the basic limitation of the current
> pkey-sig (old rsa-sig) directive. We should have extended it when the
> new name was introduced. pkey-sig should pass not just the data (or
> hash) to sign but additional info like digest type in use, padding
> mode etc. Or have a way for the management client to query additional
> parameters that may be necessary for signing.

Yes. But we still need a way to signal the capabilities of the
management client to OpenVPN, otherwise we will query for a signature
that we might not support. How about adding the supported signatures as
parameters?

E.g. management-external-key pkcs1 raw pss

> Using padded data and requiring the external "engine" to do a raw
> signature may look like a way out of this but not really: not all external
> libraries may support such a usage. AFAICS, Windows CNG does not. Also
> some hardware devices may insist on doing the padding inside --
> especially non-deterministic padding like PSS.


I have kind of the opposite problem. At least older Android version do
not expose signing with PSS. So I have to sign with a raw signature
anyway. And I would like to avoid implementing PSS in OpenVPN.

>=20
> So what about naming this "management-external-key-version2" and then
> extend pk-sig as below?
>=20
> pk-sig <base64-data-to-sign> [signing-algorithm]

Sure, not a problem with me.

> where the <signing algorithm> could be, say, SHA256_RSA_PKCS1 or
> NONE_RSA_PKCS1 or SHA384_RSA_PSS etc. If missing, and the key
> is RSA, the client can assume it is NONE_RSA_PKCS1 and expect the hash
> with digest-info header already added and sign as such. Or, if the key
> is EC, do the ECDSA signing operation as is being done now.
>=20
> The "unpadded" case could be indicated by NONE_RSA_RAW. These
> mnemonics are just examples -- we could use PKCS11 identifiers or somethi=
ng
> else.
>=20
> To get unpadded data we have to override sign() in EVP_PKEY_METHOD but
> that would also provide max flexibility.
>=20
> Now, I think its safe to just update and document this and require that
> management-interface clients that use the external key feature must
> update if using client compiled with OpenSSL 1.1.1. Android(?) and iOS (?)
> clients may be the only one's affected, but those are shipped as one comp=
lete
> package. I'm not aware of any standalone management-client UI that uses
> the external-key feature.

Might be just my client.

>> support TLS 1.3 without unpadded queries we disable TLS 1.3 otherwise.
>=20
> If we must do this, disabling TLS 1.3 will not enough. One way is to
> also explicitly set the padding mode to RSA_PKCS1_PADDING (for TLS1.2)
>=20
> EVP_PKEY_CTX_set_rsa_padding(ctx, pad) can do this.


Okay, I will add this to the patch to force pkcs1 padding. Thanks for
looking it up/pointing it out.

>=20
>>
>> We also do the same for cryptoapi since it uses the same API.
>=20
> Let's just fix cryptoapi --- I'm working on it. Anyway it does
> not use the same API as external key and prepadded data (=3D nopadding)
> will not work with Windows. This'll have to be fixed before we release bi=
naries
> linked with OpenSSL 1.1.1.

When I wrote that patch I did not know you would dive so fast into it :)

>=20
>>
>> Using the management api client version instead might seem like the
>> more logical way but since we only now that version very late,
>> it would extra logic and complexity to deal with this asynchronous
>> behaviour .
>=20
> IMO, we should explore this further and try to avoid
> --management-external-key-foo.

The biggest problem is that connect to the management interface is not
strictly enforced. If you don't have management-hold, the client might
start connecting before the management interface version is known and
start with TLS 1.3 while the management client is not yet connected and
might not support PSS signatures.

This management-external-key is a special feature I would like to opt
for simplicity here. I would rather just drop support for older
management clients that do not support the new padding but in the last
discussion of pk-sig vs rsa-sig we decided to keep support for older
clients.

Arne



--plZGxdB6mSnc9LpwLzDdn2LsU4AKkeUfA--

--rBKI0uKOOgp0wYnvy6mjoI1yiMdNWdaU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlvHCCYACgkQFRhsZwKx
RFSYLQ//XXWyHuuEj4kwCvq1VgUYCzVclBisza/7o6BeiBV+qN+9HKhZSa1TUr4Q
XjqtIS1vhGVq4k+/LVbzMD+J9ToiLyI0pZOCxhRpbLejkbVdn3cGZGg9myp66oSm
416GtUnhq2MyPdk41mScT0VFm7KWBZyqO4TqcD5vuRxJShvq0ezdxGFC8BgFLYiz
JxAqc//W9mQpQcKWeM4B87x4Q34YxIEhIPk6Qf2lzdXmuD6yuGDg3fTL84F3SaWa
j6I9Fy+4EPxhQXw+nP1tW2QVfwld5c42jGYSg6eA4QNRn5zkng46a2NM6YwSlEa2
z/z7t5pCnConxlrLtywQdXvOH8A/W2bIKjOgbkSGypnSNpKAylPfh6sUDFruuWZK
hWdl2ienUU8TxqAhrPMljlSNINhtqspR5EAiEBlWlAOZZOCe3JL6ZheSDxxNc3PK
lvEVS6efQuVetXtu2RRc7YW2lJM1jyZ3sKbfFuRhttofRBMsfdFsMNafIxKN309w
CC5itzFJyiyyOPGQalEMcJNtIkfHehPJp5M4CZpp/vSyPvCmrklLlX5fKQx+Ec2I
P2utlqM1fAwvlOewaEbFbc3vK1A26Ta/xXzjZ+Lh1Qw50x7AGzlo1XBuPVtJZ4GB
SHTuwYwXBLUGybBkbSYknJJi7wie74J4CX2+dDX/v+YEqODy3nU=
=0qCN
-----END PGP SIGNATURE-----

--rBKI0uKOOgp0wYnvy6mjoI1yiMdNWdaU1--

