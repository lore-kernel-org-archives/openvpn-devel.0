Date: Thu, 16 Jan 2025 18:20:01 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Z4k/wXXplJhXsJoZ@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.13 released
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
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN 2.6.13.

This is a bugfix release.

Feature changes:

* on non-windows clients (MacOS, Linux, Unix) send "release" string from uname()
  call as IV_PLAT_VER to server - while highly OS specific this is still helpful
  to keep track of OS versions used on the client side (github ​#637)
* Windows: protect cached username, password and token in client memory (using
  the CryptProtectMemory() windows API)
* Windows: use new API to get dco-win driver version from driver (newly introduced
  non-exclusive control device) (github ​ovpn-dco-win#76)
* Linux: pass --timeout=0 argument to systemd-ask-password, to avoid default timeout
  of 90 seconds ("console prompting also has no timeout") (github ​#649) 

Security fixes:

* improve server-side handling of clients sending usernames or passwords longer than
  USER_PASS_LEN - this would not result in a crash, buffer overflow or other security
  issues, but the server would then misparse incoming IV variables and produce
  misleading error messages. 

Notable bug fixes:

* FreeBSD DCO: fix memory leaks in nvlist handling (github ​#636)
* purge proxy authentication credentials from memory after use
  (if --auth-nocache is in use) 

Windows MSI changes since 2.6.12:

* Built against OpenSSL 3.4.0
* Included openvpn-gui updated to 11.51.0.0
  * Higher resolution eye icons (github ​openvpn-gui#697)
  * Support for concatenating OTP with password
  * Optionally always prompt for OTP
  * Fix tooltip positioning when the taskbar is at top (github ​openvpn-gui#710) 

Debian/Ubuntu community packages are now available for Ubuntu 24.10 (oracular). 

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

