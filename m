Message-ID: <521C46D6.7090501@...515...>
Date: Tue, 27 Aug 2013 00:27:34 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <CALkG1NxZC7DT+SZHuSYemyyaH8dVsx_0PAm-7pTYY9EYMbZBgQ@...278...>
	<1CED409804E2164C8104F9E623B08B901455BF6C4F@...1436...>
	<1CED409804E2164C8104F9E623B08B901455BF71F4@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901455BF71F4@...1436...>
Subject: Re: [Openvpn-devel] Adding support for AEAD cipher modes (AES-GCM,
 et al.)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 18/06/2013 01:23, Joachim Schipper wrote:
> Joachim Schipper wrote [I'm continuing my own message here]:
>>> -----Original Message-----
>>> From: Kenny Root [mailto:kenny@...1827...]
>>> Sent: dinsdag 4 juni 2013 2:15
>>> To: openvpn-devel@lists.sourceforge.net
>>> Subject: [Openvpn-devel] Adding support for AEAD cipher modes
>>> (AES-GCM, et al.)
>>>
>>> I wrote a patch to add AEAD cipher modes to OpenVPN.
>>>
>>> It also doesn't appear PolarSSL has added AES-GCM to their main crypto
>>> API yet.
>>>
>>
>> Cool to see support for GCM in the data channel!
>>
>> PolarSSL does support GCM (since 1.2, see include/polarssl/gcm.h), and
>> indeed OpenVPN-NL exclusively uses a GCM SSL ciphersuite in the control
>> channel. However, it would be very neat to also have it in the data
>> channel, so I looked at your patch with great interest. It's really
>> neat, but I do have some comments.
>
>> The prng_bytes() on src/openvpn/crypto.c:144 seems odd in various ways.
>> I'll continue reviewing tonight and tomorrow morning, and I'll take a
>> good look at this chunk of code then. (Sorry for the slow review; life
>> and spotty internet in the train got in the way.)
>
> Continuing this train of thought, both GCM and CCM need non-repeating (but
> possibly predictable) IVs. As long as net_time and net_id are unique to the
> current packet, your code works fine; and you should still have 32 bits of
> randomness left to guard against Bad Things happening to the clock. So this
> code is just fine.
>
>> I don't understand src/openvpn/crypto.c:194 either, but I'll take
>> another look tonight.
>
> After another reading, I understand just fine. Consider adding "else
> ASSERT(outlen == 0)", but ok.
>
>> Again, thanks for the patch! I'm no contributor, but I do think it's
>> really cool.
>
> Let me reiterate: thanks! I've just taken a quick look, but it looks quite
> nice.

Agreed -- adding AEAD support is great.  That gives us access to 
AES-GCM, which has spectacular performance when accelerated at the CPU 
level (i.e. AES-NI).

Testing the patch with AES-GCM, the packet crypto header looks like this 
(appearing to be loosely inspired by RFC 4106):

7e7046bd 444a7e28 cc6387b1 64a4d6c1 00000005 521c3b01 4308c041 380275a
[             auth tag            ] [seq # ] [time_t] [random] [ payload 
... ]
[   used like HMAC signature      ] [   12-byte IV/nonce/AD  ]

This is running in static key mode.  The time_t field is only used in 
static key mode and is based on the daemon startup time.  It doesn't 
change unless (a) the daemon is restarted or (b) the sequence number 
field wraps around.  In TLS mode there would be a leading control byte, 
and the time_t field would be replaced by randomness.

The "12-byte IV/nonce/AD" is the "associated data" field meaning that it 
is integrity-checked but not encrypted.  This is so it can double as the IV.

I'm thinking there might be some possible efficiency gains here by 
building the 12-byte nonce differently for TLS mode, such as by 
pre-agreeing to 8 bytes of randomness for each key negotiation, then 
send 4 additional bytes over the wire as a sequence number instead of 
12.  The IV could be synthesized on each end by combining the sequence 
number with the 8 bytes of agreed randomness.  This would cut 8 bytes 
out of the packet because [time_t] [random] vanishes, while retaining 
the essential property that the IV never repeats for a given key.

Can we get some more reviewers on this?

One question that applies to AEAD crypto in general and not specifically 
this patch, is what are the security implications of doing away with 
HMAC and trusting the cipher to do both encryption/decryption and 
integrity checking?  Is there general agreement in the crypto community 
that the integrity checking component of AEAD is as solid as 
encrypt-then-HMAC?  Because crypto history seems littered with the 
wreckage of attempts to pipe untrusted data directly into decryption 
algorithms.

James

