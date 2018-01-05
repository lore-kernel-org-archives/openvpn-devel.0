Message-ID: <a1174daaa1e8e1c6af98add253dfc1ac.squirrel@...2257...>
In-Reply-To: <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
 <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
 <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
Date: Fri, 5 Jan 2018 08:06:59 +0100
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OVPN vs IPSec performance as a transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tom Kunz <tkunz@...2030...>
Cc: "Greg Sloop <gregs@...1934...>" <gregs@...1934...>, openvpn-devel@lists.sourceforge.net

Hi,

> That would explain it if it always worked that way.
> But I can get 400%+ wire speed from A to B with compressible data, and
> 102% with incompressible data.  If I do the same test from B to A or A
> to B, I get those results.  If I hop off of that to C, speed goes from
>>1Gbps to sub-200Mbps.  In either case, the data has left the kernel
> space to arrive at "nc", so just simply saying "it's kernel vs user"
> doesn't answer it.

So if I understand correctly you are able to get wire speed over the
OpenVPN link as long as you don't route traffic further via an other
simple router?

Maybe you could try those two things:
1) Disable all LZO compression just to make sure it has nothing to do with
it.

2) Run tcpdump/wireshark on B and look in detail how data is moved over
the different tun and ethernet devices. I'm sure you should see something
there at least if you compare it with a run made without OpenVPN.

BTW, you don't have any iptables rules on any of the boxes, do you?

And, you could check all the kinds of checksumming and offloading on your
ethernet interfaces. Those settings can have a huge impact if they do
things wrong.

Regards,
Simon


