From: debbie10t <debbie10t@...277...>
Message-ID: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
Date: Sun, 2 Apr 2017 00:57:41 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] gentoo build inconsistency with openssl in openvpn
 using elliptic curve cert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

sorry, I know this is slightly off-topic ..
I understand this may be down to a gentoo maintainer
but as I don't know I decided to document the problem.

Thanks for your help




The problem:

On gentoo when building openvpn there is a difference depending on how 
openvpn is built:

The first method generates openvpn which cannot use EC PKI
The second method generates openvpn which can use EC PKI

To create the cert/key use easyrsa-3.0.1 (linux)
and change:
  set_var EASYRSA_KEY_SIZE	4096
  set_var EASYRSA_ALGO		ec
  set_var EASYRSA_CURVE		secp384r1



===================

1. BROKEN METHOD
    *************

To create the binary:

Dependencies are all installed and system is upto date.

git clone https://github.com/Openvpn/openvpn.git 2.4
cd 2.4
git checkout -b 2.4 origin/release/2.4
autoreconf -ivf
./configure
make


me@...2259... ~/openvpn $ 2.4/src/openvpn/openvpn --version

OpenVPN 2.4.1 [git:2.4/8731dfa7caaf8b6d] x86_64-pc-linux-gnu [SSL 
(OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Apr  1 2017
library versions: OpenSSL 1.0.2k  26 Jan 2017, LZO 2.08
Originally developed by James Yonan
Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
Compile time defines: enable_async_push=no enable_comp_stub=no 
enable_crypto=yes enable_crypto_ofb_cfb=yes enable_debug=yes 
enable_def_auth=yes enable_dlopen=unknown enable_dlopen_self=unknown 
enable_dlopen_self_static=unknown enable_fast_install=needless 
enable_fragment=yes enable_iproute2=no enable_libtool_lock=yes 
enable_lz4=yes enable_lzo=yes enable_management=yes enable_multi=yes 
enable_multihome=yes enable_pam_dlopen=no enable_pedantic=no 
enable_pf=yes enable_pkcs11=no enable_plugin_auth_pam=yes 
enable_plugin_down_root=yes enable_plugins=yes enable_port_share=yes 
enable_selinux=no enable_server=yes enable_shared=yes 
enable_shared_with_static_runtimes=no enable_small=no enable_static=yes 
enable_strict=no enable_strict_options=no enable_systemd=no 
enable_werror=no enable_win32_dll=yes enable_x509_alt_username=no 
with_aix_soname=aix with_crypto_library=openssl with_gnu_ld=yes 
with_mem_check=no with_sysroot=no


me@...2259... ~/openvpn $ ldd -v 2.4/src/openvpn/openvpn

	linux-vdso.so.1 (0x00007ffc1dbf8000)
	libnsl.so.1 => /lib64/libnsl.so.1 (0x00007f44f345c000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x00007f44f3245000)
	liblzo2.so.2 => /usr/lib64/liblzo2.so.2 (0x00007f44f3023000)
	libcrypto.so.1.0.0 => /usr/lib64/libcrypto.so.1.0.0 (0x00007f44f2c36000)
	libssl.so.1.0.0 => /usr/lib64/libssl.so.1.0.0 (0x00007f44f29cc000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f44f27c8000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f44f242b000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f44f2215000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f44f3674000)

	Version information:
	2.4/src/openvpn/openvpn:
		libdl.so.2 (GLIBC_2.2.5) => /lib64/libdl.so.2
		libc.so.6 (GLIBC_2.15) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.2) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
	/lib64/libnsl.so.1:
		libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_PRIVATE) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
	/lib64/libresolv.so.2:
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_PRIVATE) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
	/usr/lib64/liblzo2.so.2:
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
	/usr/lib64/libcrypto.so.1.0.0:
		libdl.so.2 (GLIBC_2.2.5) => /lib64/libdl.so.2
		libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.7) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
	/usr/lib64/libssl.so.1.0.0:
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
	/lib64/libdl.so.2:
		ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
		libc.so.6 (GLIBC_PRIVATE) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
	/lib64/libc.so.6:
		ld-linux-x86-64.so.2 (GLIBC_2.3) => /lib64/ld-linux-x86-64.so.2
		ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
	/lib64/libz.so.1:
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6


me@...2259... ~/openvpn $ 2.4/src/openvpn/openvpn 
/etc/openvpn/tunc_xxxxxu_il.conf

Sat Apr  1 23:37:57 2017 us=342905 OpenVPN 2.4.1 
[git:2.4/8731dfa7caaf8b6d] x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] 
[LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Apr  1 2017
Sat Apr  1 23:37:57 2017 us=342948 library versions: OpenSSL 1.0.2k  26 
Jan 2017, LZO 2.08
Sat Apr  1 23:37:57 2017 us=343040 MANAGEMENT: TCP Socket listening on 
[AF_INET]127.0.0.1:xxxxx

<snip>

Sat Apr  1 23:37:57 2017 us=343513 OpenSSL: error:0609E09C:digital 
envelope routines:PKEY_SET_TYPE:unsupported algorithm
Sat Apr  1 23:37:57 2017 us=343642 OpenSSL: error:0B07706F:x509 
certificate routines:X509_PUBKEY_get:unsupported algorithm
Sat Apr  1 23:37:57 2017 us=343706 OpenSSL: error:140BF10C:SSL 
routines:SSL_SET_CERT:x509 lib
Sat Apr  1 23:37:57 2017 us=343765 Cannot load inline certificate file
Sat Apr  1 23:37:57 2017 us=343827 Exiting due to fatal error

me@...2259... ~/openvpn $


====================

2. WORKING METHOD
    **************

To create this binary:
git clone https://github.com/Openvpn/openvpn-build.git btest
cd btest/generic
IMAGEROOT=`pwd`/image-native ./build


me@...2259... ~/openvpn/btest/generic $ 
image-native/openvpn/sbin/openvpn --version

OpenVPN 2.4.1 x86_64-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] 
[EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Apr  1 2017
library versions: OpenSSL 1.0.2k  26 Jan 2017, LZO 2.10
Originally developed by James Yonan
Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
Compile time defines: enable_async_push=no enable_comp_stub=no 
enable_crypto=yes enable_crypto_ofb_cfb=yes enable_debug=yes 
enable_def_auth=yes enable_dlopen=unknown enable_dlopen_self=unknown 
enable_dlopen_self_static=unknown enable_fast_install=needless 
enable_fragment=yes enable_iproute2=no enable_libtool_lock=yes 
enable_lz4=yes enable_lzo=yes enable_management=yes enable_multi=yes 
enable_multihome=yes enable_pam_dlopen=no enable_pedantic=no 
enable_pf=yes enable_pkcs11=yes enable_plugin_auth_pam=yes 
enable_plugin_down_root=yes enable_plugins=yes enable_port_share=yes 
enable_selinux=no enable_server=yes enable_shared=yes 
enable_shared_with_static_runtimes=no enable_small=no enable_static=yes 
enable_strict=no enable_strict_options=no enable_systemd=no 
enable_werror=no enable_win32_dll=yes enable_x509_alt_username=no 
with_crypto_library=openssl with_gnu_ld=yes with_mem_check=no 
with_special_build= with_sysroot=no


me@...2259... ~/openvpn/btest/generic $ ldd -v 
image-native/openvpn/sbin/openvpn

	linux-vdso.so.1 (0x00007ffc1bd78000)
	libnsl.so.1 => /lib64/libnsl.so.1 (0x00007f5832d44000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x00007f5832b2d000)
	liblzo2.so.2 => 
/home/me/openvpn/btest/generic/image-native/openvpn/lib/liblzo2.so.2 
(0x00007f58328f6000)
	libpkcs11-helper.so.1 => 
/home/me/openvpn/btest/generic/image-native/openvpn/lib/libpkcs11-helper.so.1 
(0x00007f58326d7000)
	libssl.so.1.0.0 => 
/home/me/openvpn/btest/generic/image-native/openvpn/lib/libssl.so.1.0.0 
(0x00007f5832464000)
	libcrypto.so.1.0.0 => 
/home/me/openvpn/btest/generic/image-native/openvpn/lib/libcrypto.so.1.0.0 
(0x00007f5832009000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f5831e05000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f5831a68000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f583184c000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f5832f5c000)

	Version information:
	image-native/openvpn/sbin/openvpn:
		libdl.so.2 (GLIBC_2.2.5) => /lib64/libdl.so.2
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.2) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
	/lib64/libnsl.so.1:
		libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_PRIVATE) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
	/lib64/libresolv.so.2:
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_PRIVATE) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
	/home/me/openvpn/btest/generic/image-native/openvpn/lib/liblzo2.so.2:
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
	/home/me/openvpn/btest/generic/image-native/openvpn/lib/libpkcs11-helper.so.1:
		libdl.so.2 (GLIBC_2.2.5) => /lib64/libdl.so.2
		libpthread.so.0 (GLIBC_2.3.2) => /lib64/libpthread.so.0
		libpthread.so.0 (GLIBC_2.2.5) => /lib64/libpthread.so.0
		libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.7) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.2) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
	/home/me/openvpn/btest/generic/image-native/openvpn/lib/libssl.so.1.0.0:
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
	/home/me/openvpn/btest/generic/image-native/openvpn/lib/libcrypto.so.1.0.0:
		libdl.so.2 (GLIBC_2.2.5) => /lib64/libdl.so.2
		libc.so.6 (GLIBC_2.3) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.7) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.4) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
	/lib64/libdl.so.2:
		ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
		libc.so.6 (GLIBC_PRIVATE) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
	/lib64/libc.so.6:
		ld-linux-x86-64.so.2 (GLIBC_2.3) => /lib64/ld-linux-x86-64.so.2
		ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
	/lib64/libpthread.so.0:
		ld-linux-x86-64.so.2 (GLIBC_2.2.5) => /lib64/ld-linux-x86-64.so.2
		ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
		libc.so.6 (GLIBC_2.14) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.2) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_PRIVATE) => /lib64/libc.so.6


me@...2259... ~/openvpn/btest/generic $ 
image-native/openvpn/sbin/openvpn /etc/openvpn/tunc_xxxxxu_il.conf

Sun Apr  2 00:27:15 2017 us=870872 OpenVPN 2.4.1 
x86_64-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] 
[MH/PKTINFO] [AEAD] built on Apr  1 2017
Sun Apr  2 00:27:15 2017 us=870890 library versions: OpenSSL 1.0.2k  26 
Jan 2017, LZO 2.10
Sun Apr  2 00:27:15 2017 us=870981 MANAGEMENT: TCP Socket listening on 
[AF_INET]127.0.0.1:xxxxx
Sun Apr  2 00:27:15 2017 us=871693 Outgoing Control Channel 
Authentication: Using 512 bit message hash 'SHA512' for HMAC authentication
Sun Apr  2 00:27:15 2017 us=871724 Incoming Control Channel 
Authentication: Using 512 bit message hash 'SHA512' for HMAC authentication
Sun Apr  2 00:27:15 2017 us=871795 Control Channel MTU parms [ L:1622 
D:1140 EF:110 EB:0 ET:0 EL:3 ]
Sun Apr  2 00:27:16 2017 us=107916 Data Channel MTU parms [ L:1622 
D:1450 EF:122 EB:406 ET:0 EL:3 ]
Sun Apr  2 00:27:16 2017 us=107996 Local Options String (VER=V4): 
'V4,dev-type tun,link-mtu 1602,tun-mtu 1500,proto UDPv4,comp-lzo,keydir 
1,cipher AES-256-CBC,auth SHA512,keysize 256,tls-auth,key-method 
2,tls-client'
Sun Apr  2 00:27:16 2017 us=108013 Expected Remote Options String 
(VER=V4): 'V4,dev-type tun,link-mtu 1602,tun-mtu 1500,proto 
UDPv4,comp-lzo,keydir 0,cipher AES-256-CBC,auth SHA512,keysize 
256,tls-auth,key-method 2,tls-server'
Sun Apr  2 00:27:16 2017 us=108043 TCP/UDP: Preserving recently used 
remote address: [AF_INET] etc

The connection completes ..



-- 

