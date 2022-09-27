Message-ID: <94db9dc9-f042-6819-1cba-39927744229c@...2181...>
Date: Tue, 27 Sep 2022 12:10:40 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220920114255.23639-1-gert@...1296...>
 <20220920132351.27718-1-gert@...1296...>
 <YzLFv8eO9ll5PkIc@...2685...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YzLFv8eO9ll5PkIc@...2685...>
Subject: Re: [Openvpn-devel] [PATCH v3] introduce V= level to manage
 t_client.sh output verbosity
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
To: Frank Lichtenheld <frank@...2641...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 27/09/2022 11:43, Frank Lichtenheld wrote:
> On Tue, Sep 20, 2022 at 03:23:51PM +0200, Gert Doering wrote:
>> If t_client.sh is run interactively, more verbose output is useful
>> to quickly see what it is doing.  If run from a CI environment, going
>> through lots of output for successful tests just to find the one that
>> failed is non-useful.
>>
>> Introduce V=<n> environment variable to control output verbosity
>>
>>   V=0 - do not print any per-test output at all, just overall summary
>>   V=1 - print single header line for each successful test
>>         print full output for failing tests
>>   V=99 - print full output, always, as before
>>
>> default is V=1 now
>>
> 
> Seems to do what it is supposed to do.
> 
> Acked-By: Frank Lichtenheld <frank@...2641...>

I also second this verdict:

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

