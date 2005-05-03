Message-ID: <20050504061313.20097.qmail@...392...>
From: Dan Hulme <dan_256@...109...>
Reply-To: dan_256@...109...
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0 iroutes
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
Date: Tue May  3 23:14:04 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

--I apologize if this message is repeated; Gmail seems to be having trouble hitting this list.

I recently switched a VPN server which had multiple tunnels to a single tunnel using OpenVPN 2.0. 
First off I would like to say that the new design fixes nearly everything I wished was in 1.5/1.6,
so I am very impressed.  I have been able to replace all tunnels with a single tunnel, and single
client-configurations are very easy and work correctly.  So, thanks for all your hard work, James.

Previously, on my multiple tunnel interface, I had some tunnels which connected two LANs.  I have
reimplemented these using 2.0, client-config-dir, and iroute.  This works, but has a major caveat.
 It seems if the server VPN reboots, the iroutes from the CCDs get lost.  Apparently, the server
VPN loads these iroutes when the client connects.  So, if the client is already connected (i.e.,
it did not reboot when the server did), the server never receives a signal to load the CCD the
second time, and internal LAN machines on the client side are not connected to the internal LAN on
the server side.

This is very frustrating as it requires a client reboot if the server ever reboots.  With multiple
LAN endpoints, a single reboot requires multiple remote reboots.

Am I doing something wrong, or is this the current behavior of OpenVPN?  Perhaps on restart
OpenVPN should reload CCD conf files if the client is still connected (does it know?).

Thanks,

Dan 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

