Date: Wed, 28 Dec 2022 16:36:32 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y6xigNhAE2KGIwiV@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6_rc1 released
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

The OpenVPN community project team is proud to release OpenVPN 2.6_rc1.
This is the first release candidate (and the third beta release) for
the feature release 2.6.0.

Changes since Beta 2:

* Officially deprecate NTLMv1 proxy auth method in 2.6. Will be removed in 2.7.
* Support unlimited number of connection entries and remote entries.
* New management commands to enumerate and list remote entries.
* Various bugfixes, see https://github.com/OpenVPN/openvpn/blob/v2.6_rc1/Changes.rst

Windows MSI changes since Beta 2:
* Included openvpn-gui updated to 11.34.0.0. See https://github.com/OpenVPN/openvpn-gui/blob/v11.34.0.0/CHANGES.rst.
  * New feature: Connections active on exit/logout are now automatically restarted in the next session of the GUI
* Windows installers are now built with Visual Studio 17 2022 (previously built with VS 16 2019)

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

