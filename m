MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <20170622133102.GC31123@...2287...>
References: <62da7142-d087-7d89-5974-7533b1be0713@...1856...>
	<20170621211043.6490-1-steffan@...1856...>
	<20170622133102.GC31123@...2287...>
From: Emmanuel Deloget <logout@...260...>
Date: Thu, 22 Jun 2017 17:33:44 +0200
Message-ID: <CAKh=nwF7UfzoDaUWM1RNfx8tULmMVyP_wn69ZGORztx6qMYWWQ@...278...>
Content-Type: multipart/alternative; boundary="f403043efc04d3b6e705528e35d0"
Subject: Re: [Openvpn-devel] [PATCH v2] Move adjust_power_of_2() to integer.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

--f403043efc04d3b6e705528e35d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio, Steffan,

On Thu, Jun 22, 2017 at 3:31 PM, Antonio Quartulli <a@...2181...> wrote:

> Thanks for sending v2 Steffan,
>
> On Wed, Jun 21, 2017 at 11:10:43PM +0200, Steffan Karger wrote:
> > From: Steffan Karger <steffan.karger@...1435...>
> >
> > misc.c is a mess of incoherent functions, and is therefore included by
> > virtually all our source files.  That makes testing harder than it shou=
ld
> > be.  As a first step of cleaning up misc.c, move adjust_power_of_2() to
> > integer.h, which is a more suitable place for a function like this.
> >
> > This allows us to remove the duplicate implementation from test_argv.c.
> >
> > Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>
>
> This change is quite simple and passes basic tests.
> Thanks also for adding explicit #include statements.
>
> Acked-by: Antonio Quartulli <antonio@...515...>
>
>
=E2=80=8BSince the code is moved, would it be interesting to use a less gre=
edy
algorithm to do the same thing? I know the function is not used very often,
so it does not look like it's necessary (it's a suggestion, not a
commentary on your patch Steffan :))

For example, this code:

size_t
adjust_power_of_2(size_t v)
{
if (!v)
return 1;
v--;
v |=3D v >> 1;
v |=3D v >> 2;
v |=3D v >> 4;
v |=3D v >> 8;
v |=3D v >> 16;
if (sizeof(size_t) =3D=3D 8)
v |=3D v >> 32;
v++;

return v;
}

does the exact same work on a 64 size_t but will be far faster than the
loop-based one on many situation (the sizeof() test should be optimized
away if it's never true, so the code will work even with a 32 bit size_t).

Why it works:
* if (v - 1) has 0 bits set, then v =3D 1 and the function will return 1 ((0
| 0 | ... | 0) + 1)
* if (v - 1) has at least one bit set (let's say it's bit n), then the
first iteration will set bit (n-1). The next iteration will set bits (n-2)
and (n-3). We goes on for a few steps. Before the last iteration, v has
bits (n...(n-32)) set (with sizeof(size_t) =3D=3D 8), so the very last
operation fills the remaining bits and v has bits (n...0) set. Adding one
to this value will yield the desired result.

Again, the function is not used extensively, so you can ignore this
suggestion as it will not speed up openvpn at all :)


> Cheers,
> =E2=80=8B=E2=80=8B
>

=E2=80=8BBR,

-- Emmanuel Deloget=E2=80=8B

--f403043efc04d3b6e705528e35d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:&quot;co=
urier new&quot;,monospace">Hi Antonio, Steffan,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Jun 22, 2017 at 3:31 PM, Antoni=
o Quartulli <span dir=3D"ltr">&lt;<a href=3D"mailto:a@...2181..." target=3D=
"_blank">a@...2181...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Thanks for sending v2 Steffan,<br>
<span class=3D"gmail-"><br>
On Wed, Jun 21, 2017 at 11:10:43PM +0200, Steffan Karger wrote:<br>
&gt; From: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...1435...">=
steffan.karger@...1435...</a>&gt;<br>
&gt;<br>
&gt; misc.c is a mess of incoherent functions, and is therefore included by=
<br>
&gt; virtually all our source files.=C2=A0 That makes testing harder than i=
t should<br>
&gt; be.=C2=A0 As a first step of cleaning up misc.c, move adjust_power_of_=
2() to<br>
&gt; integer.h, which is a more suitable place for a function like this.<br>
&gt;<br>
&gt; This allows us to remove the duplicate implementation from test_argv.c=
.<br>
&gt;<br>
&gt; Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...493...=
1435...">steffan.karger@...1435...</a>&gt;<br>
<br>
<br>
</span>This change is quite simple and passes basic tests.<br>
Thanks also for adding explicit #include statements.<br>
<br>
Acked-by: Antonio Quartulli &lt;<a href=3D"mailto:antonio@...515...">antoni=
o@...515...</a>&gt;<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-family:&quot;courier new&quot;,monospace">=E2=80=8BSince the code is m=
oved, would it be interesting to use a less greedy algorithm to do the same=
 thing? I know the function is not used very often, so it does not look lik=
e it&#39;s necessary (it&#39;s a suggestion, not a commentary on your patch=
 Steffan :))</div><div class=3D"gmail_default" style=3D"font-family:&quot;c=
ourier new&quot;,monospace"><br></div><div class=3D"gmail_default" style=3D=
"font-family:&quot;courier new&quot;,monospace">For example, this code:</di=
v><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;=
,monospace"><br></div><div class=3D"gmail_default"><div class=3D"gmail_defa=
ult"><font face=3D"courier new, monospace">size_t</font></div><div class=3D=
"gmail_default"><font face=3D"courier new, monospace">adjust_power_of_2(siz=
e_t v)</font></div><div class=3D"gmail_default"><font face=3D"courier new, =
monospace">{</font></div><div class=3D"gmail_default"><font face=3D"courier=
 new, monospace"><span class=3D"gmail-Apple-tab-span" style=3D"white-space:=
pre">	</span>if (!v)</font></div><div class=3D"gmail_default"><font face=3D=
"courier new, monospace"><span class=3D"gmail-Apple-tab-span" style=3D"whit=
e-space:pre">		</span>return 1;</font></div><div class=3D"gmail_default"><f=
ont face=3D"courier new, monospace"><span class=3D"gmail-Apple-tab-span" st=
yle=3D"white-space:pre">	</span>v--;</font></div><div class=3D"gmail_defaul=
t"><font face=3D"courier new, monospace"><span class=3D"gmail-Apple-tab-spa=
n" style=3D"white-space:pre">	</span>v |=3D v &gt;&gt; 1;</font></div><div =
class=3D"gmail_default"><font face=3D"courier new, monospace"><span class=
=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>v |=3D v &gt;&g=
t; 2;</font></div><div class=3D"gmail_default"><font face=3D"courier new, m=
onospace"><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	<=
/span>v |=3D v &gt;&gt; 4;</font></div><div class=3D"gmail_default"><font f=
ace=3D"courier new, monospace"><span class=3D"gmail-Apple-tab-span" style=
=3D"white-space:pre">	</span>v |=3D v &gt;&gt; 8;</font></div><div class=3D=
"gmail_default"><font face=3D"courier new, monospace"><span class=3D"gmail-=
Apple-tab-span" style=3D"white-space:pre">	</span>v |=3D v &gt;&gt; 16;</fo=
nt></div><div class=3D"gmail_default"><span style=3D"font-family:&quot;cour=
ier new&quot;,monospace;white-space:pre">	if (sizeof(size_t) =3D=3D 8)</spa=
n><font face=3D"courier new, monospace"><br></font></div><div class=3D"gmai=
l_default"><font face=3D"courier new, monospace"><span class=3D"gmail-Apple=
-tab-span" style=3D"white-space:pre">	</span></font><span style=3D"font-fam=
ily:&quot;courier new&quot;,monospace;white-space:pre">	</span><span style=
=3D"font-family:&quot;courier new&quot;,monospace">v |=3D v &gt;&gt; 32;</s=
pan></div><div class=3D"gmail_default"><font face=3D"courier new, monospace=
"><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>v+=
+;</font></div><div class=3D"gmail_default"><font face=3D"courier new, mono=
space"><br></font></div><div class=3D"gmail_default"><font face=3D"courier =
new, monospace"><span class=3D"gmail-Apple-tab-span" style=3D"white-space:p=
re">	</span>return v;</font></div><div class=3D"gmail_default"><font face=
=3D"courier new, monospace">}</font></div><div style=3D"font-family:&quot;c=
ourier new&quot;,monospace"><br></div><div style=3D"font-family:&quot;couri=
er new&quot;,monospace">does the exact same work on a 64 size_t but will be=
 far faster than the loop-based one on many situation (the sizeof() test sh=
ould be optimized away if it&#39;s never true, so the code will work even w=
ith a 32 bit size_t).=C2=A0</div><div style=3D"font-family:&quot;courier ne=
w&quot;,monospace"><br></div><div style=3D"font-family:&quot;courier new&qu=
ot;,monospace">Why it works:=C2=A0</div><div style=3D"font-family:&quot;cou=
rier new&quot;,monospace">* if (v - 1) has 0 bits set, then v =3D 1 and the=
 function will return 1 ((0 | 0 | ... | 0) + 1)</div><div style=3D"font-fam=
ily:&quot;courier new&quot;,monospace">* if (v - 1) has at least one bit se=
t (let&#39;s say it&#39;s bit n), then the first iteration will set bit (n-=
1). The next iteration will set bits (n-2) and (n-3). We goes on for a few =
steps. Before the last iteration, v has bits (n...(n-32)) set (with sizeof(=
size_t) =3D=3D 8), so the very last operation fills the remaining bits and =
v has bits (n...0) set. Adding one to this value will yield the desired res=
ult.=C2=A0</div><div style=3D"font-family:&quot;courier new&quot;,monospace=
"><br></div><div style=3D"font-family:&quot;courier new&quot;,monospace">Ag=
ain, the function is not used extensively, so you can ignore this suggestio=
n as it will not speed up openvpn at all :)</div></div></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
Cheers,<div class=3D"gmail_default" style=3D"font-family:&quot;courier new&=
quot;,monospace;display:inline">=E2=80=8B=E2=80=8B</div></blockquote><div><=
br></div><div class=3D"gmail_default" style=3D"font-family:&quot;courier ne=
w&quot;,monospace">=E2=80=8BBR,=C2=A0</div><div class=3D"gmail_default" sty=
le=3D"font-family:&quot;courier new&quot;,monospace"><br></div><div class=
=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospace">=
-- Emmanuel Deloget=E2=80=8B</div></div></div></div>

--f403043efc04d3b6e705528e35d0--

