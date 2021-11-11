MIME-Version: 1.0
References: <CAAYFXLmcybkvkw0RJ5gPVhkxrYKRr4XkdPUJwB4Cm--jQjdXKQ@...278...>
 <764146725.499610.1636544169460@...2642...>
 <CAAYFXLnJSMBcrN70GnaHRfREEosTPM-J8pZFw98DtkbNaZPKSA@...278...>
 <YY0bykbHVuGLY3DI@...1296...>
In-Reply-To: <YY0bykbHVuGLY3DI@...1296...>
From: Pete Nelson <petiepooo@...277...>
Date: Thu, 11 Nov 2021 14:26:01 +0000
Message-ID: <CAAYFXLnbfBkE7OAwOqdoQJxNt-M1aWLTcYD32Z662h-0Oc-NiA@...278...>
Content-Type: multipart/alternative; boundary="000000000000d7fa4105d0841f9d"
Subject: Re: [Openvpn-devel] [PATCH] boolean short-circuit auth upon failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000d7fa4105d0841f9d
Content-Type: text/plain; charset="UTF-8"

Should that have shown up as a separate entry in patchworks?  I'm having to
cut/paste the results of git format-patch as I can't git send-email from my
dev box, and it looks like I may have missed editing the subject line.
-- Pete

On Thu, Nov 11, 2021 at 1:34 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Nov 11, 2021 at 01:23:43PM +0000, Pete Nelson wrote:
> > Thank you, Frank.  Amended patch so it applies only to auth attempts.
> >
> > Not sure how patchwork handles this.. my intent is this amended patch
> > overwrites the patch from the OP.
> > -- Pete
>
> The best way to do that is to send the patch with "git send-email" and
> add a "-v2" switch to that - it won't overwrite the patch in PW, but
> we can see "ah, it's a v2".
>
> Please add a note to the commit message as well what is new on v2,
> like
>
>  v2: only apply shortcut logic to authentication plugin calls
>
> (if that's what is new)
>
> Please do also do "git commit -s", so we get the signed-off-by:
> line.
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--000000000000d7fa4105d0841f9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Should that have shown up as a separate e=
ntry in patchworks?=C2=A0 I&#39;m having to cut/paste the results of git fo=
rmat-patch as I can&#39;t git send-email from my dev box, and it looks like=
 I may have missed editing the subject line.</div><div>-- Pete<br></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, N=
ov 11, 2021 at 1:34 PM Gert Doering &lt;<a href=3D"mailto:gert@...1296...">=
gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Hi,<br>
<br>
On Thu, Nov 11, 2021 at 01:23:43PM +0000, Pete Nelson wrote:<br>
&gt; Thank you, Frank.=C2=A0 Amended patch so it applies only to auth attem=
pts.<br>
&gt; <br>
&gt; Not sure how patchwork handles this.. my intent is this amended patch<=
br>
&gt; overwrites the patch from the OP.<br>
&gt; -- Pete<br>
<br>
The best way to do that is to send the patch with &quot;git send-email&quot=
; and<br>
add a &quot;-v2&quot; switch to that - it won&#39;t overwrite the patch in =
PW, but<br>
we can see &quot;ah, it&#39;s a v2&quot;.<br>
<br>
Please add a note to the commit message as well what is new on v2,<br>
like<br>
<br>
=C2=A0v2: only apply shortcut logic to authentication plugin calls<br>
<br>
(if that&#39;s what is new)<br>
<br>
Please do also do &quot;git commit -s&quot;, so we get the signed-off-by:<b=
r>
line.<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div></div>

--000000000000d7fa4105d0841f9d--

