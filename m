Date: Fri, 21 Jun 2024 11:28:01 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZnVHobj26DU/SI45@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.11 released
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

The OpenVPN community project team is proud to release OpenVPN 2.6.11.

This is a bugfix release containing several security fixes.

Security fixes:

* CVE-2024-4877: Windows: harden interactive service pipe.
  Security scope: a malicious process with "some" elevated privileges
  (SeImpersonatePrivilege) could open the pipe a second time, tricking
  openvn GUI into providing user credentials (tokens), getting full
  access to the account openvpn-gui.exe runs as. (Zeze with TeamT5)
* ​CVE-2024-5594: control channel: refuse control channel messages with
  nonprintable characters in them.
  Security scope: a malicious openvpn peer can send garbage to openvpn
  log, or cause high CPU load. (Reynir Björnsson)
* CVE-2024-28882: only call schedule_exit() once (on a given peer).
  Security scope: an authenticated client can make the server "keep the
  session" even when the server has been told to disconnect this client
  (Reynir Björnsson) 

New features:

* Windows Crypto-API: Implement Windows CA template match for searching
  certificates in windows crypto store.
* Support pre-created DCO interface on FreeBSD (OpenVPN would fail to set
  ifmode p2p/subnet otherwise) 

Bug fixes:

* Fix connect timeout when using SOCKS proxies (trac #328, github ​#267)
* Work around LibreSSL crashing on OpenBSD 7.5 when enumerating ciphers
  (LibreSSL bug, already fixed upstream, but not backported to OpenBSD 7.5,
   see also ​https://github.com/libressl/openbsd/issues/150)
* Add bracket in fingerprint message and do not warn about missing
  verification (github ​#516) 

Documentation:

* Remove "experimental" denotation for --fast-io
* Correctly document ifconfig_* variables passed to scripts
* Documentation: make section levels consistent
* Samples: Update sample configurations (remove compression & old cipher
  settings, add more informative comments) 

Windows MSI changes since 2.6.10:

* For the Windows-specific security fix see above
* Built against OpenSSL 3.3.1
* Included openvpn-gui updated to 11.49.0.0
  * Contains part of the fix for ​CVE-2024-4877

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrepositories>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-release-2.6/>

Regards,
-- 
  Frank Lichtenheld

