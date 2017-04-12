References: <20170411173133.18060-1-davids@...515...>
	<429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
	<d290d0456b329f2deae5992d92e1972f.squirrel@...2257...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2efd6abc-3586-0ac8-6253-14578b3d7602@...2080...>
Date: Wed, 12 Apr 2017 11:30:16 +0200
MIME-Version: 1.0
In-Reply-To: <d290d0456b329f2deae5992d92e1972f.squirrel@...2257...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hEDObHXUPtQN39ohWCdakaxXuxK46vk5P"
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hEDObHXUPtQN39ohWCdakaxXuxK46vk5P
Content-Type: multipart/mixed; boundary="2XRQpbSi56araHPtSjA21BbDWCbFifsF3";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Simon Matter <simon.matter@...2249...>,
	Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <2efd6abc-3586-0ac8-6253-14578b3d7602@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
References: <20170411173133.18060-1-davids@...515...>
	<429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
	<d290d0456b329f2deae5992d92e1972f.squirrel@...2257...>
In-Reply-To: <d290d0456b329f2deae5992d92e1972f.squirrel@...2257...>

--2XRQpbSi56araHPtSjA21BbDWCbFifsF3
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 12/04/17 06:58, Simon Matter wrote:
>> Hi,
>>
>> On 11-04-17 19:31, David Sommerseth wrote:
>>> As RHEL 5 has reached EOL, we no longer need to support OpenSSL v0.9.8.
>>> This also makes it possible to remove a few workaronds which was
>>> needed earlier, as well as some left overs from v0.9.6.
>>>
>>> This also makes ./configure really stop running unless a new enough
>>> OpenSSL library is found.
>>>
>>> Compile tested on RHEL7.3 and RHEL6.7 (mock chroot build), both shipping
>>> openssl-1.0.1e.
>>>
>>> Signed-off-by: David Sommerseth <davids@...515...>
>>> ---
>>>  configure.ac                                                  |  6
>>> +++---
>>>  doc/openvpn.8                                                 |  1 -
>>>  .../keying-material-exporter-demo/keyingmaterialexporter.c    |  3 +--
>>>  sample/sample-plugins/log/log_v3.c                            |  3 +--
>>>  src/openvpn/ssl_openssl.c                                     |  3 ---
>>>  src/openvpn/ssl_openssl.h                                     | 11
>>> -----------
>>>  src/openvpn/ssl_verify_openssl.c                              |  6
>>> ++----
>>>  7 files changed, 7 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 2406ad8..acea060 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -859,9 +859,9 @@ if test "${enable_crypto}" =3D "yes" -a
>>> "${with_crypto_library}" =3D "openssl"; then
>>>  		# if the user did not explicitly specify flags, try to autodetect
>>>  		PKG_CHECK_MODULES(
>>>  			[OPENSSL],
>>> -			[libcrypto >=3D 0.9.8, libssl >=3D 0.9.8],
>>> -	        [have_openssl=3D"yes"],
>>> -			[have_openssl=3D"no"] # Provide if-not-found to prevent erroring out
>>> +			[libcrypto >=3D 1.0.1, libssl >=3D 1.0.1],
>>> +	                [have_openssl=3D"yes"],
>>> +			[AC_MSG_ERROR([Minimum supported OpenSSL version is 1.0.1])]
>>>  		)
>>>
>>>  		OPENSSL_LIBS=3D${OPENSSL_LIBS:--lssl -lcrypto}
>>> diff --git a/doc/openvpn.8 b/doc/openvpn.8
>>> index a9f5db7..c3248fd 100644
>>> --- a/doc/openvpn.8
>>> +++ b/doc/openvpn.8
>>> @@ -2773,7 +2773,6 @@ OPENVPN_PLUGIN_TLS_FINAL callback.
>>>  Note that exporter labels have the potential to collide with existing
>>> PRF
>>>  labels. In order to prevent this, labels MUST begin with "EXPORTER".
>>>
>>> -This option requires OpenSSL 1.0.1 or newer.
>>>  .\"*********************************************************
>>>  .SS Server Mode
>>>  Starting with OpenVPN 2.0, a multi-client TCP/UDP server mode
>>> diff --git
>>> a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
>>> b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
>>> index 177977d..a72b374 100644
>>> ---
>>> a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
>>> +++
>>> b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
>>> @@ -143,8 +143,7 @@ session_user_set(struct session *sess, X509 *x509)
>>>          {
>>>              continue;
>>>          }
>>> -        /* bug in OpenSSL 0.9.6b ASN1_STRING_to_UTF8 requires this
>>> workaround */
>>> -        unsigned char *buf =3D (unsigned char *)1;
>>> +        unsigned char *buf =3D NULL;
>>>          if (ASN1_STRING_to_UTF8(&buf, val) <=3D 0)
>>>          {
>>>              continue;
>>> diff --git a/sample/sample-plugins/log/log_v3.c
>>> b/sample/sample-plugins/log/log_v3.c
>>> index 9037225..d3014f3 100644
>>> --- a/sample/sample-plugins/log/log_v3.c
>>> +++ b/sample/sample-plugins/log/log_v3.c
>>> @@ -197,7 +197,7 @@ x509_print_info(X509 *x509crt)
>>>      X509_NAME *x509_name;
>>>      X509_NAME_ENTRY *ent;
>>>      const char *objbuf;
>>> -    unsigned char *buf;
>>> +    unsigned char *buf =3D NULL;
>>>
>>>      x509_name =3D X509_get_subject_name(x509crt);
>>>      n =3D X509_NAME_entry_count(x509_name);
>>> @@ -228,7 +228,6 @@ x509_print_info(X509 *x509crt)
>>>          {
>>>              continue;
>>>          }
>>> -        buf =3D (unsigned char *)1; /* bug in OpenSSL 0.9.6b
>>> ASN1_STRING_to_UTF8 requires this workaround */
>>>          if (ASN1_STRING_to_UTF8(&buf, val) <=3D 0)
>>>          {
>>>              continue;
>>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>>> index d7cc2ba..645ccf5 100644
>>> --- a/src/openvpn/ssl_openssl.c
>>> +++ b/src/openvpn/ssl_openssl.c
>>> @@ -254,10 +254,7 @@ tls_ctx_set_options(struct tls_root_ctx *ctx,
>>> unsigned int ssl_flags)
>>>              sslopt |=3D SSL_OP_NO_TLSv1_2;
>>>          }
>>>  #endif
>>> -#ifdef SSL_OP_NO_COMPRESSION
>>> -        /* Disable compression - flag not available in OpenSSL 0.9.8 */
>>>          sslopt |=3D SSL_OP_NO_COMPRESSION;
>>> -#endif
>>>          SSL_CTX_set_options(ctx->ctx, sslopt);
>>>      }
>>>
>>> diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
>>> index 6ca4cb6..60a1f5e 100644
>>> --- a/src/openvpn/ssl_openssl.h
>>> +++ b/src/openvpn/ssl_openssl.h
>>> @@ -33,17 +33,6 @@
>>>  #include <openssl/ssl.h>
>>>
>>>  /**
>>> - * SSL_OP_NO_TICKET tells OpenSSL to disable "stateless session
>>> resumption",
>>> - * as this is something we do not want nor need, but could potentially
>>> be
>>> - * used for a future attack.  For compatibility reasons we keep
>>> building if the
>>> - * OpenSSL version is too old (pre-0.9.8f) to support stateless session
>>> - * resumption (and the accompanying SSL_OP_NO_TICKET flag).
>>> - */
>>> -#ifndef SSL_OP_NO_TICKET
>>> -#define SSL_OP_NO_TICKET 0
>>> -#endif
>>> -
>>> -/**
>>>   * Structure that wraps the TLS context. Contents differ depending on
>>> the
>>>   * SSL library used.
>>>   */
>>> diff --git a/src/openvpn/ssl_verify_openssl.c
>>> b/src/openvpn/ssl_verify_openssl.c
>>> index 5624daa..54eadbd 100644
>>> --- a/src/openvpn/ssl_verify_openssl.c
>>> +++ b/src/openvpn/ssl_verify_openssl.c
>>> @@ -458,8 +458,7 @@ x509_setenv_track(const struct x509_track *xt,
>>> struct env_set *es, const int dep
>>>                          if (ent)
>>>                          {
>>>                              ASN1_STRING *val =3D
>>> X509_NAME_ENTRY_get_data(ent);
>>> -                            unsigned char *buf;
>>> -                            buf =3D (unsigned char *)1; /* bug in Open=
SSL
>>> 0.9.6b ASN1_STRING_to_UTF8 requires this workaround */
>>> +                            unsigned char *buf =3D NULL;
>>>                              if (ASN1_STRING_to_UTF8(&buf, val) > 0)
>>>                              {
>>>                                  do_setenv_x509(es, xt->name, (char
>>> *)buf, depth);
>>> @@ -514,7 +513,7 @@ x509_setenv(struct env_set *es, int cert_depth,
>>> openvpn_x509_cert_t *peer_cert)
>>>      ASN1_STRING *val;
>>>      X509_NAME_ENTRY *ent;
>>>      const char *objbuf;
>>> -    unsigned char *buf;
>>> +    unsigned char *buf =3D NULL;
>>>      char *name_expand;
>>>      size_t name_expand_size;
>>>      X509_NAME *x509 =3D X509_get_subject_name(peer_cert);
>>> @@ -547,7 +546,6 @@ x509_setenv(struct env_set *es, int cert_depth,
>>> openvpn_x509_cert_t *peer_cert)
>>>          {
>>>              continue;
>>>          }
>>> -        buf =3D (unsigned char *)1; /* bug in OpenSSL 0.9.6b
>>> ASN1_STRING_to_UTF8 requires this workaround */
>>>          if (ASN1_STRING_to_UTF8(&buf, val) <=3D 0)
>>>          {
>>>              continue;
>>>
>>
>> For master: ACK.
>>
>> For release/2.4: I wonder whether we need to keep 0.9.8 support, as
>> SLES11 still ships with 0.9.8h, and has general support until 31 Mar 201=
9.
>=20
> To make the picture complete, there is also the "extended" support for EL5
> for paying customers. For both RedHat EL5 and Oracle's EL5 clone extended
> support ends somewhere in 2020.

That is correct.  But we decided that is for really special installs.
Those users also pay an incredible high premium to Red Hat (and I
wouldn't expect Oracle to be different) to get access to the ELS
(Extended Life-cycle Support).  IIRC, it is also something not all
customers are eligible to buy.  I don't even think you can buy ELS from
their web-shop, you have to go through a sales contact.

<https://access.redhat.com/support/policy/updates/errata/#Extended_Life_Cyc=
le_Phase>

The ELS is also only supported on a very restricted set of packages:
<https://access.redhat.com/articles/2901071>

So considering that this isn't something being too common, we decided a
long time ago it isn't worth the hassle for us.  We anyway do support
OpenVPN v2.3 for a while more, which will work on EL5.  So if someone
really wants to stay on EL5 longer, they need to accept that they won't
get the newest OpenVPN versions.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--2XRQpbSi56araHPtSjA21BbDWCbFifsF3--

--hEDObHXUPtQN39ohWCdakaxXuxK46vk5P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY7fOoAAoJEIbPlEyWcf3ykq0P/2utArUp69gat8ywdv1eQKe4
eUEOugJV/OZpOxzy6rTMpSIBGKTuBIk+KJaX8a6iB+ij2EZ1SI/QDLsu9Jt8Kb0l
GTq4eIG0u6S4TTGKFNmk+sjHDFXHh7Bd7JPF/CsX2lRg7/B5T3AacAXA3U2Q/T2N
9tLOEEtP8vwOZLu3b2JU/FLWQbScNTRqcbulZYnOZe0GrBci92Z0xbeG767NRTyK
vtjOGtConLL9hqW4ZBycJhsksSmieeWZ1+29H5ngeqEp1+wOcmmtdvUR3cg8aFhR
u0gz/9damNikm3hjaWp/jWNB/wL+0G7hFiNL9zF4NuRaS1MlVv00ecy7FqcotNFC
cYF22yNQS05OUyV2xJKL6+J0E+zjo/Odhwe7KT1lqFDqJQ+0pfoBbJf6Dw76g2Kt
4OfGzGnX7nCAVFUwvoNHX9VbOzP9NlDvPZjqPd17hsIyn5r4v74pxAE/KH8ggOjA
N1/1NzUGHZ2duAcljFvB7ZLCDKBAm/DhB2juJR8k3+zpcR4tKioEIOr+DnMZDeoR
UNdlNt6kvRy2IfdgjhMi2rQIbVvSQasSX2RMS8bMg/IGQCVUUH8udyUZLHxO1PSL
bZefAxfKNmmp0z8aqR2fKpp3wiG7Upu3gah1D0Z/pGoLTlROPk27Cj97r1+HxkpV
cseXPzn7ENj0dO+QggMJ
=H0yx
-----END PGP SIGNATURE-----

--hEDObHXUPtQN39ohWCdakaxXuxK46vk5P--

