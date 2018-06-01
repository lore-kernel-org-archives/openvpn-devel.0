Message-Id: <1527819161.492538.1392521184.3CB7A30B@...2307...>
From: aclion@...2404...
MIME-Version: 1.0
Date: Thu, 31 May 2018 19:12:41 -0700
Subject: [Openvpn-devel] OpenVPN 2.5_git fails to build linked to OpenSSL
 v1.1.0 Works great linked to OpenSSL v1.0.2 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

I'm building OpenVPN on Linux

	cd /home/src/openvpn
	git log | head
		commit 1394192b210cb3c6624a7419bcf3ff966742e79b
		Author: Gert Doering <gert@...1296...>
		Date:   Sat Apr 14 09:26:17 2018 +0200

		    Fix potential double-free() in Interactive Service (CVE-2018-9336)

		    Malformed input data on the service pipe towards the OpenVPN interact=
ive
		    service (normally used by the OpenVPN GUI to request openvpn instances
		    from the service) can result in a double free() in the error handling=
 code.

For SSL prereqs, I built & installed both

	OpenSSL 1.0.2o  27 Mar 2018

installed into

	/opt/ssl10

and

	OpenSSL 1.1.0h  27 Mar 2018

installed into

	/opt/ssl11


If I build OpenVPN with OpenSSL version 1.0.0,

	cd /home/src/openvpn
	autoreconf -fi
	export OPENSSL_CFLAGS=3D"-I/usr/local/include -I/opt/ssl10/include -I/usr/=
include"
	export OPENSSL_LIBS=3D"-L/opt/ssl10/lib64 -Wl,-rpath,/opt/ssl10/lib64 -lss=
l -lcrypto"
	./configure --with-crypto-library=3Dopenssl --enable-shared --disable-stat=
ic --prefix=3D/opt/openvpn --libdir=3D/opt/openvpn/lib64
	make
	make install

it builds & runs with no error, linked to the right version OpenSSL libs,

	ldd /opt/openvpn/sbin/openvpn | egrep "ssl|crypto"
	        libssl.so.1.0.0 =3D> /opt/ssl10/lib64/libssl.so.1.0.0 (0x00007fdc4=
bf6a000)
	        libcrypto.so.1.0.0 =3D> /opt/ssl10/lib64/libcrypto.so.1.0.0 (0x000=
07fdc4baf1000)

	/opt/openvpn/sbin/openvpn
		OpenVPN 2.5_git [git:master/1394192b210cb3c6] x86_64-pc-linux-gnu [SSL (O=
penSSL)] [LZO] [LZ4] [EPOLL] [AEAD] built on May 31 2018
		library versions: OpenSSL 1.0.2o  27 Mar 2018, LZO 2.10
		...

When I switch to the OpenSSL version 1.1.1 libs, changing only the _FLAGS/_=
LIBS spec,

	-	export OPENSSL_CFLAGS=3D"-I/usr/local/include -I/opt/ssl11/include -I/us=
r/include"
	-	export OPENSSL_LIBS=3D"-L/opt/ssl11/lib64 -Wl,-rpath,/opt/ssl11/lib64 -l=
ssl -lcrypto"
	+	export OPENSSL_CFLAGS=3D"-I/usr/local/include -I/opt/ssl11/include -I/us=
r/include"
	+	export OPENSSL_LIBS=3D"-L/opt/ssl11/lib64 -Wl,-rpath,/opt/ssl11/lib64 -l=
ssl -lcrypto"

if still configures OK, but `make` dies,

	...
	/usr/bin/gcc-8 -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../includ=
e -I../../src/compat -O3 -Wall -fstack-protector-strong -funwind-tables -fa=
synchronous-unwind-tables -fmessage-length=3D0 -grecord-gcc-switches -D_FOR=
TIFY_SOURCE=3D2  -I/usr/local/include  -I/opt/ssl11/include -I/usr/include =
   -DPLUGIN_LIBDIR=3D\"/opt/openvpn/lib64/openvpn/plugins\"  -Wall -Wno-unu=
sed-parameter -Wno-unused-function -O3 -Wall -fstack-protector-strong -funw=
ind-tables -fasynchronous-unwind-tables -fmessage-length=3D0 -grecord-gcc-s=
witches -fPIC -DPIC -D_GNU_SOURCE -fno-strict-aliasing -Wall -std=3Dc99 -MT=
 ssl_openssl.o -MD -MP -MF .deps/ssl_openssl.Tpo -c -o ssl_openssl.o ssl_op=
enssl.c
	socket.c: In function =E2=80=98print_link_socket_actual_ex=E2=80=99:
	socket.c:2772:14: warning: unused variable =E2=80=98ifname=E2=80=99 [-Wunu=
sed-variable]
	         char ifname[IF_NAMESIZE] =3D "[undef]";
	              ^~~~~~
	ssl_openssl.c: In function =E2=80=98tls_init_lib=E2=80=99:
	ssl_openssl.c:74:5: warning: implicit declaration of function =E2=80=98SSL=
_library_init=E2=80=99; did you mean =E2=80=98SSL_in_init=E2=80=99? [-Wimpl=
icit-function-declaration]
	     SSL_library_init();
	     ^~~~~~~~~~~~~~~~
	     SSL_in_init
	ssl_openssl.c:76:5: warning: implicit declaration of function =E2=80=98SSL=
_load_error_strings=E2=80=99; did you mean =E2=80=98ERR_lib_error_string=E2=
=80=99? [-Wimplicit-function-declaration]
	     SSL_load_error_strings();
	     ^~~~~~~~~~~~~~~~~~~~~~
	     ERR_lib_error_string
	mv -f .deps/route.Tpo .deps/route.Po
	/usr/bin/gcc-8 -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../includ=
e -I../../src/compat -O3 -Wall -fstack-protector-strong -funwind-tables -fa=
synchronous-unwind-tables -fmessage-length=3D0 -grecord-gcc-switches -D_FOR=
TIFY_SOURCE=3D2  -I/usr/local/include  -I/opt/ssl11/include -I/usr/include =
   -DPLUGIN_LIBDIR=3D\"/opt/openvpn/lib64/openvpn/plugins\"  -Wall -Wno-unu=
sed-parameter -Wno-unused-function -O3 -Wall -fstack-protector-strong -funw=
ind-tables -fasynchronous-unwind-tables -fmessage-length=3D0 -grecord-gcc-s=
witches -fPIC -DPIC -D_GNU_SOURCE -fno-strict-aliasing -Wall -std=3Dc99 -MT=
 ssl_mbedtls.o -MD -MP -MF .deps/ssl_mbedtls.Tpo -c -o ssl_mbedtls.o ssl_mb=
edtls.c
	ssl_openssl.c:78:5: warning: implicit declaration of function =E2=80=98Ope=
nSSL_add_all_algorithms=E2=80=99; did you mean =E2=80=98OpenSSL_add_ssl_alg=
orithms=E2=80=99? [-Wimplicit-function-declaration]
	     OpenSSL_add_all_algorithms();
	     ^~~~~~~~~~~~~~~~~~~~~~~~~~
	     OpenSSL_add_ssl_algorithms
	ssl_openssl.c: In function =E2=80=98tls_free_lib=E2=80=99:
	ssl_openssl.c:87:5: warning: implicit declaration of function =E2=80=98EVP=
_cleanup=E2=80=99; did you mean =E2=80=98EVP_PBE_cleanup=E2=80=99? [-Wimpli=
cit-function-declaration]
	     EVP_cleanup();
	     ^~~~~~~~~~~
	     EVP_PBE_cleanup
	ssl_openssl.c:89:5: warning: implicit declaration of function =E2=80=98ERR=
_free_strings=E2=80=99; did you mean =E2=80=98ERR_load_strings=E2=80=99? [-=
Wimplicit-function-declaration]
	     ERR_free_strings();
	     ^~~~~~~~~~~~~~~~
	     ERR_load_strings
	ssl_openssl.c: In function =E2=80=98tls_ctx_check_cert_time=E2=80=99:
	ssl_openssl.c:476:25: warning: implicit declaration of function =E2=80=98X=
509_get_notBefore=E2=80=99; did you mean =E2=80=98X509_getm_notBefore=E2=80=
=99? [-Wimplicit-function-declaration]
	     ret =3D X509_cmp_time(X509_get_notBefore(cert), NULL);
	                         ^~~~~~~~~~~~~~~~~~
	                         X509_getm_notBefore
	ssl_openssl.c:476:25: warning: passing argument 1 of =E2=80=98X509_cmp_tim=
e=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
	     ret =3D X509_cmp_time(X509_get_notBefore(cert), NULL);
	                         ^~~~~~~~~~~~~~~~~~~~~~~~
	In file included from /opt/ssl11/include/openssl/pem.h:17,
	                 from /opt/ssl11/include/openssl/ssl.h:55,
	                 from ssl_openssl.h:32,
	                 from ssl_backend.h:36,
	                 from ssl_openssl.c:44:
	/opt/ssl11/include/openssl/x509.h:474:36: note: expected =E2=80=98const AS=
N1_TIME *=E2=80=99 {aka =E2=80=98const struct asn1_string_st *=E2=80=99} bu=
t argument is of type =E2=80=98int=E2=80=99
	 int X509_cmp_time(const ASN1_TIME *s, time_t *t);
	                   ~~~~~~~~~~~~~~~~~^
	ssl_openssl.c:486:25: warning: implicit declaration of function =E2=80=98X=
509_get_notAfter=E2=80=99; did you mean =E2=80=98X509_getm_notAfter=E2=80=
=99? [-Wimplicit-function-declaration]
	     ret =3D X509_cmp_time(X509_get_notAfter(cert), NULL);
	                         ^~~~~~~~~~~~~~~~~
	                         X509_getm_notAfter
	ssl_openssl.c:486:25: warning: passing argument 1 of =E2=80=98X509_cmp_tim=
e=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
	     ret =3D X509_cmp_time(X509_get_notAfter(cert), NULL);
	                         ^~~~~~~~~~~~~~~~~~~~~~~
	In file included from /opt/ssl11/include/openssl/pem.h:17,
	                 from /opt/ssl11/include/openssl/ssl.h:55,
	                 from ssl_openssl.h:32,
	                 from ssl_backend.h:36,
	                 from ssl_openssl.c:44:
	/opt/ssl11/include/openssl/x509.h:474:36: note: expected =E2=80=98const AS=
N1_TIME *=E2=80=99 {aka =E2=80=98const struct asn1_string_st *=E2=80=99} bu=
t argument is of type =E2=80=98int=E2=80=99
	 int X509_cmp_time(const ASN1_TIME *s, time_t *t);
	                   ~~~~~~~~~~~~~~~~~^
	In file included from errlevel.h:27,
	                 from ssl_openssl.c:39:
	ssl_openssl.c: In function =E2=80=98tls_ctx_load_dh_params=E2=80=99:
	ssl_openssl.c:542:13: warning: implicit declaration of function =E2=80=98D=
H_size=E2=80=99; did you mean =E2=80=98dysize=E2=80=99? [-Wimplicit-functio=
n-declaration]
	         8 * DH_size(dh));
	             ^~~~~~~
	error.h:151:67: note: in definition of macro =E2=80=98msg=E2=80=99
	 #define msg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_AR=
GS__);} EXIT_FATAL(flags); } while (false)
	                                                                   ^~~~~~~=
~~~~
	ssl_openssl.c:544:5: warning: implicit declaration of function =E2=80=98DH=
_free=E2=80=99; did you mean =E2=80=98gc_free=E2=80=99? [-Wimplicit-functio=
n-declaration]
	     DH_free(dh);
	     ^~~~~~~
	     gc_free
	ssl_openssl.c: In function =E2=80=98tls_ctx_load_ecdh_params=E2=80=99:
	ssl_openssl.c:570:9: warning: implicit declaration of function =E2=80=98SS=
L_CTX_set_ecdh_auto=E2=80=99; did you mean =E2=80=98SSL_CTX_set_dh_auto=E2=
=80=99? [-Wimplicit-function-declaration]
	         SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
	         ^~~~~~~~~~~~~~~~~~~~~
	         SSL_CTX_set_dh_auto
	ssl_openssl.c: In function =E2=80=98openvpn_extkey_rsa_finish=E2=80=99:
	ssl_openssl.c:1041:30: warning: implicit declaration of function =E2=80=98=
RSA_get_method=E2=80=99; did you mean =E2=80=98SSL_get_ssl_method=E2=80=99?=
 [-Wimplicit-function-declaration]
	     const RSA_METHOD *meth =3D RSA_get_method(rsa);
	                              ^~~~~~~~~~~~~~
	                              SSL_get_ssl_method
	ssl_openssl.c:1041:30: warning: initialization of =E2=80=98const RSA_METHO=
D *=E2=80=99 {aka =E2=80=98const struct rsa_meth_st *=E2=80=99} from =E2=80=
=98int=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
	ssl_openssl.c:1042:5: warning: implicit declaration of function =E2=80=98R=
SA_meth_free=E2=80=99; did you mean =E2=80=98BIO_meth_free=E2=80=99? [-Wimp=
licit-function-declaration]
	     RSA_meth_free((RSA_METHOD *)meth);
	     ^~~~~~~~~~~~~
	     BIO_meth_free
	ssl_openssl.c: In function =E2=80=98rsa_priv_enc=E2=80=99:
	ssl_openssl.c:1079:24: warning: implicit declaration of function =E2=80=98=
RSA_size=E2=80=99; did you mean =E2=80=98HMAC_size=E2=80=99? [-Wimplicit-fu=
nction-declaration]
	     unsigned int len =3D RSA_size(rsa);
	                        ^~~~~~~~
	                        HMAC_size
	ssl_openssl.c:1082:20: error: =E2=80=98RSA_PKCS1_PADDING=E2=80=99 undeclar=
ed (first use in this function); did you mean =E2=80=98i2d_PKCS12_SAFEBAG=
=E2=80=99?
	     if (padding !=3D RSA_PKCS1_PADDING)
	                    ^~~~~~~~~~~~~~~~~
	                    i2d_PKCS12_SAFEBAG
	ssl_openssl.c:1082:20: note: each undeclared identifier is reported only o=
nce for each function it appears in
	mv -f .deps/ssl_mbedtls.Tpo .deps/ssl_mbedtls.Po
	/usr/bin/gcc-8 -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../includ=
e -I../../src/compat -O3 -Wall -fstack-protector-strong -funwind-tables -fa=
synchronous-unwind-tables -fmessage-length=3D0 -grecord-gcc-switches -D_FOR=
TIFY_SOURCE=3D2  -I/usr/local/include  -I/opt/ssl11/include -I/usr/include =
   -DPLUGIN_LIBDIR=3D\"/opt/openvpn/lib64/openvpn/plugins\"  -Wall -Wno-unu=
sed-parameter -Wno-unused-function -O3 -Wall -fstack-protector-strong -funw=
ind-tables -fasynchronous-unwind-tables -fmessage-length=3D0 -grecord-gcc-s=
witches -fPIC -DPIC -D_GNU_SOURCE -fno-strict-aliasing -Wall -std=3Dc99 -MT=
 ssl_verify.o -MD -MP -MF .deps/ssl_verify.Tpo -c -o ssl_verify.o ssl_verif=
y.c
	In file included from ssl_openssl.c:55:
	openssl_compat.h:661:46: error: =E2=80=98RSA_F_RSA_EAY_PRIVATE_ENCRYPT=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98RSA_F=
_RSA_OSSL_PRIVATE_ENCRYPT=E2=80=99?
	 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
	                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	/opt/ssl11/include/openssl/err.h:29:59: note: in definition of macro =E2=
=80=98ERR_PUT_error=E2=80=99
	 #  define ERR_PUT_error(a,b,c,d,e)        ERR_put_error(a,b,c,d,e)
	                                                           ^
	ssl_openssl.c:1084:9: note: in expansion of macro =E2=80=98RSAerr=E2=80=99
	         RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE=
);
	         ^~~~~~
	ssl_openssl.c:1084:16: note: in expansion of macro =E2=80=98RSA_F_RSA_OSSL=
_PRIVATE_ENCRYPT=E2=80=99
	         RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE=
);
	                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	ssl_openssl.c:1084:48: error: =E2=80=98RSA_R_UNKNOWN_PADDING_TYPE=E2=80=99=
 undeclared (first use in this function); did you mean =E2=80=98SSL_R_UNKNO=
WN_ALERT_TYPE=E2=80=99?
	         RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE=
);
	                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
	/opt/ssl11/include/openssl/err.h:29:61: note: in definition of macro =E2=
=80=98ERR_PUT_error=E2=80=99
	 #  define ERR_PUT_error(a,b,c,d,e)        ERR_put_error(a,b,c,d,e)
	                                                             ^
	ssl_openssl.c:1084:9: note: in expansion of macro =E2=80=98RSAerr=E2=80=99
	         RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE=
);
	         ^~~~~~
	ssl_openssl.c: In function =E2=80=98tls_ctx_use_external_rsa_key=E2=80=99:
	ssl_openssl.c:1106:16: warning: implicit declaration of function =E2=80=98=
RSA_meth_new=E2=80=99; did you mean =E2=80=98BIO_meth_new=E2=80=99? [-Wimpl=
icit-function-declaration]
	     rsa_meth =3D RSA_meth_new("OpenVPN external private key RSA Method",
	                ^~~~~~~~~~~~
	                BIO_meth_new
	ssl_openssl.c:1107:29: error: =E2=80=98RSA_METHOD_FLAG_NO_CHECK=E2=80=99 u=
ndeclared (first use in this function); did you mean =E2=80=98SSL_SECOP_SIG=
ALG_CHECK=E2=80=99?
	                             RSA_METHOD_FLAG_NO_CHECK);
	                             ^~~~~~~~~~~~~~~~~~~~~~~~
	                             SSL_SECOP_SIGALG_CHECK
	ssl_openssl.c:1109:5: warning: implicit declaration of function =E2=80=98R=
SA_meth_set_pub_enc=E2=80=99; did you mean =E2=80=98BIO_meth_set_puts=E2=80=
=99? [-Wimplicit-function-declaration]
	     RSA_meth_set_pub_enc(rsa_meth, rsa_pub_enc);
	     ^~~~~~~~~~~~~~~~~~~~
	     BIO_meth_set_puts
	ssl_openssl.c:1110:5: warning: implicit declaration of function =E2=80=98R=
SA_meth_set_pub_dec=E2=80=99; did you mean =E2=80=98BIO_meth_set_puts=E2=80=
=99? [-Wimplicit-function-declaration]
	     RSA_meth_set_pub_dec(rsa_meth, rsa_pub_dec);
	     ^~~~~~~~~~~~~~~~~~~~
	     BIO_meth_set_puts
	ssl_openssl.c:1111:5: warning: implicit declaration of function =E2=80=98R=
SA_meth_set_priv_enc=E2=80=99; did you mean =E2=80=98BIO_meth_set_write=E2=
=80=99? [-Wimplicit-function-declaration]
	     RSA_meth_set_priv_enc(rsa_meth, rsa_priv_enc);
	     ^~~~~~~~~~~~~~~~~~~~~
	     BIO_meth_set_write
	ssl_openssl.c:1112:5: warning: implicit declaration of function =E2=80=98R=
SA_meth_set_priv_dec=E2=80=99; did you mean =E2=80=98BIO_meth_set_write=E2=
=80=99? [-Wimplicit-function-declaration]
	     RSA_meth_set_priv_dec(rsa_meth, rsa_priv_dec);
	     ^~~~~~~~~~~~~~~~~~~~~
	     BIO_meth_set_write
	ssl_openssl.c:1113:5: warning: implicit declaration of function =E2=80=98R=
SA_meth_set_init=E2=80=99; did you mean =E2=80=98EVP_MD_meth_set_init=E2=80=
=99? [-Wimplicit-function-declaration]
	     RSA_meth_set_init(rsa_meth, NULL);
	     ^~~~~~~~~~~~~~~~~
	     EVP_MD_meth_set_init
	ssl_openssl.c:1114:5: warning: implicit declaration of function =E2=80=98R=
SA_meth_set_finish=E2=80=99; did you mean =E2=80=98BIO_meth_set_gets=E2=80=
=99? [-Wimplicit-function-declaration]
	     RSA_meth_set_finish(rsa_meth, openvpn_extkey_rsa_finish);
	     ^~~~~~~~~~~~~~~~~~~
	     BIO_meth_set_gets
	ssl_openssl.c:1115:5: warning: implicit declaration of function =E2=80=98R=
SA_meth_set0_app_data=E2=80=99; did you mean =E2=80=98SSL_CTX_set_app_data=
=E2=80=99? [-Wimplicit-function-declaration]
	     RSA_meth_set0_app_data(rsa_meth, NULL);
	     ^~~~~~~~~~~~~~~~~~~~~~
	     SSL_CTX_set_app_data
	ssl_openssl.c:1118:11: warning: implicit declaration of function =E2=80=98=
RSA_new=E2=80=99; did you mean =E2=80=98SSL_new=E2=80=99? [-Wimplicit-funct=
ion-declaration]
	     rsa =3D RSA_new();
	           ^~~~~~~
	           SSL_new
	ssl_openssl.c:1118:9: warning: assignment to =E2=80=98RSA *=E2=80=99 {aka =
=E2=80=98struct rsa_st *=E2=80=99} from =E2=80=98int=E2=80=99 makes pointer=
 from integer without a cast [-Wint-conversion]
	     rsa =3D RSA_new();
	         ^
	ssl_openssl.c:1128:5: warning: implicit declaration of function =E2=80=98R=
SA_get0_key=E2=80=99; did you mean =E2=80=98SSL_get0_dane=E2=80=99? [-Wimpl=
icit-function-declaration]
	     RSA_get0_key(pub_rsa, &n, &e, NULL);
	     ^~~~~~~~~~~~
	     SSL_get0_dane
	ssl_openssl.c:1129:5: warning: implicit declaration of function =E2=80=98R=
SA_set0_key=E2=80=99; did you mean =E2=80=98SSL_set_bio=E2=80=99? [-Wimplic=
it-function-declaration]
	     RSA_set0_key(rsa, BN_dup(n), BN_dup(e), NULL);
	     ^~~~~~~~~~~~
	     SSL_set_bio
	ssl_openssl.c:1129:23: warning: implicit declaration of function =E2=80=98=
BN_dup=E2=80=99; did you mean =E2=80=98OBJ_dup=E2=80=99? [-Wimplicit-functi=
on-declaration]
	     RSA_set0_key(rsa, BN_dup(n), BN_dup(e), NULL);
	                       ^~~~~~
	                       OBJ_dup
	ssl_openssl.c:1130:5: warning: implicit declaration of function =E2=80=98R=
SA_set_flags=E2=80=99; did you mean =E2=80=98BIO_set_flags=E2=80=99? [-Wimp=
licit-function-declaration]
	     RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
	     ^~~~~~~~~~~~~
	     BIO_set_flags
	ssl_openssl.c:1130:24: warning: implicit declaration of function =E2=80=98=
RSA_flags=E2=80=99; did you mean =E2=80=98ifr_flags=E2=80=99? [-Wimplicit-f=
unction-declaration]
	     RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
	                        ^~~~~~~~~
	                        ifr_flags
	ssl_openssl.c:1130:41: error: =E2=80=98RSA_FLAG_EXT_PKEY=E2=80=99 undeclar=
ed (first use in this function); did you mean =E2=80=98SSL_F_SSL_SET_PKEY=
=E2=80=99?
	     RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
	                                         ^~~~~~~~~~~~~~~~~
	                                         SSL_F_SSL_SET_PKEY
	ssl_openssl.c:1131:10: warning: implicit declaration of function =E2=80=98=
RSA_set_method=E2=80=99; did you mean =E2=80=98SSL_set_ssl_method=E2=80=99?=
 [-Wimplicit-function-declaration]
	     if (!RSA_set_method(rsa, rsa_meth))
	          ^~~~~~~~~~~~~~
	          SSL_set_ssl_method
	ssl_openssl.c:1144:5: warning: implicit declaration of function =E2=80=98R=
SA_free=E2=80=99; did you mean =E2=80=98SSL_free=E2=80=99? [-Wimplicit-func=
tion-declaration]
	     RSA_free(rsa); /* doesn't necessarily free, just decrements refcount =
*/
	     ^~~~~~~~
	     SSL_free
	ssl_openssl.c: In function =E2=80=98print_details=E2=80=99:
	ssl_openssl.c:1889:34: warning: implicit declaration of function =E2=80=98=
RSA_bits=E2=80=99 [-Wimplicit-function-declaration]
	                                  RSA_bits(rsa));
	                                  ^~~~~~~~
	ssl_openssl.c:1895:34: warning: implicit declaration of function =E2=80=98=
DSA_bits=E2=80=99 [-Wimplicit-function-declaration]
	                                  DSA_bits(dsa));
	                                  ^~~~~~~~
	ssl_openssl.c: In function =E2=80=98get_ssl_library_version=E2=80=99:
	ssl_openssl.c:2040:12: warning: implicit declaration of function =E2=80=98=
SSLeay_version=E2=80=99; did you mean =E2=80=98SSL_version=E2=80=99? [-Wimp=
licit-function-declaration]
	     return SSLeay_version(SSLEAY_VERSION);
	            ^~~~~~~~~~~~~~
	            SSL_version
	ssl_openssl.c:2040:27: error: =E2=80=98SSLEAY_VERSION=E2=80=99 undeclared =
(first use in this function); did you mean =E2=80=98SSL2_VERSION=E2=80=99?
	     return SSLeay_version(SSLEAY_VERSION);
	                           ^~~~~~~~~~~~~~
	                           SSL2_VERSION
	ssl_openssl.c:2041:1: warning: control reaches end of non-void function [-=
Wreturn-type]
	 }
	 ^
	make[3]: *** [Makefile:717: ssl_openssl.o] Error 1
	make[3]: *** Waiting for unfinished jobs....
	mv -f .deps/ssl_verify.Tpo .deps/ssl_verify.Po
	mv -f .deps/socket.Tpo .deps/socket.Po
	mv -f .deps/ssl.Tpo .deps/ssl.Po
	mv -f .deps/options.Tpo .deps/options.Po
	make[3]: Leaving directory '/usr/local/src/openvpn/src/openvpn'
	make[2]: *** [Makefile:429: all-recursive] Error 1
	make[2]: Leaving directory '/usr/local/src/openvpn/src'
	make[1]: *** [Makefile:614: all-recursive] Error 1
	make[1]: Leaving directory '/usr/local/src/openvpn'
	make: *** [Makefile:502: all] Error 2

It looks like the OpenVPN build is still trying to use the OpenSSL 1.0.0 sy=
mbols which are deprecated in 1.1.0.

I build all sorts of other apps with these OpenSSL 1.1.0 libs/includes, and=
 everything works great, so I'm sure it's not a problem with the OpenSSL bu=
ild.

What do you need to do to build OpenVPN with OpenSSL 1.1.0?

- AC

