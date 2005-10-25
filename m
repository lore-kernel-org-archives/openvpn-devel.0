From: Samuel Tardieu <sam@...482...>
Message-ID: <87k6g15f43.fsf@...483...>
Mime-Version: 1.0
Subject: [Openvpn-devel] UDP P2P mode and multiple remote peers in 2.0.2
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
Date: Tue Oct 25 17:15:45 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi.

It looks like OpenVPN 2.0.2 only considers the first peer in UDP P2P
mode. I am in a situation where, from my laptop, the remote end is at
one of three different remote addresses depending on where I connect
from. The second and third addresses are never tried.

I worked around the problem by using a "keepalive" and "remote-random"
on the laptop so that every address gets a chance to be tried
eventually, but this takes a lot of time, especially when OpenVPN
could automatically try the next address when it receives a connection
refused from the currently tried remote address:

  Oct 26 01:40:52 [openvpn] read UDPv4 []: Connection refused (code=111)

 Sam
-- 
Samuel Tardieu -- sam@...482... -- http://www.rfc1149.net/sam


