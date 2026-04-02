Date: Thu, 2 Apr 2026 22:28:19 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ac7RYw64E9gCQMan@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.7.1 released
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

The OpenVPN community project team is proud to release OpenVPN 2.7.1.
This is a bug fix release.

New features:

* Add a new username-only flag argument to --auth-user-pass which will now make 
  OpenVPN only query for username and send a dummy password to the server. This is 
  only useful if auth schemes are used on the server side that will do some sort of 
  external challenge base on username, and not password authentication. See 
  discussion in GH OpenVPN/openvpn#501 (starting Jan 30, 2024).
* Increase default sizing of internal hash maps to 4 * --max-clients. The default 
  used to be 256 with a --max-clients default of 1024 - this is bad for 
  performance, while the memory savings are minimal. On a very memory constrained 
  system, reduce --max-clients.

User-visible Changes:

* When compiled with the AWS-LC SSL library, using --tls-cert-profile will now 
  print a run-time warning - the library does not support it, so it would silently do 
  nothing.
* Systemd unit files: change LimitNPROC to TasksMax and increase limit (GH: 
  OpenVPN/openvpn#929)
* Documentation improvements.
* port-share: log incoming connections at verb 3, not on error level anymore (GH: 
  OpenVPN/openvpn#976).

Bugfixes:

* Fix usage of --lport inside a <connection> block - this got broken with the 
  multi-socket patchset (GH: OpenVPN/openvpn#995)
* Do not try to run auto-pam unit test when cross-compiling.
* Do not break private-key passphrases of length >= 64 (GH: OpenVPN/openvpn#993)
* Fix obscure ASSERT() crash on TCP connects with TAP and no ip config.
* Make DCO work on FreeBSD systems that have no IPv4 support in kernel (FreeBSD 
  PR 286263)
* Make DCO work on Linux on big endian (namely, MIPS and PowerPC)
  (GH: OpenVPN/ovpn-dco#96)
* Fixup responses to management interface version command (for >= 4)
* Make --enable-async-push work on FreeBSD 15 (which has native
  inotify support, and consequently no libinotify.pc anymore)
* Adjust some code parts to new "const" handling on string function
  returns (ISO C23, as implemented by glibc 2.43 and newer).

Windows MSI changes since 2.7.1:

* Make sure that included openvpnserv2.exe is signed
  (GH: OpenVPN/openvpn-build#1293)
* Included openvpn-gui updated to 11.62.0.0
  * Translation updates

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/v2.7.1/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in the various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
-- 
  Frank Lichtenheld

