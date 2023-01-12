Date: Thu, 12 Jan 2023 22:22:01 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y8B5+XcKvn5T6gV4@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6_rc2 released
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

The OpenVPN community project team is proud to release OpenVPN 2.6_rc2.
This is the second release candidate (and the fourth beta release) for
the feature release 2.6.0.

Changes since RC1:

* Add rate limiter for incoming "initial handshake packets",
  enabled by default with a limit of 100 packets per 10 seconds.
  This change makes OpenVPN servers uninteresting as an UDP reflection DDoS engine.
* Report CONNECTED,ROUTE_ERROR to management GUI if connection to server succeeds
  but not all routes can be installed (Windows and Linux/Netlink only, so far) 
* Various bugfixes, see https://github.com/OpenVPN/openvpn/blob/v2.6_rc2/Changes.rst

Windows MSI changes since RC1:
* Included openvpn-gui updated to 11.35.0.0. See https://github.com/OpenVPN/openvpn-gui/blob/v11.35.0.0/CHANGES.rst.
  * New feature: Support the CONNECTED,ROUTE_ERROR management message (see above) 
* Fix some issues related to upgrading:
  * "Run on logon" option not preserved when updating from 2.5 to 2.6
  * Fix check for running service when upgrading from old NSIS installations 

Debian packages changes since RC1:

* Packages for Debian bookworm are now available. 

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

