From: "James Yonan" <jim@...41...>
Message-ID: <twig.1063214225.90210@...41...>
Subject: [Openvpn-devel] New TAP-Win32 driver needs stress testing
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
Date: Wed Sep 10 17:35:31 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

I've made some significant changes in the TAP-Win32 driver, bringing it up to
SMP standards, and making some performance improvements in latency and overall
efficiency.

While it has admirably held up to my stress tests on a single processor XP
laptop, it needs testing on more machines, especially SMP machines, to flush
out any bugs that might be remaining.

The driver is here:

http://openvpn.sourceforge.net/beta/tapdrvr.sys

Install instructions
--------------------

* Install OpenVPN normally.

* In Control Panel / Network connections, right click on all TAP-Win32
adapters and select Disable.

* Copy the new driver (tapdrvr.sys) to [your windows system
directory]\system32\drivers, overwriting the old copy.

* In Control Panel / Network connections, right click on the TAP-Win32 adapter
and select Enable.

* To verify that the correct driver is running, go to the adapter properties
-> Configure -> Driver -> Driver Details, and the file version should be
1.5-beta7.2 (DEBUG) or higher.

When you test it, I would encourage you to really STRESS TEST
it, i.e. copy large files over the tunnel while simultaneously running other
CPU or disk-intensive apps.

I would also encourage you to run the Driver Verifier.  It's
called verifier.exe, included on Win2K and later.  It will closely examine the
behavior of the driver and trigger a bug check if anything looks amiss.

Another good stress test is to have a heavy session going, then right-click
and disable the TAP adapter in the network connections control panel, while
the OpenVPN process is still running.  The OpenVPN process will generate a
stream of error messages when this happens -- this is okay.

And if you have a laptop, make sure to put it through a few sleep/resume
cycles, during heavy tunnel action.  The OpenVPN process may hiccup, but
should get back on track once the system is awake.

If you have any questions about testing the driver, don't hesitate to ask.

James


