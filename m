From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0412121141350.22477@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Password prompts with --log
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
Date: Sun Dec 12 03:03:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I had a user report that OpenVPN was working fine from a cmd-line (in 
Windows), but when using my GUI the Status windows was just empty, and it 
was impossible to terminate the openvpn connection.

The cause was that this user was using the --log option in his config 
file. When using this option, even the passphrase prompts are redirected 
to the log file, however, if you know that OpenVPN is waiting for a 
passphrase, you can still give in on stdin.

Would it possible to always print the passphrase prompts to the original 
stdout instead of the logfile? I can't see any reason why you would want 
the passphase prompt saved in the log file, or is there? OpenVPN GUI would 
still not see the log output, but at least the passphrase prompt would be 
showed, so the user would not get the feeling that openvpn has "hanged".

As OpenVPN GUI does not see the passphrase prompt now, it is also not 
possible for the GUI to terminate the connection as OpenVPN is not 
checking the exit event while waiting for user input from stdin.

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail


