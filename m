MIME-Version: 1.0
In-Reply-To: <CAA1Abx+CTuRmnZJEJB9zCVjAv6bMNicsPiRg6wNdtac+fKF4gQ@...278...>
References: <1470368394-2722-1-git-send-email-selva.nair@...277...>
	<20160805061418.GO78279@...1296...>
	<CAA1AbxJ8G5ztG1mgdkbvg7S9yqYuTwtq76SCkksUkrpVi8SjxA@...278...>
	<CAKuzo_gsjEjhCZ7eczDtGb2XOrjXwKh4LroL4ULZrc96Jy8Lhg@...278...>
	<CAA1Abx+CTuRmnZJEJB9zCVjAv6bMNicsPiRg6wNdtac+fKF4gQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 7 Aug 2016 10:47:16 -0400
Message-ID: <CAKuzo_hbfMrz3_bJBVjiPOu0fmRs=fvMr-Cm6sXZBGQp=fd-uQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c07641667f2ab05397c613e
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

--94eb2c07641667f2ab05397c613e
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Aug 7, 2016 at 10:04 AM, Steffan Karger <steffan@...1856...> wrote:

> On 5 August 2016 at 15:09, Selva Nair <selva.nair@...277...> wrote:
> > On Fri, Aug 5, 2016 at 3:32 AM, Steffan Karger <steffan@...1856...>
> wrote:
> >> On Fri, Aug 5, 2016 at 8:14 AM, Gert Doering <gert@...1296...>
> wrote:
> >> > On Thu, Aug 04, 2016 at 11:39:54PM -0400, Selva Nair wrote:
> >> >> -  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %zu
> >> >> bytes",
> >> >> -      __func__, crypto_overhead);
> >> >> +  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %d
> >> >> bytes",
> >> >> +      __func__, (int) crypto_overhead);
> >> >
> >> > Just for clarification: how does this break windows?  mingw builds, or
> >> > msvc builds?  Will it print "nothing" ("zu bytes") or wrong values?
> >
> > mingw (my version is gcc 4.6.3)  prints zu bytes. I think this could be
> also
> > fixed by defining  __USE_MINGW_ANSI_STDIO=1
>
> I looked into this a bit, and it should indeed fix the printing of %zu
> on Windows.  I would prefer to teach autotools to include this flag on
> Windows builds, instead of the suggested casts in the code.  (But if
> you both prefer the casts, just ignore my rambling.)
>

I don't like casts and agree with Steffan. That is, assuming MSVC support
is only for developers, we need not worry about the runtime and could
require MSVC 2015. I suppose we only distribute mingw cross-compiled
binaries.

I think, with __USE_MINGW_ANSI_STDIO=1 mingw will use a custom
implementation I/O routines, so the binary size may increase a bit (by ~50
kB or ~5% in my tests).

Also we currently use MS-specific format specs like %I64u %I64x for
counter_format and ptr_format. Those will have to be changed once the above
define is in place. Its only a couple of instances, though.

I am looking at this as an opportunity to stop coding for VS2011 and 2013
and feel liberated :) If Gert is fine with this I'll make a new patch.

Selva

--94eb2c07641667f2ab05397c613e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Sun, Aug 7, 2016 at 10:04 AM, Steffan Karger <span dir=3D"lt=
r">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1386...=
856...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><span>On 5 August 2016 at 15:09, Selva Nair &lt;<a href=3D"mailto:se=
lva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt; wrote:<b=
r>
&gt; On Fri, Aug 5, 2016 at 3:32 AM, Steffan Karger &lt;<a href=3D"mailto:s=
teffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt; wrote:<br>
</span><span>&gt;&gt; On Fri, Aug 5, 2016 at 8:14 AM, Gert Doering &lt;<a h=
ref=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt; wr=
ote:<br>
&gt;&gt; &gt; On Thu, Aug 04, 2016 at 11:39:54PM -0400, Selva Nair wrote:<b=
r>
&gt;&gt; &gt;&gt; -=C2=A0 msg(D_MTU_DEBUG, &quot;%s: Adjusting frame parame=
ters for crypto by %zu<br>
&gt;&gt; &gt;&gt; bytes&quot;,<br>
&gt;&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 __func__, crypto_overhead);<br>
&gt;&gt; &gt;&gt; +=C2=A0 msg(D_MTU_DEBUG, &quot;%s: Adjusting frame parame=
ters for crypto by %d<br>
&gt;&gt; &gt;&gt; bytes&quot;,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 __func__, (int) crypto_overhead);<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Just for clarification: how does this break windows?=C2=A0 mi=
ngw builds, or<br>
&gt;&gt; &gt; msvc builds?=C2=A0 Will it print &quot;nothing&quot; (&quot;z=
u bytes&quot;) or wrong values?<br>
&gt;<br>
&gt; mingw (my version is gcc 4.6.3)=C2=A0 prints zu bytes. I think this co=
uld be also<br>
&gt; fixed by defining=C2=A0 __USE_MINGW_ANSI_STDIO=3D1<br>
<br>
</span>I looked into this a bit, and it should indeed fix the printing of %=
zu<br>
on Windows.=C2=A0 I would prefer to teach autotools to include this flag on=
<br>
Windows builds, instead of the suggested casts in the code.=C2=A0 (But if<b=
r>
you both prefer the casts, just ignore my rambling.)<span><font color=3D"#8=
88888"><br></font></span></blockquote><div><br></div><div>I don&#39;t like =
casts and agree with Steffan. That is, assuming MSVC support is only for
 developers, we need not worry about the runtime and could require MSVC 201=
5. I suppose we only distribute mingw cross-compiled binaries. <br><br>I th=
ink, with __USE_MINGW_ANSI_STDIO=3D1 mingw will use a=20
custom implementation I/O routines, so the binary size may increase a=20
bit (by ~50 kB or ~5% in my tests).</div></div><div class=3D"gmail_extra"><=
br></div><div class=3D"gmail_extra">Also we currently use MS-specific forma=
t specs like %I64u %I64x for counter_format and ptr_format. Those will have=
 to be changed once the above define is in place. Its only a couple of inst=
ances, though.<br><br>I am looking at this as an opportunity to stop coding=
 for VS2011 and 2013 and feel liberated :) If Gert is fine with this I&#39;=
ll make a new patch.<br><br></div><div class=3D"gmail_extra">Selva <br></di=
v></div></div></div>

--94eb2c07641667f2ab05397c613e--

