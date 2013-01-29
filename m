Date: Tue, 29 Jan 2013 11:55:25 +0100 (CET)
From: Joerg Willmann <joe@...1803...>
Message-ID: <alpine.DEB.2.02.1301291154270.3577@...1804...>
MIME-Version: 1.0
Subject: [Openvpn-devel] #172: NTLM auth does not work with SQUID proxy
	server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I was just faced with the problem described in trac issue #172.
I was trying to use ntlm authentication against a bluecoat proxy server.
Since the reply string of the bluecoat proxy was too long the same problem 
occurred as described in #172:

"NTLM Proxy-Authorization phase 3 failed: received corrupted data from 
proxy server"

The patch attached to #172 solved my problem and seems to be reasonable.

I'm just wondering what it takes to make this issue being accepted. (Sorry 
I didn't find a description of this process in 
wiki/DeveloperDocumentation).
Does it just take time or is some input required?

Best regards,
Joerg

