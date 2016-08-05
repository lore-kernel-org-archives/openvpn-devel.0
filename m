MIME-Version: 1.0
In-Reply-To: <CAA1AbxJ8G5ztG1mgdkbvg7S9yqYuTwtq76SCkksUkrpVi8SjxA@...278...>
References: <1470368394-2722-1-git-send-email-selva.nair@...277...>
	<20160805061418.GO78279@...1296...>
	<CAA1AbxJ8G5ztG1mgdkbvg7S9yqYuTwtq76SCkksUkrpVi8SjxA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 5 Aug 2016 09:09:07 -0400
Message-ID: <CAKuzo_gsjEjhCZ7eczDtGb2XOrjXwKh4LroL4ULZrc96Jy8Lhg@...278...>
Content-Type: multipart/alternative; boundary=001a113bc7cabdf6f5053952c6b7
Subject: Re: [Openvpn-devel] [PATCH] Avoid format specifier %zu for Windows
	compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a113bc7cabdf6f5053952c6b7
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 5, 2016 at 3:32 AM, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On Fri, Aug 5, 2016 at 8:14 AM, Gert Doering <gert@...1296...> wrote:
> > On Thu, Aug 04, 2016 at 11:39:54PM -0400, Selva Nair wrote:
> >> -  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %zu
> bytes",
> >> -      __func__, crypto_overhead);
> >> +  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %d
> bytes",
> >> +      __func__, (int) crypto_overhead);
> >
> > Just for clarification: how does this break windows?  mingw builds, or
> > msvc builds?  Will it print "nothing" ("zu bytes") or wrong values?
>

mingw (my version is gcc 4.6.3)  prints zu bytes. I think this could be
also fixed by defining  __USE_MINGW_ANSI_STDIO=1

>
> > I had the suspicion that %zu wasn't as portable as Steffan hoped (and I
> > seem to remember we've been there before :) ) but was too lazy to
> > actually go out and research it.
> >
> > (Going to apply later today, so "ACK!", just curious)
>
> MSVC 2015 claims to support C99 now (took them 16 years!), and it
> should at least support %zu (which is part of C99).  Shouldn't we just
> move (at least the master branch) to C99?  Or are there good reasons
> to keep punishing ourselves with having to support C89?
>

I am totally in support of deprecating arcane MSVC (pre 2015?) support.  MS
way of printing size_t has been to use  "%Iu" (with an upper case i, not
'ell'), which indicates the required run-time support is there. But I am
not sure whether MSVC 2015 translates zu to Iu or only works on platforms
with a new runtime library.

Selva

--001a113bc7cabdf6f5053952c6b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Aug 5, 2016 at 3:32 AM, Steffan Karger <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>H=
i,<br>
<span><br>
On Fri, Aug 5, 2016 at 8:14 AM, Gert Doering &lt;<a href=3D"mailto:gert@...493...=
1296..." target=3D"_blank">gert@...1296...</a>&gt; wrote:<br>
&gt; On Thu, Aug 04, 2016 at 11:39:54PM -0400, Selva Nair wrote:<br>
&gt;&gt; -=C2=A0 msg(D_MTU_DEBUG, &quot;%s: Adjusting frame parameters for =
crypto by %zu bytes&quot;,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 __func__, crypto_overhead);<br>
&gt;&gt; +=C2=A0 msg(D_MTU_DEBUG, &quot;%s: Adjusting frame parameters for =
crypto by %d bytes&quot;,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 __func__, (int) crypto_overhead);<br>
&gt;<br>
&gt; Just for clarification: how does this break windows?=C2=A0 mingw build=
s, or<br>
&gt; msvc builds?=C2=A0 Will it print &quot;nothing&quot; (&quot;zu bytes&q=
uot;) or wrong values?<br>
</span></div></blockquote><div><br></div><div>mingw (my version is gcc 4.6.=
3)=C2=A0 prints zu bytes. I think this could be also fixed by defining=C2=
=A0 __USE_MINGW_ANSI_STDIO=3D1 <br><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div><span>&gt;<br>
&gt; I had the suspicion that %zu wasn&#39;t as portable as Steffan hoped (=
and I<br>
&gt; seem to remember we&#39;ve been there before :) ) but was too lazy to<=
br>
&gt; actually go out and research it.<br>
&gt;<br>
&gt; (Going to apply later today, so &quot;ACK!&quot;, just curious)<br>
<br>
</span>MSVC 2015 claims to support C99 now (took them 16 years!), and it<br>
should at least support %zu (which is part of C99).=C2=A0 Shouldn&#39;t we =
just<br>
move (at least the master branch) to C99?=C2=A0 Or are there good reasons<b=
r>
to keep punishing ourselves with having to support C89?</div></blockquote><=
/div><br></div><div class=3D"gmail_extra">I am totally in support of deprec=
ating arcane MSVC (pre 2015?) support.=C2=A0 MS way of printing size_t has =
been to use=C2=A0 &quot;%Iu&quot; (with an upper case i, not &#39;ell&#39;)=
, which indicates the required run-time support is there. But I am not sure=
 whether MSVC 2015 translates zu to Iu or only works on platforms with a ne=
w runtime library.</div><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra">Selva<br></div></div>

--001a113bc7cabdf6f5053952c6b7--

