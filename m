From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <22a91a88-9555-ef6a-2941-22adfc7f9788@...515...>
Date: Tue, 1 Sep 2020 17:16:08 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tWtp7nR61kKUDO1wRsll4CsY0xDKUSzfx"
Subject: [Openvpn-devel] OpenVPN 2.5-beta3 released
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
--tWtp7nR61kKUDO1wRsll4CsY0xDKUSzfx
Content-Type: multipart/mixed; boundary="3eZJVVLwos1aVd9lnueAf7dtk0023GSzL"

--3eZJVVLwos1aVd9lnueAf7dtk0023GSzL
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN
2.5-beta3. Source code and Windows installers can be downloaded from

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On RedHat derivatives we recommend using the Fedora Copr repository:

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-beta>

This release includes fixes to MSI packaging and client NCP OCP fallback
behavior.

OpenVPN 2.5 is a new major release with many new features:

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


--3eZJVVLwos1aVd9lnueAf7dtk0023GSzL--

--tWtp7nR61kKUDO1wRsll4CsY0xDKUSzfx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl9OV6gACgkQKVhNn0CG
RXiaJgf+PKNyGe+WhVheFARttaR/KXRK0hahkBxOOLLgbbBhbPiwzOPI6VvVvIFn
FyO/kuhIIqqSHJn2nw4wruHvS48RrRJKpjjk0LHy5MYMPgxekiPmulJQRj+tqdmJ
kxLNpFzbmxOx1SBS8X594N3S16lFrHKaUVud8UJvFrNvNWbn5cKC8KheL1yfgKEE
uXg1KwlLTgVc0mvRo80h99CK6EfWiUzfiCPg4dLdm7f6usr/RG0BNx5W3BCLyQwU
VjPV58TOdBroriLrQ43jGIMF6gf0QPCIsnlfqPUr5YVaojSMZXAylOeDEGd6I7IP
E64zJpCJkSPdHkXrDUVUtFVcZB7MOQ==
=muBm
-----END PGP SIGNATURE-----

--tWtp7nR61kKUDO1wRsll4CsY0xDKUSzfx--

