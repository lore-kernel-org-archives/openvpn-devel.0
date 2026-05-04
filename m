Date: Mon, 4 May 2026 13:32:55 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <afiD5-qkdCP6z_V8@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.7.4 released
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

The OpenVPN community project team is proud to release OpenVPN 2.7.4.
This is a small bugfix release.

Bugfixes:

* using --dns server ... style configs on Windows with win-dco would lead to 
  erroneously enabling "DnsSecValidationRequired : True", possibly breaking VPN DNS 
  resolution. Pushing --dns server ... dnssec no can be used as a workaround until 
  clients can be updated. (Github: openvpn#1024)
* correct comments in the --dns-up-down platform scripts relating to 
  dns_server_..._dnssec values.
* fix release-only build of pkcs11-helper vcpkg port, do not try to install files 
  from debug build.
* mbedTLS builds will now provide a proper error message if a tls-group statement 
  with no valid groups is encountered (used to run into SSL handshake failure later 
  on).
* --enable-strict and --enable-strict-options configure flags have been removed 
  (because they did not actually do anything anymore)


More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/v2.7.4/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in the various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
-- 
  Frank Lichtenheld

