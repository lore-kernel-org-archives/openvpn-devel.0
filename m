From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.60.0408141718400.7916@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Sending signals to a process in Windows
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
Date: Sat Aug 14 08:26:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I'd like my Windows OpenVPN GUI to be able to send signals to the openvpn 
processes.

Is it possible to send signals (like SIGHUP, SIGUSR1) to processses in 
Windows? How?

If not, how do I pass a scancode (like a function key) to a Pipe? I've 
used WriteFile() to pass the passphrase string, but that can only contain 
ASCII chars, right?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

