From: Andrew Alston <aalston@...340...>
Message-ID: <loom.20050120T173100-938@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Problems with redirect-gateway under windows XP
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
Date: Thu Jan 20 08:51:38 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi All,

I'm running redirect-gateway under a windows xp installation, where the 
installation is connecting as a client to a vpn server running on freebsd.

The machine connects to the internet via a PPPoE connection over an ADSL link.

When openvpn attempts to insert the route for the vpn server (the route it 
inserts to avoid route looping, as defined as step 1 in the man page) I get 
the following:

Thu Jan 20 17:32:44 2005 us=406432 route ADD 137.158.26.30 MASK 
255.255.255.255 165.146.135.233
Thu Jan 20 17:32:44 2005 us=409053 ROUTE: route addition failed using 
CreateIpForwardEntry: The parameter is incorrect.

The strange thing is that if I do a manual command like:

route add 137.158.26.30 MASK 255.255.255.255 165.146.135.233 

It works fine, just fails when openvpn tries to do it.

I also noted that if my default gateway is set on my ethernet interface 
instead of the PPPoE connection when I establish the vpn the route entry works 
fine, it seems like openvpn just has a problem inserting routes to a PPPoE 
interface under xp, though I may be wrong

Any thoughts / help would be appreciated on this one

Andrew Alston
Senior Technical Specialist - University of Cape Town



