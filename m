From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.60.0407132213180.21236@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Passing private key passphrase to openvpn
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
Date: Tue Jul 13 13:31:03 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

I'd like to implement a way to hand over the private key passphrase to 
openvpn, to be able to add this feature to my GUI.

We have discussed that this could/should be done via the management 
interface that we've discussed alot. However, I'd like to add the 
passphrase feature now so I wonder which is the best way to do this.

1. Add a cmd-line option to pass it. (Considered insecure by some).

2. Use an environment variable. Portable? Secure?

3. Start the work on this mgmnt interface and add the passphrase passing 
feature as the first cmd.


(1) is easiest to implement and good enough for my use, on single user 
windows machines, but perhaps not good enough for multi-user unix systems. 
On the other hand, no one is forcing anyone to use this cmd-line option, 
so we might start with adding this feature, and then add a way to pass the 
passphrase over the management interface when we have that ready.

James, if I create a patch that accepts the passphrase as an cmd-line 
option, will you apply it then?

Comments?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

