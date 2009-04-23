Message-ID: <49F06579.9040202@...1211...>
Date: Thu, 23 Apr 2009 08:56:25 -0400
From: Valery Vachaev <valery@...1211...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Vista-64 cannot load Tap-Win32 driver
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
To: openvpn-devel@lists.sourceforge.net

Hello

I rebuilt Tap-Win32 driver from source and signed it with a VeriSign 
class 3 certificate. On Windows-32 bit  it works as expected, on 
Vista-64 I was able to install  driver but Device Manager shows the next 
message: "Windows cannot load the device driver for this hardware. The 
driver my be corrupted or missing.(Code 39) ". Need to say, I used WDK 
6001.18002 instead of  6001.17121 for the last openvpn releases.

Any pointers-help would be very much appreciated!

Thanks in advance,
Valery




