From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 23 Sep 2024 15:18:55 +0000
In-Reply-To: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
References: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7ffdd4cd208ee0e7aa447a0f97da20e6527d98b3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WwY6W/qo++E="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Introduce
 DRIVER_AFUNIX backend for use with lwipovpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WwY6W/qo++E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/747?usp=3Demail )

Change subject: Introduce DRIVER_AFUNIX backend for use with lwipovpn
......................................................................


Patch Set 10: Code-Review-1

(8 comments)

Patchset:

PS10:
I haven't seen any hard show-stopper, but a few minor nags...


File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/df7a0350_ee091375 :
PS10, Line 306:         return false;
blank missing, and I would not wrap a single word


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/f9ab8f69_a3d074cf :
PS10, Line 1325:         c->c2.buf.len =3D tun_afunix_read(c->c1.tuntap, BP=
TR(&c->c2.buf), c->c2.frame.buf.payload_size);
the monk in me complains that `read_tun()` should be paired with `read_tun_=
afunix()`...  but that is minor


http://gerrit.openvpn.net/c/openvpn/+/747/comment/6ded27c5_58f53265 :
PS10, Line 1939:             size =3D tun_afunix_write(c->c1.tuntap, BPTR(&=
c->c2.to_tun), BLEN(&c->c2.to_tun));
see above ;-)


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/57540e5b_f2836507 :
PS10, Line 2060:             tun_afunix_close(c->c1.tuntap);
you are using `open_tun_afunix()` for `open_tun()`, so this really should b=
e `close_tun_afunix()` then...


File src/openvpn/run_command.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/c06210e8_581e4f52 :
PS10, Line 52: #define S_NOWAITPID   (1<<3)
the indenting here looks like one is using tab, one is using spaces


File src/openvpn/tun_afunix.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/57db59bc_b1c8c8db :
PS10, Line 39: #if defined(AF_UNIX) && !defined(WIN32)
I do wonder if the conditional on `AF_UNIX` is really needed (here and else=
where).  All OSes we support have AF_UNIX sockets...


http://gerrit.openvpn.net/c/openvpn/+/747/comment/50341699_b37fbb94 :
PS10, Line 125:
should we `wait()`?  Or are we handling SIGCHLD elsewhere?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7
Gerrit-Change-Number: 747
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 23 Sep 2024 15:18:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--WwY6W/qo++E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">V=
iew Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/747?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I haven&#39;t seen any hard show-stopper, b=
ut a few minor nags...</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/dco.c:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/df7a0350=
_ee091375">Patch Set #10, Line 306:</a> <code style=3D"font-family:monospac=
e,monospace">        return false;</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">blank missing, and I would not wrap a single w=
ord</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/forward.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/f9ab8f69_a3d074cf">Pa=
tch Set #10, Line 1325:</a> <code style=3D"font-family:monospace,monospace"=
>        c-&gt;c2.buf.len =3D tun_afunix_read(c-&gt;c1.tuntap, BPTR(&amp;c-=
&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);</code></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">the monk in me complains that `rea=
d_tun()` should be paired with `read_tun_afunix()`...  but that is minor</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/6ded=
27c5_58f53265">Patch Set #10, Line 1939:</a> <code style=3D"font-family:mon=
ospace,monospace">            size =3D tun_afunix_write(c-&gt;c1.tuntap, BP=
TR(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.to_tun));</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">see above ;-)</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/747/comment/57540e5b_f2836507">Patch Set #10, Line 2=
060:</a> <code style=3D"font-family:monospace,monospace">            tun_af=
unix_close(c-&gt;c1.tuntap);</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">you are using `open_tun_afunix()` for `open_tun()`, =
so this really should be `close_tun_afunix()` then...</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/run_command.h:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/747/comment/c06210e8_581e4f52">Patch Set #10, Line 52:</=
a> <code style=3D"font-family:monospace,monospace">#define S_NOWAITPID   (1=
&lt;&lt;3)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">the indenting here looks like one is using tab, one is using spaces</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tu=
n_afunix.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/747/comment/57db59bc_b1c8c8db">Patch S=
et #10, Line 39:</a> <code style=3D"font-family:monospace,monospace">#if de=
fined(AF_UNIX) &amp;&amp; !defined(WIN32)</code></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">I do wonder if the conditional on `AF_U=
NIX` is really needed (here and elsewhere).  All OSes we support have AF_UN=
IX sockets...</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
747/comment/50341699_b37fbb94">Patch Set #10, Line 125:</a> <code style=3D"=
font-family:monospace,monospace"></code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">should we `wait()`?  Or are we handling SIGCHLD=
 elsewhere?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/747?usp=3Demail">change 747</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/747?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65099ef00822d08fd3f5480c808=
92f3bf86c56e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 23 Sep 2024 15:18:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--WwY6W/qo++E=--

