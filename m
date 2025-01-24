From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 24 Jan 2025 11:48:44 +0000
In-Reply-To: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
References: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <325f40cf54aecda355caa586eac4ab1dc5e05d14-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a6RmCWhHOHA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute: adapt to new
 protocol handling and hashing improvements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--a6RmCWhHOHA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/765?usp=3Demail )

Change subject: mroute: adapt to new protocol handling and hashing improvem=
ents
......................................................................


Patch Set 15:

(7 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/765/comment/7d7d6798_7dba137c :
PS14, Line 1132:         for (int i =3D 0; i < c->c1.link_sockets_num; i++)
> I assume this hunk is needed, but it's sort of "outside the scope of mrou=
te handling" (so should eit [=E2=80=A6]
This is still about client context, so no need to loop and no need to touch=
 this again.


http://gerrit.openvpn.net/c/openvpn/+/765/comment/4c321545_89555b0c :
PS14, Line 1135:                 /* on the instance context we have only on=
e socket, so just check the first one */
> whatever the outcome is, this comment is no longer correct :-)
Done


File src/openvpn/mroute.h:

http://gerrit.openvpn.net/c/openvpn/+/765/comment/9bb3a8db_d8b619b4 :
PS14, Line 225:     return (uint32_t) a->len + 2;
> if you change the start of the to-be-hashed block, but all the existing d=
ata should still be hashed, [=E2=80=A6]
Done


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/765/comment/ff1ec800_dab6a655 :
PS14, Line 196:     m->local.proto =3D real.proto;
> This is a bit confusing.  I can see the assignment to `real. [=E2=80=A6]
That's a leftover, I see that m->local is used only on virtual addresses co=
ntext so no need to copy the real proto and since it's CLEAR() no need to s=
et the proto to 0.


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/765/comment/f9fda981_a1023801 :
PS14, Line 1156:                                    struct mroute_addr *add=
r,
> this looks wrong.  A lookup function should not modify its arguments. [=
=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/765/comment/285a38d0_93d7ac29 :
PS14, Line 3356:
> see comment above - now you're actually setting `proto` in the caller, ev=
en if I do not agree this i [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/765/comment/9738102a_e71eb117 :
PS14, Line 3561:         dest.proto =3D src.proto;
> same thing -> `mroute_extract_addr_from_packet()`
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab
Gerrit-Change-Number: 765
Gerrit-PatchSet: 15
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Fri, 24 Jan 2025 11:48:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--a6RmCWhHOHA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail">View C=
hange</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/765/comment/7d7d6798_7dba137c">Patch Set #14, Line 1132:<=
/a> <code style=3D"font-family:monospace,monospace">        for (int i =3D =
0; i &lt; c-&gt;c1.link_sockets_num; i++)</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I assume th=
is hunk is needed, but it&#39;s sort of &quot;outside the scope of mroute h=
andling&quot; (so should eit [=E2=80=A6]</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">This is still about client context=
, so no need to loop and no need to touch this again.</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/765/comment/4c321545_89555b0c">Pa=
tch Set #14, Line 1135:</a> <code style=3D"font-family:monospace,monospace"=
>                /* on the instance context we have only one socket, so jus=
t check the first one */</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">whatever the outcome is, thi=
s comment is no longer correct :-)</blockquote></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/mroute.h:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
765/comment/9bb3a8db_d8b619b4">Patch Set #14, Line 225:</a> <code style=3D"=
font-family:monospace,monospace">    return (uint32_t) a-&gt;len + 2;</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">if you change the start of the to-be-hashed block, but all=
 the existing data should still be hashed, [=E2=80=A6]</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/765/comment/ff1ec800_dab6a655">Patch Set #14, Line 196:</=
a> <code style=3D"font-family:monospace,monospace">    m-&gt;local.proto =
=3D real.proto;</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">This is a bit confusing.  I can see t=
he assignment to `real. [=E2=80=A6]</blockquote></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">That&#39;s a leftover, I see that m-&gt=
;local is used only on virtual addresses context so no need to copy the rea=
l proto and since it&#39;s CLEAR() no need to set the proto to 0.</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/765/comment/f9fda981_a1023801">Patch Set #14, Line=
 1156:</a> <code style=3D"font-family:monospace,monospace">                =
                   struct mroute_addr *addr,</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this loo=
ks wrong.  A lookup function should not modify its arguments. [=E2=80=A6]</=
blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">D=
one</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/765/commen=
t/285a38d0_93d7ac29">Patch Set #14, Line 3356:</a> <code style=3D"font-fami=
ly:monospace,monospace"></code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">see comment above - now you&=
#39;re actually setting `proto` in the caller, even if I do not agree this =
i [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/765/comment/9738102a_e71eb117">Patch Set #14, Line 3561:</a> <code sty=
le=3D"font-family:monospace,monospace">        dest.proto =3D src.proto;</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">same thing -&gt; `mroute_extract_addr_from_packet()`</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/765?usp=3Demail">change 765</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/765?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca=
88728068a92ab </div>
<div style=3D"display:none"> Gerrit-Change-Number: 765 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jan 2025 11:48:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--a6RmCWhHOHA=--

