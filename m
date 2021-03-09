From: Arne Schwabe <arne@...1227...>
References: <CAFHpkQFzOBMUC+qX7vV8jeHxg2MdP6_DCwiUZ=seX7r3DE=cBg@...278...>
Message-ID: <b11f09eb-ed92-746b-686e-51ee6c8c9a87@...1227...>
Date: Tue, 9 Mar 2021 16:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFzOBMUC+qX7vV8jeHxg2MdP6_DCwiUZ=seX7r3DE=cBg@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] using openssl feature wherever possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 09.03.21 um 12:54 schrieb Илья Шипицин:
> Hello,
> 
> if nobody minds, I can send several patches that eliminates comparison
> of OPENSSL_VERSION, for example
> 
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 49698e4b..316cca6f 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -51,7 +51,8 @@
>  #include <openssl/rand.h>
>  #include <openssl/ssl.h>
>  
> -#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) &&
> !defined(LIBRESSL_VERSION_NUMBER)
> +#ifdef EVP_PKEY_TLS1_PRF
>  #include <openssl/kdf.h>
>  #endif

I do not really see a benefit here other than it a lot harder to drop
support for OpenSSL 1.0.2 and not leaving dead code in the repository.
The macro currently tells me exactly why the code is still there. The
EVP_PKEY_TLS1_PRF is not clear. Is this an optional OpenSSL? Is it for
an old version?

Arne

