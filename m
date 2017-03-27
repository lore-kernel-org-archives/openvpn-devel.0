From: PGNet Dev <pgnet.dev@...277...>
Message-ID: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
Date: Mon, 27 Mar 2017 11:25:50 -0700
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] =?utf-8?q?building_HEAD_+_openssl_1=2E1_api_fails?=
 =?utf-8?q?_=40_=22crypto=2Ec=3A823=3A32=3A_error=3A_invalid_application_o?=
 =?utf-8?b?ZiDigJhzaXplb2bigJkgdG8gaW5jb21wbGV0ZSB0eXBlIOKAmGNpcGhlcl9j?=
 =?utf-8?b?dHhfdCI=?=
Reply-To: pgnet.dev@...277...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

fyi,

noting

	openvpn fails to build with openssl 1.1
		https://community.openvpn.net/openvpn/ticket/759

	[Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL 1.1.x
		https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14075.html

building latest HEAD,

	cd openvpn/
	git log | head
		commit 363af65178b8bbb482df958d6570c8763aee5d1d
		Author: Gert Doering <gert@...1296...>
		Date:   Sun Mar 19 19:41:35 2017 +0100

		    Make ENABLE_OCC no longer depend on !ENABLE_SMALL

		    OCC is useful functionality which (according to LEDE devs) adds only
		    about 3k to the binary size - and if the embedded router folks can
		    afford this trade-off, everyone else can :-)

builds/execs OK with OpenSSL 1.0 API.

otoh, similarly config'd, but using OpenSSL 1.1 API, as

	OPENSSL_CFLAGS="-I/usr/local/include -I/usr/local/openssl11/include" \
	OPENSSL_LIBS="-L/usr/local/openssl11/lib64 -Wl,-rpath,/usr/local/openssl11/lib64 -lssl -lcrypto" \
	./configure \
	--prefix=/usr/local/openvpn \
	--enable-shared --disable-static \
	--with-gnu-ld \
	--with-crypto-library=openssl \
	--enable-crypto \
	--enable-x509-alt-username \
	...

build fails @

	make V=1
		...
		mv -f .deps/comp-lz4.Tpo .deps/comp-lz4.Po
		/usr/bin/gcc-6 -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include -I../../src/compat -O3 -Wall -fstack-protector -funwind-tables -fasynchronous-unwind-tables -fmessage-length=0 -grecord-gcc-switches -march=native -mtune=native -D_FORTIFY_SOURCE=2  -I/usr/local/include  -I/usr/local/openssl11/include  -I/usr/include    -DPLUGIN_LIBDIR=\"/usr/local/openvpn/lib64/openvpn/plugins\"  -O3 -Wall -fstack-protector -funwind-tables -fasynchronous-unwind-tables -fmessage-length=0 -grecord-gcc-switches -march=native -mtune=native -fPIC -DPIC -D_GNU_SOURCE -fno-strict-aliasing -Wall -std=c99 -MT crypto.o -MD -MP -MF .deps/crypto.Tpo -c -o crypto.o crypto.c
		In file included from crypto.h:130:0,
		                 from crypto.c:36:
		crypto.c: In function ‘init_key_ctx’:
		crypto.c:823:32: error: invalid application of ‘sizeof’ to incomplete type ‘cipher_ctx_t {aka struct evp_cipher_ctx_st}’
		         ALLOC_OBJ(ctx->cipher, cipher_ctx_t);
		                                ^
		buffer.h:1015:61: note: in definition of macro ‘ALLOC_OBJ’
		         check_malloc_return((dptr) = (type *) malloc(sizeof(type))); \
		                                                             ^~~~
		crypto.c:847:30: error: invalid application of ‘sizeof’ to incomplete type ‘hmac_ctx_t {aka struct hmac_ctx_st}’
		         ALLOC_OBJ(ctx->hmac, hmac_ctx_t);
		                              ^
		buffer.h:1015:61: note: in definition of macro ‘ALLOC_OBJ’
		         check_malloc_return((dptr) = (type *) malloc(sizeof(type))); \
		                                                             ^~~~
		Makefile:673: recipe for target 'crypto.o' failed
		make[3]: *** [crypto.o] Error 1
		make[3]: Leaving directory '/usr/local/src/openvpn/src/openvpn'
		Makefile:429: recipe for target 'all-recursive' failed
		make[2]: *** [all-recursive] Error 1
		make[2]: Leaving directory '/usr/local/src/openvpn/src'
		Makefile:615: recipe for target 'all-recursive' failed
		make[1]: *** [all-recursive] Error 1
		make[1]: Leaving directory '/usr/local/src/openvpn'
		Makefile:503: recipe for target 'all' failed
		make: *** [all] Error 2

