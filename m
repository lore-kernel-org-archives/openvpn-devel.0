From: Tiran Kaskas <Tiran.Kaskas@...1530...>
Date: Wed, 14 Dec 2011 09:46:56 +0000
Message-ID: <A273A2F6519C0D42BFF02CA9C6A825112D005C00@...1531...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
	<4EE52A57.1040906@...1338...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
	<4EE863A2.5010302@...1114...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005B6D@...1531...>
	<0E891FB5E6304C73BB4338093E409304@...139...>
In-Reply-To: <0E891FB5E6304C73BB4338093E409304@...139...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gisle Vanem <gvanem@...139...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Indeed, a large model is used

-----Original Message-----
From: Gisle Vanem [mailto:gvanem@...139...]=20
Sent: Wednesday, December 14, 2011 11:45 AM
To: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function

"Tiran Kaskas" <Tiran.Kaskas@...1530...> wrote:

> Already done the ssl part, only polarssl. It is working perfect and does =
support 16bit with no change.

You got all the data in PolarSSL, LZO and OpenVPN to fit in a 16-bit data-s=
egment of 64 kByte? I'll be amazed. What memory model would be needed to li=
nk in all the code. 64 kByte would be not enough, so at least large model w=
ould be needed (1 data-segment multiple code- segments).

--gv


---------------------------------------------------------------------------=
---
Cloud Computing - Latest Buzzword or a Glimpse of the Future?
This paper surveys cloud computing today: What are the benefits?=20
Why are businesses embracing it? What are its payoffs and pitfalls?
http://www.accelacomm.com/jaw/sdnl/114/51425149/
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

