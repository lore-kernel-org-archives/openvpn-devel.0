References: <20200821062443.69245-1-eric@...1918...>
 <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
 <3df6fedd-f30a-4e08-0e82-b31a7728f21d@...1918...>
 <446bb2a7-7597-1c89-b4eb-543abf4e6e3f@...1227...>
 <2f192d4f-fa69-20d3-f9a2-90329d308b53@...1918...>
 <f2ddadee-f969-2bcb-5b19-ad2273a17b18@...1227...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <050fed64-f566-35be-f3fa-d9d79cf2a7c6@...1918...>
Date: Wed, 26 Aug 2020 11:15:15 +1000
MIME-Version: 1.0
In-Reply-To: <f2ddadee-f969-2bcb-5b19-ad2273a17b18@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Adds client-auth-pending-extra
 management functionality.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

I'm happy to resubmit the patch with further documentation to what I 
have already included with this patch, however I need to know what is 
likely to be accepted.

Per my previous question and example, is it acceptable to keep using 
CR_TEXT and document the C and CR flags, or, as I think you have hinted, 
would you prefer I create a fourth INFOPRE spec, for example CR_DATA, 
and document that instead?

It would also be highly appreciated if I could get some indication if 
this patch is acceptable outside of the requirement for further 
documentation or if the code needs further changes.

Thanks,
Eric

---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 25/08/2020 5:25 pm, Arne Schwabe wrote:
> Am 25.08.20 um 01:58 schrieb Eric Thorpe:
>> Hi Arne,
>>
>>> - to avoid the 256 byte management limit and multiple commands use maybe
>>> the same approach as client-auth that allows a longer frame, you can
>>> still limit that to 1024.
>> To be clear here, it isn't so much the limitation of the management or
>> control channel, it's situations where a tun-mtu may be set to say 750
>> for example, meaning the data size can only realistically be about 730
>> minus INFO_PRE, flags, etc, or OpenVPN or the network will drop the
>> control channel message. I would not recommend making any changes to
>> management or the control channel here, simply just have the ability to
>> send the data in smaller parts.
>>
>>> CR_TEXT is challenge response text and those clients that currently
>>> implement it only allow a single line. I would suggest the following to
>>> get the patch in a acceptable state:
>>>
>>> - Document your authentication method also in management.txt and also
>>> what IV_SSO flag indicates this authentication method.
>> Are you suggesting that I do not use CR_TEXT, and instead introduce a
>> new Challenge Response type (CR_DATA for example)?
> IV_SSO=crtext is a basically the AUTH_PENDING variant of presenting the
> user the text of CR_TEXT and responding with the answer.
>
> What you doing seems to be different. And if we add something that is
> different we should it its own IV_SSO flag to announce itself. And if
> you need "just" a multiline or longer text than current crtext can give
> to the user, we still need a flag for this new method, so we can signal
> if the client supports this.
>
> I am just asking that if we add new methods to AUTH_PENDING to properly
> document them.
>
> Arne
>

