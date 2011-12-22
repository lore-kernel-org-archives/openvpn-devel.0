From: Tiran Kaskas <Tiran.Kaskas@...1530...>
Date: Thu, 22 Dec 2011 10:07:42 +0000
Message-ID: <A273A2F6519C0D42BFF02CA9C6A825112D00A3D3@...1534...>
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
	<A273A2F6519C0D42BFF02CA9C6A825112D005C00@...1531...>
In-Reply-To: <A273A2F6519C0D42BFF02CA9C6A825112D005C00@...1531...>
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Again, need some help:

It seems like I am through with the vpn initialization, and seems like the =
session is created successfully.
Now, I start sending data to some server from the client side (I have an ap=
plication which opens a socket to google.com and sends some data).
I do see the packet is received on the server side and decrypted successful=
ly (virtual address is the client's tun ip).
I see the server reads this packet from the link adapter(ethernet), and wri=
tes it to the tun adapter.
Looking at the tun adapter (using wireshark), I see a packet is there with:
source ip: client's tun ip
destination ip: the google ip

The problem is that nothing happens from this point.
I am missing something, pretty sure about that, but do not know what...
I know that when the server write this packet to the TUN, it means the pack=
et is injected into the OS ip stack, as if it was received from the outside=
. But who will take care of actually sending it to the destination address?=
 Am I missing some routing configuration?

Thanks!

-----Original Message-----
From: Tiran Kaskas [mailto:Tiran.Kaskas@...1530...]=20
Sent: Wednesday, December 14, 2011 11:47 AM
To: Gisle Vanem; openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function

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

