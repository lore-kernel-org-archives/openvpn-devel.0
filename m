Date: Thu, 12 Feb 2026 17:57:29 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aY4GeZVEPhqC5FfB@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.7.0 released
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

The OpenVPN community project team is proud to release OpenVPN 2.7.0.
This is the new stable version of OpenVPN with some major new features.

This release has only minor changes relative to the last release candidate
release 2.7_rc6.

Highlights of 2.7 include:
* Multi-socket support for servers -- Handle multiple addresses/ports/protocols within one server
* Improved Client support for DNS options
  * Client implementations for Linux/BSD/macOS, included with the default install
  * New client implementation for Windows, adding support for features like split DNS and DNSSEC
* Architectural improvements on Windows
  * The "block-local" flag is now enforced with WFP filters
  * Windows network adapters are now generated on demand
  * Windows automatic service now runs as an unpriviledged user
  * Support for server mode in win-dco driver
  * Note: Support for the wintun driver has been removed. win-dco is now the default,
    tap-windows6 is the fallback solution for use-cases not covered by win-dco.
* Improved data channel
  * Enforcement of AES-GCM usage limit
  * Epoch data keys and packet format
* Support for new upstream DCO Linux kernel module
  * This release supports the new "ovpn" DCO Linux kernel module which is available
    in current upstream Linux kernel releases. Backports of the new module to older kernels
    are available via the ovpn-backports project (https://github.com/OpenVPN/ovpn-backports).
* Client-side support for new "PUSH_UPDATE" control-channel message
  * This allows servers to send updates to options like routing and DNS config without
    triggering a reconnect.
* PUSH_UPDATE server support (minimal)
  * New management interface commands "push-update-broad" and "push-update-cid" to send
    PUSH_UPDATE option updates.
* TLS 1.3 support with current mbedTLS versions
* Support for mbedTLS version 4
* Two new environment variables have been introduced to communicate desired default
  gateway redirection to plugins like Network Manager.
* Support for Epoch data channel on Windows, using the win-dco driver (2.8.0+)
* "Recursive Routing" check is now more granular, and will only drop packets-in-tunnel
  if destination IP, protocol and port matches with those needed to reach the VPN server.
* COPYING: license details only relevant to our Windows installers have been updated and
  moved to the openvpn-build repo

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/v2.7.0/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in the various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
-- 
  Frank Lichtenheld

