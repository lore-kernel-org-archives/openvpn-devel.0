References: <a7450cf9-f278-4e51-0c96-fa9aabddd169@...2181...>
 <f69a02a5-4e06-00ad-366e-56f5699c4d98@...1147...>
 <e0af59b0-2310-7ce3-482e-2353c7ce1203@...2181...>
 <973df135-fb7c-009b-5b48-da888f54d51c@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <97bb9ea6-5252-66f7-b228-9aad39b93e02@...1227...>
Date: Mon, 7 Dec 2020 15:30:20 +0100
MIME-Version: 1.0
In-Reply-To: <973df135-fb7c-009b-5b48-da888f54d51c@...1147...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [ovpn-dco] AES-CCM available for testing
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
To: Jan Just Keijser <janjust@...1147...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 07.12.20 um 12:33 schrieb Jan Just Keijser:
> Hi Antonio,
> 
> On 07/12/20 10:56, Antonio Quartulli wrote:
>> Hi Jan Just, Tony,
>>
>> On 07/12/2020 10:10, Jan Just Keijser wrote:
>>> Thank you very much for adding this so quickly; it won't help Tony He
>>> though, as he is stuck using a rather old AL314 + R9000 chip which does
>>> not support CCM or GCM. I just checked the driver code and indeed there
>>> is no HW support for GCM.  They *do* support some AEAD algorithms:
>>>
>>>    authenc-hmac-sha256-cbc-aes
>>>    authenc-hmac-sha384-cbc-aes
>>>
>>> which are listed as the (true) AEAD equivalent of AES+SHA ; the question
>>> is : how hard would it be to add support for this (and would it be worth
>>> it?)
>> I would ask the same question to the vendor: how hard would it be to
>> support AES-GCM in the current HW engine?
>>
>> Any info about that?
>> They are the best recipient for such feature request I think.
>>
>> As far as I understood the HW engine is also open source, so actually
>> anybody with the right motivation could take up that task.
> I fully agree; however, the last change to the kernel driver for that
> hardware was made over 3 years ago , so I suspect that it will be hard
> to get GCM support for it.
>>
>> Forcing ourselves to sticking to legacy algorithms is not the right
>> move, imho (especially when there are solutions - see above).
>> To answer your question: my feeling is that working on it is not worth
>> the benefit.
>>
>>
> again, I tend to agree *but* when you say that 'openvpn-dco only
> supports AEAD crypto algorithms" you can expect that sooner or later
> someone will ask the question "how about authenc-hmac-sha256-cbc-aes ?" 
> because that *IS* an AEAD algorithm after all.
> 
> But without support in OpenVPN 2.x for this the point is moot, as far as
> I am concerned, as supporting something only in the kernel driver will
> make it interoperable with the open source  community version of OpenVPN.

To be honest, I am not seeing any API in OpenSSL that makes use of them
as AEAD ciphers. And if reduce them to the fact of being
encrypt-then-mac ciphers we are basically back with normal OpenVPN usage
of CBC+SHA1 since we always used encrypt-then-mac instead of the
mac-then-encrypt that TLS used before.

And the driver support argument at least for AES-CCM does not really
count. From the README:

This driver implements standard Linux Crypto API algorithms:
ablkcipher - aes-cbc, aes-ecb, aes-ctr, dec-cbc, des-ecb,
des3-ede-cbc, des3-ede-ecb.

Something that implements aes-ctr and aes-cbc, implementing aes-ccm
should be trivial. Even if means sending the data twice to the crypto
engine for doing the cmac and the encryption in seperate calls.

As my personal opinion: I still okay with CCM as it is still an optional
mode for TLS 1.3 but TLS 1.3 does not implement any other mode and
neither should we spend any extra time on algorithms that are already
outdated and deprecated when we introduce them. I know that this feels
unfair to people using old hardware but we have to make a cut at some point.

Arne

