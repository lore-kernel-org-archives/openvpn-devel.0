From: D. Rodic <rodic@...353...>
Message-ID: <loom.20050215T135612-753@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] openvpn & smartcard
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
Date: Tue Feb 15 05:05:29 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I need desperate help from a professional:

I am trying to implement openvpn with smartcard authentication.

I have installed and configured openvpn 2.0 to be a multi-client openvpn-
server on a linux server.
Installed latest openvpn gui-client on Windows XP sp2 client
Installed driver and Safesign CSP for ikey 3000 on client.
Generated and installed smartcard user certificate (with SafeSign CSP) on ikey 
token through Windows 2000 server CA enrollment page.
Signed openvpn-server certificate signing request with Windows 2000 CA.
Copied server- and CA-certificate to openvpn-server.
When plugged in, ikey registers its digital id to MS Cert Store.
But, when trying to connect to openvpn-server i get this error: Cannot load 
certificate "SUBJ:Administrator" from Microsoft Certificate Store: 
error:C5066064:microsoft cryptoapi:CryptAcquireCertificatePrivateKey: Public 
key provider invalid

Can you help me to solve this problem?
Thanking you in advance,

David Rodic


