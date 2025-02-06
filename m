From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 6 Feb 2025 18:45:33 +0000
In-Reply-To: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
References: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <06d34c764f05cf97aeae1b401f49e0c66284b349-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vlGRm8e4x5g="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vlGRm8e4x5g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/815?usp=3Demail )

Change subject: dco-win: multipeer support
......................................................................


Patch Set 19:

(12 comments)

File src/openvpn/dco_win.h:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/4fc86de9_75204ca5 :
PS18, Line 42:     dco_mode_type mode;
> I'm not really happy with that. [=E2=80=A6]
Acknowledged


File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/958d5b8c_a18c12a8 :
PS18, Line 127:
> A few words of comment somewhere on the call chain "who calls what, in wh=
ich sequence" for p2p and m [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/815/comment/23adf9fa_be8de950 :
PS18, Line 132:     dco->mode =3D (mode =3D=3D MODE_POINT_TO_POINT) ? dco_m=
ode_p2p : dco_mode_mp;
> that comment is slightly confusing - if it is "already set", then why do =
we set it again?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/815/comment/7778dea2_f293c54f :
PS18, Line 146:     OVPN_MODE m =3D OVPN_MODE_MP;
> here we have a new define for communication between driver and userland, =
which does the same as `dco [=E2=80=A6]
Yeah, this one is from the driver API. But I see the frustration.


http://gerrit.openvpn.net/c/openvpn/+/815/comment/0dc53053_22601180 :
PS18, Line 291:     if (out.ListenAddress.Addr4.sin_family =3D=3D AF_INET)
> This part confuses me.  What is `out`?  Why is it put into `actual. [=E2=
=80=A6]
The driver writes to out the local transport address of the socket after th=
e bind() call. But we already know the local bind address, except maybe the=
 port, we probably don't want to bind to port 0. It seems that there is no =
use of this data, so I'll remove those lines.


http://gerrit.openvpn.net/c/openvpn/+/815/comment/26e4fbd9_488525de :
PS18, Line 393: {
> I do wonder why this is necessary. [=E2=80=A6]
I see. At the moment driver doesn't use local transport address of the peer=
, although this is a part of API. I will remove this code.


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/ea8ee09a_b0ad999b :
PS18, Line 1326:         bool prepend_sa =3D c->options.mode =3D=3D MODE_SE=
RVER && dco_enabled(&c->options);
> we do have `SF_PREPEND_SA` set on the sockflags - is that available here?
Actually we cannot end up here when using DCO. So prepend_sa should be fals=
e and I will add an ASSERT(!dco_enabled(&c->options));


File src/openvpn/ovpn_dco_win.h:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/98441252_eacace58 :
PS18, Line 120: } OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;
> these two are not part of *this* patch set, and might need revisiting for=
 "the new epoch thing"
Acknowledged


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/9f6896eb_6e2a0bdf :
PS18, Line 2256:     else
> since there is a "goto done" in the `if()` we could get rid of the `else`=
 and the dangling brackets  [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/815/comment/be0ef538_110ecee4 :
PS18, Line 3857:             sa_len =3D sizeof(struct sockaddr_in);
> the repetition of `sizeof(struct sockaddr_in)` makes my eyes hurt... [=E2=
=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/815/comment/c8f0d980_977d5293 :
PS18, Line 3867:             sa_len =3D sizeof(struct sockaddr_in6);
> same here
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/815/comment/69e4d1f0_887d9531 :
PS18, Line 3957:         read_sockaddr_from_overlapped(io, &from->dest.addr=
.sa, ret);
> I do not understand these two `sh.is_handle` cases. [=E2=80=A6]
SH could be either file descriptor (in case of non-dco link) or handle (non=
-dco tun and dco link).

`from` is NULL in case of non-dco tun and read tcp link - but my patch hasn=
't changed that.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6eb89021f32dba
Gerrit-Change-Number: 815
Gerrit-PatchSet: 19
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 06 Feb 2025 18:45:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--vlGRm8e4x5g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail">View C=
hange</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_win.h:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/815/comment/4fc86de9_75204ca5">Patch Set #18, Line 42:</=
a> <code style=3D"font-family:monospace,monospace">    dco_mode_type mode;<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">I&#39;m not really happy with that. [=E2=80=A6]</bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ackno=
wledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/dco_win.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment/958d5b8c_a18c12a8">=
Patch Set #18, Line 127:</a> <code style=3D"font-family:monospace,monospace=
"></code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">A few words of comment somewhere on the call chain=
 &quot;who calls what, in which sequence&quot; for p2p and m [=E2=80=A6]</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ac=
knowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
15/comment/23adf9fa_be8de950">Patch Set #18, Line 132:</a> <code style=3D"f=
ont-family:monospace,monospace">    dco-&gt;mode =3D (mode =3D=3D MODE_POIN=
T_TO_POINT) ? dco_mode_p2p : dco_mode_mp;</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">that commen=
t is slightly confusing - if it is &quot;already set&quot;, then why do we =
set it again?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/815/comment/7778dea2_f293c54f">Patch Set #18, Line 146:</a> <c=
ode style=3D"font-family:monospace,monospace">    OVPN_MODE m =3D OVPN_MODE=
_MP;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">here we have a new define for communication betw=
een driver and userland, which does the same as `dco [=E2=80=A6]</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Yeah, this=
 one is from the driver API. But I see the frustration.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment/0dc53053_22601180">=
Patch Set #18, Line 291:</a> <code style=3D"font-family:monospace,monospace=
">    if (out.ListenAddress.Addr4.sin_family =3D=3D AF_INET)</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">This part confuses me.  What is `out`?  Why is it put into `actual.=
 [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">The driver writes to out the local transport address of the so=
cket after the bind() call. But we already know the local bind address, exc=
ept maybe the port, we probably don&#39;t want to bind to port 0. It seems =
that there is no use of this data, so I&#39;ll remove those lines.</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment/26e4fbd9_4=
88525de">Patch Set #18, Line 393:</a> <code style=3D"font-family:monospace,=
monospace">{</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">I do wonder why this is necessary. [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">I see. At the moment driver doesn&#39;t use local transport address=
 of the peer, although this is a part of API. I will remove this code.</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forw=
ard.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/815/comment/ea8ee09a_b0ad999b">Patch Set #1=
8, Line 1326:</a> <code style=3D"font-family:monospace,monospace">        b=
ool prepend_sa =3D c-&gt;options.mode =3D=3D MODE_SERVER &amp;&amp; dco_ena=
bled(&amp;c-&gt;options);</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">we do have `SF_PREPEND_SA` =
set on the sockflags - is that available here?</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Actually we cannot end up he=
re when using DCO. So prepend_sa should be false and I will add an ASSERT(!=
dco_enabled(&amp;c-&gt;options));</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/ovpn_dco_win.h:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
815/comment/98441252_eacace58">Patch Set #18, Line 120:</a> <code style=3D"=
font-family:monospace,monospace">} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA=
_V2;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">these two are not part of *this* patch set, and =
might need revisiting for &quot;the new epoch thing&quot;</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/sock=
et.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/815/comment/9f6896eb_6e2a0bdf">Patch Set #18=
, Line 2256:</a> <code style=3D"font-family:monospace,monospace">    else</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">since there is a &quot;goto done&quot; in the `if()` w=
e could get rid of the `else` and the dangling brackets  [=E2=80=A6]</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknow=
ledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/com=
ment/be0ef538_110ecee4">Patch Set #18, Line 3857:</a> <code style=3D"font-f=
amily:monospace,monospace">            sa_len =3D sizeof(struct sockaddr_in=
);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">the repetition of `sizeof(struct sockaddr_in)` mak=
es my eyes hurt... [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/815/comment/c8f0d980_977d5293">Patch Set #18,=
 Line 3867:</a> <code style=3D"font-family:monospace,monospace">           =
 sa_len =3D sizeof(struct sockaddr_in6);</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">same here</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ac=
knowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
15/comment/69e4d1f0_887d9531">Patch Set #18, Line 3957:</a> <code style=3D"=
font-family:monospace,monospace">        read_sockaddr_from_overlapped(io, =
&amp;from-&gt;dest.addr.sa, ret);</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I do not understand=
 these two `sh.is_handle` cases. [=E2=80=A6]</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">SH could be either file descri=
ptor (in case of non-dco link) or handle (non-dco tun and dco link).</p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">`from` is NULL in c=
ase of non-dco tun and read tcp link - but my patch hasn&#39;t changed that=
.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/815?usp=3Demail">change 815</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
815?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6=
eb89021f32dba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 815 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 06 Feb 2025 18:45:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--vlGRm8e4x5g=--

