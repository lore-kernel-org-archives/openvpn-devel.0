Message-ID: <4FE9B68E.5080902@...515...>
Date: Tue, 26 Jun 2012 16:18:06 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Configure options for the Windows builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

Do these configure options look ok for the 2.3-alpha2 Windows builds?

enable_crypto=3Dyes
enable_debug=3Dno
enable_def_auth=3Dyes
enable_dlopen=3Dunknown
enable_dlopen_self=3Dunknown
enable_dlopen_self_static=3Dunknown
enable_eurephia=3Dyes
enable_fast_install=3Dneedless
enable_fragment=3Dyes
enable_http_proxy=3Dyes
enable_iproute2=3Dno
enable_libtool_lock=3Dyes
enable_lzo=3Dyes
enable_lzo_stub=3Dno
enable_management=3Dyes
enable_multi=3Dyes
enable_multihome=3Dyes
enable_password_save=3Dyes
enable_pedantic=3Dno
enable_pf=3Dyes
enable_pkcs11=3Dyes
enable_plugins=3Dyes
enable_port_share=3Dyes
enable_selinux=3Dno
enable_server=3Dyes
enable_shared=3Dyes
enable_shared_with_static_runtimes=3Dyes
enable_small=3Dno
enable_socks=3Dyes
enable_ssl=3Dyes
enable_static=3Dyes
enable_strict=3Dno
enable_strict_options=3Dno
enable_systemd=3Dno
enable_win32_dll=3Dyes
enable_x509_alt_username=3Dno
with_crypto_library=3Dopenssl
with_gnu_ld=3Dyes
with_mem_check=3Dno

If nobody complains, I'll use these :).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


