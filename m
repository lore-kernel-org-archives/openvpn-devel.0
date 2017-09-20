References: <13a39edc-f624-6b35-fb5e-e78516805bae@...277...>
 <788CC994-AFDA-40E2-9A07-851D0ED407BE@...1286...>
 <ab2e90c9-0e4b-532c-759f-1e14b4a26a90@...277...>
 <599C2298-FED1-4B44-B8DD-B2EB7ECE4A38@...1286...>
 <9f2db472d51e79fdbfa1ec4b65d8bd17@...1286...>
 <5cddd371c185b12e21395d56f27969ac@...1286...>
From: fragmentux <fragmentux@...277...>
Message-ID: <0f853bfc-e7fe-41f7-8e8b-a7e38f9fe925@...277...>
Date: Wed, 20 Sep 2017 11:39:01 +0100
MIME-Version: 1.0
In-Reply-To: <5cddd371c185b12e21395d56f27969ac@...1286...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [openvpn-devel] Forum upgrade problems
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
To: Eric F Crist <ecrist@...1286...>
Cc: openvpn-devel@lists.sourceforge.net

Another suggestion:
Can you please change [oconf=x] to simply [oconf]
There is enough remaining information to be able to determine what
the config is used for .. and if there isn't then a simple question
can be asked to clarify.

Otherwise, people just use it blindly and assume it does not work.
eg: https://forums.openvpn.net/viewtopic.php?f=4&t=24913


On 19/09/17 15:39, Eric F Crist wrote:
> Switching the forum back from our custom style to the prosilver default 
> resolves at least the [code] BBCode.  I'll look at the differences tonight.
> 
> ---
> Eric F Crist
> 
> 
> On 2017-09-19 09:34, Eric F Crist wrote:
>> I've uploaded the [oconf] BBcode to github: 
>> https://github.com/ecrist/oconf
>>
>> There may be style/template issues on the forum, and I will look into
>> those based on your other messages.
>>
>> ---
>> Eric F Crist
>>
>>
>> On 2017-09-18 16:29, Eric Crist wrote:
>>> The oconf stuff is something I can share. I’ll post to github this
>>> afternoon. This white space problem appears to be a known
>>> “feature”.
>>>
>>> Eric Crist
>>>
>>> On Sep 18, 2017, at 4:26 PM, fragmentux <fragmentux@...277...> wrote:
>>>
>>>> Any update ?
>>>>
>>>> here is a good example of the problem:
>>>> https://forums.openvpn.net/viewtopic.php?f=6&t=24907
>>>>
>>>> On 14/09/17 17:29, Eric Crist wrote:
>>>>
>>>>> I will look into these. I'm surprised [oconf] is broken, since I
>>>>> wrote that myself and it is not a normal part of phpBB.
>>>>
>>>>> Eric Crist
>>>> On Sep 14, 2017, at 6:36 AM, fragmentux <fragmentux@...277...>
>>>> wrote:
>>>
>>>>>
>>>
>>>>> The forum upgrade has broken the following BBCodes.
>>>
>>>>>
>>>
>>>>> 1. [quote="Name"]
>>>
>>>>> "Name" is no longer shown.
>>>
>>>>>
>>>
>>>>> 2. [code]
>>>
>>>>> Appears to strip out all newline / CRLF.
>>>
>>>
>>> ------------------------------------------------------------------------------ 
>>>
>>> Check out the vibrant tech community on one of the world's most
>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>>
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>> ------------------------------------------------------------------------------ 
>>
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

