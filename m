From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.60.0408092121530.27324@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] psw in pem_passphrase_callback() static or not?
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
Date: Mon Aug  9 12:36:07 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

When i first looked at the pem_passphrase_callback() function in ssl.c, I 
though that the intention was to save the passphrase so the key could be 
reloaded after a ping-restart, because you use:

static char passbuf[256];

So, I was surprised when my GUI now asked me for the passphrase a second 
time (after a ping-restart).

A closer look at the function revealed that you do a CLEAR(passbuf) 
before returning.

So, I just wonder, was the intention to save the passphrase or not? If 
not, why do declare passbuf as static?

Also, is it safe todo
if (!strlen (passbuf)) 
when passbuf has not get been assigned any string?


-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

