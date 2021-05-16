References: <E1lRfW3-0001sy-VM@...2508...>
 <202104021816.132IG2w4032861@...2054...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <9bddcaa8-42c7-e5c9-fed0-0613e08cf061@...1856...>
Date: Sun, 16 May 2021 11:11:52 +0200
MIME-Version: 1.0
In-Reply-To: <202104021816.132IG2w4032861@...2054...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: reliable: retransmit if 3
 follow-up ACKs are received
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 02-04-2021 20:16, Gert Doering wrote:
> Your patch has been applied to the master branch.
> 
> I have never looked into this reliable stuff before, and do not have
> a test environment with a) significant amounts of control plane traffic,
> and b) "just the right amount" of packet loss.  So I've just stared at
> the code a bit (seems reasonable) and tested client side on Linux
> (works).

Thanks!

> I do wonder a bit under which condition this could fire - with the
> larger control channel packets we introduced a few years ago, I do
> not see many scenarios where "more than 3 packets" could be in-flight
> at the same time...  inital TLS handshake with very large DH groups?

This was written in the context of our post-quantum crypto experiments
with OpenVPN. Post-quantum (pub)keys are typically larger than
traditional keys. So yes, large keys / paramters is one example.

Another one would be someone pushing large amounts of routes. I recall
ValikSS had such a use case. I've also seen companies push a lot of
routers to have high-volume traffic (e.g. video conferencing, cloud
storage) bypass the VPN.

-Steffan

