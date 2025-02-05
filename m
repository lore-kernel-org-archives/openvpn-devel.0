From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 5 Feb 2025 19:11:20 +0000
In-Reply-To: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
References: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <fbbaeff35db272492b24595751b861586d36896b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="grSAFycDJTs="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco-win: multipeer
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--grSAFycDJTs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/815?usp=3Demail )

Change subject: dco-win: multipeer support
......................................................................


Patch Set 18: Code-Review-1

(13 comments)

Patchset:

PS18:
Oh well, when I start, I tend to find things... sorry for that.


File src/openvpn/dco_win.h:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/8bc501cb_073ac40b :
PS18, Line 42:     dco_mode_type mode;
I'm not really happy with that.  `dco_linux` has its own very similar enum,=
 with uppercase `DCO_MODE_<xx>` and calls the member variable `dco->ifmode`=
.  Since it does the same thing, can you name the windows variant `ifmode` =
as well, and also use uppercase for the enum?  (re-using the enum is not tr=
ivial because it comes from `ovpn_dco_linux.h` but won't be necessary, I th=
ink, as long as it's clear "it does the same thing").

Maybe `ovpn_dco_init()` can also be modeled to be more lookalike?


File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/9f12680a_836a673a :
PS18, Line 127:
A few words of comment somewhere on the call chain "who calls what, in whic=
h sequence" for p2p and mp mode would help me get less confused... there's =
so many "open", "init" and "start" functions here.


http://gerrit.openvpn.net/c/openvpn/+/815/comment/410773f9_bc0b637c :
PS18, Line 132:     dco->mode =3D (mode =3D=3D MODE_POINT_TO_POINT) ? dco_m=
ode_p2p : dco_mode_mp;
that comment is slightly confusing - if it is "already set", then why do we=
 set it again?


http://gerrit.openvpn.net/c/openvpn/+/815/comment/f14e44de_56a2dc7b :
PS18, Line 146:     OVPN_MODE m =3D OVPN_MODE_MP;
here we have a new define for communication between driver and userland, wh=
ich does the same as `dco_mode_mp`...


http://gerrit.openvpn.net/c/openvpn/+/815/comment/aaa33b91_1d10db5c :
PS18, Line 291:     if (out.ListenAddress.Addr4.sin_family =3D=3D AF_INET)
This part confuses me.  What is `out`?  Why is it put into `actual.dest`?  =
This seems to be the address of the peer we're talking to, judging from oth=
er uses of `actual.dest` but then it shouldn't be tied to the "global" DCO =
opening, but to individual peers?   Or am I totally misunderstanding this?


http://gerrit.openvpn.net/c/openvpn/+/815/comment/ac5dc11e_4884b3b4 :
PS18, Line 393: {
I do wonder why this is necessary.  "Use best source for destination" is wh=
at happens automatically when passing an UDP packet without source to `send=
to()`.  Is this different in kernel space?  Why was this not needed for p2p=
 win-dco?

(As in, if kernel space will automatically put the "best source" in the pac=
ket anyway, we can just get rid of all code dealing with "best_src")


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/c2131d8c_f342751d :
PS18, Line 1326:         bool prepend_sa =3D c->options.mode =3D=3D MODE_SE=
RVER && dco_enabled(&c->options);
we do have `SF_PREPEND_SA` set on the sockflags - is that available here?


File src/openvpn/ovpn_dco_win.h:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/bd9f5732_254ace41 :
PS18, Line 120: } OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;
these two are not part of *this* patch set, and might need revisiting for "=
the new epoch thing"


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/141b9fd2_5cf1aa60 :
PS18, Line 2256:     else
since there is a "goto done" in the `if()` we could get rid of the `else` a=
nd the dangling brackets outside of the #endif...


http://gerrit.openvpn.net/c/openvpn/+/815/comment/0df307dd_57fedb84 :
PS18, Line 3857:             sa_len =3D sizeof(struct sockaddr_in);
the repetition of `sizeof(struct sockaddr_in)` makes my eyes hurt... what a=
bout assigning `sa_len` first and then doing `if (buf_len() < sa_len)... me=
mcpy(...sa_len)` etc?


http://gerrit.openvpn.net/c/openvpn/+/815/comment/f9087006_6ac2ed8b :
PS18, Line 3867:             sa_len =3D sizeof(struct sockaddr_in6);
same here


http://gerrit.openvpn.net/c/openvpn/+/815/comment/445a211f_710bf77b :
PS18, Line 3957:         read_sockaddr_from_overlapped(io, &from->dest.addr=
.sa, ret);
I do not understand these two `sh.is_handle` cases.  Isn't this always a ha=
ndle on windows?  Or is this the "regular socket" case, and only wintun + d=
co have `is_handle`?

Also, the conditon on `if (from)` is interesting, so if `from` happens to b=
e NULL, we wouldn't `read_sockaddr_from_packet()` and subsequently the pack=
et will be malformed... can it ever be NULL here?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6eb89021f32dba
Gerrit-Change-Number: 815
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Wed, 05 Feb 2025 19:11:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--grSAFycDJTs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>Patch set 18:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail">V=
iew Change</a></p><p>13 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/815?tab=3Dcomments">Patch Set #18:</a> </p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Oh well, when I start, I tend to find thin=
gs... sorry for that.</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/dco_win.h:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment/8bc50=
1cb_073ac40b">Patch Set #18, Line 42:</a> <code style=3D"font-family:monosp=
ace,monospace">    dco_mode_type mode;</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">I&#39;m not really happy with that.  `dco_=
linux` has its own very similar enum, with uppercase `DCO_MODE_&lt;xx&gt;` =
and calls the member variable `dco-&gt;ifmode`.  Since it does the same thi=
ng, can you name the windows variant `ifmode` as well, and also use upperca=
se for the enum?  (re-using the enum is not trivial because it comes from `=
ovpn_dco_linux.h` but won&#39;t be necessary, I think, as long as it&#39;s =
clear &quot;it does the same thing&quot;).</p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Maybe `ovpn_dco_init()` can also be modeled t=
o be more lookalike?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/dco_win.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment/9f1268=
0a_836a673a">Patch Set #18, Line 127:</a> <code style=3D"font-family:monosp=
ace,monospace"></code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">A few words of comment somewhere on the call chain &quot;who call=
s what, in which sequence&quot; for p2p and mp mode would help me get less =
confused... there&#39;s so many &quot;open&quot;, &quot;init&quot; and &quo=
t;start&quot; functions here.</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/815/comment/410773f9_bc0b637c">Patch Set #18, Line 132:</a>=
 <code style=3D"font-family:monospace,monospace">    dco-&gt;mode =3D (mode=
 =3D=3D MODE_POINT_TO_POINT) ? dco_mode_p2p : dco_mode_mp;</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">that comment is slight=
ly confusing - if it is &quot;already set&quot;, then why do we set it agai=
n?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment=
/f14e44de_56a2dc7b">Patch Set #18, Line 146:</a> <code style=3D"font-family=
:monospace,monospace">    OVPN_MODE m =3D OVPN_MODE_MP;</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">here we have a new defin=
e for communication between driver and userland, which does the same as `dc=
o_mode_mp`...</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
815/comment/aaa33b91_1d10db5c">Patch Set #18, Line 291:</a> <code style=3D"=
font-family:monospace,monospace">    if (out.ListenAddress.Addr4.sin_family=
 =3D=3D AF_INET)</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">This part confuses me.  What is `out`?  Why is it put into `actu=
al.dest`?  This seems to be the address of the peer we&#39;re talking to, j=
udging from other uses of `actual.dest` but then it shouldn&#39;t be tied t=
o the &quot;global&quot; DCO opening, but to individual peers?   Or am I to=
tally misunderstanding this?</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/815/comment/ac5dc11e_4884b3b4">Patch Set #18, Line 393:</a> =
<code style=3D"font-family:monospace,monospace">{</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I do wonder why this is necessa=
ry.  &quot;Use best source for destination&quot; is what happens automatica=
lly when passing an UDP packet without source to `sendto()`.  Is this diffe=
rent in kernel space?  Why was this not needed for p2p win-dco?</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">(As in, if kernel space =
will automatically put the &quot;best source&quot; in the packet anyway, we=
 can just get rid of all code dealing with &quot;best_src&quot;)</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/815/comment/c2131d8c_f342751d">Patch Set #18, Lin=
e 1326:</a> <code style=3D"font-family:monospace,monospace">        bool pr=
epend_sa =3D c-&gt;options.mode =3D=3D MODE_SERVER &amp;&amp; dco_enabled(&=
amp;c-&gt;options);</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">we do have `SF_PREPEND_SA` set on the sockflags - is that ava=
ilable here?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/ovpn_dco_win.h:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment/bd9f5732_=
254ace41">Patch Set #18, Line 120:</a> <code style=3D"font-family:monospace=
,monospace">} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">these two are not part=
 of *this* patch set, and might need revisiting for &quot;the new epoch thi=
ng&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src=
/openvpn/socket.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment/141b9fd2_5cf1aa60">=
Patch Set #18, Line 2256:</a> <code style=3D"font-family:monospace,monospac=
e">    else</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">since there is a &quot;goto done&quot; in the `if()` we could get rid=
 of the `else` and the dangling brackets outside of the #endif...</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment/0df307dd_57=
fedb84">Patch Set #18, Line 3857:</a> <code style=3D"font-family:monospace,=
monospace">            sa_len =3D sizeof(struct sockaddr_in);</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">the repetition of `=
sizeof(struct sockaddr_in)` makes my eyes hurt... what about assigning `sa_=
len` first and then doing `if (buf_len() &lt; sa_len)... memcpy(...sa_len)`=
 etc?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comm=
ent/f9087006_6ac2ed8b">Patch Set #18, Line 3867:</a> <code style=3D"font-fa=
mily:monospace,monospace">            sa_len =3D sizeof(struct sockaddr_in6=
);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">sam=
e here</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/com=
ment/445a211f_710bf77b">Patch Set #18, Line 3957:</a> <code style=3D"font-f=
amily:monospace,monospace">        read_sockaddr_from_overlapped(io, &amp;f=
rom-&gt;dest.addr.sa, ret);</code></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">I do not understand these two `sh.is_handle` cases.  =
Isn&#39;t this always a handle on windows?  Or is this the &quot;regular so=
cket&quot; case, and only wintun + dco have `is_handle`?</p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Also, the conditon on `if (from=
)` is interesting, so if `from` happens to be NULL, we wouldn&#39;t `read_s=
ockaddr_from_packet()` and subsequently the packet will be malformed... can=
 it ever be NULL here?</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail">change 815</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/815?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6=
eb89021f32dba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 815 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Feb 2025 19:11:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--grSAFycDJTs=--

