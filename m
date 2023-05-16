Date: Tue, 16 May 2023 14:40:12 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZGN5rLctl5w8Iy3T@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.4 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN 2.6.4.

This is a small bugfix release.

Note:

* License amendment: all NEW commits fall under a modified license that explicitly permits
  linking with Apache2 libraries (mbedTLS, OpenSSL).
  See COPYING for details. Existing code will fall under the new license as soon as all
  contributors have agreed to the change - work ongoing.

Feature changes:

* DCO: support kernel-triggered key rotation (avoid IV reuse after 232 packets).
  This is the userland side, accepting a message from kernel, and initiating a
  TLS renegotiation. As of 2.6.4 release, only implemented in FreeBSD kernel. 

Windows MSI changes since 2.6.3:

* Rebuilt included tap-windows driver with the correct version of the old Windows 7 driver,
  removing a warning about unsigned driver on Windows 7 installation.
  See GH ​openvpn-build#365. 

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

(The Changes document also contains a section with work-arounds for
common problems encountered when using OpenVPN with OpenSSL 3)

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrepositories>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release-2.6/>

Kind regards,
-- 
  Frank Lichtenheld

