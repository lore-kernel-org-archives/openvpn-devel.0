From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 24 Jul 2025 08:21:03 +0000
In-Reply-To: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
References: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <a4e586eaafeedb660079e3afd5fb01a274eb5f35-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0CYmKiTrKRs="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE message
 sender: enabling the server to send PUSH_UPDATE c...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0CYmKiTrKRs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

mrbff has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/869?usp=3Demail )

Change subject: PUSH_UPDATE message sender: enabling the server to send PUS=
H_UPDATE control messages
......................................................................


Patch Set 17:

(12 comments)

File doc/management-notes.txt:

http://gerrit.openvpn.net/c/openvpn/+/869/comment/33d4ba61_04cc0d55 :
PS16, Line 1075:
> I do question whether this is a reasonable approach, to have "by cn" and =
"by addr" functions, that a [=E2=80=A6]
i mostly followed the `kill` command, but yes it is the second one.


File src/openvpn/manage.c:

http://gerrit.openvpn.net/c/openvpn/+/869/comment/183ce8a9_448ff5ac :
PS16, Line 1362:         }
> I bet there are more elegant and less repetitive ways to do 4 different `=
if (status) print(SUCCESS!) [=E2=80=A6]
Done


File src/openvpn/push.h:

http://gerrit.openvpn.net/c/openvpn/+/869/comment/940bc697_89ca7f9f :
PS16, Line 54:
> This does confuse me a bit. [=E2=80=A6]
you can get the cid only from management, but theoretically the rest could =
be used by other functions in the future


File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/869/comment/ccbe9b3d_34774f2d :
PS16, Line 66: /* Allocate memory and asseble the final message */
> typo
Done


http://gerrit.openvpn.net/c/openvpn/+/869/comment/a9514c2d_3d9f4c1f :
PS16, Line 82:     }
> it might increase readability to juse use `snprintf( ... [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/869/comment/bc395641_798e9979 :
PS16, Line 122:             msgs[im] =3D forge_msg(str, ",push-continuation=
 2", gc);
> I do wonder if this can be done without modifying the string, so getting =
rid of the `strdup()` requi [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/869/comment/9e0a4d3f_be2fdaaa :
PS16, Line 143: /* It actually send the already divided messagge to one sin=
gle client */
> This comment needs a visit from the grammar police ;-) [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/869/comment/c617f505_475db955 :
PS16, Line 158:         buf_write(&buf, msgs[i], strlen(msgs[i]));
> If you want to have the message in a `buf` here, you could have `forge_ms=
g()` just use `buf_printf() [=E2=80=A6]
ok, working on it


http://gerrit.openvpn.net/c/openvpn/+/869/comment/ac640134_01fb9aae :
PS16, Line 165:         /* After sending the control message, we update the=
 options server-side in the client's context */
> Can you extend the comment a bit on why this is needed?  I assume (which =
might or might not be a bad [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/869/comment/7a73548b_cfd887a6 :
PS16, Line 204:     if (!message_splitter(gc_strdup(msg, &gc), msgs, &gc, s=
afe_cap))
> Please do not call `strdup()` in a function call... [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/869/comment/4e68ba97_68899c76 :
PS16, Line 239:
> how can we ever end here if ENABLE_MANAGEMENT is not defined?  Except for=
 the unit test, there is no [=E2=80=A6]
We can't now, yes, but the function could be used somewhere else in the fut=
ure


http://gerrit.openvpn.net/c/openvpn/+/869/comment/d6fc2d7c_558c5256 :
PS16, Line 305:     RETURN_UPDATE_STATUS(n_sent);
> so here we have this nice if/else macro that manage.c could use :-)... [=
=E2=80=A6]
i need to do the lookup anyway in send_push_update(), so it would duplicate=
 code with no good reason i think, but i can use the macro anyway, np



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc
Gerrit-Change-Number: 869
Gerrit-PatchSet: 17
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 24 Jul 2025 08:21:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--0CYmKiTrKRs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail">View C=
hange</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File doc/management-notes.txt:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/869/comment/33d4ba61_04cc0d55">Patch Set #16, Line 10=
75:</a> <code style=3D"font-family:monospace,monospace"></code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">I do question whether this is a reasonable approach, to have &quot;by c=
n&quot; and &quot;by addr&quot; functions, that a [=E2=80=A6]</blockquote><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">i mostly foll=
owed the `kill` command, but yes it is the second one.</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/869/comment/183ce8a9_448ff5ac">Patch Set #16, Line 1362:</a>=
 <code style=3D"font-family:monospace,monospace">        }</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">I bet there are more elegant and less repetitive ways to do 4 differe=
nt `if (status) print(SUCCESS!) [=E2=80=A6]</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/push.h:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/869/comment/940bc697_89ca7f9f">Patch Set #16, Line 54:</a> <code sty=
le=3D"font-family:monospace,monospace"></code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This does con=
fuse me a bit. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">you can get the cid only from management, but th=
eoretically the rest could be used by other functions in the future</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push_ut=
il.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/869/comment/ccbe9b3d_34774f2d">Patch Set #16=
, Line 66:</a> <code style=3D"font-family:monospace,monospace">/* Allocate =
memory and asseble the final message */</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">typo</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869/comment/a9514=
c2d_3d9f4c1f">Patch Set #16, Line 82:</a> <code style=3D"font-family:monosp=
ace,monospace">    }</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">it might increase readability to=
 juse use `snprintf( ... [=E2=80=A6]</blockquote></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/869/comment/bc395641_798e9979">Patch Set #16, L=
ine 122:</a> <code style=3D"font-family:monospace,monospace">            ms=
gs[im] =3D forge_msg(str, &quot;,push-continuation 2&quot;, gc);</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">I do wonder if this can be done without modifying the string, s=
o getting rid of the `strdup()` requi [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869/comment/9e0a4d3f_be2f=
daaa">Patch Set #16, Line 143:</a> <code style=3D"font-family:monospace,mon=
ospace">/* It actually send the already divided messagge to one single clie=
nt */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">This comment needs a visit from the grammar pol=
ice ;-) [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/869/comment/c617f505_475db955">Patch Set #16, Line 158:</a> <cod=
e style=3D"font-family:monospace,monospace">        buf_write(&amp;buf, msg=
s[i], strlen(msgs[i]));</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">If you want to have the messa=
ge in a `buf` here, you could have `forge_msg()` just use `buf_printf() [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">ok, working on it</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/869/comment/ac640134_01fb9aae">Patch Set #16, Line 165:</a> =
<code style=3D"font-family:monospace,monospace">        /* After sending th=
e control message, we update the options server-side in the client&#39;s co=
ntext */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">Can you extend the comment a bit on why this=
 is needed?  I assume (which might or might not be a bad [=E2=80=A6]</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869/comment/7a7=
3548b_cfd887a6">Patch Set #16, Line 204:</a> <code style=3D"font-family:mon=
ospace,monospace">    if (!message_splitter(gc_strdup(msg, &amp;gc), msgs, =
&amp;gc, safe_cap))</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">Please do not call `strdup()` in =
a function call... [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/869/comment/4e68ba97_68899c76">Patch Set #16, Line 23=
9:</a> <code style=3D"font-family:monospace,monospace"></code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">how can we ever end here if ENABLE_MANAGEMENT is not defined?  Except fo=
r the unit test, there is no [=E2=80=A6]</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">We can&#39;t now, yes, but the fun=
ction could be used somewhere else in the future</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/869/comment/d6fc2d7c_558c5256">Patch Set=
 #16, Line 305:</a> <code style=3D"font-family:monospace,monospace">    RET=
URN_UPDATE_STATUS(n_sent);</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">so here we have this nice =
if/else macro that manage.c could use :-)... [=E2=80=A6]</blockquote></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">i need to do the l=
ookup anyway in send_push_update(), so it would duplicate code with no good=
 reason i think, but i can use the macro anyway, np</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=
=3Demail">change 869</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d=
1a323ed8df3fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 869 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 17 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 24 Jul 2025 08:21:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0CYmKiTrKRs=--

