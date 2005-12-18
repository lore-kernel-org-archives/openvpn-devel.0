From: Ulf Dambacher <ulf.dambacher@...83...>
Reply-To: ulf.dambacher@...83...
MIME-Version: 1.0
Message-Id: <200512182046.43146.ulf.dambacher@...83...>
Subject: [Openvpn-devel] feature request: demand connection
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
Date: Sun Dec 18 11:45:11 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi

I need a feature "connection on demand" including a "callback" script for a 
tls-client.
why? I want to connect two servers via internet and establish a tunnel.  
Both servers use ADSL to connect to the internet on demand. 
Now if one server wants to connect to the other, he has to inititate a 
callback (in my case call the other via ISDN/capiutils wich in tune connects 
to the internet) 
After this, the openvpn connection will run as normal.

With the --demand feature set, the client should set up its devices and routes 
as to the config file like normal, but should not connect to the host named 
in --remote until the first packet has to be transmitted.
Using the --callback feature, openvpn should call a script or plugin before 
initiating the --remote connection. This script or plugin can then start a 
dialup link or do some other things to get a connection to the --remote host.

I looked at the sources to do this myself, but hacking is hard to start. 
Can you help me on where to look?

bye
Ulf

