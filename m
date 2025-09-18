From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 18 Sep 2025 09:59:06 +0000
In-Reply-To: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
References: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <a2b696d3355938be71c55550ee654109dd6c2c96-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JO9PTbytquw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: add building of
 openvpnsrvmsg.dll from eventmsg.mc to autoconf/mingw ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JO9PTbytquw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1197?usp=3Demail )

Change subject: add building of openvpnsrvmsg.dll from eventmsg.mc to autoc=
onf/mingw builds
......................................................................


Patch Set 2: Code-Review-1

(3 comments)

File src/openvpnserv/Makefile.am:

http://gerrit.openvpn.net/c/openvpn/+/1197/comment/504cb947_ee947437 :
PS2, Line 32: 	MSG00409.bin eventmsg.h eventmsg.rc openvpnservmsg.dll
Is it intentional that `openvpnservmsg.dll` is in `noinst`? Shouldn't it be=
 installed?


http://gerrit.openvpn.net/c/openvpn/+/1197/comment/51bca724_b7505ca0 :
PS2, Line 46: 	$(CC) -shared -Wl,--entry=3D0 -nostdlib -nostartfiles -o ope=
nvpnservmsg.dll eventmsg.o
This looks like it might fail with out-of-tree builds. Can you please verif=
y that it works.
As a nitpick I would also recommend using `$@` and `$<`


http://gerrit.openvpn.net/c/openvpn/+/1197/comment/8d382386_4d9818d6 :
PS2, Line 51: 	$(WINDMC) -U eventmsg.mc
same concerns here



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I071e8190dac28f429257b8af1c6f9e68f8896bc0
Gerrit-Change-Number: 1197
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Thu, 18 Sep 2025 09:59:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--JO9PTbytquw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/Makefile.=
am:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1197/comment/504cb947_ee947437">Patch Set #2, =
Line 32:</a> <code style=3D"font-family:monospace,monospace">	MSG00409.bin =
eventmsg.h eventmsg.rc openvpnservmsg.dll</code></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Is it intentional that `openvpnservmsg.=
dll` is in `noinst`? Shouldn&#39;t it be installed?</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1197/comment/51bca724_b7505ca0">Patch=
 Set #2, Line 46:</a> <code style=3D"font-family:monospace,monospace">	$(CC=
) -shared -Wl,--entry=3D0 -nostdlib -nostartfiles -o openvpnservmsg.dll eve=
ntmsg.o</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">This looks like it might fail with out-of-tree builds. Can you please ver=
ify that it works.<br>As a nitpick I would also recommend using `$@` and `$=
&lt;`</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1197/com=
ment/8d382386_4d9818d6">Patch Set #2, Line 51:</a> <code style=3D"font-fami=
ly:monospace,monospace">	$(WINDMC) -U eventmsg.mc</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">same concerns here</p></li></ul=
></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1197?usp=3Demail">change 1197</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I071e8190dac28f429257b8af1c6=
f9e68f8896bc0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1197 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 18 Sep 2025 09:59:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--JO9PTbytquw=--

