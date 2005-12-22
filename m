Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: multipart/alternative; boundary=Apple-Mail-10-220454881
Message-Id: <0de7bd8e1dba22e5af9a2f7f78371f98@...521...>
From: Jeff Stearns <jps@...521...>
Subject: [Openvpn-devel] OpenVPN failure traced to bug in tun driver (with fix)
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
Date: Thu Dec 22 15:27:03 2005
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail-10-220454881
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit

If you use OpenVPN on Linux 2.2 or 4 2.4 or Solaris, you may be 
suffering from a bug which causes connections to hang under heavy load. 
  The symptoms are very similar to the MTU problems discussed frequently 
in these mailing lists.  But it turns out that this bug is not caused 
by MTU problems.  It's a bug in the tun/tap driver.

There are multiple tun/tap drivers. The bug discussed here exists in 
the tun-1.1 driver at http://vtun.sourceforge.net/tun/.  This is the 
tun/tap driver which is recommended by the INSTALL document for OpenVPN 
(http://openvpn.net/install.html).

The bug in the tun-1.1 driver definitely affects Linux 2.2 and 2.4.  It 
may also affect other operating systems; I did not check because I have 
no way of testing them.  If you use this driver, you are likely 
affected by the bug and may want to install a patch.  With this patch 
installed, OpenVPN works reliably on Linux 2.2.  (I did not test the 
driver on any other platforms.)

The bug is that poll() returns the wrong result if there is queued data 
available to read.  In these cases, it fails to return the 
POLLOUT|POLLWRNORM bits.  This causes openvpn to hang instead of 
sending data.  It is most likely to happen when there is much data to 
send.

Here is a patch for the Linux 2.2 kernel:
--- tun-1.1/linux/2.2/tun.c     2000-10-23 22:13:08.000000000 -0700
+++ tun.new/linux/2.2/tun.c     2005-12-22 00:27:56.000000000 -0800
@@ -180,8 +180,19 @@

     poll_wait(file, &tun->read_wait, wait);

+   /* Data written to the /dev/tunX device is immediately placed into 
a socket buffer, making it
+    * available to networking code at the tunX interface.  Writes 
never block.
+    * Likewise, data flows from the network stack, through the tunX 
interface and into the /dev/tun* device,
+    * where it is queued, making it available for read().
+    * Thus the character device /dev/tunX is:
+    *   - readable if data was "transmitted" to the tunX interface and 
is now queued at the /dev/tunX device.
+    *   - always writable.
+    * Everything written here is equally true of taps.
+    * The author made a mistake when implementing this routine; he 
forgot that the device is always writable.
+    * -jeff stearns 22-Dec-2005
+    */
     if( skb_queue_len(&tun->txq) )
-      return POLLIN | POLLRDNORM;
+      return POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM;

     return POLLOUT | POLLWRNORM;
  }

The patch for the Linux 2.4 driver is analogous.  The bug may also be 
in the version for other operating systems; I didn't check.

I tried mailing this patch to the tun-1.1 driver developer, but the 
author's mailbox no longer exists. Thus I expect that the bug will 
never be fixed; you'll need to install the patch for yourself.
--Apple-Mail-10-220454881
Content-Type: text/enriched;
	charset=US-ASCII
Content-Transfer-Encoding: 7bit

<fontfamily><param>Helvetica</param>If you use OpenVPN on Linux 2.2 or
4 2.4 or Solaris, you may be suffering from a bug which causes
connections to hang under heavy load.  The symptoms are very similar
to the MTU problems discussed frequently in these mailing lists.  But
it turns out that this bug is not caused by MTU problems.  It's a bug
in the tun/tap driver.


There are multiple tun/tap drivers. The bug discussed here exists in
the </fontfamily>tun-1.1 driver at http://vtun.sourceforge.net/tun/. 
This is the tun/tap driver which is recommended by
the<fontfamily><param>Helvetica</param> INSTALL document for OpenVPN
(http://openvpn.net/install.html). 


</fontfamily>The bug in the tun-1.1 driver definitely affects Linux
2.2 and 2.4.  It may also affect other operating systems; I did not
check because I have no way of testing them.  If you use this driver,
you are likely affected by the bug and may want to install a patch. 
With this patch installed, OpenVPN works reliably on Linux 2.2.  (I
did not test the driver on any other platforms.)


The bug is that poll() returns the wrong result if there is queued
data available to read.  In these cases, it fails to return the
POLLOUT|POLLWRNORM bits.  This causes openvpn to hang instead of
sending data.  It is most likely to happen when there is much data to
send.


Here is a patch for the Linux 2.2 kernel:

--- tun-1.1/linux/2.2/tun.c     2000-10-23 22:13:08.000000000 -0700

+++ tun.new/linux/2.2/tun.c     2005-12-22 00:27:56.000000000 -0800

@@ -180,8 +180,19 @@


    poll_wait(file, &tun->read_wait, wait);


+   /* Data written to the /dev/tunX device is immediately placed into
a socket buffer, making it

+    * available to networking code at the tunX interface.  Writes
never block.

+    * Likewise, data flows from the network stack, through the tunX
interface and into the /dev/tun* device,

+    * where it is queued, making it available for read().

+    * Thus the character device /dev/tunX is:

+    *   - readable if data was "transmitted" to the tunX interface
and is now queued at the /dev/tunX device.

+    *   - always writable.

+    * Everything written here is equally true of taps.

+    * The author made a mistake when implementing this routine; he
forgot that the device is always writable.

+    * -jeff stearns 22-Dec-2005

+    */

    if( skb_queue_len(&tun->txq) )

-      return POLLIN | POLLRDNORM;

+      return POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM;


    return POLLOUT | POLLWRNORM;

 }


The patch for the Linux 2.4 driver is analogous.  The bug may also be
in the version for other operating systems; I didn't check.


I tried mailing this patch to the tun-1.1 driver developer, but the
author's mailbox no longer exists. Thus I expect that the bug will
never be fixed; you'll need to install the patch for yourself.
--Apple-Mail-10-220454881--


