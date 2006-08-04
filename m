Message-ID: <44D2A3B9.9050506@...277...>
Date: Thu, 03 Aug 2006 18:32:41 -0700
From: Richard <openmacnews@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] malloc errors on OpenVPN-cvs 'make check'
Reply-To: openmacnews@...277...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

(i guess this belongs over here on -devel ...)

hi,

i'm attempting a 1st build/install of OpenVPN from src on OSX 10.4.7

as prereqs, i've successfully:

	built & kextload-ed the TUN/TAP drivers
	built & installed lzo libs & headers

working with a cvs co (8/3/06 10:17:15) of openvpn head:

	cd /usr/ports/openvpn-cvs
	autoreconf -i -v

	./configure \
	--prefix=/usr/local/openvpn \
	--enable-pthread \
	--disable-password-save \
	--with-ssl-headers=/usr/local/ssl/include/openssl/ \
	--with-ssl-lib=/usr/local/ssl/lib/ \
	--with-lzo-headers=/usr/local/include/lzo \
	--with-lzo-lib=/usr/local/lib \
	--with-ifconfig-path=/sbin/ifconfig \
	--with-route-path=/sbin/route

	make

all succeed without apparent error.

but an immediately subsequent:

	make check

fails at:

make  check-TESTS
PASS: t_lpback.sh
the following test will run about two minutes...
Thu Aug  3 11:59:29 2006 OpenVPN 2.0.2 powerpc-apple-darwin8.7.0 [SSL]
[LZO] built on Aug  3 2006
Thu Aug  3 11:59:29 2006 WARNING: --ping should normally be used with
- --ping-restart or --ping-exit
Thu Aug  3 11:59:29 2006 WARNING: No server certificate verification
method has been enabled.  See http://openvpn.net/howto.html#mitm for
more info.
Thu Aug  3 11:59:29 2006 OpenVPN 2.0.2 powerpc-apple-darwin8.7.0 [SSL]
[LZO] built on Aug  3 2006
Thu Aug  3 11:59:29 2006 WARNING: --ping should normally be used with
- --ping-restart or --ping-exit
Thu Aug  3 11:59:29 2006 WARNING: file 'sample-keys/client.key' is group
or others accessible
Thu Aug  3 11:59:29 2006 Control Channel MTU parms [ L:1541 D:138 EF:38
EB:0 ET:0 EL:0 ]
Thu Aug  3 11:59:29 2006 Data Channel MTU parms [ L:1541 D:1450 EF:41
EB:4 ET:0 EL:0 ]
Thu Aug  3 11:59:29 2006 Local Options hash (VER=V4): '914df5fc'
Thu Aug  3 11:59:29 2006 Expected Remote Options hash (VER=V4): '0b2b92a2'
Thu Aug  3 11:59:29 2006 UDPv4 link local (bound): 127.0.0.1:16001
Thu Aug  3 11:59:29 2006 UDPv4 link remote: 127.0.0.1:16000
Thu Aug  3 11:59:29 2006 Diffie-Hellman initialized with 1024 bit key
Thu Aug  3 11:59:29 2006 WARNING: file 'sample-keys/server.key' is group
or others accessible
Thu Aug  3 11:59:29 2006 Control Channel MTU parms [ L:1541 D:138 EF:38
EB:0 ET:0 EL:0 ]
Thu Aug  3 11:59:29 2006 Data Channel MTU parms [ L:1541 D:1450 EF:41
EB:4 ET:0 EL:0 ]
Thu Aug  3 11:59:29 2006 Local Options hash (VER=V4): '0b2b92a2'
Thu Aug  3 11:59:29 2006 Expected Remote Options hash (VER=V4): '914df5fc'
Thu Aug  3 11:59:29 2006 UDPv4 link local (bound): 127.0.0.1:16000
Thu Aug  3 11:59:29 2006 UDPv4 link remote: 127.0.0.1:16001
Thu Aug  3 11:59:29 2006 TLS: Initial packet from 127.0.0.1:16000,
sid=588a7109 2e42c448
Thu Aug  3 11:59:29 2006 TLS: Initial packet from 127.0.0.1:16001,
sid=f9ef0a6f 6d80d30a
Thu Aug  3 12:00:29 2006 TLS Error: TLS key negotiation failed to occur
within 60 seconds (check your network connectivity)
Thu Aug  3 12:00:29 2006 TLS Error: TLS handshake failed
openvpn(5148) malloc: ***  Deallocation of a pointer not malloced:
0x3c001000; This could be a double free(), or free() called with the
middle of an allocated block; Try setting environment variable
MallocHelp to see tools to help debug
openvpn(5148) malloc: ***  Deallocation of a pointer not malloced:
0x9002c5d0; This could be a double free(), or free() called with the
middle of an allocated block; Try setting environment variable
MallocHelp to see tools to help debug
openvpn(5148) malloc: ***  Deallocation of a pointer not malloced:
0x900c84b0; This could be a double free(), or free() called with the
middle of an allocated block; Try setting environment variable
MallocHelp to see tools to help debug
openvpn(5148) malloc: ***  Deallocation of a pointer not malloced:
0xa0006210; This could be a double free(), or free() called with the
middle of an allocated block; Try setting environment variable
MallocHelp to see tools to help debug
openvpn(5148) malloc: ***  Deallocation of a pointer not malloced:
0x90019cc0; This could be a double free(), or free() called with the
middle of an allocated block; Try setting environment variable
MallocHelp to see tools to help debug
openvpn(5148) malloc: ***  Deallocation of a pointer not malloced:
0xa0006210; This could be a double free(), or free() called with the
middle of an allocated block; Try setting environment variable
MallocHelp to see tools to help debug
openvpn(5148) malloc: ***  Deallocation of a pointer not malloced:
0x90410004; This could be a double free(), or free() called with the
middle of an allocated block; Try setting environment variable
MallocHelp to see tools to help debug
openvpn(5148) malloc: ***  Deallocation of a pointer not malloced:
0x9012fc8c; This could be a double free(), or free() called with the
middle of an allocated block; Try setting environment variable
MallocHelp to see tools to help debug
./t_cltsrv.sh: line 28:  5147 Bus error               ./openvpn --cd
"${srcdir}" --config sample-config-files/loopback-server
./t_cltsrv.sh: line 28:  5148 Bus error               ./openvpn --cd
"${srcdir}" --config sample-config-files/loopback-client
FAIL: t_cltsrv.sh
====================================================
1 of 2 tests failed
Please report to openvpn-users@lists.sourceforge.net
====================================================
make[1]: *** [check-TESTS] Error 1
make: *** [check-am] Error 2


my network is up-n-running, and i'm able to ssh at will to any/all
locations.

thoughts/suggestions?

thanks,

richard
- --

/"\
\ /  ASCII Ribbon Campaign
 X   against HTML email, vCards
/ \  & micro$oft attachments

[GPG] OpenMacNews at gmail dot com
fingerprint: 50C9 1C46 2F8F DE42 2EDB  D460 95F7 DDBD 3671 08C6
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iEYEAREDAAYFAkTSo7gACgkQlffdvTZxCMZxRACfTVhQJtNCyZl+AspYoX8t9rhf
xD8AnjWEPTMzMLC662IXNNf1ooOZGh3k
=QKA9
-----END PGP SIGNATURE-----


