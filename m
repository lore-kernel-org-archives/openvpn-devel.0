Message-ID: <008901c1da97$e4ce0b70$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <1017760165.9891.85.camel@...2...>
Subject: Re: [Openvpn-devel] More BSD TUN info.
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Tue Apr  2 14:50:29 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Janne Johansson <jan.johansson@...1...>
Cc: openvpn-devel@lists.sourceforge.net

>Sorry for "spamming" so much with my porting issues.

Hey, I think it's great you're trying to port it!  Post as much as you want.

>Now it seems that BSD (at least Free/OpenBSD) TUN devices send AF_INET
as a u_int32_t in network byte order first, which Linux tun-devs
dont.

Interesting.  We should post something about that on the TUN/TAP list.  I
would think that network byte order should be the correct behaviour.

>That's why my last mail contains sending of "00000002" as the first
32 bits, it's telling the other end which AF to use.

>When initiated from the Linux end, the BSD will say
"unknown address family" or something very similar, which is true
since it gets "45000054" as the first data.

>Is there two types of tun or is the BSD tuns just slightly different and
incompatible by design?

Also sounds like a TUN/TAP list question.  I know the TUN/TAP driver became
an official part of the linux kernel as of the early 2.4 releases.

A fix on the linux side to conform to network byte ordering would be dicey
since it would break compatibility.

My approach would be to do the fix on the linux side but add an extra check
for compatibility and allow packets if the order is wrong.  Since there
aren't too many address families to worry about, the bad ordering test
should't be terribly ambiguous.

And since linux kernel changes take a long time to happen, it might be
necessary to add a workaround in OpenVPN to deal with this.

What do you think?

James



