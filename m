From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0411032329070.26459@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Changing server config without disconnecting users
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
Date: Wed Nov  3 15:11:53 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

As OpenVPN gets deployed at larger and larger corporations as a 
roadwarrior VPN server, I think it becomes more and more important that 
it's possible to change as much of the server configuration as possible 
without having to restart the server and causing all users to be 
disconnected.

One thing that I've had to do a few times is adding routes that it beeing 
pushed to the clients. If I put the configuration in a ccd file, I can add 
routes without restarting the server. But if I want to add a route that 
should be pushed to all clients, I need to put it in the main config, and 
then I can't have it updated without restarting the server, right?

How do the future look like for OpenVPN?

Is using a client-connect script to generate default options the way 
this should be handled in the future, or should we solve it some other 
way?

Perhaps we could have a file in the ccd dir named default that could hold 
all the client options that we today put in the main config that will be 
re-read when a new client connects?

I also see the need for being able to "kill" a client instance without 
having to restart the server.

Say that you have a star site-to-site VPN build with openvpn in server 
mode at the headquarter and an openvpn router at each branch office.

If one of the branch officies get's compromised, you would like to add the 
branch office certificate to the CRL, and kick that instance from the 
openvpn server. You can't wait until the compromised office disconnects on 
his own, and you don't want to break connectivity with the other branch 
offices.

/Mathias

