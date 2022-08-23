Message-ID: <3ef4ed64-e30d-35c0-b067-1562ee75ca28@...1227...>
Date: Wed, 24 Aug 2022 00:46:18 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220822154037.44320-1-maximilian.fillinger@...2507...>
 <202208221832.27MIWLif003899@...2054...>
 <66bcce76f7df4aa1861a3f44fb723ac7@...2507...>
 <YwUinOP01/bMpf6l@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YwUinOP01/bMpf6l@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Update openssl_compat.h for
 newer LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 23.08.22 um 20:55 schrieb Gert Doering:
> Hi,
> 
> On Tue, Aug 23, 2022 at 10:21:30AM +0000, Maximilian Fillinger wrote:
>>> I'm a bit unsure if we need this for 2.5 - it's "long term compat"
>>> and not very intrusive, but on the other hand, not too many people
>>> seem to care about LibreSSL.
>>
>> OpenBSD has packaged 2.5.7 for snapshots, so they must already have a workaround.
> 
> Might be worth looking at their ports tree and see what patches they
> apply...  (putting that on my heap of things to do "really soon")


So here is a git mirror of their CVS (sic!) tree:

https://github.com/openbsd/ports/tree/master/net/openvpn

- They patch sample config to use user _nobody and enable that.
- Something in route, removing RTA_IFP
- some stuff in tun.c

but they think the revamped OpenSSL 3.0 way of calculating the TLS1 PRF 
might actually not be in 2.5 yet, so they do not need a patch for that.

Arne

