From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 21 Jul 2025 19:53:36 +0000
In-Reply-To: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
References: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <7078822e92d000c630f546fed63ce81f369e6177-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l/bVItgiLIc="; charset=UTF-8
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
To: mrbff <marco@...2726...>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--l/bVItgiLIc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/869?usp=3Demail )

Change subject: PUSH_UPDATE message sender: enabling the server to send PUS=
H_UPDATE control messages
......................................................................


Patch Set 16: Code-Review-1

(13 comments)

Patchset:

PS16:
lots of string and buffer related nagging, plus some general questioning if=
 we need this in the full breadth...


File doc/management-notes.txt:

http://gerrit.openvpn.net/c/openvpn/+/869/comment/a8274ef9_1e452d98 :
PS16, Line 1075:
I do question whether this is a reasonable approach, to have "by cn" and "b=
y addr" functions, that add code (... that needs to be tested and maintaine=
d) when a management client can just look up the CID itself, and then do `p=
ush-update-cid`?

Is this something AS wants?  Or "let's just do all variants, so nobody comp=
lains about a missing feature"?


File src/openvpn/manage.c:

http://gerrit.openvpn.net/c/openvpn/+/869/comment/54080c2e_539d2c6e :
PS16, Line 1362:         }
I bet there are more elegant and less repetitive ways to do 4 different `if=
 (status) print(SUCCESS!) else print(ERROR)` blocks...


File src/openvpn/push.h:

http://gerrit.openvpn.net/c/openvpn/+/869/comment/f1e00c73_49d8e6c7 :
PS16, Line 54:
This does confuse me a bit.  If we have no ENABLE_MANAGEMENT, why would we =
have UPD_BY_ADDR or UPD_BY_CN?  Is this usable from a plugin interface or a=
 script?


File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/869/comment/fb47d1a4_53787e8b :
PS16, Line 66: /* Allocate memory and asseble the final message */
typo


http://gerrit.openvpn.net/c/openvpn/+/869/comment/384c531b_cb1d0b7b :
PS16, Line 82:     }
it might increase readability to juse use `snprintf( ... "%s,%s%s", push_up=
date_cmd, src, continuation? continuation: 0)` here... and get rid of `i`.

Or use `buf_printf()` and get rid of the length and malloc stuff...  (retur=
ning `BSTR(&buf)` then).


http://gerrit.openvpn.net/c/openvpn/+/869/comment/e1cd130c_c8e39305 :
PS16, Line 122:             msgs[im] =3D forge_msg(str, ",push-continuation=
 2", gc);
I do wonder if this can be done without modifying the string, so getting ri=
d of the `strdup()` requirement...


http://gerrit.openvpn.net/c/openvpn/+/869/comment/5e9e0424_e91519f2 :
PS16, Line 143: /* It actually send the already divided messagge to one sin=
gle client */
This comment needs a visit from the grammar police ;-)

```
/* send the message(s) prepared to one single client */
```


http://gerrit.openvpn.net/c/openvpn/+/869/comment/648be3fc_6ea876c8 :
PS16, Line 158:         buf_write(&buf, msgs[i], strlen(msgs[i]));
If you want to have the message in a `buf` here, you could have `forge_msg(=
)` just use `buf_printf()` and return the resulting `buf`...?


http://gerrit.openvpn.net/c/openvpn/+/869/comment/caf4cb50_9100e63f :
PS16, Line 165:         /* After sending the control message, we update the=
 options server-side in the client's context */
Can you extend the comment a bit on why this is needed?  I assume (which mi=
ght or might not be a bad idea) that this is so `ifconfig-push` and `ifconf=
ig-ipv6-push`  can work?  `cipher` etc. is not PUSH_UPDATE-able, and most o=
ther options the server should not care about?  But without a bit of more s=
pecific explanation, this is very, uh, non-intuitive stuff.


http://gerrit.openvpn.net/c/openvpn/+/869/comment/693c5314_a1a08fa4 :
PS16, Line 204:     if (!message_splitter(gc_strdup(msg, &gc), msgs, &gc, s=
afe_cap))
Please do not call `strdup()` in a function call... yes, this works, but it=
 is hard to read and no gain compared to "just call strdup() at the beginni=
ng of `message_splutter()`  (if it turns out to be necessary).


http://gerrit.openvpn.net/c/openvpn/+/869/comment/8aa9f5e8_3e0aac7c :
PS16, Line 239:
how can we ever end here if ENABLE_MANAGEMENT is not defined?  Except for t=
he unit test, there is no caller remaining...


http://gerrit.openvpn.net/c/openvpn/+/869/comment/ecc7ac6a_56bfc11e :
PS16, Line 305:     RETURN_UPDATE_STATUS(n_sent);
so here we have this nice if/else macro that manage.c could use :-)... but =
only 3 out of 4 functions use it?  Can we not do the "does this CID exist?"=
 check in the caller (for `management_callback_send_push_update_by_cid()`)?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc
Gerrit-Change-Number: 869
Gerrit-PatchSet: 16
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Mon, 21 Jul 2025 19:53:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--l/bVItgiLIc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos, s=
tipa. </p>
<p>Patch set 16:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail">V=
iew Change</a></p><p>13 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/869?tab=3Dcomments">Patch Set #16:</a> </p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">lots of string and buffer related nagging,=
 plus some general questioning if we need this in the full breadth...</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/management-no=
tes.txt:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/869/comment/a8274ef9_1e452d98">Patch Set =
#16, Line 1075:</a> <code style=3D"font-family:monospace,monospace"></code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I do questio=
n whether this is a reasonable approach, to have &quot;by cn&quot; and &quo=
t;by addr&quot; functions, that add code (... that needs to be tested and m=
aintained) when a management client can just look up the CID itself, and th=
en do `push-update-cid`?</p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Is this something AS wants?  Or &quot;let&#39;s just do all var=
iants, so nobody complains about a missing feature&quot;?</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/869/comment/54080c2e_539d2c6e">Patch Set #16, Line 1362:<=
/a> <code style=3D"font-family:monospace,monospace">        }</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">I bet there are mor=
e elegant and less repetitive ways to do 4 different `if (status) print(SUC=
CESS!) else print(ERROR)` blocks...</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/push.h:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869/co=
mment/f1e00c73_49d8e6c7">Patch Set #16, Line 54:</a> <code style=3D"font-fa=
mily:monospace,monospace"></code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">This does confuse me a bit.  If we have no ENABLE_MANA=
GEMENT, why would we have UPD_BY_ADDR or UPD_BY_CN?  Is this usable from a =
plugin interface or a script?</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/push_util.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869/com=
ment/fb47d1a4_53787e8b">Patch Set #16, Line 66:</a> <code style=3D"font-fam=
ily:monospace,monospace">/* Allocate memory and asseble the final message *=
/</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">typo=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869/comment/3=
84c531b_cb1d0b7b">Patch Set #16, Line 82:</a> <code style=3D"font-family:mo=
nospace,monospace">    }</code></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">it might increase readability to juse use `snprintf( ...=
 &quot;%s,%s%s&quot;, push_update_cmd, src, continuation? continuation: 0)`=
 here... and get rid of `i`.</p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Or use `buf_printf()` and get rid of the length and malloc =
stuff...  (returning `BSTR(&amp;buf)` then).</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/869/comment/e1cd130c_c8e39305">Patch Set #16=
, Line 122:</a> <code style=3D"font-family:monospace,monospace">           =
 msgs[im] =3D forge_msg(str, &quot;,push-continuation 2&quot;, gc);</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I do wonder i=
f this can be done without modifying the string, so getting rid of the `str=
dup()` requirement...</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/869/comment/5e9e0424_e91519f2">Patch Set #16, Line 143:</a> <code s=
tyle=3D"font-family:monospace,monospace">/* It actually send the already di=
vided messagge to one single client */</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">This comment needs a visit from the gramma=
r police ;-)</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
```<br>/* send the message(s) prepared to one single client */<br>```</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869/comment/648be3f=
c_6ea876c8">Patch Set #16, Line 158:</a> <code style=3D"font-family:monospa=
ce,monospace">        buf_write(&amp;buf, msgs[i], strlen(msgs[i]));</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">If you want =
to have the message in a `buf` here, you could have `forge_msg()` just use =
`buf_printf()` and return the resulting `buf`...?</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/869/comment/caf4cb50_9100e63f">Patch Se=
t #16, Line 165:</a> <code style=3D"font-family:monospace,monospace">      =
  /* After sending the control message, we update the options server-side i=
n the client&#39;s context */</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Can you extend the comment a bit on why this is nee=
ded?  I assume (which might or might not be a bad idea) that this is so `if=
config-push` and `ifconfig-ipv6-push`  can work?  `cipher` etc. is not PUSH=
_UPDATE-able, and most other options the server should not care about?  But=
 without a bit of more specific explanation, this is very, uh, non-intuitiv=
e stuff.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869/c=
omment/693c5314_a1a08fa4">Patch Set #16, Line 204:</a> <code style=3D"font-=
family:monospace,monospace">    if (!message_splitter(gc_strdup(msg, &amp;g=
c), msgs, &amp;gc, safe_cap))</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Please do not call `strdup()` in a function call...=
 yes, this works, but it is hard to read and no gain compared to &quot;just=
 call strdup() at the beginning of `message_splutter()`  (if it turns out t=
o be necessary).</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/869/comment/8aa9f5e8_3e0aac7c">Patch Set #16, Line 239:</a> <code style=
=3D"font-family:monospace,monospace"></code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">how can we ever end here if ENABLE_MANAGEME=
NT is not defined?  Except for the unit test, there is no caller remaining.=
..</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869/comment=
/ecc7ac6a_56bfc11e">Patch Set #16, Line 305:</a> <code style=3D"font-family=
:monospace,monospace">    RETURN_UPDATE_STATUS(n_sent);</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">so here we have this nic=
e if/else macro that manage.c could use :-)... but only 3 out of 4 function=
s use it?  Can we not do the &quot;does this CID exist?&quot; check in the =
caller (for `management_callback_send_push_update_by_cid()`)?</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/869?usp=3Demail">change 869</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d=
1a323ed8df3fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 869 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Jul 2025 19:53:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--l/bVItgiLIc=--

