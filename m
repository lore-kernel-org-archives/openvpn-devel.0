References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
 <c0192fdc-6aa8-5ac6-27ac-6729dbe22991@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8c547b28-f6af-7a3f-d461-baca78ed2a47@...2080...>
Date: Fri, 24 Jul 2020 10:56:01 +0200
MIME-Version: 1.0
In-Reply-To: <c0192fdc-6aa8-5ac6-27ac-6729dbe22991@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NBxrvgArI9y4nXxi0JN9OAitfoElc52UM"
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
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
--NBxrvgArI9y4nXxi0JN9OAitfoElc52UM
Content-Type: multipart/mixed; boundary="lqCG6OGNIAJX6vH0cF318mTO1WAGtSw2Q";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <8c547b28-f6af-7a3f-d461-baca78ed2a47@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
 <c0192fdc-6aa8-5ac6-27ac-6729dbe22991@...1856...>
In-Reply-To: <c0192fdc-6aa8-5ac6-27ac-6729dbe22991@...1856...>

--lqCG6OGNIAJX6vH0cF318mTO1WAGtSw2Q
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 24/07/2020 10:14, Steffan Karger wrote:
> Hi,
>=20
> On 17-07-2020 15:47, Arne Schwabe wrote:
>> The change in name signals that data-ciphers is the preferred way to
>> configure data channel (and not --cipher). The data prefix is chosen
>> to avoid ambiguity and make it distinct from tls-cipher for the TLS
>> ciphers.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  Changes.rst                            | 13 ++++++++++---
>>  doc/man-sections/protocol-options.rst  | 11 +++++++----
>>  doc/man-sections/server-options.rst    |  4 ++--
>>  sample/sample-config-files/client.conf |  2 +-
>>  src/openvpn/multi.c                    |  4 ++--
>>  src/openvpn/options.c                  |  5 +++--
>>  src/openvpn/ssl_ncp.c                  |  4 ++--
>>  7 files changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/Changes.rst b/Changes.rst
>> index 6e283270..2158c8e7 100644
>> --- a/Changes.rst
>> +++ b/Changes.rst
>> @@ -14,12 +14,19 @@ ChaCha20-Poly1305 cipher support
>>      channel.
>>=20=20
>>  Improved Data channel cipher negotiation
>> +    The option ``ncp-ciphers`` has been renamed to ``data-ciphers``.
>> +    The old name is still accepted. The change in name signals that
>> +    ``data-ciphers`` is the preferred way to configure data channel
>> +    ciphers and the data prefix is chosen to avoid the ambiguity that
>> +    exists with ``--cipher`` for the data cipher and ``tls-cipher``
>> +    for the TLS ciphers.
>> +
>>      OpenVPN clients will now signal all supported ciphers from the
>> -    ``ncp-ciphers`` option to the server via ``IV_CIPHERS``. OpenVPN
>> -    servers will select the first common cipher from the ``ncp-ciphers``
>> +    ``data-ciphers`` option to the server via ``IV_CIPHERS``. OpenVPN
>> +    servers will select the first common cipher from the ``data-ciphers=
``
>>      list instead of blindly pushing the first cipher of the list. This
>>      allows to use a configuration like
>> -    ``ncp-ciphers ChaCha20-Poly1305:AES-256-GCM`` on the server that
>> +    ``data-ciphers ChaCha20-Poly1305:AES-256-GCM`` on the server that
>>      prefers ChaCha20-Poly1305 but uses it only if the client supports i=
t.
>>=20=20
>>  Asynchronous (deferred) authentication support for auth-pam plugin.
>> diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/pr=
otocol-options.rst
>> index 923d2da0..051f1d32 100644
>> --- a/doc/man-sections/protocol-options.rst
>> +++ b/doc/man-sections/protocol-options.rst
>> @@ -62,7 +62,7 @@ configured in a compatible way between both the local =
and remote side.
>>    The default is :code:`BF-CBC`, an abbreviation for Blowfish in Cipher
>>    Block Chaining mode. When cipher negotiation (NCP) is allowed,
>>    OpenVPN 2.4 and newer on both client and server side will automatical=
ly
>> -  upgrade to :code:`AES-256-GCM`.  See ``--ncp-ciphers`` and
>> +  upgrade to :code:`AES-256-GCM`.  See ``--data-ciphers`` and
>>    ``--ncp-disable`` for more details on NCP.
>>=20=20
>>    Using :code:`BF-CBC` is no longer recommended, because of its 64-bit
>> @@ -169,7 +169,7 @@ configured in a compatible way between both the loca=
l and remote side.
>>    non-standard key lengths, and a larger key may offer no real guarantee
>>    of greater security, or may even reduce security.
>>=20=20
>> ---ncp-ciphers cipher-list
>> +--data-ciphers cipher-list
>>    Restrict the allowed ciphers to be negotiated to the ciphers in
>>    ``cipher-list``. ``cipher-list`` is a colon-separated list of ciphers,
>>    and defaults to :code:`AES-256-GCM:AES-128-GCM`.
>> @@ -189,9 +189,9 @@ configured in a compatible way between both the loca=
l and remote side.
>>    Additionally, to allow for more smooth transition, if NCP is enabled,
>>    OpenVPN will inherit the cipher of the peer if that cipher is differe=
nt
>>    from the local ``--cipher`` setting, but the peer cipher is one of the
>> -  ciphers specified in ``--ncp-ciphers``. E.g. a non-NCP client (<=3Dv2=
.3,
>> +  ciphers specified in ``--data-ciphers``. E.g. a non-NCP client (<=3Dv=
2.3,
>>    or with --ncp-disabled set) connecting to a NCP server (v2.4+) with
>> -  ``--cipher BF-CBC`` and ``--ncp-ciphers AES-256-GCM:AES-256-CBC`` set=
 can
>> +  ``--cipher BF-CBC`` and ``--data-ciphers AES-256-GCM:AES-256-CBC`` se=
t can
>>    either specify ``--cipher BF-CBC`` or ``--cipher AES-256-CBC`` and bo=
th
>>    will work.
>>=20=20
>> @@ -201,6 +201,9 @@ configured in a compatible way between both the loca=
l and remote side.
>>    This list is restricted to be 127 chars long after conversion to Open=
VPN
>>    ciphers.
>>=20=20
>> +  This option was called ``ncp-ciphers`` in OpenVPN 2.4 but has been re=
named
>> +  to ``data-ciphers`` in OpenVPN 2.5 to more accurately reflect its mea=
ning.
>> +
>>  --ncp-disable
>>    Disable "Negotiable Crypto Parameters". This completely disables ciph=
er
>>    negotiation.
>> diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/serv=
er-options.rst
>> index c24aec0b..74ad5e18 100644
>> --- a/doc/man-sections/server-options.rst
>> +++ b/doc/man-sections/server-options.rst
>> @@ -473,8 +473,8 @@ fast hardware. SSL/TLS authentication must be used i=
n this mode.
>>          *AES-GCM-128* and *AES-GCM-256*.
>>=20=20
>>    :code:`IV_CIPHERS=3D<ncp-ciphers>`
>> -        The client pushes the list of configured ciphers with the
>> -        ``--ciphers`` option to the server.
>> +        The client announces the list of supported ciphers configured w=
ith the
>> +        ``--data-ciphers`` option to the server.
>>=20=20
>>    :code:`IV_GUI_VER=3D<gui_id> <version>`
>>          The UI version of a UI if one is running, for example
>> diff --git a/sample/sample-config-files/client.conf b/sample/sample-conf=
ig-files/client.conf
>> index 7f2f30a3..47ca4099 100644
>> --- a/sample/sample-config-files/client.conf
>> +++ b/sample/sample-config-files/client.conf
>> @@ -112,7 +112,7 @@ tls-auth ta.key 1
>>  # then you must also specify it here.
>>  # Note that v2.4 client/server will automatically
>>  # negotiate AES-256-GCM in TLS mode.
>> -# See also the ncp-cipher option in the manpage
>> +# See also the data-ciphers option in the manpage
>>  cipher AES-256-CBC
>>=20=20
>>  # Enable compression on the VPN link.
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index 88ba9db2..d2549bca 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -1827,7 +1827,7 @@ multi_client_set_protocol_options(struct context *=
c)
>>          else
>>          {
>>              /*
>> -             * Push the first cipher from --ncp-ciphers to the client t=
hat
>> +             * Push the first cipher from --data-ciphers to the client =
that
>>               * the client announces to be supporting.
>>               */
>>              char *push_cipher =3D ncp_get_best_cipher(o->ncp_ciphers, o=
->ciphername,
>> @@ -1847,7 +1847,7 @@ multi_client_set_protocol_options(struct context *=
c)
>>                  {
>>                      msg(M_INFO, "PUSH: No common cipher between server =
and "
>>                          "client. Expect this connection not to work. Se=
rver "
>> -                        "ncp-ciphers: '%s', client supported ciphers '%=
s'",
>> +                        "data-ciphers: '%s', client supported ciphers '=
%s'",
>>                          o->ncp_ciphers, peer_ciphers);
>>                  }
>>                  else
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 31e33ae3..896abcde 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -536,7 +536,7 @@ static const char usage_message[] =3D
>>      "--cipher alg    : Encrypt packets with cipher algorithm alg\n"
>>      "                  (default=3D%s).\n"
>>      "                  Set alg=3Dnone to disable encryption.\n"
>> -    "--ncp-ciphers list : List of ciphers that are allowed to be negoti=
ated.\n"
>> +    "--data-ciphers list : List of ciphers that are allowed to be negot=
iated.\n"
>>      "--ncp-disable   : (DEPRECATED) Disable cipher negotiation.\n"
>>      "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
>>      "                   nonce_secret_len=3Dnsl.  Set alg=3Dnone to disa=
ble PRNG.\n"
>> @@ -7866,7 +7866,8 @@ add_option(struct options *options,
>>          VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
>>          options->ciphername =3D p[1];
>>      }
>> -    else if (streq(p[0], "ncp-ciphers") && p[1] && !p[2])
>> +    else if ((streq(p[0], "data-ciphers") || streq(p[0], "ncp-ciphers"))
>> +            && p[1] && !p[2])
>>      {
>>          VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
>>          options->ncp_ciphers =3D p[1];
>> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
>> index e057a40b..6760884e 100644
>> --- a/src/openvpn/ssl_ncp.c
>> +++ b/src/openvpn/ssl_ncp.c
>> @@ -111,7 +111,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_a=
rena *gc)
>>          const cipher_kt_t *ktc =3D cipher_kt_get(token);
>>          if (!ktc)
>>          {
>> -            msg(M_WARN, "Unsupported cipher in --ncp-ciphers: %s", toke=
n);
>> +            msg(M_WARN, "Unsupported cipher in --data-ciphers: %s", tok=
en);
>>              error_found =3D true;
>>          }
>>          else
>> @@ -130,7 +130,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_a=
rena *gc)
>>              if (!(buf_forward_capacity(&new_list) >
>>                    strlen(ovpn_cipher_name) + 2))
>>              {
>> -                msg(M_WARN, "Length of --ncp-ciphers is over the "
>> +                msg(M_WARN, "Length of --data-ciphers is over the "
>>                      "limit of 127 chars");
>>                  error_found =3D true;
>>              }
>>
>=20
> Thanks. Patch looks good, and passes manual tests.
>=20
> Acked-by: Steffan Karger <steffan@...1856...>

NAK.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--lqCG6OGNIAJX6vH0cF318mTO1WAGtSw2Q--

--NBxrvgArI9y4nXxi0JN9OAitfoElc52UM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfGqIhAAoJEIbPlEyWcf3y21wQAMK7mSXEfFt/nciwmYRzlvN6
WNjBYIdGv0DyChxdiLOoHpCyoGS07UTVrNdV38BQMRyq+M1x+bfBJC5Mz7gT+3eq
855cSUvTxeiS/xLGh0IzDseqTGKa6Kl/QETOJgRCj4owDag7WaAlITTxo/cKqDzC
B1xg2JAhDa2JOXBQ7MvfQofX3+npwj6DaxLYSwoXLxFxThFZolN0XoBOzaxIdmHB
1BL0fPu8FmnciaazLAb+dnSre6wTaDZhrvHFfXFPjlx/6ymx0Tvg8r72oCF5xCO1
+hEjt07rKKr+RQA55SDYNHwOPdIsV+ECAa0F1rgNhM2zpiSdSzVtOIwV/gAZ8qV0
6igGlvnGZWMrNldmAM2zY/Oa9EPJ2v0hg6jv3WyI+vCBRkAbJ/lOC9birT06a4qx
ZeZSfLF9U5cSAUh65UAVWkzCB8DE9+kky7/GjgXPb+a9XMKTSqJd88lBb6YXwcSl
kXFJjfxMTTvBPVEbMf1l/yBu+y9ino9iv2Yhh60lnbbRQttbvogiw0GKHkOEsWXa
mQzfJXNIS//j1Ot5k+Km7WluL3h/+WmH/gYkpv73Hd4D3RPVxvZd29noCz33sLTX
DsecPmr+04ounMHAu0rHOzjVlpn65Tmx+aiSYzLCxYUrTlzJSjZB31OoA+x4NzOK
vk8blbXSMx6M70v3jRRn
=exVh
-----END PGP SIGNATURE-----

--NBxrvgArI9y4nXxi0JN9OAitfoElc52UM--

