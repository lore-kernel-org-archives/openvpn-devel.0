References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
	<bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
	<CAA1AbxLXh_AOuHFBt0Om=eDOLH-WHM_C6OnGgHLnO+iAYP7dEw@...278...>
	<CAKuzo_gH8UNruspCDOTeAa-wU9YsDB8nGGponvkCrVWnPR7SKw@...278...>
	<CAA1AbxJORM6ONqNNH7cA+Wy88_f1us=jvtTSXKzc4r5YbwtQcQ@...278...>
	<efc994a6-49bc-121b-3c47-503e6228d1ca@...2080...>
	<CAKuzo_hQyg2vQidGdkhOkn8jCSQKN3+uh-SL-uc8sfft_fFFeA@...278...>
	<a13638c6-23cf-520f-6b5b-d18da4a87d62@...1856...>
	<CAKuzo_i2ED_oND-HJw9jVrxOAJ5cOv2_056YjkuXPX5g9w8G5Q@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <75c5efa8-346f-f2ca-57bd-4b3e38364a27@...1856...>
Date: Tue, 13 Dec 2016 21:10:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i2ED_oND-HJw9jVrxOAJ5cOv2_056YjkuXPX5g9w8G5Q@...278...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 13-12-16 20:54, Selva Nair wrote:
> 
> On Tue, Dec 13, 2016 at 1:55 PM, Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>> wrote:
> 
>     >
>     >     On 09/12/16 22:27, Steffan Karger wrote:
>     >     >
>     >     > Sounds like we have a final config on the CodeStyle page now.  Are we
>     >     > ready to run it on all code now, and publish a reformat branch?
>     >     >
>     >
>     >     Agreed.  I can do this later this night.
>     >
>     > Wait a minute we may need cmt_cpp_to_c=true  -- I saw some C++ comments
>     > (added by uncrustify) in header files against #endif etc..
> 
>     Indeed, tested and added to the CodeStyle page.  Anyone up for creating
>     the reformatting branch?
> 
> 
> I did some test over the weekend. For what its worth just pushed the branch 
> to https://github.com/selvanair/openvpn/tree/uncrustify
> 
> This uses all options at the CodeStyle page plus
> sp_bool=add

This makes sense.

> sp_arith=add

I think we agreed on IRC to not touch arithmetic spacing, because
clarity really depends on the code.

> pos_bool=lead

What does this do exactly?  The description "The position of boolean
operators in wrapped expressions" from --show-config doesn't ring a bell
for me.

-Steffan

