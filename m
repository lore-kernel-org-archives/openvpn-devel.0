Message-ID: <3CBBD7A8.2000707@...8...>
From: Jean-Eric Cuendet <jean-eric.cuendet@...8...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Multi-user openvpn
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Tue Apr 16 00:52:04 2002
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, =?ISO-8859-15?Q?S=E9bastien_E?= =?ISO-8859-15?Q?gger?= <Sebastien.Egger@...8...>

Hi,
We found openvpn last week and tried it for our needs.
We have a mix of Windows+Linux clients, some of which wants to connect 
to the main site through VPN.
The windows users use CheckPoint securemote and we want that Linux users 
use openvpn.
We made some tests and want to congratulate you fr your great job. It's 
working well and is simple!

Now, our questions.
We want to be able to let multiple users that have an SSH connection on 
one VPN server, opens a VPN with openvpn. It must have dynamic 
addresses, should be opened as users, not root, should not run if there 
is no more traffic.
We want to make a server script that:
- create a tun device as a user
- assign the client an address
- create a symmetric key for openvpn

We are able to:
- opening a tun device as a simple user
- run openvpn as a user
- Providing dynamic address is not simple, but possible with the script.

What lacks is the ability to let openvpn stop automatically when there 
is no traffic after a lap of time
Another problem is that for 1 client to open a VPN, 2 addresses are 
needed, one for client and one for the server tun device.
Does TAP device resolve this? Is it possible to use only 1 address for 1 
client with TAP device? And is it possible to use TAP device with openvpn?

Thanks.
-jec

PS: Would you be interested in our script in the openvpn distribution?

-- 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
E-mail: jean-eric.cuendet@...8...
http://www.linkvest.com
--------------------------------------------------------




