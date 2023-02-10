Message-ID: <9bcf4906-6212-a298-1c14-f2c215fb6492@...2181...>
Date: Fri, 10 Feb 2023 23:07:32 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230210133159.1336-1-lstipakov@...277...>
 <a080d07f-c772-4dc4-de40-1807d2f74a6a@...2181...>
 <CAKuzo_hkFXh=m3VYvxKCzGePzMau92Af8cBmUy23vd8XcrBpmQ@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAKuzo_hkFXh=m3VYvxKCzGePzMau92Af8cBmUy23vd8XcrBpmQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Improve format specifier for socket
 handle in Windows
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
To: Selva Nair <selva.nair@...277...>, Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 10/02/2023 20:54, Selva Nair wrote:
> 
>     I also discussed this with Lev and, despite this being different from
>     what we do in the *nix world (where decimal representations make sense
>     for file descriptors), it seems to be the right hting to do on Windows
>     when using HANDLEs (shrug).
> 
> 
> Windows kernel handles are very much "like" fds though the handle table 
> also covers processes, threads,  semaphores etc. They are not pointers, 
> are generally smallish numbers or ~0 (== -1). But not as small as fds in 
> the Unix/Linux world --- mainly because several objects share the name 
> space and they have to be multiples of 4 for some arcane reason.
> 
> The problem here was not printing as "decimal" but as "unsigned 
> decimal". Use of the latter would have caused the same issue on Linux too.
> 
> Using hex is a compromise here as handles are defined as "unsigned ints" 
> of the same size as pointers. So PRIdPTR somehow looks improper though I 
> would have chosen that.

Given your explanation then it sounds like we should truly use PRIdPTR.
Wouldn't you agree Lev?

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

