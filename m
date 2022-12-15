Date: Thu, 15 Dec 2022 23:33:05 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y5ugocPlS5/VSeb2@...2678...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6_beta2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN 2.6_beta2.
This is the second Beta release for the feature release 2.6.0.

Changes since Beta 1:

* Transport statistics (bytes in/out) for DCO environments.
  Currently only for Windows clients and FreeBSD servers.
  Other platforms will be fixed in next release.
* Various bugfixes, see https://github.com/OpenVPN/openvpn/blob/v2.6_beta2/Changes.rst

Windows MSI changes since Beta 1:

* Included openvpn-gui updated to 11.33.0.0. See https://github.com/OpenVPN/openvpn-gui/blob/v11.33.0.0/CHANGES.rst
* Update included pkcs11-helper so it can load pkcs11 providers from outside of its own install directory.
* Add legacy provider for included OpenSSL so that the workarounds documented for old ciphers work on Windows.

Some highlights of 2.6.0 are:

* Data Channel Offload (DCO) kernel acceleration support for Windows, Linux, and FreeBSD.
* OpenSSL 3 support.
* Improved handling of tunnel MTU, including support for pushable MTU.
* Reworked TLS handshake, making OpenVPN immune to replay-packet state exhaustion attacks.
* Added --peer-fingerprint mode for a more simplistic certificate setup and verification.
* Improved protocol negotiation, leading to faster connection setup.

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

(The Changes document also contains a section with work-arounds for
common problems encountered when using OpenVPN with OpenSSL 3)

Source code and Windows installers can be downloaded from our download page:

<https://community.openvpn.net/openvpn/wiki/Downloads>

(The Windows installers use OpenSSL 3 now)

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

(Note that as a Beta release, packages are only available in testing
and release/2.6 repositories, not in stable)

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release/>


Kind regards,
-- 
  Frank Lichtenheld

