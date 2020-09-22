From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <b1352a58-c9a1-ab2d-f85d-c419c8887ef0@...515...>
Date: Tue, 22 Sep 2020 12:10:44 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------06120E408988A132CA497F62"
Content-Language: en-US
Subject: [Openvpn-devel] OpenVPN 2.5-rc1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------06120E408988A132CA497F62
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN
2.5-rc1. Source code and Windows installers can be downloaded from our
download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On Red Hat derivatives we recommend using the Fedora Copr repository:

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-beta/>

This release includes a number of fixes to OpenVPN. On the Windows side
there are several changes:

- The MSI installer now bundles EasyRSA 3, a modern take on OpenVPN CA
management

- OpenVPN GUI can now be run as admin without breaking Wintun with the
"Always use interactive service by default" checkbox.

- Windows performance is increased by enabling compile-time
optimizations for OpenVPN and OpenSSL.

OpenVPN 2.5 is a new major release with many new features:

    Client-specific tls-crypt keys (--tls-crypt-v2)
    Added support for using the ChaCha20-Poly1305 cipher in the OpenVPN
data channel
    Improved Data channel cipher negotiation
    Removal of BF-CBC support in default configuration
    Asynchronous (deferred) authentication support for auth-pam plugin
    Deferred client-connect
    Faster connection setup
    Netlink support
    Wintun support
    IPv6-only operation
    Improved Windows 10 detection
    Linux VRF support
    TLS 1.3 support
    Support setting DHCP search domain
    Handle setting of tun/tap interface MTU on Windows
    HMAC based auth-token support
    VLAN support
    Support building of .msi installers for Windows
    Allow unicode search string in --cryptoapicert option (Windows)
    Support IPv4 configs with /31 netmasks now
    New option --block-ipv6 to reject all IPv6 packets (ICMPv6)

More details on these new features as well as a list of deprecated
features and user-visible changes are available in Changes.rst:

<https://github.com/OpenVPN/openvpn/blob/release/2.5/Changes.rst>

For generic help use these support channels:

    Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
    Wiki: <https://community.openvpn.net/>
    Forums: <https://forums.openvpn.net/>
    User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
    User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

    Community bug tracker: <https://community.openvpn.net/>
    Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
    Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
Freenode registration)

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------06120E408988A132CA497F62
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.5_rc1-changelog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn-2.5_rc1-changelog"

David Sommerseth (4):
      man: Add missing --server-ipv6
      man: Improve --remote entry
      sample-plugins: Partially autotoolize the sample-plugins build
      build: Fix make distclean/distcheck

Gert Doering (11):
      Fix handling of 'route remote_host' for IPv6 transport case.
      Replace 'echo -n' with 'printf' in tests/t_lpback.sh
      Fix description of --client-disconnect calling convention in manpag=
e.
      Handle NULL returns from calloc() in sample plugins.
      Fix --show-gateway for IPv6 on NetBSD/i386.
      socks.c: fix alen for DOMAIN type addresses, bump up buffer sizes
      Fix netbits setting (in TAP mode) for IPv6 on Windows.
      If IPv6 pool specification sets pool start to ::0 address, incremen=
t.
      Add demo plugin that excercises "CLIENT_CONNECT" and "CLIENT_CONNEC=
T_V2" paths
      Fix combination of --dev tap and --topology subnet across multiple =
platforms.
      Preparing release 2.5_rc1

Lev Stipakov (1):
      msvc: better support for 32bit architecture

Selva Nair (2):
      Add a remark on dropping privileges when --mlock is used
      Allow --dhcp-option in config file when windows-driver is wintun

Vladislav Grishenko (1):
      Fix fatal error at switching remotes (#629)


--------------06120E408988A132CA497F62
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBF9XbKwBCADAEsX9sF+0PauqVCIX5SzteYzz2/awfjio7R4A7yGOkCPyFZui
ryItvJ9Oh21Woq2DW41JNZ16BR+3gJnWZ2wjKrYORXkk6Cq2mGfs1VHkikOXGeKh
G0kmNgewOB2xrbk27VvhALeUBRlbHF5w1XqGekm1tB/a8OThiyLA/jCzTf8LGSCq
rZoeg/DSvUNoOIuz/VzKvPRBNrvBgGfoR4qMmg5m6OaneaPckCuT58eNDMOGW3SD
f1wk31xBaqHNV2VMAyFuioxl3oyWdjp0dwdvgop+/l/8TJ/gUWqfQ8k5sik40Vlr
LrTwlR5+2/zOutJIy2N4T3xvz/4W6AthWe5BABEBAAG0JVNhbXVsaSBTZXBww6Ru
ZW4gPHNhbXVsaUBvcGVudnBuLm5ldD6JAVQEEwEIAD4WIQTUwk9SkPxedAa+noMq
Bow1gbDSfQUCX1dsrQIbAwUJAeEzgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
CRAqBow1gbDSfU62CACJBr2t6bor5THu7nx6NMTV2ubtsUYyHiLD4FeMXgRDSMhV
1GPJwSVF7qg1yNShlqco04Hykp/hDP83CG6ivZC21QACcVaUnRfACDETBGZ5ciUi
gLwjknDR9sQ9azOoqPp+bNBrlLWiQdYw7nyuNUYYGXQkv2stj7Rb11fR8IkWhIky
2VK8n5ppd3Al1nTNWxZkrTBgCO/JYXSWaZXFydwOPQxlzIBBeUoM3yoVxCP7qypu
ZbVQrDSX9L4LAFIBtgWaEBc2a2ocdlrwcQTovC8CWbg/b+0cG0FUsCuRhH4hsZOI
UiOwGGku2uLH5+JNKNDYgNmWgBZhV6wl59X4iZqguQENBF9XbKwBCADuoJFZ4PwJ
aCXWadIuuhy7pn+Gu7og85UGbb0xuI2mPtzR83V2qur/LeY8OnQSMSyy5n3ZBim5
noTe7la+9v/sYX+CC9Zj9KXXkTYiwDWtg+Pvwwjooee/ea336/kYaQSn1L2KHOJW
SgkQlfvM5FIvekQRvJ7scHn0o1tXKCtKVAOP9XIZdl2Dp+QGtKRAwJRFUiyd5oMq
7vY2x0YJoRS9Looq/+iqYNM+9zU0CjRNSXzfnKxBzSOVLtYBDFsud2LCt0bE5Gky
RFBq6cbJUt6aQInzzxVPW7kzEGKHi25AeCZ5UkX07eIGLwNO7PAX7A6YmsbF4Xbd
21sZEbb6EBVtABEBAAGJATwEGAEIACYWIQTUwk9SkPxedAa+noMqBow1gbDSfQUC
X1dsrAIbDAUJAeEzgAAKCRAqBow1gbDSfQe7CACZ6GI+rgKsIuXzhbyafZALyk55
d7I/6iFYNhCYUrVSOT187fhu1F/NTMCvcgQiOly+vvi9Xnw1JJTHVRSAmSMtCz/i
pM8mwU9HHQpHaN6adLdPsfhqsQM3/rGpQ6eGaNimfiQygA1YESvQIUC/edYw3ItF
4LOGu0Eyl5fbXV17ei21BzYiSrqtoBVfS0/G6p9fhP6j8w6OmpIc+ugSY/JmHNMb
NAjg6BR4Uuib/XeMIhtm57UmZqtJzBN0K61exQ2dJTvVdQ4X7wIqB73q3oNLJqJ1
kCZgoaLwFQhBMvRgh8zmk3Xm45RrmJAuPtgT4lzD1QcH0HZLkQFeI5QuHNC8
=3DqMWb
-----END PGP PUBLIC KEY BLOCK-----

--------------06120E408988A132CA497F62--

