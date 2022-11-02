Date: Wed, 2 Nov 2022 22:37:12 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y2LjCP6+bVqYOkGQ@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.5.8 released
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

The OpenVPN community project team is proud to release OpenVPN 2.5.8. This is
mostly a bugfix release.
However, there were several enhancements of the Windows GUI component:

* OpenVPN 3 support -- the GUI can also work as a user interface for
  the OpenVPN 3 client.
* pkcs11-id-management -- the GUI can list available pkcs11-ids and
  allows the user to select one.
* Persistent connections -- the GUI lists connections started at boot
  by the automatic service and lets the user control them. Interactive
  inputs such as username/password with such connections are possible.

The official APT repositories now contain packages built for Ubuntu 22.10
(kinetic).

List of changes in OpenVPN:

<https://github.com/OpenVPN/openvpn/blob/release/2.5/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release/>

