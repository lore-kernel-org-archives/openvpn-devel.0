MIME-Version: 1.0
In-Reply-To: <20160811173021.GX78279@...1296...>
References: <1470368394-2722-1-git-send-email-selva.nair@...277...>
	<20160805061418.GO78279@...1296...>
	<CAA1AbxJ8G5ztG1mgdkbvg7S9yqYuTwtq76SCkksUkrpVi8SjxA@...278...>
	<CAKuzo_gsjEjhCZ7eczDtGb2XOrjXwKh4LroL4ULZrc96Jy8Lhg@...278...>
	<CAA1Abx+CTuRmnZJEJB9zCVjAv6bMNicsPiRg6wNdtac+fKF4gQ@...278...>
	<CAKuzo_hbfMrz3_bJBVjiPOu0fmRs=fvMr-Cm6sXZBGQp=fd-uQ@...278...>
	<20160811173021.GX78279@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Aug 2016 13:58:21 -0400
Message-ID: <CAKuzo_g0QKiVKH+tLaku8VvVdSdKh5NT1WabX_GsZ-6an-w-4g@...278...>
Content-Type: multipart/alternative; boundary=94eb2c124e3426e49c0539cf84a3
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--94eb2c124e3426e49c0539cf84a3
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 11, 2016 at 1:30 PM, Gert Doering <gert@...1296...> wrote:

> sorry for being a bit lazy in answering.  This is the sort of threads
> that lead to endless wars ... :-)
>

Oh, no, this one is not worth even a fist fight, forget wars :)


>
> On Sun, Aug 07, 2016 at 10:47:16AM -0400, Selva Nair wrote:
> > > I looked into this a bit, and it should indeed fix the printing of %zu
> > > on Windows.  I would prefer to teach autotools to include this flag on
> > > Windows builds, instead of the suggested casts in the code.  (But if
> > > you both prefer the casts, just ignore my rambling.)
> >
> > I don't like casts and agree with Steffan. That is, assuming MSVC support
> > is only for developers, we need not worry about the runtime and could
> > require MSVC 2015. I suppose we only distribute mingw cross-compiled
> > binaries.
> >
> > I think, with __USE_MINGW_ANSI_STDIO=1 mingw will use a custom
> > implementation I/O routines, so the binary size may increase a bit (by
> ~50
> > kB or ~5% in my tests).
> >
> > Also we currently use MS-specific format specs like %I64u %I64x for
> > counter_format and ptr_format. Those will have to be changed once the
> above
> > define is in place. Its only a couple of instances, though.
>
> Mmmh.  Trading off 3 ("easy") casts vs. 50 kB extra code for stdio instead
> of using the platform-provided stdio library *plus* having to change
> (and possibly review) quite a few other parts of the code sounds like
> a fairly easy trade-off to me - and my conclusion would be "drop %zu,
> just cast to (unsigned int)".
>
>
So, in hindsight, that "full disclosure" about 50kB + some lines was not in
the best interests
of the case I was trying to make. Anyway... :)


> > I am looking at this as an opportunity to stop coding for VS2011 and 2013
> > and feel liberated :) If Gert is fine with this I'll make a new patch.
>
> This is somewhat tangential from not using %zu :) - I think regarding
> "which VS versions do we support", we should at least check with James
> and Lev, as these two seem to be the last ones to (regularily) build
> with MSVC...
>

I'll submit a new patch.

Selva

--94eb2c124e3426e49c0539cf84a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Aug 11, 2016 at 1:30 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":cev" class=3D"a3s aX=
jCH m1567aa7aedb0adce">sorry for being a bit lazy in answering.=C2=A0 This =
is the sort of threads<br>
that lead to endless wars ... :-)<br></div></blockquote><div><br></div><div=
>Oh, no, this one is not worth even a fist fight, forget wars :)</div><div>=
=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":cev" class=3D"=
a3s aXjCH m1567aa7aedb0adce">
<span class=3D""><br>
On Sun, Aug 07, 2016 at 10:47:16AM -0400, Selva Nair wrote:<br>
&gt; &gt; I looked into this a bit, and it should indeed fix the printing o=
f %zu<br>
&gt; &gt; on Windows.=C2=A0 I would prefer to teach autotools to include th=
is flag on<br>
&gt; &gt; Windows builds, instead of the suggested casts in the code.=C2=A0=
 (But if<br>
&gt; &gt; you both prefer the casts, just ignore my rambling.)<br>
&gt;<br>
&gt; I don&#39;t like casts and agree with Steffan. That is, assuming MSVC =
support<br>
&gt; is only for developers, we need not worry about the runtime and could<=
br>
&gt; require MSVC 2015. I suppose we only distribute mingw cross-compiled<b=
r>
&gt; binaries.<br>
&gt;<br>
&gt; I think, with __USE_MINGW_ANSI_STDIO=3D1 mingw will use a custom<br>
&gt; implementation I/O routines, so the binary size may increase a bit (by=
 ~50<br>
&gt; kB or ~5% in my tests).<br>
&gt;<br>
&gt; Also we currently use MS-specific format specs like %I64u %I64x for<br>
&gt; counter_format and ptr_format. Those will have to be changed once the =
above<br>
&gt; define is in place. Its only a couple of instances, though.<br>
<br>
</span>Mmmh.=C2=A0 Trading off 3 (&quot;easy&quot;) casts vs. 50 kB extra c=
ode for stdio instead<br>
of using the platform-provided stdio library *plus* having to change<br>
(and possibly review) quite a few other parts of the code sounds like<br>
a fairly easy trade-off to me - and my conclusion would be &quot;drop %zu,<=
br>
just cast to (unsigned int)&quot;.<br>
<br></div></blockquote><div><br></div><div>So, in hindsight, that &quot;ful=
l disclosure&quot; about 50kB + some lines was not in the best interests</d=
iv><div>of the case I was trying to make. Anyway... :)</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div id=3D":cev" class=3D"a3s aXjCH m1567a=
a7aedb0adce"><span class=3D"">&gt; I am looking at this as an opportunity t=
o stop coding for VS2011 and 2013<br>
&gt; and feel liberated :) If Gert is fine with this I&#39;ll make a new pa=
tch.<br>
<br>
</span>This is somewhat tangential from not using %zu :) - I think regardin=
g<br>
&quot;which VS versions do we support&quot;, we should at least check with =
James<br>
and Lev, as these two seem to be the last ones to (regularily) build<br>
with MSVC...</div></blockquote></div><div class=3D"gmail_extra"><br></div><=
div class=3D"gmail_extra">I&#39;ll submit a new patch.<br></div><br></div><=
div class=3D"gmail_extra">Selva</div></div>

--94eb2c124e3426e49c0539cf84a3--

