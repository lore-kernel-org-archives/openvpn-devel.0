MIME-version: 1.0
Message-id: <0E891FB5E6304C73BB4338093E409304@...139...>
From: Gisle Vanem <gvanem@...139...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
	<4EE52A57.1040906@...1338...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
	<4EE863A2.5010302@...1114...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005B6D@...1531...>
Date: Wed, 14 Dec 2011 10:45:10 +0100
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; CHARSET=US-ASCII; charset="US-ASCII"; format=flowed;
 reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

"Tiran Kaskas" <Tiran.Kaskas@...1530...> wrote:

> Already done the ssl part, only polarssl. It is working perfect and does support 16bit with no change.

You got all the data in PolarSSL, LZO and OpenVPN to fit in a 16-bit
data-segment of 64 kByte? I'll be amazed. What memory model would
be needed to link in all the code. 64 kByte would be not enough, so at
least large model would be needed (1 data-segment multiple code-
segments).

--gv


