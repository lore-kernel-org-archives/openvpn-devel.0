From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.60.0410012147580.18074@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Pass log and passphrase between OpenVPN and OpenVPN GUI
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
Date: Fri Oct  1 13:18:35 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Didier announced a first release of an improved version of the OpenVPN 
Service Wrapper earlier this week. The goal with this is to allow a non 
admin user on Windows to start/stop openvpn processes.

It does this by listening on a local TCP socket for commands like "START 
config.ovpn" or "STOP config.ovpn".

I've started working on OpenVPN GUI 2.0 that will use this service 
wrapper to control openvpn.

There is two things that remain unsolved though that I'd like to bring up 
for some discussion.

1. How do we pass the private key passphrase from the GUI to the openvpn 
process?

2. How do we get the openvpn log to the GUI so we can show it in real time 
in the status window?


I can see a couple of solutions:

A) We create a pipe between the openvpn process and the service wrapper. 
The service can then watch the openvpn output for the passphrase prompt, 
and pass on the request to the GUI over the TCP socket.

The log is then written to the log file by the service. The GUI will have 
to monitor this file for changes to be able to show the log in real-time.


B) We create another TCP socket for every launched process, and creates a 
pipe between this socket and the openvpn process. The GUI can then connect 
to this socket to recieve the log in real-time, and can monitor this for 
the passphrase prompt itself.


Comments or suggestions on other solutions are welcome.

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail

