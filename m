From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0501201030310.13840@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: Openvpn future: probably certificate problems...
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
Date: Thu Jan 20 01:46:47 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, peter@...292...

> Peter 'Luna' Runestig has put together a Crypto API patch which tries to 
> access user-based certificate/key pairs even when OpenVPN is running as 
> a service.
> 
> Given that Peter can't test this patch himself, it would be great if 
> someone who uses this feature would volunteer to do some testing and 
> report back to the list.
> 
> I've built a drop-in replacement for openvpn.exe (2.0-rc8) with the 
> patch applied:
> 
> http://openvpn.net/beta/ca3/

I've tried this patched version now, and there's a diffrence, but still 
not working with the key/cert in my user certstore.

With OpenVPN 2.0-rc8 I get:

Thu Jan 20 02:07:24 2005 Cannot load certificate "SUBJ:Mathias Sundman" 
from Microsoft Certificate Store: error:C5065064:microsoft 
cryptoapi:CertFindCertificateInStore:Cannot find object or property.

With OpenVPN 2.0-rc8-ca3 I get:

Thu Jan 20 02:03:37 2005 Cannot load certificate "SUBJ:Mathias Sundman" 
from Microsoft Certificate Store: error:C5064064:microsoft 
cryptoapi:CertOpenSystemStore:The parameter is incorrect.

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail


