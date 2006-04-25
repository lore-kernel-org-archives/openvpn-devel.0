From: Eric Limpens <eric@...624...>
Message-ID: <20060425100020.18086c30@...625...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Changing routes on the client
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
Date: Tue Apr 25 01:02:06 2006
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


Hello, 

 I've made a (win32) app which (tries to) alter the routes on the
 client using the 'up' statement.
 With the information in the environment and the command line parameters
 I've tried to 'hide' the local network from the client.

 The purpose is to prevent users to communicate with their own
 equipment when they are using a VPN connection. 

 So, when a client has an IP address 192.168.1.10, in the subnet
 192.168.1.0/24, I want to route all traffic to the 192.168.1.0/24
 network thru the VPN server. This might not seem logic, but we want
 to prevent people to communicate with other equipment when connected
 to the VPN.

 The app tries to detect the current (physical) interface being used to
 get connected, and retrieves the network by using the GetAdaptersInfo
 function. 

 When I insert a new route, using the interface index of the Tap
 interface, the CreateIpForwardEntry function failes (probably because
 the interface doesn't exist already?).

 Is it possible, to add an option to the behaviour of the 'push
 redirect-gateway' which takes care of the above? The current 'def1'
 and 'local' options don't quite get the job done.


Eric

 

