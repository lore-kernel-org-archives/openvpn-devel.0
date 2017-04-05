References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
From: debbie10t <debbie10t@...277...>
Message-ID: <267890da-2186-dddb-d4c4-d6374da7e086@...277...>
Date: Wed, 5 Apr 2017 15:42:21 +0100
MIME-Version: 1.0
In-Reply-To: <063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
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



On 05/04/17 05:34, Simon Matter wrote:
>>> Hi,
>>>
>>> On Tue, Apr 04, 2017 at 08:29:49AM +0200, Simon Matter wrote:
>>>> Interesting to see that there is zero interest in this patch here.
>>>
>>> This is a misinterpretation.
>>>
>>
>> Hi Gert,
>>
>> Thanks for the explanation, I'll be patient then :)
>>
>> If it's preferred for the patch to keep it even simpler and compatible the
>> current configs, it could be broken down to something like this in init.c:
>
> I've attached v2 now which works without any config change:
>
> --reneg-sec n
>     Renegotiate data channel key after n seconds (default=3600).
>
>     Note that the effective value used here is a per session pseudo-
>     randomized 25% of n deducted from n.  With the default value  of
>     3600 this results in an effective per session value in the range
>     of 2701 ... 3600 seconds.
>


A different approach could be like so:

--reneg-sec 3600
--reneg-sec-1sttime-rand 1|0 (The name here for detail)

where --reneg-sec is essentially left alone
but --reneg-sec-1sttime-rand does the very first renegotiation at some
random time upto the --reneg-sec parameter.  After that --reneg-sec is
only in play.

It could even be done as --rand-reneg 1|0 and that could be set
to randomize *all* --reneg-* parameters upto the limit of the --reneg-*
in question and then hand control back to the --reneg-* in use after 
--rand-reneg has executed one time. (Although, I expect only --reneg-sec
has such a specific issue)

my2c



