Message-ID: <139d5059-25b8-e968-2996-5b3bc225ba3b@...68...>
Date: Mon, 27 Mar 2023 15:57:59 +0200
MIME-Version: 1.0
From: Matthias Andree <matthias.andree@...68...>
References: <20230327114937.28246-1-selva.nair@...277...>
Content-Language: en-US
In-Reply-To: <20230327114937.28246-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Make cert_data.h and
 test_cryptoapi/pkcs11.c MSVC compliant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 27.03.23 um 13:49 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
>
> - Do not use non-literal initializers for static objects
> - Replace empty initializer {} by {0}

Should we go to a revision, I would suggest to not make something
compliant to a compiler because that is assigning it way too much power
and control. A terms such as "ready to be compiled with MSVC" or so
would be in order, or making this code compliant with some wisely chosen
version of the ISO 9899 standard, aka. standard C.

> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> To be applied after the test-pkcs11 patch set
>
>   tests/unit_tests/openvpn/cert_data.h      |  6 ++---
>   tests/unit_tests/openvpn/test_cryptoapi.c | 24 ++++++++++++++------
>   tests/unit_tests/openvpn/test_pkcs11.c    | 27 ++++++++++++++++-------
>   3 files changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/open=
vpn/cert_data.h
> index 33de35ec..0886b071 100644
> --- a/tests/unit_tests/openvpn/cert_data.h
> +++ b/tests/unit_tests/openvpn/cert_data.h
> @@ -79,7 +79,7 @@ static const char *const cert2 =3D
>       "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n"
>       "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA=3D=3D\n"
>       "-----END CERTIFICATE-----\n";
> -static const char *const key2 =3D key1;
> +#define key2 key1

So we are not getting rid of #defines yet? Can't we make this data
somehow local?  Personally, I would probably - at least outside unit
tests - write (key1) instead of bare key, so that it's clear this is one
name and can't be somehow extended.

Whenever I see such code I wonder if it's not worthwhile to slowly walk
towards C++17 where appropriate.

I am not going to NAK or ACK this because I won't have time available to
set up a compilation environment based on Frank's repo within the next
three days, just commenting.

