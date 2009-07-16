Message-ID: <4A5EFE61.3020100@...41...>
Date: Thu, 16 Jul 2009 04:18:09 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc19 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVpn-Users <openvpn-users@lists.sourceforge.net>, Openvpn-devel@lists.sourceforge.net

This release fixes an issue with the Windows TAP driver that can cause 
BSODs on Vista (normally seen in the OpenVPN client).  The problem is 
that Windows has always restricted kernel threads to a very small stack 
size (12KB on x86 32-bit).  If they go over this limit, Windows will 
crash with a BSOD.  Apparently Vista has added a bit more bloat to its 
kernel stack usage, and as a result, when the TAP driver is called, and 
then it in turn calls other kernel-level functions, there is a chance 
that the kernel stack can overflow in a particular sequence of code that 
is executed when the client initially connects and gets an IP address 
assignment from the server.  Apparently because XP is more efficient in 
its use of stack space, the same build of the TAP driver running on XP 
does not exhibit this defect.

2009.07.16 -- Version 2.1_rc19

* In Windows TAP driver, refactor DHCP/ARP packet injection code to
   use a DPC (deferred procedure call) to defer packet injection until
   IRQL < DISPATCH_LEVEL, rather than calling NdisMEthIndicateReceive
   in the context of AdapterTransmit.  This is an attempt to reduce kernel
   stack usage, and prevent EXCEPTION_DOUBLE_FAULT BSODs that have been
   observed on Vista.  Updated TAP driver version number to 9.6.

* In configure.ac, use datadir instead of datarootdir for compatibility
   with <autoconf-2.60.

James

