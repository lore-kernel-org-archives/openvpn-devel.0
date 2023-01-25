Date: Wed, 25 Jan 2023 20:50:12 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y9GH9PKFR5V8ld9E@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.0 released
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

The OpenVPN community project team is proud to release OpenVPN 2.6.0.
This is the new stable version of OpenVPN with some major new features.

Changes since RC2:

* Various bugfixes, see https://github.com/OpenVPN/openvpn/blob/v2.6.0/Changes.rst

Windows MSI changes since RC2:
* Included openvpn-gui updated to 11.36.0.0. See https://github.com/OpenVPN/openvpn-gui/blob/v11.36.0.0/CHANGES.rst.
* DCO driver is now included as a installer module (msm) so that other products (like OpenVPN Connect) can share the DCO installation.

Some highlights of 2.6.0 are:

* Data Channel Offload (DCO) kernel acceleration support for Windows, Linux, and FreeBSD.
* OpenSSL 3 support, which is now the default on Windows.
* Improved handling of tunnel MTU, including support for pushable MTU.
* Outdated cryptographic algorithms disabled by default, but there are options to override
  if necessary.
* Reworked TLS handshake, making OpenVPN immune to replay-packet state exhaustion attacks.
* Added --peer-fingerprint mode for a more simplistic certificate setup and verification.
* Added Pre-Logon Access Provider support to OpenVPN GUI for Windows.
* Improved protocol negotiation, leading to faster connection setup.

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

(The Changes document also contains a section with work-arounds for
common problems encountered when using OpenVPN with OpenSSL 3)

Source code and Windows installers can be downloaded from our download page:

<https://community.openvpn.net/openvpn/wiki/Downloads>

(The Windows installers use OpenSSL 3 now)

(The Community Downloads page on openvpn.net
<https://openvpn.net/community-downloads/>
will probably be updated tomorrow).

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release/>

Kind regards,
-- 
  Frank Lichtenheld

