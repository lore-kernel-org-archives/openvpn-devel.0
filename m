From: Emil <emil@...314...>
Message-ID: <loom.20041115T171745-883@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] TAP-Win32 and other NDIS IM drivers
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
Date: Mon Nov 15 08:32:00 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I'm using the TAP-Win32 driver from openvpn together with a modified passthru
example (the passthru NDIS IM driver in windows DDK examples).

However I'm experiencing the following problems (WinXP SP2):
The computer crashes when I restore from a hybernated system. I found this:

http://www.tech-archive.net/Archive/Development/
microsoft.public.development.device.drivers/2004-02/1154.html

and implemented the fix into my NDIS IM driver.
The result was no more blue screens but nor can I set the IP of the TAP-Win32
device using iphlpapi.dll nor the netsh.exe option.
The same problem persists even with empty functions in the NDIS driver.
It seams like the fact that ProtocolStatus and ProtocolStatusComplete functions
being called prevents me from setting the IP of the TAP-device.

Does anybode recognize this problem and maybe even have any suggestions on how
to fix it?

Regards
/E


