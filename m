References: <20181011220639.7316-1-arne@...1227...>
 <40a60bc4-eb11-1d5e-cf45-be328b7a3e5e@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0e83b3d5-1bbe-ff6e-56ba-75d11c0059ab@...1227...>
Date: Fri, 12 Oct 2018 13:42:24 +0200
MIME-Version: 1.0
In-Reply-To: <40a60bc4-eb11-1d5e-cf45-be328b7a3e5e@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uFCmzmvq4ZS193ie3937fr90dtCpc1Ss9"
Subject: Re: [Openvpn-devel] [PATCH] Use right function to set TLS1.3
 restrictions in show-tls
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
--uFCmzmvq4ZS193ie3937fr90dtCpc1Ss9
Content-Type: multipart/mixed; boundary="X3rbOzMAwTBYH7wiEMMWEbh8PovhINFDe";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <0e83b3d5-1bbe-ff6e-56ba-75d11c0059ab@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Use right function to set TLS1.3
 restrictions in show-tls
References: <20181011220639.7316-1-arne@...1227...>
 <40a60bc4-eb11-1d5e-cf45-be328b7a3e5e@...2080...>
In-Reply-To: <40a60bc4-eb11-1d5e-cf45-be328b7a3e5e@...2080...>

--X3rbOzMAwTBYH7wiEMMWEbh8PovhINFDe
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 12.10.18 um 12:38 schrieb David Sommerseth:
> On 12/10/18 00:06, Arne Schwabe wrote:
>> The last version of the patch used the TLS1.2 version
>> tls_ctx_restrict_ciphers to set the restrictions for both
>> TLS 1.3 and TLS1.2 instead of using tls_ctx_restrict_ciphers_tls13
>> for TLS1.3.
>>
>> Also fix minor style problem while I am touching the function
>> ---
>>  src/openvpn/ssl_openssl.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>> index 6717ded0..da573cfa 100644
>> --- a/src/openvpn/ssl_openssl.c
>> +++ b/src/openvpn/ssl_openssl.c
>> @@ -2002,15 +2002,16 @@ show_available_tls_ciphers_list(const char *ciph=
er_list,
>>      if (tls13)
>>      {
>>          SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
>> +        tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
>=20
> Isn't this function only available in OpenSSL 1.1.1 and newer?  Or am I
> missing a fine detail here?
>

It is and it is a block ifdef'ed by OpenSSL version.

Arne



--X3rbOzMAwTBYH7wiEMMWEbh8PovhINFDe--

--uFCmzmvq4ZS193ie3937fr90dtCpc1Ss9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlvAiKAACgkQFRhsZwKx
RFRmRQ/+J8hkjqbMMXrallBPxsR9s7CFbCfTuvrjQP7MjFUlz/JlVN6IxwvTvkm9
F6Nc3yglgY659Lzurt7+cM+w/3JyJ26QrHIZD2eUAdeLnVR3hjwNiQMdp8XHY0Z5
+owFTsr4krSoOQ7MVq71Mv+C8rIYnFSDMUKjmgF+n+Atk65uGLkE6T1/RzyAWlVf
B3PWoBp49quCZ/Alm58TEArKnKNv9NaWnODIA3l59D4mA/rYvqDe/wk3Pvx62OrH
ZrnkqkTLZhIx4tH87Cily8yHt/7rk8Ev5LWFQHhwdfx1syyTfycN49KAC3zR/CM+
O/yZFFo+d6TCsIEwGjZKGnOVvuBMQ4nj8ZmQ/mAxwP1ueVE+KPqO0lfdC9/ekOkM
uaMmv5aj7IRLfClL0u8uKCs4P8laaIUFY3Ty4GZUX4hHWIbcc+K/IEetsmpvTeN2
NPrYBFk2WFZMEeKSII+6tBHmwdxh0J9FeZg2hjOYIB37T25ZgOHr7v4/PAt2orj+
oGX1B7MQTTQDd04z7gEH09JMYXmc3M1SsAR1a4gzZRCJDiUJ53qrZfJ0oXbp+rvF
w/woOMSVHzQVO45Yw9fcwzrhfpD+rNCJ5yicg7OWtvSO4la8nJ3XAgrRxLj+x7LN
Cc6Y30vQN5Pdr/yCpl87iFXdr01l+Yqo8/IXwMIMPr7RjOUZLr4=
=NHuP
-----END PGP SIGNATURE-----

--uFCmzmvq4ZS193ie3937fr90dtCpc1Ss9--

