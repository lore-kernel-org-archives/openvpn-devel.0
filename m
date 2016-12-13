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
	<75c5efa8-346f-f2ca-57bd-4b3e38364a27@...1856...>
	<CAKuzo_hoavzZ6ZHTF8fTZLzax1=YK0VV6NJWmo5zh3zvTF7b+g@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <876c9d6e-d8b4-7f0f-5dfd-32b248ae216f@...1856...>
Date: Tue, 13 Dec 2016 21:35:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hoavzZ6ZHTF8fTZLzax1=YK0VV6NJWmo5zh3zvTF7b+g@...278...>
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

On 13-12-16 21:22, Selva Nair wrote:
>     > pos_bool=lead
> 
>     What does this do exactly?  The description "The position of boolean
>     operators in wrapped expressions" from --show-config doesn't ring a bell
>     for me.
> 
> This extends the pos_arith=lead (Knuth style) to booleans too so that we get
> 
> x = first_condition 
>       && second_condition
>       && third_condition
> 
> instead of leaving && at the tail of previous line... Not a big thing,
> but I thought it looks better.

Agreed.  I added pos_bool=Lead to the CodeStyle page, sp_bool=add was
already there.

Anything else holding back the reformatting branch?  I think we should
really move on with this, if we want to have the chance to do any
additional manual fixes after running uncrustify.

-Steffan

