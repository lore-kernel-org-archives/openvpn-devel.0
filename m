From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0504301622050.25603@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0.1-rc1 released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Apr 30 15:30:08 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

Here is a release candidate for 2.0.1, with a few minor patches.  Please 
test, especially if you are using plugins or configurations which use 
multiple --remote options.

Download:

http://openvpn.net/beta/

The current plan is to maintain 2.0.x as the stable branch, with bug fixes 
and minor patches only.  Larger patches will go into the 2.1 beta series 
which should begin shortly.

ChangeLog:

2005.04.30 -- Version 2.0.1-rc1

* Fixed bug where certain kinds of fatal errors after
  initialization (such as port in use) would leave plugin
  processes (such as openvpn-auth-pam) still running.
* Added optional openvpn_plugin_abort_v1 plugin function for
  closing initialized plugin objects in the event of a fatal
  error by main OpenVPN process.
* When the --remote list is > 1, and --resolv-retry is not
  specified (meaning that it defaults to "infinite"), apply the
  infinite timeout to the --remote list as a whole, but try each
  list item only once before moving on to the next item.
* Added new --syslog directive which redirects output
  to syslog without requiring the use of the --daemon or --inetd
  directives.
* Added openvpn.spec option to allow RPM to be built with support
  for passwords read from a file:
  rpmbuild -tb [openvpn.x.tar.gz] --define 'with_password_save 1'

James

