References: <20200821062443.69245-1-eric@...1918...>
 <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
 <3df6fedd-f30a-4e08-0e82-b31a7728f21d@...1918...>
 <446bb2a7-7597-1c89-b4eb-543abf4e6e3f@...1227...>
 <2f192d4f-fa69-20d3-f9a2-90329d308b53@...1918...>
 <f2ddadee-f969-2bcb-5b19-ad2273a17b18@...1227...>
 <050fed64-f566-35be-f3fa-d9d79cf2a7c6@...1918...>
 <c6d1361f-f7d5-9a28-ff93-580b9dd75ad3@...1227...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <84776d54-ca63-e21a-6c6d-311760f9e280@...1918...>
Date: Thu, 27 Aug 2020 09:34:09 +1000
MIME-Version: 1.0
In-Reply-To: <c6d1361f-f7d5-9a28-ff93-580b9dd75ad3@...1227...>
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

The first we are trying to migrate across is U2F - 
https://www.sparklabs.com/support/kb/article/yubikey-u2f-two-factor-authentication-with-openvpn-and-viscosity/ 
<https://www.sparklabs.com/support/kb/article/yubikey-u2f-two-factor-authentication-with-openvpn-and-viscosity/>

Even though the patches in the above article work for the vast majority, 
they are a bit of a hack and we want to get away from them as they're 
still prone to failing on connections with low MTU or fragmentation 
issues as previously mentioned.

All our 2FA supported methods that we want to migrate across to 
AUTH_PENDING instead of AUTH_FAILED are available here as well if you'd 
like some further examples of what this would be used for - 
https://github.com/thesparklabs/openvpn-two-factor-extensions 
<https://github.com/thesparklabs/openvpn-two-factor-extensions>

Anything using this new method would also end up in the above repo.

Regards,
Eric

---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 26/08/2020 6:55 pm, Arne Schwabe wrote:
> Am 26.08.20 um 03:15 schrieb Eric Thorpe:
>> Hi Arne,
>>
>> I'm happy to resubmit the patch with further documentation to what I
>> have already included with this patch, however I need to know what is
>> likely to be accepted.
>>
>> Per my previous question and example, is it acceptable to keep using
>> CR_TEXT and document the C and CR flags, or, as I think you have hinted,
>> would you prefer I create a fourth INFOPRE spec, for example CR_DATA,
>> and document that instead?
> Maybe. I am not against the idea of allowing more authentication
> methods. But I am not sure what you are trying to achieve.
>
>> It would also be highly appreciated if I could get some indication if
>> this patch is acceptable outside of the requirement for further
>> documentation or if the code needs further changes.
> Currently I don't understand what authentication method you are trying
> to implement. It is frustrating for me that you avoid that question.
>
> For accepting it is very simple. Either is something everyone using
> OpenVPN can implement and understand and you are willing to share with
> OpenVPN. Then the patches can go. If it a special private authentication
> method and you don't want to share that, then your patches can also be
> kept private and applied your own branch/client/server.
>
> Arne
>

