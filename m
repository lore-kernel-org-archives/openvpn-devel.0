Date: Wed, 24 Sep 2025 16:52:00 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aNQFkHw9AE0aF4id@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.15 released
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
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN 2.6.15.

This is a bugfix release.

Bug fixes:

* On Windows, do not use "wmic.exe" any longer to set DNS search domain
  (discontinued by Microsoft), use "powershell" fragment instead.
* On Windows, logging to the windows event log has been improved
  (and logging of GetLastError() strings repaired).
  To make this work, a new "openvpnmsgserv.dll" library is now installed and
  registered.
* DNS domain names are now strictly validated with a positive-list of
  allowed characters (including UTF-8 high-bit-set bytes) before being handed
  to powershell.
* Apply more checks to incoming TLS handshake packets before creating new state
  - namely, verify message ID / acked ID for "valid range for an initial packet".
  This fixes a problem with clients that float very early but send control
  channel packet from the pre-float IP (Github: OpenVPN/openvpn#704, backported
  from 2.7_beta1).
* Backport handling of client float notifications on FreeBSD 14/STABLE DCO.
  (FreeBSD: #289303)
* Update GPL license text to latest version from FSF.
* On Linux, on interfaces where applicable, OpenVPN explicitly configures the
  broadcast address again. This was dropped for 2.6.0 "because computers are
  smart and can do it themselves", but the kernel netlink interface isn't, and
  will install "0.0.0.0". This does not normally matter, but for broadcast-based
  applications that get the address to use from "ifconfig", this change repairs
  functionality.

Windows MSI changes since 2.6.14-I004:

* Built against OpenSSL 3.5.3
* Included openvpn-gui updated to 11.56.0.0
  * Fix "Cannot open the System Tray Menu with Keyboard"
    (Github: OpenVPN/openvpn-gui#763)

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

(The Changes document also contains a section with work-arounds for
common problems encountered when using OpenVPN with OpenSSL 3)

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrepositories>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/g/OpenVPN/openvpn-release-2.6/>

Regards,
-- 
  Frank Lichtenheld

