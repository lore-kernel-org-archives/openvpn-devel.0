From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <692598dd-cd68-97de-5a52-b5cf9f3f0531@...515...>
Date: Fri, 14 Aug 2020 22:31:18 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QwwdkXH7Nb1YODX1umgVP6RMDC0lrPcRh"
Subject: [Openvpn-devel] OpenVPN 2.5-beta1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QwwdkXH7Nb1YODX1umgVP6RMDC0lrPcRh
Content-Type: multipart/mixed; boundary="ohnNeLscCeufxzX6facGg1v0FiI2PbcIZ"

--ohnNeLscCeufxzX6facGg1v0FiI2PbcIZ
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN
2.5-beta1. Source code and Windows installers can be downloaded from

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On RedHat derivatives we recommend using the Fedora Copr repository:

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-beta>

This is a new major release with many new features:

    - Client-specific tls-crypt keys (--tls-crypt-v2)
    - Added support for using the ChaCha20-Poly1305 cipher in the
OpenVPN data channel
    - Improved Data channel cipher negotiation
    - Removal of BF-CBC support in default configuration
    - Asynchronous (deferred) authentication support for auth-pam plugin
    - Deferred client-connect
    - Faster connection setup
    - Netlink support
    - Wintun support
    - IPv6-only operation
    - Improved Windows 10 detection
    - Linux VRF support
    - TLS 1.3 support
    - Support setting DHCP search domain
    - Handle setting of tun/tap interface MTU on Windows
    - HMAC based auth-token support
    - VLAN support
    - Support building of .msi installers for Windows
    - Allow unicode search string in --cryptoapicert option (Windows)
    - Support IPv4 configs with /31 netmasks now
    - New option --block-ipv6 to reject all IPv6 packets (ICMPv6)
    - IPv4-only VPN

More details on these new features as well as a list of deprecated
features and user-visible changes are available in Changes.rst:

<https://github.com/OpenVPN/openvpn/blob/release/2.5/Changes.rst>

For generic help use these support channels:

Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
Wiki: <https://community.openvpn.net>
Forums: <https://forums.openvpn.net>
User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

Bug tracker and wiki: <https://community.openvpn.net>
Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
Freenode registration)



--ohnNeLscCeufxzX6facGg1v0FiI2PbcIZ--

--QwwdkXH7Nb1YODX1umgVP6RMDC0lrPcRh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl825oYACgkQKVhNn0CG
RXhcxAgAiPN4HjWx7GIU7bLdTBM/VsriUpFuYDmcpSvQK4tqK8pYmZ3z5DfGZs6K
mu+eIjBnwWLmfOA3LJk07Z5eBTIOZihZ8XWiVGsb5Cr22G09+tWLUdo/2oPPNNw4
ycCjGAzl/0DtoDjLgn8b7w73X8vMSGeG+bWrzcGxIMHnq8jWH2ZTXmzcywQneES0
YyIxHDLLsa373pC+Dyb/SqMapfa6wD03qskHVzbYsUSAtT1XbR/MVWWj4OK3qekX
iTBRI0fFKItVhL8l93pSWp9zq42mveVTQ+Ust4QNeetVftp4q5VFffmoqiZzE4ZR
UiGyW3mat8VdWjyvZ4mihw2j0MEG/g==
=geji
-----END PGP SIGNATURE-----

--QwwdkXH7Nb1YODX1umgVP6RMDC0lrPcRh--

