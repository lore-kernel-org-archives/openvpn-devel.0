Message-ID: <44e7c38b-5749-a7d6-526d-d6c252c62566@...1856...>
Date: Tue, 12 Dec 2023 14:47:14 +0100
MIME-Version: 1.0
References: <b3e0a162-f0e2-4d76-bd15-02db44443346@...1227...>
Content-Language: en-US
From: Steffan Karger <steffan@...1856...>
In-Reply-To: <b3e0a162-f0e2-4d76-bd15-02db44443346@...1227...>
Subject: Re: [Openvpn-devel] OpenVPN data channel format using 64bit IV
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I've been just lurking for a while, but you've managed to nerd-snipe me 
in responding.

On 11-12-2023 13:31, Arne Schwabe wrote:
> with DCO and possible future hardware assisted OpenVPN acceleration we 
> are approaching the point where 32 bit IVs are not cutting it any more.

Agreed. Though to be precise, we use 96-bit IVs in our AEAD mode, which 
include a 32-bit packet counter.

> To illustrate the problem, some back of the envelope math here:
> 
> If we want to keep the current 3600s renogotiation interval and have a 
> safety margin of 30% we have about 3 million packets (2*32 * 0.7) to 
> work with. That translates to about 835k packets per second.

Nitpicking, but we currently maintain a reneg threshold at 75% (pid >= 
0xFF000000).

> With 1300 Byte packets that translates into 8-9 Gbit/s. That is from 
> unrealistic any more. Current DCO implementations are already in 
> spitting distance to that or might even reach (for a single client 
> connection) that if you have extremely fast single core performance CPU.

Agreed. Though it seems to me that with so much processing power and 
network throughput, it wouldn't be much of an issue to renegotiate 
slightly more often.

> So I think we need to consider adding 64bit IV now rather than later.

Even considering my remarks above, I do agree it's time.

But, we will also need to make sure that we won't exceed the limits of 
the ciphers we use, which might need additional logic. I don't have time 
right now to dig up all the specifics, but this IRTF draft might serve 
as a good starting point for reading: 
https://www.ietf.org/archive/id/draft-irtf-cfrg-aead-limits-07.html

> So the proposal is the following:
> 
> - add IV_PACKET_FORMAT_AEAD_V2 flag to the protocol flags. This signal 
> that the other side supports the new AEAD data channel packet format 
> that supports 64 bit IVs.
> 
> I don't think we need to extend this feature to the CBC data channel 
> format. I just don't see a use case where people would be able to 
> upgrade to a new OpenVPN version to use 64 bit IVs but not to also 
> change to use AEAD ciphers.

Ack. Do note that CBC has a random IV per packet, so this doesn't apply 
to the IV in CBC, just the packet counter.

> - add protocol-flag aead-packet-format-v2 This signals the client to 
> switch to the new data channel format.
> 
> 
> And finally have the data channel format. Since this format is 
> negotiated like the cipher, there is no need to use another opcode if 
> keep the peer id to just 24 bit. But we might want to extend the format 
> to have it 8 byte aligned to also allow peer-id to be extended in the 
> future.

I'd at least consider to not send the upper 32 bits of the counter over 
the wire. With some simple arithmetic you can detect the counter 
overflow and keep the high bits internal to the application. I'd expect 
such per-packet arithmetic to be much cheaper than transmitting 4 bytes 
extra for each packet.

If you take that approach, you would not even need to change the wire 
format.

Even more, you might not even have to negotiate the option with the 
peer, because the peer will initiate a renegotiation after 0xFF000000 
packets if it doesn't support the "implicit long PID". New peers will 
postpone the reneg to 0xFF00000000000000 packets.

> Regardless of what choice we take, this is a good opportunity to rectify 
> the position of the AEAD tag in our packet. Especially for hardware 
> implementations it is quite advantageous to have the AEAD at the end of 
> the packet instead of the beginning and since we need to have a new data 
> format, there is no reason to keep the tag at the start of the packet.

Agreed (as I already stated in 2015: 
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg09879.html).

> 
> So the choice is basically
> 
> Variant A:
> 
> Bytes
> 
>           1          234        5-13      13- (n+13)     (n+14) - (n+30)
> 
> [OP_CODE_DATA_V2][peerid]   [64 bit IV] [  payload  ][ 16 byte auth tag]
> 
> 
> Variant B:
> 
>         1            3-8
> [OP_CODE_DATA_V3] [ peer-id/padding] [rest identical]

or:

Variant C:

Leave the on-the-wire PID as-is. Just move the auth tag to the end of 
the packet.

variant D:

Keep wire format as-is.

-Steffan

