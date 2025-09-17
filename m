From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 10:13:36 +0000
In-Reply-To: <gerrit.1758101669000.Idb137ecbade4b0584a4d74aee34978062e247bc5@...2715...>
References: <gerrit.1758101669000.Idb137ecbade4b0584a4d74aee34978062e247bc5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <837a36147b670c0fe92b457e0be9826ad9c7ea28-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j7wh5zlnlDs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 dev-tools/gerrit-send-mail.py: include Gerrit URL into the commit mes...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--j7wh5zlnlDs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1196?usp=3Demail )

Change subject: dev-tools/gerrit-send-mail.py: include Gerrit URL into the =
commit message
......................................................................


Patch Set 1: Code-Review-1

(3 comments)

Patchset:

PS1:
LGTM but please fix whitespace damage


File dev-tools/gerrit-send-mail.py:

http://gerrit.openvpn.net/c/openvpn/+/1196/comment/fa643897_51c57035 :
PS1, Line 109:         + acked_by_text
trailing newline


http://gerrit.openvpn.net/c/openvpn/+/1196/comment/b3e07869_273491f4 :
PS1, Line 110: 	+ f"Gerrit URL: {gerrit_url}\n"
tab vs. spaces



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1196?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb137ecbade4b0584a4d74aee34978062e247bc5
Gerrit-Change-Number: 1196
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Wed, 17 Sep 2025 10:13:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--j7wh5zlnlDs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1196?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1196?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">LGTM but please fix whitespace damage</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File dev-tools/gerrit-=
send-mail.py:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1196/comment/fa643897_51c57035">Patc=
h Set #1, Line 109:</a> <code style=3D"font-family:monospace,monospace">   =
     + acked_by_text </code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">trailing newline</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1196/comment/b3e07869_273491f4">Patch Set #1, Line 110:<=
/a> <code style=3D"font-family:monospace,monospace">	+ f&quot;Gerrit URL: {=
gerrit_url}\n&quot;</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">tab vs. spaces</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1196?usp=3Demail">change 1196</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1196?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb137ecbade4b0584a4d74aee34=
978062e247bc5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1196 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 17 Sep 2025 10:13:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--j7wh5zlnlDs=--

