From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0411060041150.1651@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN GUI connection configuration
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
Date: Fri Nov  5 16:00:03 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I'd like to start adding connection specific options to OpenVPN GUI, that 
need to specified somewhere.

The first option I plan to add is:

* Connection name (instead of the filename)

* script to run before starting openvpn, to allow for example a telnet 
auth session to a PIX firewall before openvpn is started.

I just wonder where the best place to put these options is.

I've thought of two ways.

1) Use a comment prefix in the already existing openvpn config file like:
### connection-name Office

where ### is used to denote that this is not really a comment but a 
openvpn-gui option.

2) Use a new config file with the same name as the openvpn config file, 
but a diffrent extension like .ogui that can hold openvpn gui settings for 
each connection.


I'd like to get some feedback on what method the communtity would like me 
to use. Additional ways that I havn't thought of is of cource welcome...

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail


