Message-ID: <1edc266d-09e7-40b6-5b73-6998a3548d45@...2181...>
Date: Mon, 26 Sep 2022 00:13:57 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220818084825.187755-1-a@...2181...>
 <20220918220618.31112-1-a@...2181...> <YyntXHQMcmih8aLE@...1296...>
 <32aae0d4-d225-a5c1-3ee2-2b03b184d324@...2181...>
 <CAKuzo_gyYS=_cfV9QYi+UbpZbRuKdpJJjuCq3jFdhmNna2=2rg@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAKuzo_gyYS=_cfV9QYi+UbpZbRuKdpJJjuCq3jFdhmNna2=2rg@...278...>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 20/09/2022 21:57, Selva Nair wrote:
> 
> 
> On Tue, Sep 20, 2022 at 3:26 PM Antonio Quartulli <a@...2181... 
> <mailto:a@...2181...>> wrote:
> 
>     Hi,
> 
>     On 20/09/2022 18:42, Gert Doering wrote:
>      > Hi,
>      >
>      > On Mon, Sep 19, 2022 at 12:06:18AM +0200, Antonio Quartulli wrote:
>      >> +    switch (session->opt->push_peer_info_detail)
>      >>       {
>      >> -        /* push version */
>      >> -        buf_printf(&out, "IV_VER=%s\n", PACKAGE_VERSION);
>      >> +        case 3:
>      >> +        {
>      > ...
>      >> +        }
>      >>
>      >> +        /* fall through */
>      >
>      > These {} brackets are not needed by C or our style guide.
> 
>     they are required when the first instruction after a case label is a
>     variable declaration. So this is needed for case 3, but could be
>     avoided
>     for the other 2.
> 
> 
> IMO, we should have a policy of avoiding variable declarations within 
> case: clauses.
> 
> Whether its the first line after the case: label or not, if the scope is 
> not limited using {}, it leads to possible jumping over initialization. 
> Its so easy to overlook that. Unfortunately C (unlike C++) complains 
> loudly only if the declaration is next to the label.  One could always 
> use {},  but that makes code hard to read. I think its much better to 
> require that all locals used within a switch block must be defined 
> before all case: labels.

I agree with that. To be a bit more strict: I always preferred declaring 
all variables at the beginning of the function.

You may have jumps in a function too (having the same issue as the 
switch/case) or you may also hide another variable (i.e. function 
argument) without noticing.

However, this is a broader topic that should be discussed during a 
community meeting IMHO.

For now I will just remove the brackets from case 2, where they are not 
needed.

Cheers,

> 
> Selva
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli

