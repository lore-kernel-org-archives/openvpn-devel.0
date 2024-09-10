Message-ID: <0c73b044-7397-4f85-9457-1d1c9d5b2019@...1856...>
Date: Tue, 10 Sep 2024 21:51:45 +0200
MIME-Version: 1.0
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
 <20240910163411.23119-1-gert@...1296...>
Content-Language: en-US
From: Steffan Karger <steffan@...1856...>
In-Reply-To: <20240910163411.23119-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v11] Implement support for larger packet
 counter sizes
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
To: openvpn-devel@lists.sourceforge.net

Hi,

TL;DR: I don't think this should be merged yet. My primary concern is 
that we don't have any means to limit key usage to a safe value. I 
raised this concern back in December 2023:

https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27791.html

If we allow for packet counter of 64 bits, we would allow users to 
exceed the safe limits determined for AES-GCM in the context of TLS. As 
far as I can tell, we don't have a reason to allow for looser limits. So 
before this patch goes in, I really think we should discuss what those 
limits should be for OpenVPN *and* enforce them.

This might have been overlooked, because attention was drawn to my 
proposal to make the upper bits "implicit" in the same mail.

On 10-09-2024 18:34, Gert Doering wrote:
> From: Arne Schwabe <arne@...1227...>
> 
> With DCO and possible future hardware assisted OpenVPN acceleration we
> are approaching the point where 32 bit IVs are not cutting it any more.

s/IVs/packet counters/. See my mail from Dec 2023.

> To illustrate the problem, some back of the envelope math here:
> 
> If we want to keep the current 3600s renegotiation interval and have
> a safety margin of 25% (when we trigger renegotiation) we have about
> 3.2 million packets (2*32 * 0.7) to work with. That translates to
> about 835k packets per second.
> 
> With 1300 Byte packets that translates into 8-9 Gbit/s. That is far
> from unrealistic any more. Current DCO implementations are already in
> spitting distance to that or might even reach (for a single client
> connection) that if you have extremely fast
> single core performance CPU.
> 
> This introduces the 64bit packet counters for AEAD data channel
> ciphers in TLS mode ciphers. No effort has been made to support
> larger packet counters in any other scenario since those are all legacy.

Note that for AES-GCM, assuming limits similar to TLS, we likely won't 
be able to postpone key refresh for much longer than we currently do. 
For ChaCha-Poly we can, because of the larger auth tag.

So if we want to improve things for AES-GCM, we probably need other 
optimizations. I have some ideas, but was hoping to do some research and 
a write-up during the train ride to the hackathon, so we could discuss 
it further in Karlsruhe.

-Steffan

