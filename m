Date: Tue, 28 Mar 2023 12:02:57 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZCK7UUerR1gILqwv@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.2 released
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

The OpenVPN community project team is proud to release OpenVPN 2.6.2.

This is mostly a bugfix release with some improvements.

Feature changes:

* implement byte counter statistics for DCO Linux (p2mp server and client)
* implement byte counter statistics for DCO Windows (client only)
* "--dns server <n> address ..." now permits up to 8 v4 or v6 addresses

Important note for Linux DCO users:

New control packets flow for data channel offloading on Linux:
2.6.2+ changes the way OpenVPN control packets are handled on Linux when
DCO is active, fixing the lockups observed with 2.6.0/2.6.1 under high client
connect/disconnect activity. This is an INCOMPATIBLE change and therefore an
ovpn-dco kernel module older than v0.2.20230323 (commit ID 726fdfe0fa21) will
not work anymore and must be upgraded. The kernel module was renamed to
"ovpn-dco-v2.ko" in order to highlight this change and ensure that users and
userspace software could easily understand which version is loaded. Attempting
to use the old ovpn-dco with 2.6.2+ will lead to disabling DCO at runtime.

Windows MSI changes since 2.6.1:

* Update included openvpn-gui to 11.39.0.0

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

