From: Marcel =?utf-8?q?Pennewi=C3=9F?= <mailinglists@...1145...>
Date: Thu, 13 Nov 2008 01:23:46 +0100
MIME-Version: 1.0
Message-Id: <200811130123.46417.mailinglists@...1145...>
Subject: [Openvpn-devel] IPv6 Support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

a long time ago Juanjo Ciarlante wrote a patch for openvpn to create a tunnel 
via ipv6 [1]. Later i fixed the patch to work with openvpn-2.0 and 2.1 which 
i use on OpenWRT and Gentoo. Roy (from Gentoo) wrote about this also to the 
devel-list [1]. But since that no one answered :( 

What about IPv6-support to create a tunnel over IPv6? Since my first patch i 
try to adapt the patch to newer versions. This patches are not properly 
tested but works fine for me (on gentoo).[2][3]

I'm not able to adapt the patch detailed 'cause of not enough knowledge about 
the source and missing programming skills. JuanJo want some integration to 
the official openvpn source code, but knowone did this until now. 

[1] 
http://sourceforge.net/mailarchive/message.php?msg_id=20070629101345.0f8beeba%40uberlaptop.marples.name
[2] http://source.pennewiss.de/openvpn/udp6/
[3] http://bugs.gentoo.org/show_bug.cgi?id=183457

Are there plans to integrate it to the future?

Regards,
Marcel

