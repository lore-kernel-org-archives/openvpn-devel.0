From: moshe <makeit_quick@...109...>
Message-ID: <loom.20041123T220422-499@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] HTTP CONNECT Vs. HTTP POST & GET
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
Date: Wed Nov 24 12:39:18 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

My corporate Firewall does not allow an OpenVPN client initiating a connection 
using HTTP 1.0 CONNECT.
I succeeded to penetrate the Firewall using a public test application called 
GNU HTTPTUNNEL (which uses HTTP 1.1 POST & GET).
Can someone tell me if OpenVPN is planned to support HTTP 1.1 POST & GET in 
order to improve it's connectivity ? if yes when ?
If I drill into the code and implement this, what are the chances that it will 
get into main release ?

thanks
Moshe


