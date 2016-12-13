MIME-Version: 1.0
In-Reply-To: <a13638c6-23cf-520f-6b5b-d18da4a87d62@...1856...>
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
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Dec 2016 14:54:19 -0500
Message-ID: <CAKuzo_i2ED_oND-HJw9jVrxOAJ5cOv2_056YjkuXPX5g9w8G5Q@...278...>
Content-Type: multipart/alternative; boundary=001a114d8ca4400aed05438f97f2
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114d8ca4400aed05438f97f2
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 13, 2016 at 1:55 PM, Steffan Karger <steffan@...1856...> wrote:

> >
> >     On 09/12/16 22:27, Steffan Karger wrote:
> >     >
> >     > Sounds like we have a final config on the CodeStyle page now.  Are
> we
> >     > ready to run it on all code now, and publish a reformat branch?
> >     >
> >
> >     Agreed.  I can do this later this night.
> >
> > Wait a minute we may need cmt_cpp_to_c=true  -- I saw some C++ comments
> > (added by uncrustify) in header files against #endif etc..
>
> Indeed, tested and added to the CodeStyle page.  Anyone up for creating
> the reformatting branch?


I did some test over the weekend. For what its worth just pushed the branch
to https://github.com/selvanair/openvpn/tree/uncrustify

This uses all options at the CodeStyle page plus
sp_bool=add
sp_arith=add
pos_bool=lead

which I found to have some "beautifying" effects :)

Notes:
One file (include/openvpn-plugins.h) caused uncrustify to segfault
so was let out (haven't yet got time to investigate).

More details of the command used is here:
https://gist.github.com/selvanair/bdd3f6151e72a428055d5d5e87cdbe2b

--001a114d8ca4400aed05438f97f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Dec 13, 2016 at 1:55 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);borde=
r-left-style:solid;padding-left:1ex"><span class=3D"gmail-">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 09/12/16 22:27, Steffan Karger wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Sounds like we have a final config on the Code=
Style page now.=C2=A0 Are we<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ready to run it on all code now, and publish a=
 reformat branch?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Agreed.=C2=A0 I can do this later this night.<br>
&gt;<br>
&gt; Wait a minute we may need cmt_cpp_to_c=3Dtrue=C2=A0 -- I saw some C++ =
comments<br>
&gt; (added by uncrustify) in header files against #endif etc..<br>
<br>
</span>Indeed, tested and added to the CodeStyle page.=C2=A0 Anyone up for =
creating<br>
the reformatting branch?</blockquote></div><br>I did some test over the wee=
kend. For what its worth just pushed the branch=C2=A0</div><div class=3D"gm=
ail_extra">to=C2=A0<a href=3D"https://github.com/selvanair/openvpn/tree/unc=
rustify">https://github.com/selvanair/openvpn/tree/uncrustify</a></div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">This uses all o=
ptions at the CodeStyle page plus</div><div class=3D"gmail_extra"><div clas=
s=3D"gmail_extra">sp_bool=3Dadd</div><div class=3D"gmail_extra">sp_arith=3D=
add</div><div class=3D"gmail_extra">pos_bool=3Dlead</div><div><br></div><di=
v>which I found to have some &quot;beautifying&quot; effects :)</div></div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Notes:</div=
><div class=3D"gmail_extra">One file (include/openvpn-plugins.h) caused unc=
rustify to segfault=C2=A0</div><div class=3D"gmail_extra">so was let out (h=
aven&#39;t yet got time to investigate).<br></div><div class=3D"gmail_extra=
"><br></div><div class=3D"gmail_extra">More details of the command used is =
here:=C2=A0</div><div class=3D"gmail_extra"><a href=3D"https://gist.github.=
com/selvanair/bdd3f6151e72a428055d5d5e87cdbe2b">https://gist.github.com/sel=
vanair/bdd3f6151e72a428055d5d5e87cdbe2b</a></div></div>

--001a114d8ca4400aed05438f97f2--

