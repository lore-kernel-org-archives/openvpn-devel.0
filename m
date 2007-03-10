From: Tony <kb2wjw@...277...>
Date: Sun, 11 Mar 2007 00:41:33 +0300
Message-ID: <op.tozsszi7ioehzu@...596...>
Mime-Version: 1.0
Sender: news <news@...165...>
Subject: [Openvpn-devel] The "residual" traffic after a disconnect?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

OpenVPN v2.1-rc2 (both client and server).
winXP-SP2 (both client and server).

On a client I see a sort of a "residual" traffic after a VPN disconnect -  
the tray icon of my GPRS modem (it's "remote" part) keeps blinking time  
after time and the traffic meter shows ~0.6~1.0kbps (kilobits per second)  
peaks. (It is the OpenVPN disconnected, not the GPRS connection torn down,  
I'm still on-line but idle.)

Strangely, I do not see that "residual" traffic on a POTS dial-up  
connection. Neither the LAN nor WiFi connection have it too.

It was always so, not just on this (v2.1-rc2) version.

What could it be and how do I solve it (if at all possible)?

-- 
Tony.


