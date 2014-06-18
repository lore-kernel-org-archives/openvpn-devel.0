Message-ID: <53A1FF99.1000001@...1114...>
Date: Wed, 18 Jun 2014 23:07:37 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>	<1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>	<20140602182009.GP1118@...1296...>	<538F27C6.2030203@...1516...>
	<53A14B09.8010405@...1516...>
In-Reply-To: <53A14B09.8010405@...1516...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Get NTLMv1 compatibilities and
 NTLMv2 up and running
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

On 18/06/14 10:17, Holger Kummert wrote:
>
> Hello Gert,
>
> I reconsidered this point and found some lively discussions about it,
> e.g. http://stackoverflow.com/questions/1674032/static-const-vs-define-in-c
>
> The "const int" way has some advantages (as pointed out in all the
> discussions I found) over the #define:
> - It is type-safe
> - It respects scope
> - It eases (in some cases) debugging (entry in symbol table)
>
> It is usually recommended as "static const", what we could also use.
>
> Am 04.06.2014 16:05, schrieb Holger Kummert:
>>>>>> +  const unsigned int uni_max_utf16      = 0x0010FFFF,
>>>>>> +                     uni_half_base      = 0x00010000,
>>>>>> +                     uni_half_mask      = 0x000003FF,
>>>>>> +                     uni_half_shift     = 10,
>>>>>> +                     uni_sur_high_start = 0xD800,
>>>>>> +                     uni_sur_low_start  = 0xDC00,
>>>>>> +                     uni_sur_low_end    = 0xDFFF;
>>>>
>>>> I'm feeling slightly uneasy with these.  If these are true constants,
>>>> is there a good reason to use "const int" variables, and not follow
>>>> the usual convention
>>>>
>>>> #define UNI_MAX_UTF16 ...
>>>> #define UNI_HALF_BASE ...
>
> In the original code both variants are used ...
> (see http://clang.llvm.org/doxygen/ConvertUTF_8c_source.html)
>
>>>>
>>>> so it's more obvious to the reader of the code that this is not something
>>>> which can change at run time?
>
> Well, doesn't a "const" definition express this?

Not really, how I see it.  Because most of the macros are defined in upper 
case in the OpenVPN code vase.  So when you see upper case "variables" used, 
you can be quite sure it's a constant you're dealing with.  You don't have to 
lookup where that variable is defined to see if it's a constant or not.  But 
that's more a coding style thing.

>> Yes, you're right, they are actually constants.
>> The reason why I defined them as variables is because I wanted to keep
>> things together that belong together. I'm a bit unhappy with defining a
>> constant in a separate .h file that is used only once somewhere in the code.
>>
>> So what about defining them as constants, but at the same location in the
>> code as the variable definitions are now?
>>
>
> So I'm in favor of the "static const" - definition.
>
> Opinions?

I see and understands the arguments for using static const, and it surely have 
it's advantages.  However, the OpenVPN code base, which dates back over a 
decade, has used the #define approach.  This is probably one of the really few 
things where the code base is quite consistent.  I prefer that we try to be 
somewhat consistent with what most of the already existing code uses.

Even though the coding style can be quite inconsistent in parts of the code 
base, I prefer that we don't add more inconsistency.

If we at some point find the advantages with static const to really be 
superior to #define, then we should switch most of the code base to that 
style.  But that's a different discussion, as this just as well requires 
compatibility testing with preprocessors and compilers across several platforms.


-- 
kind regards,

David Sommerseth

