Message-ID: <e7ad101d-4a46-72b2-7eec-5be5e8d636f4@...2669...>
Date: Mon, 15 Aug 2022 12:40:55 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
 <YvoXzZNWGa49RJ6D@...1296...>
 <41d3a297-83f3-5b13-49f7-dd70b0d8daee@...2669...>
 <YvogFJdhB+8n3qrK@...1296...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <YvogFJdhB+8n3qrK@...1296...>
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



On 15/08/2022 12:29, Gert Doering wrote:
> Hi,
> 
> On Mon, Aug 15, 2022 at 12:14:23PM +0200, Timo Rothenpieler wrote:
>>> Unfortunately, it seems that our approach to "if SITNL is used, we hard
>>> require that setting CAP_NET_ADMIN succeeds" is too strong for the twisted
>>> ways that people use openvpn.
>>
>> That's not how the patch operates.
>> It only hard-requires the capability retention is dco_enabled() returns
>> true.
>> In all other cases, it will try to retain capabilities, but continue
>> with a warning if it fails.
> 
> Yes, but we do have DCO here, setting CAP_NET_ADMIN fails, and we abort,
> instead of having a working client connect.
> 
>> Making the dco_enabled() case a "try but continue" would be a matter of
>> changing a 1 to a -1. But given that DCO can't really work then, I'm not
>> sure if that's desirable.
> 
> *DCO* can work fine, from the looks of that bug report (because all
> the DCO open happens before capability drop on a --client config).
> 
> "Calling ifconfig and installing routes" cannot, but this is exactly what
> we are not doing if --ifconfig-noexec + --route-noexec are set.
> 
> Please look closely at the log in the bug report, and keep in mind
> that NM will do all the "SITNL" stuff for the user in that scenaro,
> not OpenVPN itself.
> 
> gert

There's basically two options then:

Remove the dco_enabled() check entirely, and purely check for SITNL, but 
always only warn if it fails and carry on, hoping it works fine.

Add checks for ifconfig-noexec + route-noexec being set, and either only 
warn in that case, or don't even try to retain capabilities, since 
they're not needed either way. I'd prefer the later, since fewer 
capabilities is generally better.

The later of the two options seems nicer, will have a look at 
implementing them. Shouldn't be that hard, given the config is already 
there.
I don't have a NM setup to test that on though.

