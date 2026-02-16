Date: Mon, 16 Feb 2026 14:17:56 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aZMZBIef0acdoTfQ@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.6.18/2.6.19 released
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

This mail covers the releases of 2.6.18 and 2.6.19 that both
happened on February 4th 2026, but for which no announcement mails
were sent.

2.6.19 only fixed one small issue in the creation of the 2.6.18 release
tarball. All the following mentioned changes are from 2.6.18.

User visible changes:
* disable DCO if "--bind-dev" option is given (no support for this in
  the old out-of-kernel Linux DCO implementation)
* on Windows, if using "--ip-win32 netsh" and not using the interactive
  service, IPv4 addresses would be installed as "permanent", possibly
  causing problems later on with using that IPv4 address on a different
  interface.  Change to "store=active".  (GH: #915)
* improve pull-filter documentation, emphasizing possible problems if
  used as a naive security measure (reported by SRLabs)

Bugfixes:
* p2mp server: fix incorrect file descriptor handling on "inotify" FD
  during a SIGUSR1 restart (GH: #966)
* management interface: fix bug where "--management-forget-disconnect"
  and "--management-signal" could be executed even if password authentication
  to managment interface was still pending (ZeroPath finding)
* repair client-side interaction on reconnect between DCO event handling
  and "--persist-tun" - after a ping timeout and reconnect, the DCO
  event handler would not be armed, and the next ping timeout would not
  be received by userland, causing non-working connections with nothing
  in the openvpn log (Linux and FreeBSD only, GH: #947)
* prevent crash on invalid server-ipv6 argument, calling "freeaddrinfo()"
  with a NULL pointer.  This only affects OpenBSD.  (Klemens Nanni).

Windows MSI changes since 2.6.17-I001:
* Built against OpenSSL 3.6.1
* Included openvpn-gui updated to 11.61.0.0
  * translation updates

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/release/2.6/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrepositories>

On Red Hat derivatives we recommend using the Fedora Copr repository.

<https://copr.fedorainfracloud.org/coprs/g/OpenVPN/openvpn-release-2.6/>

Kind regards,
-- 
  Frank Lichtenheld

