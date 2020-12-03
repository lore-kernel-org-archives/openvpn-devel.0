References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
 <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
 <1998772f-b476-1862-9102-b95fd1a33be7@...2525...>
 <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
 <50c23608-1b71-1651-fa4e-af0d39aba7b3@...2525...>
 <0f47e3c7-f9d2-1649-0fb7-b0b58fa4b84a@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <37a8a66a-bc0f-a9a8-4e83-a991d80a359c@...2525...>
Date: Thu, 3 Dec 2020 14:32:49 +0100
MIME-Version: 1.0
In-Reply-To: <0f47e3c7-f9d2-1649-0fb7-b0b58fa4b84a@...1227...>
Content-Type: multipart/mixed; boundary="------------C425D852B5B783EDE3CFD930"
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
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------C425D852B5B783EDE3CFD930
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arne,

I didn't send a new patch yet because I only wanted to provide an update 
that progress is being made. I'm attaching an updated patch if you are 
interested.

I didn't get that error when compiling wolfSSL with the compile options 
you provided. Is it possible that you didn't run `autoreconf` after 
pulling in the latest commit in the branch but before running the 
configure script?

The warning is due to wolfSSL using a generic compare function 
definition with pointers to void as parameters.

Sincerely
Juliusz

On 03/12/2020 13:22, Arne Schwabe wrote:
> Am 19.11.20 um 13:23 schrieb Juliusz Sosinowicz:
>> Hi Arne,
>>
>> some time has passed and I was able to address most of your comments in
>> my branch
>> https://github.com/julek-wolfssl/wolfssl/tree/openvpn-2.5-missing-stuff
>>
>> To summarize what has been done regarding your comments:
>>
>>    * SHA1 was indeed being called SHA in wolfSSL. I changed this in favor
>>      of just using SHA1.
>>    * in configure.ac I used David Sommerseth's suggestion to use
>>      PKG_CHECK_MODULES to get the wolfSSL installation directory.
> Do you that new patch posted here? I don't see an updated patch.
>
>>    * setting tls min and max is currently not working in the branch that
>>      I linked above but we have a big compatibility layer PR pending that
>>      appears to fix these issues. Once it is merged I'll revisit this
>>      issue and make sure it is solved.
>>    * show-tls is fixed but it also relies on the PR I mentioned earlier.
>>      After that is merged this should be solved.
>>    * tls-ciphersuites and tls-cipher appears to be working in general.
>>      Should wolfSSL reject the specified cipher if for example a TLS 1.3
>>      cipher is set using --tls-cipher?
> Well that is a general question you have to answer yourself on OpenSSL
> compatibility. I don't think this is just for OpenVPN.
>
>>    * unfortunately wolfSSL does not support ed448 certificates.
> That is not a show stopper. Mbed TLS does not support them either.
>
>>    * tls-groups now checks the validity of the passed in curves
>>    * since OpenVPN will make use TLS EKM, exporting keying material has
>>      been implemented in wolfSSL.
> Great!
>
>>    * I haven't tested OpenVPN with the FIPS mode patch so that issue is
>>      still pending. Once I get a chance to test it I will also change
>>      wolfSSL to target 1.1.0+ API
>>
>> Thanks for your patience!
>>
> Hey I am trying to check on this. Since I haven't found the new patch. I
> am trying to use it with the old one:
>
> I am getting an error related to EKM:
>
> ./../../openvpn-git/src/openvpn/ssl_openssl.c:166:9: error: implicit
> declaration of function 'wolfSSL_export_keying_material' is invalid in C99
>        [-Werror,-Wimplicit-function-declaration]
>      if (SSL_export_keying_material(ssl, ekm, ekm_size, label,
>
>
> So I tried ./configure --enable-openvpn --enable-keying-material for
> WolfSSL but that failed during compile:
>
> src/tls13.c:806:50: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
>        [-Werror,-Wshorten-64-to-32]
>              protocol, protocolLen, (byte*)label, labelLen,
>                                                   ^~~~~~~~
> src/tls13.c:812:38: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
>        [-Werror,-Wshorten-64-to-32]
>      ret = wc_Hash(hashType, context, contextLen, hashOut,
> WC_MAX_DIGEST_SIZE);
>            ~~~~~~~                    ^~~~~~~~~~
> src/tls13.c:816:34: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
>        [-Werror,-Wshorten-64-to-32]
>      ret = HKDF_Expand_Label(out, outLen, firstExpand, hashLen,
>            ~~~~~~~~~~~~~~~~~      ^~~~~~
>    CC       tests/unit_test-unit.o
> src/ssl.c:11526:61: error: implicit conversion loses integer precision:
> 'unsigned long' to 'word32' (aka 'unsigned int')
> [-Werror,-Wshorten-64-to-32]
>      word32 seedLen = !use_context ? SEED_LEN : SEED_LEN + 2 + contextLen;
>             ~~~~~~~                             ~~~~~~~~~~~~~^~~~~~~~~~~~
> src/ssl.c:11590:25: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
>        [-Werror,-Wshorten-64-to-32]
>      if (wc_PRF_TLS(out, outLen, ssl->arrays->masterSecret, SECRET_LEN,
>          ~~~~~~~~~~      ^~~~~~
> src/ssl.c:11591:27: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
>        [-Werror,-Wshorten-64-to-32]
>              (byte*)label, labelLen, seed, seedLen, IsAtLeastTLSv1_2(ssl),
>
>
>
> I am also seeing another warning during the compilation:
>
> ../../../openvpn-git/src/openvpn/ssl_openssl.c:1559:55: warning:
> incompatible pointer types passing 'int (const X509_NAME *const *, const
>        X509_NAME *const *)' (aka 'int (const struct WOLFSSL_X509_NAME
> *const *, const struct WOLFSSL_X509_NAME *const *)') to parameter of type
>        'wolf_sk_compare_cb' (aka 'int (*)(const void *const *, const void
> *const *)') [-Wincompatible-pointer-types]
>                          cert_names = sk_X509_NAME_new(sk_x509_name_cmp);
>                                                        ^~~~~~~~~~~~~~~~
>
>
> Arne

--------------C425D852B5B783EDE3CFD930
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Support-for-wolfSSL-in-OpenVPN.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Support-for-wolfSSL-in-OpenVPN.patch"

From 7ee789ed7632d1eb43f0d461ab4e0801607e9031 Mon Sep 17 00:00:00 2001
From: Juliusz Sosinowicz <juliusz@...2525...>
Date: Thu, 28 Nov 2019 19:10:44 +0100
Subject: [PATCH] Support for wolfSSL in OpenVPN

This patch adds support for wolfSSL in OpenVPN. Support is added by using wolfSSL's OpenSSL compatibility layer. Function calls are left unchanged and instead the OpenSSL includes point to wolfSSL headers and OpenVPN is linked against the wolfSSL library. The wolfSSL installation directory is detected using pkg-config.

As requested by OpenVPN maintainers, this patch does not include wolfssl/options.h on its own. By defining the macro EXTERNAL_OPTS_OPENVPN in the configure script wolfSSL will include wolfssl/options.h on its own (change added in https://github.com/wolfSSL/wolfssl/pull/2825). The patch adds an option `--disable-wolfssl-options-h` in case the user would like to supply their own settings file for wolfSSL.

wolfSSL:
Support added in: https://github.com/wolfSSL/wolfssl/pull/2503
```
git clone https://github.com/wolfSSL/wolfssl.git
cd wolfssl
./autogen.sh
./configure --enable-openvpn
make
sudo make install
```

OpenVPN:
```
autoreconf -i -v -f
./configure --with-crypto-library=wolfssl
make
make check
sudo make install
```

Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
---
 configure.ac          | 107 +++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/syshead.h |   3 +-
 2 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1ab8fe59d..96321a1e4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -264,16 +264,23 @@ AC_ARG_WITH(
 
 AC_ARG_WITH(
 	[crypto-library],
-	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|mbedtls @<:@default=openssl@:>@])],
+	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|mbedtls|wolfssl @<:@default=openssl@:>@])],
 	[
 		case "${withval}" in
-			openssl|mbedtls) ;;
+			openssl|mbedtls|wolfssl) ;;
 			*) AC_MSG_ERROR([bad value ${withval} for --with-crypto-library]) ;;
 		esac
 	],
 	[with_crypto_library="openssl"]
 )
 
+AC_ARG_ENABLE(
+	[wolfssl-options-h],
+	[AS_HELP_STRING([--disable-wolfssl-options-h], [Disable including options.h in wolfSSL @<:@default=yes@:>@])],
+	,
+	[enable_wolfssl_options_h="yes"]
+)
+
 AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @<:@default=LIBDIR/openvpn/plugins@:>@])
 if test -n "${PLUGINDIR}"; then
 	plugindir="${PLUGINDIR}"
@@ -1019,6 +1026,102 @@ elif test "${with_crypto_library}" = "mbedtls"; then
 	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
 	CRYPTO_CFLAGS="${MBEDTLS_CFLAGS}"
 	CRYPTO_LIBS="${MBEDTLS_LIBS}"
+
+elif test "${with_crypto_library}" = "wolfssl"; then
+	AC_ARG_VAR([WOLFSSL_CFLAGS], [C compiler flags for wolfssl. The include directory should
+								  contain the regular wolfSSL header files but also the 
+								  wolfSSL OpenSSL header files. Ex: -I/usr/local/include 
+								  -I/usr/local/include/wolfssl])
+	AC_ARG_VAR([WOLFSSL_LIBS], [linker flags for wolfssl])
+
+	saved_CFLAGS="${CFLAGS}"
+	saved_LIBS="${LIBS}"
+
+	if test -z "${WOLFSSL_CFLAGS}" -a -z "${WOLFSSL_LIBS}"; then
+		# if the user did not explicitly specify flags, try to autodetect
+		PKG_CHECK_MODULES(
+			[WOLFSSL],
+			[wolfssl],
+			[],
+			[AC_MSG_ERROR([Could not find wolfSSL.])]
+		)
+		PKG_CHECK_VAR(
+			[WOLFSSL_INCLUDEDIR], 
+			[wolfssl], 
+			[includedir], 
+			[],
+			[AC_MSG_ERROR([Could not find wolfSSL includedir variable.])]
+		)
+		WOLFSSL_CFLAGS="${WOLFSSL_CFLAGS} -I${WOLFSSL_INCLUDEDIR}/wolfssl"
+	fi
+	saved_CFLAGS="${CFLAGS}"
+	saved_LIBS="${LIBS}"
+	CFLAGS="${CFLAGS} ${WOLFSSL_CFLAGS}"
+	LIBS="${LIBS} ${WOLFSSL_LIBS}"
+
+	AC_CHECK_LIB(
+		[wolfssl],
+		[wolfSSL_Init],
+		[],
+		[AC_MSG_ERROR([Could not link wolfSSL library.])]
+	)
+	AC_CHECK_HEADER([wolfssl/options.h],,[AC_MSG_ERROR([wolfSSL header wolfssl/options.h not found!])])
+
+	AC_DEFINE([HAVE_HMAC_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_HMAC_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_HMAC_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_MD_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_MD_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_MD_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_CIPHER_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_OPENSSL_VERSION], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_SSL_CTX_SET_SECURITY_LEVEL], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_GET0_NOTBEFORE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_GET0_NOTAFTER], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_GET0_PUBKEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_STORE_GET0_OBJECTS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_OBJECT_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_X509_OBJECT_GET_TYPE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_PKEY_ID], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_PKEY_GET0_RSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_PKEY_GET0_DSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EVP_PKEY_GET0_EC_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_SET_FLAGS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_GET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_SET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_DSA_GET0_PQG], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_DSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_PUB_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_PUB_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_INIT], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_SIGN], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET_FINISH], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_SET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_RSA_METH_GET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+	AC_DEFINE([HAVE_EC_GROUP_ORDER_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
+
+	if test "${enable_wolfssl_options_h}" = "yes"; then
+		AC_DEFINE([EXTERNAL_OPTS_OPENVPN], [1], [Include options.h from wolfSSL library])
+	else
+		AC_DEFINE([WOLFSSL_USER_SETTINGS], [1], [Use custom user_settings.h file for wolfSSL library])
+	fi
+	
+	have_export_keying_material="yes"
+	
+	CFLAGS="${saved_CFLAGS}"
+	LIBS="${saved_LIBS}"
+	
+	AC_DEFINE([ENABLE_CRYPTO_WOLFSSL], [1], [Use wolfSSL crypto library])
+	AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use wolfSSL openssl compatibility layer])
+	CRYPTO_CFLAGS="${WOLFSSL_CFLAGS}"
+	CRYPTO_LIBS="${WOLFSSL_LIBS}"
 else
 	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
 fi
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 2ad5afc20..a20de1f65 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -569,7 +569,8 @@ socket_defined(const socket_descriptor_t sd)
 /*
  * Do we have CryptoAPI capability?
  */
-#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL)
+#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL) && \
+        !defined(ENABLE_CRYPTO_WOLFSSL)
 #define ENABLE_CRYPTOAPI
 #endif
 
-- 
2.25.1


--------------C425D852B5B783EDE3CFD930--

