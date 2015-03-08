Message-ID: <54FC26BB.2000202@...1856...>
Date: Sun, 08 Mar 2015 11:38:51 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Remove support for key-method 1 from master/2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

To create keys for the data channel, OpenVPN currently supports two 
mechanisms, 'Key method 1' and the newer 'Key method 2'.  Key method 2 
is supported since OpenVPN 1.5, and has been the default from OpenVPN 
2.0.  See the manpage and/or 
http://openvpn.net/index.php/open-source/documentation/security-overview.html 
for a short recap of both methods.

I think the time has come to remove support for key method 1 from 
OpenVPN.  This will allow us to remove quite some legacy code, and will 
probably allow us to simplify some of the surrounding code.

However, before investing time in preparing a patch for this, I would 
like to hear if there are objections to this proposal.  So, if you have 
a setup that uses key method 1, and you want to use that setup with 
OpenVPN 2.4, or have other reasons to believe we should keep supporting 
key method 1 in OpenVPN 2.4, please speak up.

-Steffan

