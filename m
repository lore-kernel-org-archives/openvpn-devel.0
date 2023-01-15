Message-ID: <79a79fe0-978b-020d-83f2-026299e7337e@...1227...>
Date: Sun, 15 Jan 2023 16:34:33 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
 <af0497ca-b862-6a5c-f5ff-eb0d34a84692@...1227...>
 <0456a9e2e317af58f1aa6947c768ac7853c06485.camel@...2316...>
 <334bc5ad-1d55-208b-bbaf-2233c4708d9f@...1227...>
 <f24287289b084285b67fc1a7fb26714fec3f0bbc.camel@...2316...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <f24287289b084285b67fc1a7fb26714fec3f0bbc.camel@...2316...>
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
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
To: James Bottomley <James.Bottomley@...2316...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 15.01.23 um 16:22 schrieb James Bottomley:
> On Sun, 2023-01-15 at 15:22 +0100, Arne Schwabe wrote:
>>
>>> If that's the source of this issue, then I think there's a
>>> misunderstanding about the problem the OpenSSL exception is
>>> addressing. The problem was that the OpenSSL licence required
>>> additional conditions be imposed on the binary as a whole, even
>>> though openssl itself was a system library.
>>>
>>> https://spdx.org/licenses/OpenSSL.html
>>>
>>> Specifically the advertising and redistribution clauses.  The
>>> OpenSSL exception is to make GPLv2 compatible with the OpenSSL
>>> licence's additional restrictions, not the other way around.  There
>>> is still a considerable body of opinion that thinks the system
>>> exception covers this case as well, but just in case, people added
>>> the OpenSSL compatibility exception to GPLv2.
>>>
>>> The goal of changing OpenSSL to Apache-2 was to remove those
>>> additional restrictions and make the library behave like a normal
>>> linked library from a licensing point of view.  The Apache-2
>>> licence imposes no additional restrictions on the binary as a
>>> whole, which is why no exception is necessary.  Specifically the
>>> patent retaliation and indemnity clauses which some people think
>>> cause the cut and paste incompatibility don't apply to the binary
>>> as a whole, only to the Apache2 pieces.
>>
>>
>> Yes. That is my understanding as well. But I think where we have been
>> told
> 
> Who told you?  Because I'd like to tackle this misinformation at source
> before it spreads further than openvpn.
> 
>>   and see the problem different is that the GPL2 covers the whole
>> binary and also the Apache2 licensed parts.
> 
> It does under section 2 for any component that can't be classified as a
> system library, yes.  But the system library exception is the way you
> avoid this for linking with most libraries.

So we have the same interpretation and just disagree if mbed TLS and 
OpenSSL can be seen as system library on non-Linux/non-BSD systems.

>>   And then the restrictions become a problem.
> 
> Only if the library you're linking with isn't a system library, which I
> think we can all agree in not the case on every Linux distribution
> because they all ship both openssl and mbedtls as part of the
> distribution.
> 
>>   So you are right in the sense that the Apache2 is just
>> a normal library to link for most purposes, the GPL licenses are
>> special in the way that they want to cover the whole source
>> code/binary. Sometimes this feature of the GPL is called viral by
>> opponents of the license.
> 
> Not for system libraries ... that's what the system library exception
> is all about.

Yes but neither mbed TLS nor OpenSSL is a system library on Windows or 
macOS. And even mbed TLS is sketchy as many distributions do not have in 
their base system. So just assume, at least for the sake of argument 
that they are not. In that case I think we need this exception. So I am 
asking if you are willing to allow this exception to the license even 
though you think it is unnecessary to make the people that think that it 
is needed happy?

Arne



