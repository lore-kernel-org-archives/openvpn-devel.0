From: "James Yonan" <jim@...41...>
Message-ID: <twig.1064398659.1177@...41...>
Subject: [Openvpn-devel] OpenVPN pre-beta8 is ready for testing.
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
Date: Wed Sep 24 03:19:02 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

I have a new beta release available with some very cool new features:

* The TAP-Win32 driver on Windows can now emulate a "tun" point-to-point IP
interface.  This completes the "compatibility matrix" meaning that OpenVPN on
Windows can now talk to OpenVPN on any other platform, including those which
do not have a "tap" driver available.

* The --ifconfig option now works for both "tun" and "tap" interfaces.

* --ifconfig also works now on Windows in the same way that it works on other
OSes (On Windows it is a proxy for the "netsh" command).

* Added a --route option that provides a platform-independent proxy to the
universal (but syntactically incompatible) route commands of the major OSes. 
Still need route cases for NetBSD and Mac OS X.

* Added a --route-up script callback which can optionally be executed n
seconds after connection establishment.

* A large number of useful parameters are now made available to scripts
through environmental variables.

* Added the --mssfix option to control TCP segment size.  --mssfix when used
in tandem with --fragment may turn out to be the solution we have been looking
for on the MTU front, where routers and firewalls that block Path MTU
Discovery have been wreaking havoc with IP encapsulation.  --mssfix lowers the
TCP packet size by mangling TCP SYN packets (just like iptables can do), and
--fragment does internal fragmentation on non-TCP packets.  They both work
together quite well.

* Significantly reworked the TAP-Win32 driver to bring it up to SMP standards.

* All new features are documented in the man page or the Win32 install notes.

There are few caveats as well to be aware of:

* I have experienced stalls in the Linux tap driver that seem to be
exacerbated when the TCP MSS is lowered using --mssfix.  All analysis so far
has pointed to the problem being in the Linux kernel.  The problem only occurs
on tap devices, not tun devices.

* There are a couple points to be aware of when using the new --dev tun
capability on Linux:  all ifconfig endpoint pairs must be the two usable
addresses in a /30 subnet.  The Windows install notes have more details about
this.  Also, --dev tun on Windows uses a --tun-mtu setting of 1500, so the
other side of the connection (if it is not also on Windows) must explicitly
have --tun-mtu 1500 in its config.

* The default value of --tun-mtu-extra was lowered from 64 to 32.  This
parameter describes the extra space over and above the MTU value, used for
things like the ethernet header.  If you are talking between different
versions of OpenVPN, and using TLS mode, you will need to explicitly state
--tun-mtu-extra 32 on both sides of the connection.

This is a limited release, primarily aimed at beta testers, so please report
experiences, both positive and negative.  If it tests well, it should be
promoted to 1.5-beta8 shortly.

Download:

http://openvpn.sourceforge.net/beta/

James



