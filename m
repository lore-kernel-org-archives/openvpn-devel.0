From: "James Yonan" <jim@...41...>
Message-ID: <twig.1074156443.1050@...41...>
Subject: [Openvpn-devel] OpenVPN 1.6-beta1 released
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
Date: Thu Jan 15 00:48:00 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Well it's that time again... the first 1.6 beta is now available and ready for
testing.  This is primarily a bugfix release, with the most significant change
being the implementation of "--ip-win32 dynamic" for the Windows version. 
Instead of releasing this version as a quickie 1.5.1, I decided to jump to 1.6
and do another beta testing cycle because "--ip-win32 dynamic" involves a
moderate addition to the TAP-Win32 driver, and device driver changes need to
always be treated with caution.  I've done my own stress testing on the driver
using XP, and I'm confident at this point to release it as beta.

Some of you may recall during the 1.5 beta testing cycle, that getting the
--ifconfig option to work on Windows was problematic because there did not
seem to be a consistent API for programmatically setting the TCP/IP properties
of a network adapter.  The choice was made in 1.5 to use the "IP Helper API"
by default, but that produced the strange side effect that the adapter ends up
with two addresses, one is what you want, the other is the bogus
"autoconfiguration" address which besides being a terrible hack, tends to
break samba.

But there's another way, and it happens to be one of the most universal and
often-used mechanism for setting TCP/IP properties:  DHCP.  When OpenVPN opens
a TAP-Win32 interface, Windows (by default) starts sending DHCP queries,
looking for a DHCP server.  All one has to do is reply to these queries and
windows will dutifully set any TCP/IP property which you care to specify. 
This is the basis of the new "--ip-win32 dynamic" option.  It's been made the
default in 1.6-beta1 and I would encourage all to test it to determine whether
or not it will be the definitive --ip-win32 method.  

There are a number of other bugfixes in this release, the most notable being
improvements to the HTTP proxy client mode, which in 1.5.0 does not work on
certain HTTP proxies.

James




