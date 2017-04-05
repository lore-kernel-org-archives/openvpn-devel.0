References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
From: debbie10t <debbie10t@...277...>
Message-ID: <2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
Date: Wed, 5 Apr 2017 17:51:47 +0100
MIME-Version: 1.0
In-Reply-To: <11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
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



On 05/04/17 17:13, debbie10t wrote:
>
>
> On 05/04/17 16:58, David Sommerseth wrote:
>> On 05/04/17 17:53, David Sommerseth wrote:
>>> On 05/04/17 16:42, debbie10t wrote:
>>>>
>
>>>>
>>>> A different approach could be like so:
>>>>
>>>> --reneg-sec 3600
>>>> --reneg-sec-1sttime-rand 1|0 (The name here for detail)
>>>
>
>>
>> Oh, and in regards to the first-time/non-first-time .... if we decide
>> for such flexibility, that can be a flag after the randomness.
>>
>> For example  --reneg-sec 3600 12 first-only
>>
>> I am far from convinced if that should be configurable or not.  But
>> still, this approach is still far better than introducing new options.
>>
>
> Ok - accept that new options is not preferred but ..
>
> I like the idea of "first-only" addition (which is more or less as I
> proposed anyway) - And so, instead of having randomness in the reneg-sec
> itself, it is only randomness in the first run, after that the expected
> behaviour would be restored.  eg: --reneg-sec 3600
>
> To my mind (as a non programmer) this essentially boils down to
> setting the first --reneg-sec timer to something between 1 and
> 3600 (default). This affords a much larger window for the scattering
> of clients and further behaviour is "as expected now".
>
> and it looks very non-instrusive to me ..
>

To clarify:  --reneg-sec 3600 RAND

Where RAND indicates that the first-run timer should run from a random
integer from 1 upto the value of --reneg-sec.  RAND does not require a
user to specify an amount.

Regards



