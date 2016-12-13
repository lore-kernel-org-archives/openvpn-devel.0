MIME-Version: 1.0
In-Reply-To: <75c5efa8-346f-f2ca-57bd-4b3e38364a27@...1856...>
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
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Dec 2016 15:22:05 -0500
Message-ID: <CAKuzo_hoavzZ6ZHTF8fTZLzax1=YK0VV6NJWmo5zh3zvTF7b+g@...278...>
Content-Type: multipart/alternative; boundary=94eb2c06cdea7e483e05438ffaf2
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

--94eb2c06cdea7e483e05438ffaf2
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 13, 2016 at 3:10 PM, Steffan Karger <steffan@...1856...> wrote:

> > sp_bool=add
>
> This makes sense



> > sp_arith=add
>
> I think we agreed on IRC to not touch arithmetic spacing, because
> clarity really depends on the code.
>

Forgot about that discussion. Seeing lines like
|FORMAT_MESSAGE_ALLOCATE_BUFFER, looked like a good idea to add that to get
a space after '|'. But it does changes 'buf+7' to 'buf + 7' etc. which is
not ideal. OK, let's leave that out.


> > pos_bool=lead
>
> What does this do exactly?  The description "The position of boolean
> operators in wrapped expressions" from --show-config doesn't ring a bell
> for me.
>

This extends the pos_arith=lead (Knuth style) to booleans too so that we get

x = first_condition
      && second_condition
      && third_condition

instead of leaving && at the tail of previous line... Not a big thing, but
I thought it looks better.

Selva

--94eb2c06cdea7e483e05438ffaf2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Dec 13, 2016 at 3:10 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:</div></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,20=
4);border-left-style:solid;padding-left:1ex">&gt; sp_bool=3Dadd<br>=C2=A0<b=
r>This makes sense</blockquote><div>=C2=A0</div><div class=3D"gmail_extra">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex"><div id=3D"gmail-:6nu" class=3D=
"gmail-a3s gmail-aXjCH gmail-m158f9cf37a1486c0">
&gt; sp_arith=3Dadd<br>
<br>
I think we agreed on IRC to not touch arithmetic spacing, because<br>
clarity really depends on the code.<br></div></blockquote><div><br></div><d=
iv>Forgot about that discussion. Seeing lines like |FORMAT_MESSAGE_ALLOCATE=
_BUFFER, looked like a good idea to add that to get a space after &#39;|&#3=
9;. But it does changes &#39;buf+7&#39; to &#39;buf + 7&#39; etc. which is =
not ideal. OK, let&#39;s leave that out.</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1e=
x"><div id=3D"gmail-:6nu" class=3D"gmail-a3s gmail-aXjCH gmail-m158f9cf37a1=
486c0">
<br>
&gt; pos_bool=3Dlead<br>
<br>
What does this do exactly?=C2=A0 The description &quot;The position of bool=
ean<br>
operators in wrapped expressions&quot; from --show-config doesn&#39;t ring =
a bell<br>
for me.</div></blockquote></div><br>This extends the pos_arith=3Dlead (Knut=
h style) to booleans too so that we get</div><div class=3D"gmail_extra"><br=
></div><div class=3D"gmail_extra">x =3D first_condition=C2=A0</div><div cla=
ss=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 &amp;&amp; second_condition</div><d=
iv class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 &amp;&amp; third_condition</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">instead =
of leaving &amp;&amp; at the tail of previous line... Not a big thing, but =
I thought it looks better.</div><div class=3D"gmail_extra"><br></div><div c=
lass=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br></div></div>

--94eb2c06cdea7e483e05438ffaf2--

