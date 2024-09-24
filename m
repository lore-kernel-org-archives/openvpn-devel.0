From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 08:21:53 +0000
In-Reply-To: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
References: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <1d2c6c4bb2b556a37ccbd583be314c7509871b2f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EVEZ/YUwhtg="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EVEZ/YUwhtg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/747?usp=3Demail )

Change subject: Introduce DRIVER_AFUNIX backend for use with lwipovpn
......................................................................


Patch Set 10:

(7 comments)

File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/dc90dae1_5d368c9f :
PS10, Line 306:         return false;
> blank missing, and I would not wrap a single word
Done


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/786d9bf0_01d92300 :
PS10, Line 1325:         c->c2.buf.len =3D tun_afunix_read(c->c1.tuntap, BP=
TR(&c->c2.buf), c->c2.frame.buf.payload_size);
> the monk in me complains that `read_tun()` should be paired with `read_tu=
n_afunix()`... [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/747/comment/4985ee6c_466dd8db :
PS10, Line 1939:             size =3D tun_afunix_write(c->c1.tuntap, BPTR(&=
c->c2.to_tun), BLEN(&c->c2.to_tun));
> see above ;-)
Done


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/9d2a0551_4486932b :
PS10, Line 2060:             tun_afunix_close(c->c1.tuntap);
> you are using `open_tun_afunix()` for `open_tun()`, so this really should=
 be `close_tun_afunix()` th [=E2=80=A6]
Done


File src/openvpn/run_command.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/128d3fd4_13147565 :
PS10, Line 52: #define S_NOWAITPID   (1<<3)
> the indenting here looks like one is using tab, one is using spaces
Done


File src/openvpn/tun_afunix.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/56f93adc_cb7474df :
PS10, Line 39: #if defined(AF_UNIX) && !defined(WIN32)
> I do wonder if the conditional on `AF_UNIX` is really needed (here and el=
sewhere). [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/747/comment/11503245_d6c4ddaf :
PS10, Line 125:
> should we `wait()`?  Or are we handling SIGCHLD elsewhere?
I am not sure that waiting is really needed. We could wait to ensure that t=
he child really exits. We currently ignore SIGCHLD and that means that the =
process will just die.



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 24 Sep 2024 08:21:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--EVEZ/YUwhtg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">View C=
hange</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/747/comment/dc90dae1_5d368c9f">Patch Set #10, Line 306:</a> <=
code style=3D"font-family:monospace,monospace">        return false;</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">blank missing, and I would not wrap a single word</blockquo=
te></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forw=
ard.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/747/comment/786d9bf0_01d92300">Patch Set #1=
0, Line 1325:</a> <code style=3D"font-family:monospace,monospace">        c=
-&gt;c2.buf.len =3D tun_afunix_read(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf=
), c-&gt;c2.frame.buf.payload_size);</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">the monk in me c=
omplains that `read_tun()` should be paired with `read_tun_afunix()`... [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/747/comment/4985ee6c_466dd8db">Patch Set #10, Line 1939:</a> <code style=
=3D"font-family:monospace,monospace">            size =3D tun_afunix_write(=
c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.to_tun));</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">see above ;-)</blockquote></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
47/comment/9d2a0551_4486932b">Patch Set #10, Line 2060:</a> <code style=3D"=
font-family:monospace,monospace">            tun_afunix_close(c-&gt;c1.tunt=
ap);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">you are using `open_tun_afunix()` for `open_tun(=
)`, so this really should be `close_tun_afunix()` th [=E2=80=A6]</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/run_c=
ommand.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/747/comment/128d3fd4_13147565">Patch Set=
 #10, Line 52:</a> <code style=3D"font-family:monospace,monospace">#define =
S_NOWAITPID   (1&lt;&lt;3)</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">the indenting here looks l=
ike one is using tab, one is using spaces</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun_afunix.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/747/comment/56f93adc_cb7474df">Patch Set #10, Line 39:</a> <co=
de style=3D"font-family:monospace,monospace">#if defined(AF_UNIX) &amp;&amp=
; !defined(WIN32)</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">I do wonder if the conditional on `=
AF_UNIX` is really needed (here and elsewhere). [=E2=80=A6]</blockquote></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/11503245_d6c=
4ddaf">Patch Set #10, Line 125:</a> <code style=3D"font-family:monospace,mo=
nospace"></code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">should we `wait()`?  Or are we handling SIG=
CHLD elsewhere?</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">I am not sure that waiting is really needed. We could wait =
to ensure that the child really exits. We currently ignore SIGCHLD and that=
 means that the process will just die.</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">chan=
ge 747</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 24 Sep 2024 08:21:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--EVEZ/YUwhtg=--

