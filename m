Message-ID: <8cbced43-54e2-3f0d-c607-dea2f3def3ae@...1227...>
Date: Fri, 11 Aug 2023 17:35:03 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20230728124005.177414-1-frank@...2641...>
 <ZNZP1EQIjFmgTqX1@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <ZNZP1EQIjFmgTqX1@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] GHA: new workflow to submit scan to
 Coverity Scan service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Am 11.08.23 um 17:12 schrieb Gert Doering:
> Hi,
> 
> generally good, but...
> 
> On Fri, Jul 28, 2023 at 02:40:05PM +0200, Frank Lichtenheld wrote:
>> index 00000000..0620f638
>> --- /dev/null
>> +++ b/.github/workflows/coverity-scan.yml
>> @@ -0,0 +1,45 @@
>> +name: coverity-scan
>> +on:
>> +  schedule:
>> +    - cron: '0 20 * * *' # Daily at 20:00 UTC
>> +  workflow_dispatch:
> 
> ... not sure this is the best way to approach the run limit, as
> we can have many days with no commits at all, so we'd waste credits.
> 
> Maybe cache the last commit ID and only run coverity if this has
> changed?  Or run it "on commit", but cache the current day, and only
> run it again on the next commit that's not on the same day?
> 
> (My typical workflow is "you folks queue up patches, and then I find
> half a day of free time, and go merge&push as many as I can make sense of")

You can get that behaviour but it is tricky. You have to resort tricks 
like this: https://github.com/orgs/community/discussions/26519 of saving 
something to a cache and then reading the cache on the next run and 
check if something changed. We can probably implement like that and then 
trigger on push too?

Arne


