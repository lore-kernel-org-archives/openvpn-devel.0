From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a932b216-9ffe-a6c7-ff28-0e03b810fb2d@...515...>
Date: Wed, 30 Sep 2020 14:50:18 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------CB7D506E351D3A60907A5444"
Content-Language: en-US
Subject: [Openvpn-devel] OpenVPN 2.5-rc2 released
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
--------------CB7D506E351D3A60907A5444
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN
2.5-rc2. Source code and Windows installers can be downloaded from our
download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On Red Hat derivatives we recommend using the Fedora Copr repository:

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-beta/>

This release includes a number of fixes to OpenVPN, most of which affect
Windows only.

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
    MSI installer (Windows)
    The MSI installer now bundles EasyRSA 3, a modern take on OpenVPN CA
      management

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



--------------CB7D506E351D3A60907A5444
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.5_rc2-changelog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn-2.5_rc2-changelog"

Gert Doering (1):
      Preparing release 2.5_rc2

Lev Stipakov (1):
      Alias ADAPTER_DOMAIN_SUFFIX to DOMAIN

Selva Nair (2):
      Set DNS Domain using iservice
      Improve documentation of --username-as-common-name

Simon Rozman via Openvpn-devel (4):
      netsh: Specify interfaces by index rather than name
      netsh: Clear existing IPv6 DNS servers before configuring new ones
      netsh: Delete WINS servers on TUN close
      openvpnmsica: Simplify find_adapters() to void return

Vladislav Grishenko (1):
      Fix update_time() and openvpn_gettimeofday() coexistence


--------------CB7D506E351D3A60907A5444
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

--------------CB7D506E351D3A60907A5444--

