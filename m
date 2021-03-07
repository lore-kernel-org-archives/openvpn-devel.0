MIME-Version: 1.0
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
In-Reply-To: <20210307181002.GQ976@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 7 Mar 2021 13:36:03 -0500
Message-ID: <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000e4960705bcf69767"
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e4960705bcf69767
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 7, 2021 at 1:10 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> thanks for the review.
>
> On Sun, Mar 07, 2021 at 12:22:32PM -0500, Selva Nair wrote:
> > On Sun, Mar 7, 2021 at 11:31 AM Gert Doering <gert@...1296...>
> wrote:
> >
> > > If --mlock is used, the amount of memory OpenVPN can use is guarded
> > > by the RLIMIT_MEMLOCK value (see mlockall(2)).  The OS default for this
> > > is usually 64 Kbyte, which is enough for OpenVPN to initialize, but
> > > as soon as the first TLS handshake comes it, OpenVPN will crash due
> > > to "ouf of memory", and might even end up in a crash loop.
> > >
> > > Steady-state OpenVPN requires between 8 MB and 30-50 MB (servers with
> > > many concurrent clients) of memory.
> > >
> > > So: with this patch, we check if getrlimit() is available, and if yes,
> > > log the amount of mlock'able memory.  If the amount is below 20 MB,
> > > which is an arbitrary value "large enough for most smaller
> deployments",
> > > we abort.
> > >
> >
> > This is required only if privileges are dropped, isn't it? Could be made
> > conditional
> > on o->username is set.
>
> "I'm not sure", TBH.  rlimit handling in unix is a bit of an unknown
> territory for me.
>
> What I understand is that root can *increment* the rlimit at will, but
> I'd assume that the rlimit value "in existance right now" (specifically,
> the soft limit) applies to root processes as well.  Sort of a voluntary
> protection against processes running away.
>

On modern linux kernels (since some 2.6.x..) RLIMIT_MEMLOCK applies only to
unprivileged processes -- privileged processes allowed to lock "unlimited"
amount of memory as documented in man mlock. We updated the man page based
on that sometime ago.

We could also consider using setrlimit to increase the limit before
dropping privileges.

But I haven't checked how other "unix"-like OSes behave.

Selva

--000000000000e4960705bcf69767
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 7, 2021 at 1:10 PM Gert D=
oering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
thanks for the review. <br>
<br>
On Sun, Mar 07, 2021 at 12:22:32PM -0500, Selva Nair wrote:<br>
&gt; On Sun, Mar 7, 2021 at 11:31 AM Gert Doering &lt;<a href=3D"mailto:ger=
t@...1296..." target=3D"_blank">gert@...1296...</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; If --mlock is used, the amount of memory OpenVPN can use is guard=
ed<br>
&gt; &gt; by the RLIMIT_MEMLOCK value (see mlockall(2)).=C2=A0 The OS defau=
lt for this<br>
&gt; &gt; is usually 64 Kbyte, which is enough for OpenVPN to initialize, b=
ut<br>
&gt; &gt; as soon as the first TLS handshake comes it, OpenVPN will crash d=
ue<br>
&gt; &gt; to &quot;ouf of memory&quot;, and might even end up in a crash lo=
op.<br>
&gt; &gt;<br>
&gt; &gt; Steady-state OpenVPN requires between 8 MB and 30-50 MB (servers =
with<br>
&gt; &gt; many concurrent clients) of memory.<br>
&gt; &gt;<br>
&gt; &gt; So: with this patch, we check if getrlimit() is available, and if=
 yes,<br>
&gt; &gt; log the amount of mlock&#39;able memory.=C2=A0 If the amount is b=
elow 20 MB,<br>
&gt; &gt; which is an arbitrary value &quot;large enough for most smaller d=
eployments&quot;,<br>
&gt; &gt; we abort.<br>
&gt; &gt;<br>
&gt; <br>
&gt; This is required only if privileges are dropped, isn&#39;t it? Could b=
e made<br>
&gt; conditional<br>
&gt; on o-&gt;username is set.<br>
<br>
&quot;I&#39;m not sure&quot;, TBH.=C2=A0 rlimit handling in unix is a bit o=
f an unknown<br>
territory for me.<br>
<br>
What I understand is that root can *increment* the rlimit at will, but<br>
I&#39;d assume that the rlimit value &quot;in existance right now&quot; (sp=
ecifically,<br>
the soft limit) applies to root processes as well.=C2=A0 Sort of a voluntar=
y<br>
protection against processes running away.<br></blockquote><div><br></div><=
div>On modern linux kernels (since some 2.6.x..) RLIMIT_MEMLOCK applies onl=
y to unprivileged processes -- privileged=C2=A0processes allowed to lock &q=
uot;unlimited&quot; amount of memory as documented in man mlock. We updated=
 the man page based on that sometime ago.</div><div><br></div><div>We could=
 also consider using setrlimit to increase the limit before dropping privil=
eges.=C2=A0</div><div><br></div><div>But I haven&#39;t=C2=A0checked how oth=
er &quot;unix&quot;-like OSes behave.</div><div><br></div><div>Selva</div><=
/div></div>

--000000000000e4960705bcf69767--

