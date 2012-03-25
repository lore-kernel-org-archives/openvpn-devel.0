Message-ID: <4F6F58F0.4080809@...1030...>
Date: Sun, 25 Mar 2012 18:42:08 +0100
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
Subject: [Openvpn-devel] certificate key usage in openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Looking at the openvpn manual, the predefined certificate key usage for 
clients is "digitalSignature and/or keyAgreement" (or "80 08 88"). The 
same for the server is "digitalSignature and ( keyEncipherment or 
keyAgreement )" - "a0 88".

According to Section 4.2.1.3 of RFC3280, the certificate key usage is 
defined as follows:

KeyUsage ::= BIT STRING {
digitalSignature (0),
nonRepudiation (1),
keyEncipherment (2),
dataEncipherment (3),
keyAgreement (4),
keyCertSign (5),
cRLSign (6),
encipherOnly (7),
decipherOnly (8) }

In other words, the values of digitalSignature (bit 0) and/or 
keyAgreement (bit 4), when OR-ed should give me numbers 0x01 (00000001 
binary) and 0x10 (0001 0000), so the certificate key usage should be 
0x01 (0000 0001), 0x10 (0001 0000) or 0x11 (0001 0001), not 0x80 (1000 
0000) 0x08 (0000 1000) or 0x88 (1000 1000).

Similar for the server: bit 0 and (bit 2 or bit 4) makes this as 0x5 
(0000 0101) or 0x11 (0001 0001), not 0xa0 (1010 0000) or 0x88 (1000 
1000). Am I missing something obvious?

