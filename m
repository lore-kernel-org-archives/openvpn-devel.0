From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Jan 2024 16:45:08 +0000
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <ba848292c7ddc5ec701fdfc40a3759f377a17439-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DbXDjfk+TjI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement the
 --tls-export-cert feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DbXDjfk+TjI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/466?usp=3Demail )

Change subject: Implement the --tls-export-cert feature
......................................................................


Patch Set 7:

(4 comments)

Patchset:

PS6:
So we have to decide how to go about this. The current patch only So just e=
xporting and providing


File doc/man-sections/script-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/f8e03d25_01b36152 :
PS6, Line 426: --tls-export-cert-path dir
> the manpage calls the option "tls-export-cert-path", while options. [=E2=
=80=A6]
Ooops missed that one.


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/e88dae53_952dc331 :
PS6, Line 3339:     to.export_peer_cert_dir =3D options->tls_export_peer_ce=
rt_path;
> why call this "_dir" in the to, and "_path" in options-> ?
Fixed and now using always _dir


File src/openvpn/ssl_verify.c:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/6cb0e20f_1acc6fec :
PS6, Line 734:     if (opt->export_peer_cert_dir)
> So I tried to understand why it seemed to work in my testing. [=E2=80=A6]
This version of the patch now removes the environment variable together wit=
h the file. That is not as intrusive and should give at least backwards com=
patibility for now. The better solution is more complicated and requires mo=
dification to env handling (or even lot bigger refactoring) and is moved to=
 follow up patches.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2
Gerrit-Change-Number: 466
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 02 Jan 2024 16:45:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--DbXDjfk+TjI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
466?tab=3Dcomments">Patch Set #6:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">So we have to decide how to go about this. The cu=
rrent patch only So just exporting and providing</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File doc/man-sections/script-options.rst:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/466/comment/f8e03d25_01b36152">Patch Set #6, Line 4=
26:</a> <code style=3D"font-family:monospace,monospace">--tls-export-cert-p=
ath dir</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">the manpage calls the option &quot;tls-export=
-cert-path&quot;, while options. [=E2=80=A6]</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Ooops missed that one.</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/466/comment/e88dae53_952dc331">Patch Set #6, Line=
 3339:</a> <code style=3D"font-family:monospace,monospace">    to.export_pe=
er_cert_dir =3D options-&gt;tls_export_peer_cert_path;</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">why call this &quot;_dir&quot; in the to, and &quot;_path&quot; in option=
s-&gt; ?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Fixed and now using always _dir</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/ssl_verify.c:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/466/comment/6cb0e20f_1acc6fec">Patch Set #6, Line 734:</a> <code style=
=3D"font-family:monospace,monospace">    if (opt-&gt;export_peer_cert_dir)<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">So I tried to understand why it seemed to work in my =
testing. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">This version of the patch now removes the environment =
variable together with the file. That is not as intrusive and should give a=
t least backwards compatibility for now. The better solution is more compli=
cated and requires modification to env handling (or even lot bigger refacto=
ring) and is moved to follow up patches.</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">ch=
ange 466</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b=
4cebd0bf19ce2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 466 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 02 Jan 2024 16:45:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--DbXDjfk+TjI=--

