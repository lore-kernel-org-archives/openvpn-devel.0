From: "James Yonan" <jim@...41...>
Message-ID: <twig.1068364772.78810@...41...>
Subject: [Openvpn-devel] OpenVPN 1.5 Release Candidate 1
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Nov  9 00:00:13 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

We're getting close to a 1.5 final release...

I would like to nominate OpenVPN 1.5-beta14 to be release candidate 1 for
OpenVPN 1.5. Beta14 has been out for a week or so without any bugs reported
thus far.  If you think you've found a bug, please report it ASAP.

There have been a number of reports about certain things working on early
versions of the beta cycle running on Windows, i.e. before beta 8 or 9, then
not working on later versions.  Most of these problems have been attributed to
the new --ip-win32 option which changed default behavior.  The default is now
--ip-win32 ipapi, but two other methods exist, "netsh" and "manual" -- please
consult the man page and try these other options if you are running the
Windows version of the beta and experienced problems after upgrading to recent
versions of OpenVPN, i.e. beta12 or greater.

If you follow the CVS, I've merged beta14 back into the HEAD branch as
1.5-rc1, and started a new branch BETA20 for ongoing development of major new
features such as forking server support and point-to-multipoint mode which
will ultimately be released as OpenVPN 2.0.

Bug fixes and minor or moderate feature additions will go into the HEAD branch
for release on a shorter development & test cycle.

James



