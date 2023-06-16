Date: Fri, 16 Jun 2023 18:03:13 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZIyHwZY0c6+KdFpv@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.5 released
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

The OpenVPN community project team is proud to release OpenVPN 2.6.5.

This is a small bugfix release.

User visible changes:

* tapctl (windows): generate driver-specific names (if using tapctl to create
  additional tap/wintun/dco devices, and not using --name).
  See GH ​#337.
* interactive service (windows): do not force target desktop for openvpn.exe
  - this has no impact for normal use, but enables running of OpenVPN in a scripted
  way when no user is logged on (for example, via task scheduler).
  See GH ​openvpn-gui#626 

Windows MSI changes since 2.6.4:

* MSIs now use OpenSSL 3.1.1 

Debian/Ubuntu packages in official apt repositories are now available for arm64. 

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

