From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 09:42:51 +0000
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <78de764131ff5411ac031cd5e832a61791eb311b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s4jWLteat6E="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: allow user to
 specify 'local' multiple times in config files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--s4jWLteat6E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/436?usp=3Demail )

Change subject: allow user to specify 'local' multiple times in config files
......................................................................


Patch Set 8:

(9 comments)

File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/8dd8c81c_1c28df37 :
PS7, Line 114:   open a socket.
> This text is not clear to me.  What does "*" do?  (This interacts with #7=
61 on `::`). [=E2=80=A6]
Done, for the text.

(--proto)
It will not interact with --proto, I tried to avoid checking it as it is fi=
shy on the server side since we may have multiple sockets of different prot=
ocols, instead we will check the protocol for each socket when possible, ot=
herwise we rely on the mode.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/3c4e7f07_331b4f56 :
PS5, Line 6247:         if (strcmp(p[1], "*") !=3D 0)
> should we issue a warning if someone specifies "--local *" without port n=
umber that this is a NOOP?
Acknowledged


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/d9af2a74_f67140b0 :
PS7, Line 133:     "                        a server listen on multiple soc=
kets at the same time.\n"
> when there is agreement on the wording in the manpage, this needs to be a=
ddressed as well
Done


http://gerrit.openvpn.net/c/openvpn/+/436/comment/b04415ed_9d0e4ae8 :
PS7, Line 998:     setenv_str_i(es, "local", e->local_list->array[0]->local=
, i);
> will this crash if `--local` has not been used at all?
No, it will not, even without specifying any '--local' we're gonna create a=
 local_entry based on the global port, see options.c:3818 for details.


http://gerrit.openvpn.net/c/openvpn/+/436/comment/750168cd_967ca0a0 :
PS7, Line 2406:     }
> I would not check on `ce->remote` but on `mode =3D=3D SERVER` here, and c=
hange the wording to `multiple  [=E2=80=A6]
Done for the check.

See answer above for --local crash question.


http://gerrit.openvpn.net/c/openvpn/+/436/comment/fb946320_525f1ec3 :
PS7, Line 3185:     bool need_bind =3D ce->local_port_defined || ce->bind_d=
efined;
> this looks incomplete - shouldn't the existence of a `--local` entry also=
 set `need_bind =3D true`?
Extended this with checking for the local_list, (if not NULL we're going to=
 bind).


http://gerrit.openvpn.net/c/openvpn/+/436/comment/d52d560f_2dcb23ff :
PS7, Line 3198:     if (o->client && !need_bind)
> is this intentional or a rebase artefact?  This looks a bit unrelated
Done


http://gerrit.openvpn.net/c/openvpn/+/436/comment/6ecec3d0_fc5af621 :
PS7, Line 3827:     /* use the same listen list for every outgoing connecti=
on */
> well... for outgoing connections we do not want to use a *list* at all, a=
s we can only bind() once.. [=E2=80=A6]
We handle everything as a list, but later on there's a specific sanity chec=
k that in the case of clients ensures that the list has only one element.


http://gerrit.openvpn.net/c/openvpn/+/436/comment/3a5e4b2a_9eed652f :
PS7, Line 6250:             e->bind_local =3D true;
> I do not understand this `bind_local` variable. [=E2=80=A6]
I removed the bind_local variable on the local_entry and rely on the o->ce.=
bind_local which has all the sanity checks of the case.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Gerrit-Change-Number: 436
Gerrit-PatchSet: 8
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Thu, 12 Dec 2024 09:42:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--s4jWLteat6E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">View C=
hange</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/link-options.=
rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/436/comment/8dd8c81c_1c28df37">Patch Set #7, =
Line 114:</a> <code style=3D"font-family:monospace,monospace">  open a sock=
et.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">This text is not clear to me.  What does &quot;*&=
quot; do?  (This interacts with #761 on `::`). [=E2=80=A6]</blockquote></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done, for the te=
xt.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">(--proto)=
<br>It will not interact with --proto, I tried to avoid checking it as it i=
s fishy on the server side since we may have multiple sockets of different =
protocols, instead we will check the protocol for each socket when possible=
, otherwise we rely on the mode.</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436/co=
mment/3c4e7f07_331b4f56">Patch Set #5, Line 6247:</a> <code style=3D"font-f=
amily:monospace,monospace">        if (strcmp(p[1], &quot;*&quot;) !=3D 0)<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">should we issue a warning if someone specifies &quot;=
--local *&quot; without port number that this is a NOOP?</blockquote></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/optio=
ns.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/436/comment/d9af2a74_f67140b0">Patch Set #7,=
 Line 133:</a> <code style=3D"font-family:monospace,monospace">    &quot;  =
                      a server listen on multiple sockets at the same time.=
\n&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">when there is agreement on the wording in th=
e manpage, this needs to be addressed as well</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/436/comment/b04415ed_9d0e4ae8">Patch S=
et #7, Line 998:</a> <code style=3D"font-family:monospace,monospace">    se=
tenv_str_i(es, &quot;local&quot;, e-&gt;local_list-&gt;array[0]-&gt;local, =
i);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">will this crash if `--local` has not been used at=
 all?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">No, it will not, even without specifying any &#39;--local&#39; we&#39=
;re gonna create a local_entry based on the global port, see options.c:3818=
 for details.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
436/comment/750168cd_967ca0a0">Patch Set #7, Line 2406:</a> <code style=3D"=
font-family:monospace,monospace">    }</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I would not ch=
eck on `ce-&gt;remote` but on `mode =3D=3D SERVER` here, and change the wor=
ding to `multiple  [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done for the check.</p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">See answer above for --local crash qu=
estion.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436/co=
mment/fb946320_525f1ec3">Patch Set #7, Line 3185:</a> <code style=3D"font-f=
amily:monospace,monospace">    bool need_bind =3D ce-&gt;local_port_defined=
 || ce-&gt;bind_defined;</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">this looks incomplete - shou=
ldn&#39;t the existence of a `--local` entry also set `need_bind =3D true`?=
</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Extended this with checking for the local_list, (if not NULL we&#39;re goi=
ng to bind).</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
36/comment/d52d560f_2dcb23ff">Patch Set #7, Line 3198:</a> <code style=3D"f=
ont-family:monospace,monospace">    if (o-&gt;client &amp;&amp; !need_bind)=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">is this intentional or a rebase artefact?  This look=
s a bit unrelated</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/436/comment/6ecec3d0_fc5af621">Patch Set #7, Line 3827:</a> <code =
style=3D"font-family:monospace,monospace">    /* use the same listen list f=
or every outgoing connection */</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">well... for outgoing =
connections we do not want to use a *list* at all, as we can only bind() on=
ce.. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">We handle everything as a list, but later on there&#39;s a=
 specific sanity check that in the case of clients ensures that the list ha=
s only one element.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/436/comment/3a5e4b2a_9eed652f">Patch Set #7, Line 6250:</a> <code sty=
le=3D"font-family:monospace,monospace">            e-&gt;bind_local =3D tru=
e;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">I do not understand this `bind_local` variable. [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">I removed the bind_local variable on the local_entry and rely on=
 the o-&gt;ce.bind_local which has all the sanity checks of the case.</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/436?usp=3Demail">change 436</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Dec 2024 09:42:51=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--s4jWLteat6E=--

