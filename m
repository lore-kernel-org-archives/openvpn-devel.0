References: <20200911214002.24419-1-gert@...1296...>
 <20200917161909.11573-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <afc0f9bb-f0e0-9f97-782d-64fdaf2e8f1d@...2080...>
Date: Thu, 17 Sep 2020 20:48:03 +0200
MIME-Version: 1.0
In-Reply-To: <20200917161909.11573-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dVMEJ1cEGFLeHv8o39vqZzX7aQpgzO9kM"
Subject: Re: [Openvpn-devel] [PATCH v4] Add demo plugin that excercises
 "CLIENT_CONNECT" and "CLIENT_CONNECT_V2" paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dVMEJ1cEGFLeHv8o39vqZzX7aQpgzO9kM
Content-Type: multipart/mixed; boundary="89Gso2fVQnNPCstqDCHw2ixtL4SvWMzQk";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <afc0f9bb-f0e0-9f97-782d-64fdaf2e8f1d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v4] Add demo plugin that excercises
 "CLIENT_CONNECT" and "CLIENT_CONNECT_V2" paths
References: <20200911214002.24419-1-gert@...1296...>
 <20200917161909.11573-1-gert@...1296...>
In-Reply-To: <20200917161909.11573-1-gert@...1296...>

--89Gso2fVQnNPCstqDCHw2ixtL4SvWMzQk
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/09/2020 18:19, Gert Doering wrote:
> This is a new "samples" plugin which does not do many useful things,
> besides
>  - show how a plugin is programmed
>  - how the various messages get dispatched
>  - how to pass back information from a client-connect/v2 plugin
>  - how to do async-cc plugins  [not yet implemented]
>=20
> the operation of the plugin is controlled by UV_WANT_* environment variab=
les
> controlled by the client ("--setenv UV_WANT_CC_FAIL 1 --push-peer-info"),
> to "fail CLIENT_CONNECT" or "use async-cc for CLIENT_CONNECT_V2" or
> "send 'disable' back from ...") - which is useful for automated testing
> of server success/defer/fail code paths for the CLIENT_CONNECT_* function=
s.
>=20
> See samples/sample-plugins/client-connect/README for details how to do th=
is.
>=20
> v2:
>   - implement async / deferred operation both for CLIENT_CONNECT and
>     CLIENT_CONNECT_V2 plugin calls
>   - implement returning openvpn-controlled (setenv) config snippets
>     (so the client side can verify in automated testing that the plugin
>     operated correctly, without hard-coding something in the plugin code)
>=20
> v3:
>   - remove -Wno-unused-variable from Makefile
>   - remove unused "char ** argv" (commented out, but kept as reference)
>=20
> v4:
>   - upgrade to use the build infra brought by commit 0b5141d8f946
>   - remove local Makefile
>   - include "config.h" to get what is needed to get rid of the strdup()
>     warning
> ---
>  sample/sample-plugins/Makefile.plugins        |   3 +-
>  sample/sample-plugins/README                  |   6 +
>  sample/sample-plugins/client-connect/README   |  38 ++
>  .../client-connect/sample-client-connect.c    | 612 ++++++++++++++++++
>  4 files changed, 658 insertions(+), 1 deletion(-)
>  create mode 100644 sample/sample-plugins/client-connect/README
>  create mode 100644 sample/sample-plugins/client-connect/sample-client-co=
nnect.c
>=20

I've only glared at important code pieces, diffed against the v2 of this pa=
tch
and compiled it on RHEL-7 (gcc-4.8.5 and gcc-9.3.1/devtoolset-9).  Since
everything is as expected now (no compiler complaints, diff is good) and pr=
ior
review testing worked as expected ...

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--89Gso2fVQnNPCstqDCHw2ixtL4SvWMzQk--

--dVMEJ1cEGFLeHv8o39vqZzX7aQpgzO9kM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfY69kAAoJEIbPlEyWcf3yfCoP/2zcYhnPwXiVt7bG3r6/lcKB
Wn04q8We0KA/fUcceQrQ/C0GRwkNoqp1eTknSWGQa7QyAbBqdMbLD9WqMcBgFuNE
DZfyLVEfTDdA+DFKNTAZ/v9L+nFlVnWnTmrecw5D2sAw71pErOPKAMMOA/2HXH4m
RiOAzjuuTqZvJMdQT5cIZphVbogOSpoUTJPtxFkmqGhkOIXkTaKGeDY2U+WcWE/s
zruYSCurChYfP0+/iyDqRB1jBhtL6kHSbSOMYqApH3JHyEuFN7PNP4rxrLHC9wiV
hMcRaNKLf9Y5v1p9uHUiECSMBizHT2Su9ILJWF7QM5b3SQddFJ/Nhd2LO7GVB2Gm
hAPe008QjkgGxpwFpnPMnK9x+TWfdA5kuyUvlf7QttizINjyIt0yG0Foz6/RAgqx
cCzL3MNMGmV7/QTalUkEl/LnN0c8Zot9XVS+J1WFNjHTxqiUIl+L64Pc5bGd33BN
9PIumtzGtl9cxC9pGG3LezZ/BDZrXb+aKr/o7pCE87tHvumlBLdTr8pwjHXx1x0r
N4PXn9AqJ826hqxnm1jwsqgGGBssitlFI9i62rcm+vJFID0vhklWtylB5b/jlS/E
XeiVuxA3EjwLHpZnRq3LdFjrpQHSzstjyarnKeFdUgjrhjaf+1tMxOPasvXuCOMM
7bQsCJv7v3mGuq8JdrpB
=e8g6
-----END PGP SIGNATURE-----

--dVMEJ1cEGFLeHv8o39vqZzX7aQpgzO9kM--

