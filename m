Message-ID: <937cf6e4-375e-549a-99f3-a54d93d87b77@...2181...>
Date: Mon, 26 Sep 2022 08:46:50 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220818084825.187755-1-a@...2181...>
 <20220918220618.31112-1-a@...2181...> <YyntXHQMcmih8aLE@...1296...>
 <32aae0d4-d225-a5c1-3ee2-2b03b184d324@...2181...>
 <CAKuzo_gyYS=_cfV9QYi+UbpZbRuKdpJJjuCq3jFdhmNna2=2rg@...278...>
 <1edc266d-09e7-40b6-5b73-6998a3548d45@...2181...>
 <YzFJCxQ1pDGuMG+g@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YzFJCxQ1pDGuMG+g@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4] push-peer-info: rearrange function
 generating peer info
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
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 26/09/2022 08:39, Gert Doering wrote:
> Hi,
> 
> On Mon, Sep 26, 2022 at 12:13:57AM +0200, Antonio Quartulli wrote:
>> For now I will just remove the brackets from case 2, where they are not
>> needed.
> 
> TBH, I think we should just not use switch/case here.
> 
> It might seem elegant, to do this with a fall-through switch/case, but
> it turns out to be not very elegant due to the restrictions on local
> variables.   Also, if someone ends up setting push-peer-info to 4,
> they will get "nothing at all" now, instead of "everything".

This is set programmatically, not by the user. So right now you can't 
set a value higher than 3.

Actually it may make sense to switch to an enum instead of a plain int, 
so that the compiler will warn us if the switch/case is not handling all 
the values (an 'if' won't do that).

> 
> To keep to your idea of doing this in blocks "3", "2+3", "1+2+3" one
> could do
> 
>     int detail = session->opt->push_peer_info_detail;
>     if (detail >= 3)
>     {
>         ...
>     }
>     if (detail > 2)
>     {
>         ...
>     }
>     if (detail > 1)
>     {
>         ...
>     }
> 
> so it has less twisted conditions.

Since >3 is not possible, this is exactly the same as a switch/case, 
(just reimplemented with ifs).

I am not sure why this switch/case is different from the others?
We also have {} in other case blocks for the very same reason.

If we feel having the {} is ugly, we should agree on what to do 
globally, no? Not just change this hunk.

Cheers,

-- 
Antonio Quartulli

