From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f2cedb6f-8be8-c7c6-f092-ac166aec2b7f@...515...>
Date: Mon, 19 Oct 2020 18:04:40 +0300
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] OpenVPN 2.5-rc3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN
2.5-rc3. Source code and Windows installers can be downloaded from our
download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On Red Hat derivatives we recommend using the Fedora Copr repository:

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-beta/>

This release includes a number of fixes to OpenVPN.

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

