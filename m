Message-ID: <ab064e37-0f3f-40ff-b72b-05c8d08eb269@...1227...>
Date: Tue, 23 Jan 2024 12:14:25 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <b3e0a162-f0e2-4d76-bd15-02db44443346@...1227...>
 <44e7c38b-5749-a7d6-526d-d6c252c62566@...1856...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <44e7c38b-5749-a7d6-526d-d6c252c62566@...1856...>
Subject: Re: [Openvpn-devel] OpenVPN data channel format using 64bit IV
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

>> - add protocol-flag aead-packet-format-v2 This signals the client to 
>> switch to the new data channel format.
>>
>>
>> And finally have the data channel format. Since this format is 
>> negotiated like the cipher, there is no need to use another opcode if 
>> keep the peer id to just 24 bit. But we might want to extend the 
>> format to have it 8 byte aligned to also allow peer-id to be extended 
>> in the future.
> 
> I'd at least consider to not send the upper 32 bits of the counter over 
> the wire. With some simple arithmetic you can detect the counter 
> overflow and keep the high bits internal to the application. I'd expect 
> such per-packet arithmetic to be much cheaper than transmitting 4 bytes 
> extra for each packet.
> 
> If you take that approach, you would not even need to change the wire 
> format.
> 
> Even more, you might not even have to negotiate the option with the 
> peer, because the peer will initiate a renegotiation after 0xFF000000 
> packets if it doesn't support the "implicit long PID". New peers will 
> postpone the reneg to 0xFF00000000000000 packets.

Even as nice as that sounds, I am not super convinced that we should be 
the "odd protocol" here that takes a different approach than all other 
protocol. All other protocols that I looked at, rather use longer IV 
instead of doing some hidden counter that is not transmitted.

So I would rather err on the safe side here and go for a 8 byte IV instead.

Arne


