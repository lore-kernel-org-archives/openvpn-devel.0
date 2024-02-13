Date: Tue, 13 Feb 2024 12:32:46 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZctTXpCR5vT06JXJ@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.9 released
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

The OpenVPN community project team is proud to release OpenVPN 2.6.9.

This is a bugfix release containing one security fix for the Windows installer.

Security fixes:

* Windows Installer: fix ​CVE-2023-7235 where installing to a non-default directory
  could lead to a local privilege escalation. Reported by Will Dormann. 

New features:

* Add support for building with mbedTLS 3.x.x
* New option --force-tls-key-material-export to only accept clients that can do
  TLS keying material export to generate session keys
  (mostly an internal option to better deal with TLS 1.0 PRF failures).
* Windows: bump vcpkg-ports/pkcs11-helper to 1.30
* Log incoming SSL alerts in easier to understand form and move logging from --verb 8
  to --verb 3.
* protocol_dump(): add support for printing --tls-crypt packets 

User visible changes:

* License change is now complete, and all code has been re-licensed under the new license
  (still GPLv2, but with new linking exception for Apache2 licensed code).
  See ​COPYING for details. 
  Code that could not be re-licensed has been removed or rewritten.
* The original code for the --tls-export-cert feature has been removed (due to the
  re-licensing effort) and rewritten without looking at the original code.
  Feature-compatibility has been tested by other developers, looking at both old and
  new code and documentation, so there *should* not be a user-visible change here.
* IPv6 route addition/deletion are now logged on the same level (3) as for IPv4.
  Previously IPv6 was always logged at --verb 1.
* Better handling of TLS 1.0 PRF failures in the underlying SSL library (e.g. on some
  FIPS builds) - this is now reported on startup, and clients before 2.6.0 that can not
  use TLS EKM to generate key material are rejected by the server. Also, error messages
  are improved to see what exactly failed. 

Notable bug fixes:

* FreeBSD: for servers with multiple clients, reporting of peer traffic statistics would
  fail due to insufficient buffer space (Github: ​#487) 

Windows MSI changes since 2.6.8:

* Security fix, see above
* Built against OpenSSL 3.2.0
* Included openvpn-gui updated to 11.47.0.0
  * Windows GUI: always update tray icon on state change (Github: ​#openvpn-gui/669)
    (for persistent connection profiles, "connecting" state would not show) 

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

