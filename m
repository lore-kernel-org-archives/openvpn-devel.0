Date: Fri, 14 Apr 2023 22:17:16 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZDm0zN12jLJHySoH@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.3 released
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

The OpenVPN community project team is proud to release OpenVPN 2.6.3.

This is a small bugfix release.

Feature changes:

* Windows: support setting DNS domain in configurations without GUI and DHCP
  (typically wintun or windco drivers), see GH ​openvpn#306. 

Windows MSI changes since 2.6.2:

* Several Windows-specific issues fixed:
  * ensure interactive service stays enabled after silent reinstall,
    see GH ​openvpn-build#348, ​openvpn-build#349 and ​openvpn-build#351
  * repair querying install path info for easyrsa-start.bat on some Windows
    language versions, see GH ​openvpn-build#352. 
* MSIs are now built against OpenSSL 3.1.0.
* Update included openvpn-gui to 11.41.0.0
  * This update removes the ability to change the password of a private key from the GUI.
    This was a niche feature which caused a direct dependency of GUI on OpenSSL.
    Use openssl.exe directly if you need to edit a private key. 

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

(The Changes document also contains a section with work-arounds for
common problems encountered when using OpenVPN with OpenSSL 3)

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release/>

Kind regards,
-- 
  Frank Lichtenheld

