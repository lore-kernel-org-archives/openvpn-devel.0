Message-ID: <D361D4D8184C40E2A8E222238EA0BE35@...2089...>
From: <debbie10t@...277...>
Date: Tue, 29 Dec 2015 12:31:35 -0000
MIME-Version: 1.0
Subject: [Openvpn-devel] man openvpn(8): --block-outside-dns
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Is this considered to be sufficient documentation:

https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage

--block-outside-dns

Block DNS servers on other network adapters to prevent DNS leaks. This 
option prevents any application from accessing TCP or UDP port 53 except one 
inside the tunnel. It uses Windows Filtering Platform (WFP) and works on 
Windows Vista or later.

--block-outside-dns is not an openvpn directive ... it cannot be used in a 
config file as such.

Regards


