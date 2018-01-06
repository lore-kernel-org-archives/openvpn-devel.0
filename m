Message-ID: <6a78a531d2f3d05661d38111ef3ce4e3.squirrel@...2260...>
In-Reply-To: <961580051.20180105122147@...1934...>
References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
 <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
 <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
 <4da8bb9a-7118-e0ab-ba7d-bc813e33d7c4@...515...>
 <d92ef8b9-fb9a-4cd0-ac6c-ebd04853311e@...2030...>
 <961580051.20180105122147@...1934...>
Date: Sat, 6 Jan 2018 17:49:16 +0100
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
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: Greg Sloop <gregs@...1934...>
Cc: openvpn-devel@lists.sourceforge.net

> -SNIP-
> I haven't taken the time to fully understand the tests you've done etc.
> [And it does seem you are not some neophyte blindly hacking your way
> through this...]
>
> However, I will tell you that it's *very* common for people to do things
> that appear very similarly as you describe, and find the IPSec throughput
> is vastly better then OpenVPN. [That's always been my experience in any
> benchmarking I've done - and I've done some.]  Each time I've seen it
> discussed - I've seen repeated threads all pointing to the kernel vs user
> space arguments.
>
> And all my own testing also shows that to be the case.
>
> IIRC, in the platforms I've tested, OVPN isn't CPU constrained - the
> connection will max out throughput far earlier than CPU exhaustion. IPSec
> will scale more or less directly with CPU performance - and at max
> throughput the CPU handling encryption will max out. (I suppose this might
> not be true in a system with in-hardware AES or other encryption
> off-loading - and the ethernet interface will become the bottleneck, not
> the CPU - but where I've run tests, that was never the case. It's,
> admittedly, been a while since I've done any real throughput tests on a
> test-bed setup.)
>
> TK> Again, keep in mind that full wire speed is realized with no vpn, and
> TK> with IPSec.
> TK> So, to reason this through a little:
>
> 1) TK> - No vpn = fast.
> 2) TK> - IPSec = fast.
> 3) - OVPN->>OVPN = even faster
> 4) - OVPN->>OVPN->routing/hardware = slow, down to about 200Mbps from
> 1+Gbps.
>
>
> I may certainly be wrong, but I'd be *really* skeptical about #3. I've

I may be wrong but I think it's simply the effect of LZO compression and
the nature of transferred data. Without LZO (or any other compression like
LZ4) I'm quite sure the speed is almost identical to #2 with IPSec.

> *never* seen a case where the performance of OpenVPN is better than IPSec
> on the same platform.
>
> And if #3 is wrong, your "tinkering" with #4 will never yield something
> useful.
> Obviously, I'd want to be pretty sure the straight OVPN <-> OVPN tests are
> accurate before trying to solve #4.

Still, I believe a dump on host B should reveal where the bottleneck is.
I'm also not sure the simple 'ethtool -K {dev} rx off tx off' is enough
here. Did you also look at ethernet features

- scatter-gather
- TCP segmentation  offload
- UDP  fragmentation offload
- generic segmentation offload
- generic receive offload

I know that the default settings can slow down data transfers horribly
with some traffic shaping configurations. I expect they can also have an
effect here.

Regards,
Simon
- large receive offload


