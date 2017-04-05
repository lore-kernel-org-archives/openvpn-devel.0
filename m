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
From: debbie10t <debbie10t@...277...>
Message-ID: <31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
Date: Wed, 5 Apr 2017 22:13:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170405204236.GM93896@...1296...>
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net



On 05/04/17 21:42, Gert Doering wrote:
> Hi,
>
> On Wed, Apr 05, 2017 at 07:00:54PM +0100, debbie10t wrote:
>>> Optional option does not mean that it is disabled by default. If you
>>> don't the randomness you would need to do:
>>>
>>> reneg-sec 3600 3600
>>>
>>> the optional argument also allows it to fine tune it to your needs.
>>
>> As the reason for --reneg-sec is to specify how long a key should exist,
>> I don't see any further need to make the "random window" be specifically
>> configurable .. The reneg-sec period will remain as specified (def 3600)
>> except for the first run, where --reneg-sec is started from a random
>> time between now and then.  There after returning to "normal" with full
>> randomisation of all connected clients --reneg-sec being spread over the
>> *entire* period of --reneg-sec nn and not some unnecessary window.
>
> Setups with 2FA will have to re-enter auth credentials on reneg.  Having
> OpenVPN all of a sudden default to "it could be asking 5 minutes after
> connection for the credentials again" is massive annoyance - and brings
> no real benefit anyway.
>
> It makes sense to jitter reneg-sec somewhat (like, 10%-ish), but changing
> behaviour too much is not bringing much benefit - you don't need to
> spread the reneg over the whole period anyway, as different clients
> connect and disconnect at different times anyway.  Just if all of them
> connect at the same time, the identically-timed renegs are a problem.
>
>
> I like Arne's and David's suggestion - the existing option "as is" will
> enable X% jitter, while a second parameter can specify a more specific
> range.  Following Arne's argument about users and percent math, it might
> indeed be better to have "min max" here ("3500 3600"), because that is
> really easy to understand and explain.

I don't believe there is any need to specify "max" because that would be 
--reneg-sec as is. Otherwise specify a smaller or larger --reneg-sec

I accept that "min" or "window" is viable (provided it is first-run)

But, overall, I think having to login twice in succession at a 
surprisingly short random time *just the once* and then followed by 
regular intervals is not such a huge concern, if it is suitably 
documented.  So I vote for my version.

Of course, it is up to you guys and I will leave it at that.

Thanks

