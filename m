From: Tony <kb2wjw@...277...>
Date: Fri, 08 Sep 2006 19:49:25 +0400
Message-ID: <op.tfkgwnitioehzu@...603...>
Mime-Version: 1.0
Sender: news <news@...165...>
Subject: [Openvpn-devel] MULTICAST: cannot join a group across the OpenVPN
	connection. Why?
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

I have a BRIDGEd configuration on my main LAN. The server pushes the  
"redirect gateway" option to the client. (Both server and client are  
winXP-SP2 boxes with firewall OFF)

On the main LAN there is a box MULTICASTing to the 239.255.20.1:50001  
group.
Any box on the LAN is able to join that group and properly receive the  
streamed data. If my client is physically connected to the LAN - it too is  
able to receive that stream.
But if my client is connected via OpenVPN - no data gets in.
The same time all other IP and Ethernet connectivity works as expected -  
HTTP[S], POP3|SMTP and NetBEUI - all I use for my everyday work - operate  
as they should.

What may be the cause of this misfeature?

Tony.


