Date: Wed, 23 Aug 2023 11:19:23 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZOXPGwUFBCIxZts7@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.6 released
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

The OpenVPN community project team is proud to release OpenVPN 2.6.6.

This is a small bugfix release.

User visible changes:

* OCC exit messages are now logged more visibly. See GH ​#391.
* OpenSSL error messages are now logged with more details
  (for example, when loading a provider fails, which .so was tried, and why did it fail).
  See GH ​#361.
* print a more user-friendly message when tls-crypt-v2 client auth fails
* packaging now includes all documentation in the source tarball 

New features:

* set WINS server via interactive service - this adds support for
  "dhcp-option WINS 192.0.2.1" for DCO + wintun interfaces where
  no DHCP server is used. See GH ​#373. 

Windows MSI changes since 2.6.5:

* Included openvpn-gui updated to 11.44.0.0
* MSIs now use OpenSSL 3.1.2 

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

