MIME-Version: 1.0
Date: Mon, 26 Mar 2012 22:33:01 +0200
Message-ID: <CAOazyz0qskX3taZW7amei-tEt=LcARsuE=hQCZ+010hRGVNC4w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] build solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Seems to compile using sun studio compiler and sun tool chain.
---
$ src/openvpn/openvpn --version
OpenVPN 2.3_alpha1 sparc-sun-solaris2.10 [SSL (OpenSSL)] [eurephia]
[PF_INET6] [IPv6 payload 20110522-1 (2.2.0)] built on Mar 26 2012
Originally developed by James Yonan
Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
Compile time defines: enable_crypto=yes enable_debug=yes
enable_def_auth=yes enable_dlopen=unknown enable_dlopen_self=unknown
enable_dlopen_self_static=unknown enable_eurephia=yes
enable_fast_install=needless enable_fragment=yes enable_http_proxy=yes
enable_iproute2=no enable_libtool_lock=yes enable_lzo=no
enable_lzo_stub=no enable_management=yes enable_multi=yes
enable_multihome=yes enable_pedantic=no enable_pf=yes enable_pkcs11=no
enable_plugins=yes enable_port_share=yes enable_selinux=no
enable_server=yes enable_shared=yes
enable_shared_with_static_runtimes=no enable_small=no enable_socks=yes
enable_ssl=yes enable_static=yes enable_strict=no
enable_strict_options=no enable_systemd=no enable_win32_dll=yes
enable_x509_alt_username=no with_crypto_library=openssl with_gnu_ld=no
with_mem_check=no with_sysroot=no

