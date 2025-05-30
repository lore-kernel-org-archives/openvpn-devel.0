Date: Fri, 30 May 2025 11:32:10 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aDl7GvNseOsYrQjS@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.7_alpha1 released
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

The OpenVPN community project team is proud to release OpenVPN 2.7_alpha1.
This is the first Alpha release for the feature release 2.7.0.
As the "Alpha" name implies this is an early release build, this is not intended
for production use.

Highlights of this release include:
* Multi-socket support for servers -- Handle multiple addresses/ports/protocols
  within one server
* Improved Client support for DNS options
  * Client implementations for Linux/BSD, included with the default install
  * New client implementation for Windows, adding support for features like split
    DNS and DNSSEC
* Architectural improvements on Windows
  * The block-local flag is now enforced with WFP filters
  * Windows network adapters are now generated on demand
  * Windows automatic service now runs as an unprivileged user
  * Support for server mode in win-dco driver
  * Note: Support for the wintun driver has been removed.
    win-dco is now the default, tap-windows6 is the fallback solution for
    use-cases not covered by win-dco.
* Improved data channel
  * Enforcement of AES-GCM usage limit
  * Epoch data keys and packet format
* Support for new upstream DCO Linux kernel module
  * This release supports the new ovpn DCO Linux kernel module which will be
    available in future upstream Linux kernel releases. Backports of the new
    module to current kernels are available via the ovpn-backports project.

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/master/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in the various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Regards,
-- 
  Frank Lichtenheld

