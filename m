From: "Harsha V. Madhyastha" <harsha@...338...>
Message-ID: <Pine.LNX.4.58L.0501152259110.5779@...339...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Problem opening TAP device on Win XP from Java
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
Date: Sat Jan 15 23:37:24 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi,

I am a graduate student in Computer Science at the University of 
Washington. I have been trying to use the TUN/TAP device as a means of 
capturing incoming and outgoing packets. To make my system portable across 
Windows and Linux, I have been using Java for development, because of which 
I have run into a problem.

I installed v1.6 of the TUN/TAP device on my Windows XP machine. I then 
found from the registry that the key for the device on my machine is
{5998ABF4-70CC-4B8C-9CBF-F2B985BAD4A2} (under the 
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318} 
subtree). 
