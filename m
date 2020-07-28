References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-9-arne@...1227...>
 <e0b8b673-3ec2-d728-2da0-cc0dfb5b68e1@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <727152c2-bd1f-a1ef-62de-3fc7090cd942@...1227...>
Date: Tue, 28 Jul 2020 16:11:46 +0200
MIME-Version: 1.0
In-Reply-To: <e0b8b673-3ec2-d728-2da0-cc0dfb5b68e1@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5JXYzEbWIeErIB9c0kNMValnWBwzkoBMu"
Subject: Re: [Openvpn-devel] [PATCH 9/9] Rework NCP compability logic and
 drop BF-CBC support by default
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
--5JXYzEbWIeErIB9c0kNMValnWBwzkoBMu
Content-Type: multipart/mixed; boundary="PGKqTSfU5vnpdkfXW6HcJb4Y5JhvLt9aa"

--PGKqTSfU5vnpdkfXW6HcJb4Y5JhvLt9aa
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 28.07.20 um 14:27 schrieb Steffan Karger:

>>   * - peer id
>>   */
>> -static void
>> +static bool
>>  multi_client_set_protocol_options(struct context *c)
>>  {
>>=20=20
>> @@ -1807,8 +1807,11 @@ multi_client_set_protocol_options(struct context =
*c)
>>      }
>>=20=20
>>      /* Select cipher if client supports Negotiable Crypto Parameters */
>> -    if (o->ncp_enabled)
>> +    if (!o->ncp_enabled)
>>      {
>> +        return true;
>> +    }
>> +
>=20
> Hm, in this case I don't think this improves things. This turns
>=20

Yes. But this code will also be removed as soon as we hit 2.6 master and
remove ncp-disable and then the flow should be good.


>=20
> Can we please avoid using strcpy and strcat? Using openvpn_snprintf()
> should result in simpler code, and makes it easier to ensure that we
> won't overflow.
>=20
> Actually, looks like this already overflows, since there is no space for
> the null-byte in ncp_ciphers.

Yes, I still hate string handling in C. I hope my next attempt is better...


>>=20=20
>>      buf_printf(&out, ",dev-type %s", dev_type_string(o->dev, o->dev_typ=
e));
>> -    buf_printf(&out, ",link-mtu %u", (unsigned int) calc_options_string=
_link_mtu(o, frame));
>> +    if (o->ciphername)
>> +    {
>> +        /* the link-mtu that we send has only a meaning if have a fixed
>> +         * cipher (p2p) or have a fallback cipher for older non ncp
>> +         * clients. If we do have a fallback cipher, do not send it */
>=20
> This confuses me. The code reads like it's dependent on --cipher, rather
> than --fallbck-cipher. Also shouldn't this be "If we *don't* have a
> fallback cipher"?

Good catch. First I wanted to set ciphername =3D=3D NULL in case we don't
have a ciphername but to be to difficult for the time being. This an
oversight from that try.


>>      {
>>          const char *ios =3D ifconfig_options_string(tt, remote, o->ifco=
nfig_nowarn, gc);
>>          if (ios && strlen(ios))
>> @@ -3751,8 +3812,15 @@ options_string(const struct options *o,
>>=20=20
>>          init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
>>                        false);
>> -
>> -        buf_printf(&out, ",cipher %s", cipher_kt_name(kt.cipher));
>> +        /* Only announce the cipher to our peer if we are willing to
>> +         * support it */
>> +        const char *ciphername =3D cipher_kt_name(kt.cipher);
>> +        if (p2p_nopull || !o->ncp_enabled
>> +            || (o->ncp_enabled
>> +                && tls_item_in_cipher_list(ciphername, o->ncp_ciphers)))
>=20
> This second check for o->ncp_enabled is not needed. You already ensured
> it's true before. (Saves you a line wrap.)

I added to make the condition a bit clearer but I will remove it.

> I wonder though, isn't it too soon to stop sending cipher? Looks like
> both 2.3 and 2.4 clients will currently print options warnings if cipher
> is missing from OCC. The earlier NCP versions carefully tries to send
> what the peer expected here to prevent bogus warnings.

The main reason that I added it that sending it would break
compatibility with 2.5 master servers. Since --cipher BF-CBC, a server
would assume that it was supported. But I think we can keep sending
and instead assume that a client that sends IV_CIPHERS will only support
those and not necessarily the one in the OCC cipher. Basically disabling
Poor man's NCP when we see a 2.5 client. I would need to fix OpenVPN3 to
also include its --cipher in the IV_CIPHERS string but that is doable.

That would bascially break support of David's currently released
openpvn3-linux clients since they use openvpn3 master that has currently
has the hardcoded list

IV_CIPHERS=3DCHACHA20-POLY1305:AES-256-GCM:AES-128-GCM

and we would ignore the OCC cipher. But I think that is acceptable
because you need to actively set a ncp-ciphers option on the server to
something that removes the GCM ciphers.


>>  }
>> diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
>> index d00c222d..98f80286 100644
>> --- a/src/openvpn/ssl_ncp.h
>> +++ b/src/openvpn/ssl_ncp.h
>> @@ -44,10 +44,13 @@ tls_peer_supports_ncp(const char *peer_info);
>>   * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
>>   * Allows non-NCP peers to upgrade their cipher individually.
>>   *
>> + * Returns true if we switched to the peer's cipher
>> + *
>>   * Make sure to call tls_session_update_crypto_params() after calling t=
his
>>   * function.
>>   */
>> -void tls_poor_mans_ncp(struct options *o, const char *remote_ciphername=
);
>> +bool
>> +tls_poor_mans_ncp(struct options *o, const char *remote_ciphername);
>=20
> I think we almost always put the return type on the same line in header
> files. (Don't know why, but it seems quite consistent.)
> -Steffan

Depends on the header, but you are right.

Arne


--PGKqTSfU5vnpdkfXW6HcJb4Y5JhvLt9aa--

--5JXYzEbWIeErIB9c0kNMValnWBwzkoBMu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8gMiMACgkQFRhsZwKx
RFQN+BAAlbGw8gcQRLwSBAiJ5K5dC+AeyhVyQLlSr/4VYgjlQ7djPZK8y0Dfn9v9
EI7VRorQZ6zsPAGdDhTkuaSvP7gOJjlHIYGD0QVmB7r1FfGy4jdgM0F8Fclalvec
MHKqXykKmaqvr02wcQUKluAe/Joqt6U134rBzf1DePVAQEY4xANvg9XMFZPiEt3D
fkoWQg+2qATS1NsyVfrVrm8lbsTzNKifwd9FRsv0UeszBpQdyPxyxCDqAz41dCpW
AV9zbeayZ+Z7JSyxcMcfxTJIeAc0u2FHUpqkKdQbxpBQ9G2S/ZCTfBln6DTwHRP4
jXD4bMIkZh4YycxYRu0E3KYcGJIPYbdBCIJTwzOTDmmIvUH8q0fNJEKignXt5bmt
ZOgbChXtHiVKW8rDYdCWa+lNnHe5W4+QmzORfWMQM8zpQBiUDt4UpaDAEgLdHXoE
e70BkKPdxB6dhHdf62lvE+1bcYnUHS28LFX3cfjIrHcO488w7kzcTIqeGHuQaXqc
nQhKazuzlEsI4JKTu+w7xpDjlK8gd5IVo8KxvKANGVgV6FDIm3CataGnGGF6Moz3
seoXHLQ9JoiflqxIdbu8A+iEfBOjHJsY5Q4UXojS5ZIW26fisLzkpcQO2JNqz/QP
awCKXNzIaoesdEQiK2OoiZ9ElUXbMLdntWlQuXEOfWR/KVXh5iw=
=gSgz
-----END PGP SIGNATURE-----

--5JXYzEbWIeErIB9c0kNMValnWBwzkoBMu--

