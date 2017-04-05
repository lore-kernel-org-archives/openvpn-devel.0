References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
	<93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
	<de982e46-7014-13a0-44e9-5d888233e299@...277...>
From: debbie10t <debbie10t@...277...>
Message-ID: <fa12f155-3f85-5d2a-4350-7c7528bc22dc@...277...>
Date: Wed, 5 Apr 2017 23:01:41 +0100
MIME-Version: 1.0
In-Reply-To: <de982e46-7014-13a0-44e9-5d888233e299@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 05/04/17 22:57, debbie10t wrote:
> Hi,
>
> On 05/04/17 22:39, David Sommerseth wrote:
>> On 05/04/17 23:13, debbie10t wrote:
>>> I don't believe there is any need to specify "max" because that would be
>>> --reneg-sec as is. Otherwise specify a smaller or larger --reneg-sec
>>
>> I think you, probably without being aware of it, are agreeing to what
>> the current proposal is:
>>
>>   --reneg-sec max
>>     A renegotiation happens within 'max' seconds, but with a 10%-ish
>>     randomness
>>
>>   --reneg-sec min max
>>     A renegotiation happens within 'min' and 'max' seconds, fully
>>     controllable
>>
>> So using --reneg-sec 3600 3600, effectively removes the randomness.
>
> I understand the proposed methods ..
>
> Of the two above, I would be inclined toward option 2.
> eg: (for me) --reneg-sec 0 3600 is ideal.
>
> Thanks :)

With the proviso of "First-run only" ..

