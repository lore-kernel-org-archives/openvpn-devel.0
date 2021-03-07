MIME-Version: 1.0
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
In-Reply-To: <20210307184402.GS976@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 7 Mar 2021 14:20:32 -0500
Message-ID: <CAKuzo_huZkMc1LhG7abCBKn0TK17JR_TLb3DyMeV1VYb5mNesQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000f5512905bcf73642"
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

--000000000000f5512905bcf73642
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Mar 7, 2021 at 1:44 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sun, Mar 07, 2021 at 01:36:03PM -0500, Selva Nair wrote:
> > > "I'm not sure", TBH.  rlimit handling in unix is a bit of an unknown
> > > territory for me.
> > >
> > > What I understand is that root can *increment* the rlimit at will, but
> > > I'd assume that the rlimit value "in existance right now"
> (specifically,
> > > the soft limit) applies to root processes as well.  Sort of a voluntary
> > > protection against processes running away.
> >
> > On modern linux kernels (since some 2.6.x..) RLIMIT_MEMLOCK applies only
> to
> > unprivileged processes -- privileged processes allowed to lock
> "unlimited"
> > amount of memory as documented in man mlock. We updated the man page
> based
> > on that sometime ago.
>
> Indeed, "man mlock" says something about "privileged processes" on Linux
> (it doesn't say that on FreeBSD).
>
> > We could also consider using setrlimit to increase the limit before
> > dropping privileges.
>
> That's another possible angle... just up soft+hard to "something"
> (how much would that be? :-) ) and log the fact.
>

Rereading my comment on Trac #1059 I recall testing this and concluding
100MB enough for clients. On modern machines that's a low amount of memory
--- not allowing swapout of 100MB should be acceptable.  For servers, I
think there is no reliable limit that we could come up with.

Selva

--000000000000f5512905bcf73642
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>Hi,<div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 7, 2021 at 1:44 P=
M Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">ger=
t@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Hi,<br>
<br>
On Sun, Mar 07, 2021 at 01:36:03PM -0500, Selva Nair wrote:<br>
&gt; &gt; &quot;I&#39;m not sure&quot;, TBH.=C2=A0 rlimit handling in unix =
is a bit of an unknown<br>
&gt; &gt; territory for me.<br>
&gt; &gt;<br>
&gt; &gt; What I understand is that root can *increment* the rlimit at will=
, but<br>
&gt; &gt; I&#39;d assume that the rlimit value &quot;in existance right now=
&quot; (specifically,<br>
&gt; &gt; the soft limit) applies to root processes as well.=C2=A0 Sort of =
a voluntary<br>
&gt; &gt; protection against processes running away.<br>
&gt; <br>
&gt; On modern linux kernels (since some 2.6.x..) RLIMIT_MEMLOCK applies on=
ly to<br>
&gt; unprivileged processes -- privileged processes allowed to lock &quot;u=
nlimited&quot;<br>
&gt; amount of memory as documented in man mlock. We updated the man page b=
ased<br>
&gt; on that sometime ago.<br>
<br>
Indeed, &quot;man mlock&quot; says something about &quot;privileged process=
es&quot; on Linux<br>
(it doesn&#39;t say that on FreeBSD).<br>
<br>
&gt; We could also consider using setrlimit to increase the limit before<br>
&gt; dropping privileges.<br>
<br>
That&#39;s another possible angle... just up soft+hard to &quot;something&q=
uot;<br>
(how much would that be? :-) ) and log the fact.<br></blockquote><div><br><=
/div><div>Rereading my comment on Trac #1059 I recall testing this and conc=
luding 100MB enough for clients. On modern machines that&#39;s a low amount=
 of memory --- not allowing swapout of 100MB should be acceptable.=C2=A0 Fo=
r servers, I think there is no reliable limit that we could come up with.=
=C2=A0</div><div><br></div><div>Selva</div></div></div></div>

--000000000000f5512905bcf73642--

