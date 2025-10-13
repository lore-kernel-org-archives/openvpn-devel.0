From: "mrbff (Code Review)" <gerrit@...515...>
Date: Mon, 13 Oct 2025 08:59:48 +0000
In-Reply-To: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
References: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <a85e5986b1b2b220e70c5b359d10644f6e70298b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kk0K+5ZH97k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE server:
 remove old IP(s) from vhash after sending a messa...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kk0K+5ZH97k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

mrbff has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1253?usp=3Demail )

Change subject: PUSH_UPDATE server: remove old IP(s) from vhash after sendi=
ng a message containing ifconfig(-ipv6)
......................................................................


Patch Set 4:

(6 comments)

File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1253/comment/669873c8_f711dc79?usp=3D=
email :
PS3, Line 4296:     msg(D_MULTI_LOW, "MULTI: Remove: %s -> %s", mroute_addr=
_print(&r->addr, &gc), multi_instance_string(mi, false, &gc));
> this is too much logging ;-) [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1253/comment/94ace8fa_436f6223?usp=3D=
email :
PS3, Line 4301:
> we might have a memleak here.  I looked at the code in "multi. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1253/comment/cf4e61f7_f768ee6d?usp=3D=
email :
PS3, Line 4320:     ASSERT(mroute_extract_openvpn_sockaddr(&addr, &remote_s=
i, false));
> This works, but feels more clumsy than needed - looking through mroute.c,=
 I find [=E2=80=A6]
mroute_get_in_addr_t() and mroute_get_in6_add6() are a static inline (and i=
 suppose there is a reason for that, but even if not, why bother), anyway i=
 got your point and i tried to make the helper less clumsy and more symmetr=
ic.


http://gerrit.openvpn.net/c/openvpn/+/1253/comment/cec62582_b1eddb2e?usp=3D=
email :
PS3, Line 4339:
> `mroute_get_in6_addr(&addr, a6, 0)` does this for you
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1253/comment/5bac7178_9e782090?usp=3D=
email :
PS3, Line 4366:             old_addr.s_addr =3D ntohl(mi->context.c2.push_i=
fconfig_local);
> we could just do `in_addr_t old_addr =3D ... [=E2=80=A6]
Done


File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/1253/comment/79224a68_ad59ff25?usp=3D=
email :
PS3, Line 158:     memset(&o, 0, sizeof(struct options));
> please use `CLEAR(o);` for that. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Gerrit-Change-Number: 1253
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 13 Oct 2025 08:59:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>

--kk0K+5ZH97k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">View =
Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1253/comment/669873c8_f711dc79?usp=3Demail">Patch Set #3, =
Line 4296:</a> <code style=3D"font-family:monospace,monospace">    msg(D_MU=
LTI_LOW, &quot;MULTI: Remove: %s -&gt; %s&quot;, mroute_addr_print(&amp;r-&=
gt;addr, &amp;gc), multi_instance_string(mi, false, &amp;gc));</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">this is too much logging ;-) [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253/comment/94a=
ce8fa_436f6223?usp=3Demail">Patch Set #3, Line 4301:</a> <code style=3D"fon=
t-family:monospace,monospace"></code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">we might have a memlea=
k here.  I looked at the code in &quot;multi. [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253/comm=
ent/cf4e61f7_f768ee6d?usp=3Demail">Patch Set #3, Line 4320:</a> <code style=
=3D"font-family:monospace,monospace">    ASSERT(mroute_extract_openvpn_sock=
addr(&amp;addr, &amp;remote_si, false));</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This works, =
but feels more clumsy than needed - looking through mroute.c, I find [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">mroute_get_in_addr_t() and mroute_get_in6_add6() a=
re a static inline (and i suppose there is a reason for that, but even if n=
ot, why bother), anyway i got your point and i tried to make the helper les=
s clumsy and more symmetric.</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1253/comment/cec62582_b1eddb2e?usp=3Demail">Patch Set #3, Li=
ne 4339:</a> <code style=3D"font-family:monospace,monospace"></code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">`mroute_get_in6_addr(&amp;addr, a6, 0)` does this for you</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1253/comment/5bac7178_9e782090?usp=3Demail">Patch Set #3, Line 4366=
:</a> <code style=3D"font-family:monospace,monospace">            old_addr.=
s_addr =3D ntohl(mi-&gt;context.c2.push_ifconfig_local);</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">we could just do `in_addr_t old_addr =3D ... [=E2=80=A6]</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/push_util.c:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253/comment/79224a68_ad59ff2=
5?usp=3Demail">Patch Set #3, Line 158:</a> <code style=3D"font-family:monos=
pace,monospace">    memset(&amp;o, 0, sizeof(struct options));</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">please use `CLEAR(o);` for that. [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1253?usp=3Demail">change 1253</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1253?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde987=
02a9801616a5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1253 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 13 Oct 2025 08:59:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>

</body></html>=

--kk0K+5ZH97k=--

