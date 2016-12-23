MIME-Version: 1.0
In-Reply-To: <7b735498-f033-6f7c-0286-08da9eafdb7a@...1856...>
References: <1482524791-5788-1-git-send-email-steffan@...1856...>
	<CAKuzo_jKfWW0TA2TUzFhPFOQa6JjtfDNpiAStTUp4vyT+7yOOw@...278...>
	<f3feae1b-5429-f9aa-dc29-ec0f21124dcd@...1856...>
	<7b735498-f033-6f7c-0286-08da9eafdb7a@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 23 Dec 2016 17:20:43 -0500
Message-ID: <CAKuzo_hbGphKBoB3MEtA5mn6JLNanGshntvmJxisxVTDWAWKxA@...278...>
Content-Type: multipart/alternative; boundary=001a1149b0a4334b2f05445acd55
Subject: Re: [Openvpn-devel] [PATCH] Add nl_for_brace=add to uncrustify.conf
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

--001a1149b0a4334b2f05445acd55
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 23, 2016 at 4:59 PM, Steffan Karger <steffan@...1856...> wrote:

> On 23-12-16 22:44, Steffan Karger wrote:
> > On 23-12-16 22:23, Selva Nair wrote:
> >>
> >> On Fri, Dec 23, 2016 at 3:26 PM, Steffan Karger <steffan@...1856...
> >> <mailto:steffan@...1856...>> wrote:
> >>
> >>     diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
> >>     index 95e0b2a..3745ed0 100644
> >>     --- a/dev-tools/uncrustify.conf
> >>     +++ b/dev-tools/uncrustify.conf
> >>     @@ -9,6 +9,7 @@ nl_brace_else=add
> >>      nl_elseif_brace=add
> >>      nl_else_brace=add
> >>      nl_else_if=remove
> >>     +nl_for_brace=add
> >>
> >>
> >> What about
> >>
> >> nl_switch_brace = add
> >> nl_while_brace = add
> >> nl_fdef_brace = add
> >>
> >> These are not optional as per the style, are they?
> >
> > Indeed.  Let's add them too.  I'll send a v2.
>
> Hrmpf, yet another can of worms.  If I add these and check the changes,
> it looks like we need these too:
>
> mod_full_brace_while=add
> mod_full_brace_for=add


This is never-ending. We may also need

nl_do_brace=add
mod_full_brace_do=add

Selva

--001a1149b0a4334b2f05445acd55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Dec 23, 2016 at 4:59 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 23-1=
2-16 22:44, Steffan Karger wrote:<br>
&gt; On 23-12-16 22:23, Selva Nair wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Dec 23, 2016 at 3:26 PM, Steffan Karger &lt;<a href=3D"mai=
lto:steffan@...1856...">steffan@...1856...</a><br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:steffan@...1856...">steffan@...2115...=
.</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/dev-tools/uncrustify.conf b/dev-to=
ols/uncrustify.conf<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0index 95e0b2a..3745ed0 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0--- a/dev-tools/uncrustify.conf<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+++ b/dev-tools/uncrustify.conf<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -9,6 +9,7 @@ nl_brace_else=3Dadd<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 nl_elseif_brace=3Dadd<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 nl_else_brace=3Dadd<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 nl_else_if=3Dremove<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+nl_for_brace=3Dadd<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; What about<br>
&gt;&gt;<br>
&gt;&gt; nl_switch_brace =3D add<br>
&gt;&gt; nl_while_brace =3D add<br>
&gt;&gt; nl_fdef_brace =3D add<br>
&gt;&gt;<br>
&gt;&gt; These are not optional as per the style, are they?<br>
&gt;<br>
&gt; Indeed.=C2=A0 Let&#39;s add them too.=C2=A0 I&#39;ll send a v2.<br>
<br>
</span>Hrmpf, yet another can of worms.=C2=A0 If I add these and check the =
changes,<br>
it looks like we need these too:<br>
<br>
mod_full_brace_while=3Dadd<br>
mod_full_brace_for=3Dadd</blockquote></div><br></div><div class=3D"gmail_ex=
tra">This is never-ending. We may also need<br></div><div class=3D"gmail_ex=
tra"><br>nl_do_brace=3Dadd<br>mod_full_brace_do=3Dadd<br><br></div><div cla=
ss=3D"gmail_extra">Selva<br></div></div>

--001a1149b0a4334b2f05445acd55--

