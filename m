From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 18 Sep 2025 13:55:45 +0000
In-Reply-To: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
References: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277..., gert@...1296...
Message-ID: <45157198bcd8ad8659cec586fa4e7cbb7d5221ae-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="swyV4NMu8Uk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: fix building of
 openvpnsrvmsg.dll from eventmsg.mc in mingw builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--swyV4NMu8Uk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1197?usp=3Demail )

Change subject: fix building of openvpnsrvmsg.dll from eventmsg.mc in mingw=
 builds
......................................................................


Patch Set 4:

(3 comments)

File src/openvpnserv/Makefile.am:

http://gerrit.openvpn.net/c/openvpn/+/1197/comment/b366bbb6_39e946fa :
PS2, Line 32: 	MSG00409.bin eventmsg.h eventmsg.rc openvpnservmsg.dll
> Is it intentional that `openvpnservmsg. [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1197/comment/9357acc2_b468f24e :
PS2, Line 46: 	$(CC) -shared -Wl,--entry=3D0 -nostdlib -nostartfiles -o ope=
nvpnservmsg.dll eventmsg.o
> This looks like it might fail with out-of-tree builds. Can you please ver=
ify that it works. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1197/comment/0472f96c_f7c0a629 :
PS2, Line 51: 	$(WINDMC) -U eventmsg.mc
> same concerns here
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I071e8190dac28f429257b8af1c6f9e68f8896bc0
Gerrit-Change-Number: 1197
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Thu, 18 Sep 2025 13:55:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--swyV4NMu8Uk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/Makefile.am:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1197/comment/b366bbb6_39e946fa">Patch Set #2, Line=
 32:</a> <code style=3D"font-family:monospace,monospace">	MSG00409.bin even=
tmsg.h eventmsg.rc openvpnservmsg.dll</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is it intention=
al that `openvpnservmsg. [=E2=80=A6]</blockquote></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1197/comment/9357acc2_b468f24e">Patch S=
et #2, Line 46:</a> <code style=3D"font-family:monospace,monospace">	$(CC) =
-shared -Wl,--entry=3D0 -nostdlib -nostartfiles -o openvpnservmsg.dll event=
msg.o</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">This looks like it might fail with out-of-tree =
builds. Can you please verify that it works. [=E2=80=A6]</blockquote></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1197/comment/0472f96c_f7c0a=
629">Patch Set #2, Line 51:</a> <code style=3D"font-family:monospace,monosp=
ace">	$(WINDMC) -U eventmsg.mc</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">same concerns here</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1197?usp=3Demail">change 1197</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1197?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I071e8190dac28f429257b8af1c6=
f9e68f8896bc0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1197 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 18 Sep 2025 13:55:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--swyV4NMu8Uk=--

