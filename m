From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.60.0407230944060.20730@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN get stuck in getpass()
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
Date: Fri Jul 23 01:35:08 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

OpenVPN (2.0-beta7) does not exit when the exit_event is signaled if a 
passphrase protected key is used, and openvpn in waiting for the password 
from the console.

This is a problem now that I pass the passphrase from my gui as a cmd-line 
option. I want to support non passphrase protected keys to, therefor if 
the user justs hits enter at my passphrase dialog, I do not use the 
--passphrase option.

The problem arises if the key IS protected, but the user just hits enter 
at the passphrase prompt (by mistake perhaps), as then openvpn is launched 
as normal without knowing about the passphrase, and will therefor ask for 
the passphrase from the console.

And there it's stuck :-) Even if I signal the exit_event the openvpn 
process don't exit, so I have to kill the process manually to be able to 
restart the connection...

Any suggestions how to solve this?

Is it possible to have openvpn exit when the exit_event is signaled even 
if it is in getpass(), or do I have to come up with a way to tell openvpn 
not to ask for the passphrase from the console at all?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

