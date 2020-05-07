References: <20200429145132.28424-1-juliusz@...2525...>
 <41fef456-3ced-7cb3-7888-46a3522080b2@...2181...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <196ab7ef-4a2f-dc82-45a7-59295b5c36e7@...2525...>
Date: Thu, 7 May 2020 14:02:36 +0200
MIME-Version: 1.0
In-Reply-To: <41fef456-3ced-7cb3-7888-46a3522080b2@...2181...>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi Antonio,

thank you for reviewing and testing OpenVPN with wolfSSL. Let me explain 
the warnings:

On 07/05/2020 12:28, Antonio Quartulli wrote:
> Hi Juliusz,
>
> There are some warnings when compiling with wolfssl v4.0.0-stable:
>
>
> In file included from crypto_openssl.c:44:
> openssl_compat.h:93: warning: "EVP_CIPHER_CTX_reset" redefined
>     93 | #define EVP_CIPHER_CTX_reset EVP_CIPHER_CTX_init
>        |
> In file included from crypto_openssl.h:32,
>                   from crypto_backend.h:33,
>                   from crypto.h:125,
>                   from crypto_openssl.c:42:
> /usr/local/include/wolfssl/openssl/evp.h:769: note: this is the location
> of the previous definition
>    769 | #define EVP_CIPHER_CTX_reset          wolfSSL_EVP_CIPHER_CTX_reset
>        |
OpenVPN recently started using EVP_CIPHER_CTX_reset and HAVE_ 
EVP_CIPHER_CTX_RESET wasn't being defined in the wolfSSL configure 
section. I will fix this for the next version of the patch as well as 
all other missing defines I found.
> ssl_openssl.c: In function ‘tls_ctx_load_ca’:
> ssl_openssl.c:1601:55: warning: passing argument 1 of
> ‘wolfSSL_sk_X509_NAME_new’ from incompatible pointer type
> [-Wincompatible-pointer-types]
>   1601 |                         cert_names =
> sk_X509_NAME_new(sk_x509_name_cmp);
>        |
> ^~~~~~~~~~~~~~~~
>        |                                                       |
>        |                                                       int
> (*)(const X509_NAME * const*, const X509_NAME * const*) {aka int
> (*)(const struct WOLFSSL_X509_NAME * const*, const struct
> WOLFSSL_X509_NAME * const*)}
> In file included from /usr/local/include/wolfssl/openssl/ssl.h:35,
>                   from ssl_openssl.h:32,
>                   from ssl_backend.h:36,
>                   from ssl_openssl.c:44:
> /usr/local/include/wolfssl/ssl.h:3534:47: note: expected
> ‘wolf_sk_compare_cb’ {aka ‘int (*)(const void * const*, const void *
> const*)’} but argument is of type ‘int (*)(const X509_NAME * const*,
> const X509_NAME * const*)’ {aka ‘int (*)(const struct WOLFSSL_X509_NAME
> * const*, const struct WOLFSSL_X509_NAME * const*)’}
>   3534 | WOLFSSL_API WOLF_STACK_OF(WOLFSSL_X509_NAME)*
> wolfSSL_sk_X509_NAME_new(
>        |
> ^~~~~~~~~~~~~~~~~~~~~~~~
To make wolfSSL_sk_X509_NAME_new more universal we accept a function 
with void* parameters. This will unfortunately generate a warning when 
compiling with wolfSSL but won't affect functionality.
> ssl_openssl.c: In function ‘print_details’:
> ssl_openssl.c:2082:22: warning: unused variable ‘dsa’ [-Wunused-variable]
>   2082 |                 DSA *dsa = EVP_PKEY_get0_DSA(pkey);
>        |                      ^~~
DSA_bits is defined as
#define DSA_bits(...)                   0
which means that the dsa variable will not be used. I will look into 
fixing this as DSA support has been added to our EVP layer since this 
definition.
> On top of that, unfortunately something is not working.
>
> While openvpn can connect if provided with a config that references key
> material from external files, i.e. "key a/b/c.key" or "cert
> a/b/c/d.crt", it does not work when trying to connect using inline
> material, i.e. "<key>$something here</key>".
>
>
> This is what I see:
>
> Thu May  7 12:16:12 2020 OpenVPN 2.5_git [git:master/6acb2a69e47a8da0]
> x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO]
> [AEAD] built on May  7 2020
> Thu May  7 12:16:12 2020 library versions: 4.4.0, LZO 2.10
> Thu May  7 12:16:12 2020 WARNING: --ns-cert-type is DEPRECATED.  Use
> --remote-cert-tls instead.
> Thu May  7 12:16:12 2020 OpenSSL: Please supply a buffer for error string
> Thu May  7 12:16:12 2020 Cannot load inline certificate file
> Thu May  7 12:16:12 2020 Exiting due to fatal error
>
>
> Any clue why this is failing?
>
> - openvpn is: master openvpn + your patch
> - for wolfssl I tested both master and 4.4.0

I will investigate this issue and see what can be done about it. Thank 
you for catching it.

Thanks
Juliusz

> On 29/04/2020 16:51, Juliusz Sosinowicz wrote:
>> This patch adds support for wolfSSL in OpenVPN. Support is added by using wolfSSL's OpenSSL compatibility layer. Function calls are left unchanged and instead the OpenSSL includes point to wolfSSL headers and OpenVPN is linked against the wolfSSL library.
>>
>> As requested by OpenVPN maintainers, this patch does not include wolfssl/options.h on its own. By defining the macro EXTERNAL_OPTS_OPENVPN in the configure script wolfSSL will include wolfssl/options.h on its own (change added in https://github.com/wolfSSL/wolfssl/pull/2825). The patch adds an option `--disable-wolfssl-options-h` in case the user would like to supply their own settings file for wolfSSL.
>>
>> wolfSSL:
>> Support added in: https://github.com/wolfSSL/wolfssl/pull/2503
>> ```
>> git clone https://github.com/wolfSSL/wolfssl.git
>> cd wolfssl
>> ./autogen.sh
>> ./configure --enable-openvpn
>> make
>> sudo make install
>> ```
>>
>> OpenVPN:
>> ```
>> autoreconf -i -v -f
>> ./configure --with-crypto-library=wolfssl
>> make
>> make check
>> sudo make install
>> ```
>>
>> Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
>> ---
>>   configure.ac          | 91 ++++++++++++++++++++++++++++++++++++++++++-
>>   src/openvpn/syshead.h |  3 +-
>>   2 files changed, 91 insertions(+), 3 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index fcec7389..53ad3181 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -276,16 +276,23 @@ AC_ARG_WITH(
>>   
>>   AC_ARG_WITH(
>>   	[crypto-library],
>> -	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|mbedtls @<:@default=openssl@:>@])],
>> +	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|mbedtls|wolfssl @<:@default=openssl@:>@])],
>>   	[
>>   		case "${withval}" in
>> -			openssl|mbedtls) ;;
>> +			openssl|mbedtls|wolfssl) ;;
>>   			*) AC_MSG_ERROR([bad value ${withval} for --with-crypto-library]) ;;
>>   		esac
>>   	],
>>   	[with_crypto_library="openssl"]
>>   )
>>   
>> +AC_ARG_ENABLE(
>> +	[wolfssl-options-h],
>> +	[AS_HELP_STRING([--disable-wolfssl-options-h], [Disable including options.h in wolfSSL @<:@default=yes@:>@])],
>> +	,
>> +	[enable_wolfssl_options_h="yes"]
>> +)
>> +
>>   AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @<:@default=LIBDIR/openvpn/plugins@:>@])
>>   if test -n "${PLUGINDIR}"; then
>>   	plugindir="${PLUGINDIR}"
>> @@ -1029,6 +1036,86 @@ elif test "${with_crypto_library}" = "mbedtls"; then
>>   	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
>>   	CRYPTO_CFLAGS="${MBEDTLS_CFLAGS}"
>>   	CRYPTO_LIBS="${MBEDTLS_LIBS}"
>> +
>> +elif test "${with_crypto_library}" = "wolfssl"; then
>> +	AC_ARG_VAR([WOLFSSL_CFLAGS], [C compiler flags for wolfssl])
>> +	AC_ARG_VAR([WOLFSSL_LIBS], [linker flags for wolfssl])
>> +	AC_ARG_VAR([WOLFSSL_DIR], [Path to the wolfssl directory @<:@default=/usr/local/include/wolfssl@:>@])
>> +	if test -n "${WOLFSSL_DIR}"; then
>> +		wolfssldir="${WOLFSSL_DIR}"
>> +	else
>> +		wolfssldir="/usr/local/include/wolfssl"
>> +	fi
>> +
>> +	saved_CFLAGS="${CFLAGS}"
>> +	saved_LIBS="${LIBS}"
>> +
>> +	if test -z "${WOLFSSL_CFLAGS}" -a -z "${WOLFSSL_LIBS}"; then
>> +		# if the user did not explicitly specify flags, try to autodetect
>> +		LIBS="${LIBS} -lwolfssl -lm -pthread"
>> +		AC_CHECK_LIB(
>> +			[wolfssl],
>> +			[wolfSSL_Init],
>> +			[],
>> +			[AC_MSG_ERROR([Could not link wolfSSL library.])]
>> +		)
>> +		AC_CHECK_HEADER([wolfssl/options.h],,[AC_MSG_ERROR([wolfSSL header wolfssl/options.h not found!])])
>> +	fi
>> +
>> +	AC_DEFINE([HAVE_HMAC_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_HMAC_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_HMAC_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_EVP_MD_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_EVP_MD_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_EVP_MD_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_OPENSSL_VERSION], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_SSL_CTX_SET_SECURITY_LEVEL], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_X509_GET0_PUBKEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_X509_STORE_GET0_OBJECTS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_X509_OBJECT_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_X509_OBJECT_GET_TYPE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_EVP_PKEY_ID], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_EVP_PKEY_GET0_RSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_EVP_PKEY_GET0_DSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_EVP_PKEY_GET0_EC_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_SET_FLAGS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_GET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_SET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_DSA_GET0_PQG], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_DSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_SET_PUB_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_SET_PUB_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_SET_INIT], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_SET_SIGN], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_SET_FINISH], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_SET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_RSA_METH_GET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	AC_DEFINE([HAVE_EC_GROUP_ORDER_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
>> +	
>> +	have_crypto_aead_modes="yes"
>> +	have_crypto="yes"
>> +
>> +	if test "${enable_wolfssl_options_h}" = "yes"; then
>> +		AC_DEFINE([EXTERNAL_OPTS_OPENVPN], [1], [Include options.h from wolfSSL library])
>> +	else
>> +		AC_DEFINE([WOLFSSL_USER_SETTINGS], [1], [Use custom user_settings.h file for wolfSSL library])
>> +	fi
>> +	
>> +	WOLFSSL_CFLAGS="${WOLFSSL_CFLAGS} -I${wolfssldir}"
>> +	CFLAGS="${WOLFSSL_CFLAGS} ${CFLAGS}"
>> +	LIBS="${WOLFSSL_LIBS} ${LIBS}"
>> +	
>> +	AC_DEFINE([ENABLE_CRYPTO_WOLFSSL], [1], [Use wolfSSL crypto library])
>> +	AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use wolfSSL openssl compatibility layer])
>> +	CRYPTO_CFLAGS="${WOLFSSL_CFLAGS}"
>> +	CRYPTO_LIBS="${WOLFSSL_LIBS}"
>>   else
>>   	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
>>   fi
>> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
>> index b031dd60..0196596c 100644
>> --- a/src/openvpn/syshead.h
>> +++ b/src/openvpn/syshead.h
>> @@ -593,7 +593,8 @@ socket_defined(const socket_descriptor_t sd)
>>   /*
>>    * Do we have CryptoAPI capability?
>>    */
>> -#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL)
>> +#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL) && \
>> +        !defined(ENABLE_CRYPTO_WOLFSSL)
>>   #define ENABLE_CRYPTOAPI
>>   #endif
>>   
>>

