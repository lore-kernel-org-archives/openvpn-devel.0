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
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
From: debbie10t <debbie10t@...277...>
Message-ID: <86ef0241-5144-206a-4691-6713434fdaa4@...277...>
Date: Wed, 5 Apr 2017 19:00:54 +0100
MIME-Version: 1.0
In-Reply-To: <f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
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
To: Arne Schwabe <arne@...1227...>, Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net



On 05/04/17 18:13, Arne Schwabe wrote:
>
>>>
>>> Where RAND indicates that the first-run timer should run from a random
>>> integer from 1 upto the value of --reneg-sec.  RAND does not require a
>>> user to specify an amount.
>>
>> But then, why not just do it always and forget about the additional option?

I actually agree, why not simply enable RAND as above *always*

>>
>
> Optional option does not mean that it is disabled by default. If you
> don't the randomness you would need to do:
>
> reneg-sec 3600 3600
>
> the optional argument also allows it to fine tune it to your needs.

As the reason for --reneg-sec is to specify how long a key should exist,
I don't see any further need to make the "random window" be specifically
configurable .. The reneg-sec period will remain as specified (def 3600)
except for the first run, where --reneg-sec is started from a random 
time between now and then.  There after returning to "normal" with full 
randomisation of all connected clients --reneg-sec being spread over the 
*entire* period of --reneg-sec nn and not some unnecessary window.

Regards

