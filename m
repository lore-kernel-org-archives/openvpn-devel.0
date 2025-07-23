From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 17:11:24 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <77d9f65e3e7bf98a92f47d99432a68193fd17cf0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LQ9TTG2yatA="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Allow
 OpenVPN in client mode to receive and handle PUSH ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LQ9TTG2yatA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, stipa.

mrbff has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/808?usp=3Demail )

Change subject: PUSH_UPDATE: Allow OpenVPN in client mode to receive and ha=
ndle PUSH UPDATE control messages to allow options updating at runtime.
......................................................................


Patch Set 21:

(8 comments)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/0bc4e799_eafa8770 :
PS19, Line 5567: apply_push_options(struct options *options,
> please do not move that one around in options. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/808/comment/010661f3_5e3b560e :
PS19, Line 5654:
> so I would call check_push_update_option_flags() from here, possibly movi=
ng the "while isspace(*line [=E2=80=A6]
Done


File src/openvpn/options_util.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/47b8a262_12fab17a :
PS19, Line 198:     if (!line || !*line || !**line)
> the use of a double pointer irritates me, because we never move the point=
er, instead `memmove()` the [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/808/comment/8e312009_6f3eacc1 :
PS19, Line 231:
> If there is whitespace here (`?  route`) we'll fail with `pushed option i=
s not updateable: '  route' [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/808/comment/a777b4e8_51887b18 :
PS19, Line 252:             msg(D_PUSH, "Pushed option is not updatable: '%=
s'", *line);
> Maybe add an " Ignoring. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/808/comment/b521c226_07b2309a :
PS19, Line 270:     if (!o->pull_filter_list && !(is_update))
> So, if we call `check_push_update_option_flags()` from outside, we do not=
 need this extra dance, che [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/808/comment/4d43cf7c_4985502d :
PS19, Line 276:     while (isspace(*line))
> It makes sense to move that upwards to `apply_push_options()`, before cal=
ling anything on the line. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/808/comment/a7cb08ef_9c354e3e :
PS19, Line 310:                 return true;
> This duplication of the messages and `return true` looks a bit silly :-) =
- I would suggest to do [=E2=80=A6]
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a
Gerrit-Change-Number: 808
Gerrit-PatchSet: 21
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Wed, 23 Jul 2025 17:11:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--LQ9TTG2yatA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">View C=
hange</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/808/comment/0bc4e799_eafa8770">Patch Set #19, Line 5567:<=
/a> <code style=3D"font-family:monospace,monospace">apply_push_options(stru=
ct options *options,</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">please do not move that one arou=
nd in options. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/808/comment/010661f3_5e3b560e">Patch Set #19, Line 5654:<=
/a> <code style=3D"font-family:monospace,monospace"></code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
so I would call check_push_update_option_flags() from here, possibly moving=
 the &quot;while isspace(*line [=E2=80=A6]</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/options_util.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/808/comment/47b8a262_12fab17a">Patch Set #19, Line 198:</a> <=
code style=3D"font-family:monospace,monospace">    if (!line || !*line || !=
**line)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">the use of a double pointer irritates me, bec=
ause we never move the pointer, instead `memmove()` the [=E2=80=A6]</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/8e31=
2009_6f3eacc1">Patch Set #19, Line 231:</a> <code style=3D"font-family:mono=
space,monospace"></code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">If there is whitespace here (`?  ro=
ute`) we&#39;ll fail with `pushed option is not updateable: &#39;  route&#3=
9; [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/808/comment/a777b4e8_51887b18">Patch Set #19, Line 252:</a> <code sty=
le=3D"font-family:monospace,monospace">            msg(D_PUSH, &quot;Pushed=
 option is not updatable: &#39;%s&#39;&quot;, *line);</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Maybe add an &quot; Ignoring. [=E2=80=A6]</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/808/comment/b521c226_07b2309a">Patch Set =
#19, Line 270:</a> <code style=3D"font-family:monospace,monospace">    if (=
!o-&gt;pull_filter_list &amp;&amp; !(is_update))</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">So, =
if we call `check_push_update_option_flags()` from outside, we do not need =
this extra dance, che [=E2=80=A6]</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/808/comment/4d43cf7c_4985502d">Patch Set #19, Line=
 276:</a> <code style=3D"font-family:monospace,monospace">    while (isspac=
e(*line))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">It makes sense to move that upwards to `app=
ly_push_options()`, before calling anything on the line. [=E2=80=A6]</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/a7c=
b08ef_9c354e3e">Patch Set #19, Line 310:</a> <code style=3D"font-family:mon=
ospace,monospace">                return true;</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This d=
uplication of the messages and `return true` looks a bit silly :-) - I woul=
d suggest to do [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">ch=
ange 808</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595=
c742aeec6064a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 808 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Jul 2025 17:11:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--LQ9TTG2yatA=--

