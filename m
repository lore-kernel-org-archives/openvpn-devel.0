References: <20200616180046.8069-1-juliusz@...2525...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
Date: Wed, 15 Jul 2020 10:26:51 +0200
MIME-Version: 1.0
In-Reply-To: <20200616180046.8069-1-juliusz@...2525...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Everyone,

do you have an update on the latest patch I sent? There have been 
updates to wolfSSL to fix the remaining issues brought up last time.

Thanks
Juliusz

On 16/06/2020 20:00, Juliusz Sosinowicz wrote:
> This patch adds support for wolfSSL in OpenVPN. Support is added by using wolfSSL's OpenSSL compatibility layer. Function calls are left unchanged and instead the OpenSSL includes point to wolfSSL headers and OpenVPN is linked against the wolfSSL library.
>
> As requested by OpenVPN maintainers, this patch does not include wolfssl/options.h on its own. By defining the macro EXTERNAL_OPTS_OPENVPN in the configure script wolfSSL will include wolfssl/options.h on its own (change added in https://github.com/wolfSSL/wolfssl/pull/2825). The patch adds an option `--disable-wolfssl-options-h` in case the user would like to supply their own settings file for wolfSSL.
>
> wolfSSL:
> Support added in: https://github.com/wolfSSL/wolfssl/pull/2503
> ```
> git clone https://github.com/wolfSSL/wolfssl.git
> cd wolfssl
> ./autogen.sh
> ./configure --enable-openvpn
> make
> sudo make install
> ```
>
> OpenVPN:
> ```
> autoreconf -i -v -f
> ./configure --with-crypto-library=wolfssl
> make
> make check
> sudo make install
> ```
>
> Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
> ---
>   configure.ac          | 94 ++++++++++++++++++++++++++++++++++++++++++-
>   src/openvpn/syshead.h |  3 +-
>   2 files changed, 94 insertions(+), 3 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 273a8d1b..56d63555 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -269,16 +269,23 @@ AC_ARG_WITH(
>   
>   AC_ARG_WITH(
>   	[crypto-library],
> -	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|mbedtls @<:@default=openssl@:>@])],
> +	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|mbedtls|wolfssl @<:@default=openssl@:>@])],
>   	[
>   		case "${withval}" in
> -			openssl|mbedtls) ;;
> +			openssl|mbedtls|wolfssl) ;;
>   			*) AC_MSG_ERROR([bad value ${withval} for --with-crypto-library]) ;;
>   		esac
>   	],
>   	[with_crypto_library="openssl"]
>   )
>   
> +AC_ARG_ENABLE(
> +	[wolfssl-options-h],
> +	[AS_HELP_STRING([--disable-wolfssl-options-h], [Disable including options.h in wolfSSL @<:@default=yes@:>@])],
> +	,
> +	[enable_wolfssl_options_h="yes"]
> +)
> +
>   AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @<:@default=LIBDIR/openvpn/plugins@:>@])
>   if test -n "${PLUGINDIR}"; then
>   	plugindir="${PLUGINDIR}"
> @@ -1022,6 +1029,89 @@ elif test "${with_crypto_library}" = "mbedtls"; then
>   	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
>   	CRYPTO_CFLAGS="${MBEDTLS_CFLAGS}"
>   	CRYPTO_LIBS="${MBEDTLS_LIBS}"
> +
> +elif test "${with_crypto_library}" = "wolfssl"; then
> +	AC_ARG_VAR([WOLFSSL_CFLAGS], [C compiler flags for wolfssl])
> +	AC_ARG_VAR([WOLFSSL_LIBS], [linker flags for wolfssl])
> +	AC_ARG_VAR([WOLFSSL_DIR], [Path to the wolfssl directory @<:@default=/usr/local/include/wolfssl@:>@])
> +	if test -n "${WOLFSSL_DIR}"; then
> +		wolfssldir="${WOLFSSL_DIR}"
> +	else
> +		wolfssldir="/usr/local/include/wolfssl"
> +	fi
> +
> +	saved_CFLAGS="${CFLAGS}"
> +	saved_LIBS="${LIBS}"
> +
> +	if test -z "${WOLFSSL_CFLAGS}" -a -z "${WOLFSSL_LIBS}"; then
> +		# if the user did not explicitly specify flags, try to autodetect
> +		LIBS="${LIBS} -lwolfssl -lm -pthread"
> +		AC_CHECK_LIB(
> +			[wolfssl],
> +			[wolfSSL_Init],
> +			[],
> +			[AC_MSG_ERROR([Could not link wolfSSL library.])]
> +		)
> +		AC_CHECK_HEADER([wolfssl/options.h],,[AC_MSG_ERROR([wolfSSL header wolfssl/options.h not found!])])
> +	fi
> +
> +	AC_DEFINE([HAVE_HMAC_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_HMAC_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_HMAC_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_EVP_MD_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_EVP_MD_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_EVP_MD_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_EVP_CIPHER_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_OPENSSL_VERSION], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_SSL_CTX_SET_SECURITY_LEVEL], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_X509_GET0_NOTBEFORE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_X509_GET0_NOTAFTER], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_X509_GET0_PUBKEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_X509_STORE_GET0_OBJECTS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_X509_OBJECT_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_X509_OBJECT_GET_TYPE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_EVP_PKEY_ID], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_EVP_PKEY_GET0_RSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_EVP_PKEY_GET0_DSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_EVP_PKEY_GET0_EC_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_SET_FLAGS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_GET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_SET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_DSA_GET0_PQG], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_DSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_SET_PUB_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_SET_PUB_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_SET_INIT], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_SET_SIGN], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_SET_FINISH], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_SET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_RSA_METH_GET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	AC_DEFINE([HAVE_EC_GROUP_ORDER_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> +	
> +	have_crypto_aead_modes="yes"
> +	have_crypto="yes"
> +
> +	if test "${enable_wolfssl_options_h}" = "yes"; then
> +		AC_DEFINE([EXTERNAL_OPTS_OPENVPN], [1], [Include options.h from wolfSSL library])
> +	else
> +		AC_DEFINE([WOLFSSL_USER_SETTINGS], [1], [Use custom user_settings.h file for wolfSSL library])
> +	fi
> +	
> +	WOLFSSL_CFLAGS="${WOLFSSL_CFLAGS} -I${wolfssldir}"
> +	CFLAGS="${WOLFSSL_CFLAGS} ${CFLAGS}"
> +	LIBS="${WOLFSSL_LIBS} ${LIBS}"
> +	
> +	AC_DEFINE([ENABLE_CRYPTO_WOLFSSL], [1], [Use wolfSSL crypto library])
> +	AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use wolfSSL openssl compatibility layer])
> +	CRYPTO_CFLAGS="${WOLFSSL_CFLAGS}"
> +	CRYPTO_LIBS="${WOLFSSL_LIBS}"
>   else
>   	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
>   fi
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index cafe4719..78e434ab 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -587,7 +587,8 @@ socket_defined(const socket_descriptor_t sd)
>   /*
>    * Do we have CryptoAPI capability?
>    */
> -#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL)
> +#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL) && \
> +        !defined(ENABLE_CRYPTO_WOLFSSL)
>   #define ENABLE_CRYPTOAPI
>   #endif
>   

