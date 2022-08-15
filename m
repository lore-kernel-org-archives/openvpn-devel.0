Message-ID: <41d3a297-83f3-5b13-49f7-dd70b0d8daee@...2669...>
Date: Mon, 15 Aug 2022 12:14:23 +0200
MIME-Version: 1.0
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
 <YvoXzZNWGa49RJ6D@...1296...>
Content-Language: en-US
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <YvoXzZNWGa49RJ6D@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: platform: Retain
 CAP_NET_ADMIN when dropping privileges
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, berni@...376...

On 15/08/2022 11:54, Gert Doering wrote:
> HI,
> 
> On Thu, Aug 11, 2022 at 12:03:45PM +0200, Gert Doering wrote:
>> I have not tested this myself, but if I had, the test setup would have
>> been very similar to what Frank did (so, big thanks) - run a DCO
>> environment with "owner nobody", and see if things still work.
>>
>> I will add this to my DCO server test environment - run one of the
>> iroute-using instances with "nobody", so it is continuously tested.
> [..]
>> commit 2e359a088226ab1e5ee41fbab27d38d8a8d192ac
>> Author: Timo Rothenpieler
>> Date:   Sat May 14 12:37:17 2022 +0200
>>
>>       platform: Retain CAP_NET_ADMIN when dropping privileges
> 
> Unfortunately, it seems that our approach to "if SITNL is used, we hard
> require that setting CAP_NET_ADMIN succeeds" is too strong for the twisted
> ways that people use openvpn.

That's not how the patch operates.
It only hard-requires the capability retention is dco_enabled() returns 
true.
In all other cases, it will try to retain capabilities, but continue 
with a warning if it fails.

Making the dco_enabled() case a "try but continue" would be a matter of 
changing a 1 to a -1. But given that DCO can't really work then, I'm not 
sure if that's desirable.

