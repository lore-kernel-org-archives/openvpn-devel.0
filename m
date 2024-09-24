From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 10:42:26 +0000
In-Reply-To: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
References: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <53e6415f1754bfdda6869a9bca61a68702aa94ce-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dx2SngZ6h7c="; charset=UTF-8
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

--dx2SngZ6h7c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/747?usp=3Demail )

Change subject: Introduce DRIVER_AFUNIX backend for use with lwipovpn
......................................................................


Patch Set 11: Code-Review-1

(3 comments)

Patchset:

PS11:
the dco.c string fix was overlooked, the rest is ready to be merged now (no=
t sure why the builds fail in t_server_null)


File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/9fcc0c82_242360d5 :
PS10, Line 306:         return false;
> Done
Umm.  This does not look changed between 10 and 11?  I saw a similar code f=
ragment changed in a different patch, but not here...


File src/openvpn/tun_afunix.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/42b0e935_ab5748b8 :
PS10, Line 125:
> I am not sure that waiting is really needed. We could wait to ensure that=
 the child really exits. [=E2=80=A6]
ignoring SIGCHLD is good enough



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7
Gerrit-Change-Number: 747
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 24 Sep 2024 10:42:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--dx2SngZ6h7c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 11:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/747?tab=3Dcomments">Patch Set #11:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">the dco.c string fix was overlooked, the re=
st is ready to be merged now (not sure why the builds fail in t_server_null=
)</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/dco.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/747/comment/9fcc0c82_242360d5">Patch Set =
#10, Line 306:</a> <code style=3D"font-family:monospace,monospace">        =
return false;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">Done</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Umm.  This does not look changed b=
etween 10 and 11?  I saw a similar code fragment changed in a different pat=
ch, but not here...</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>File src/openvpn/tun_afunix.c:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/42b0=
e935_ab5748b8">Patch Set #10, Line 125:</a> <code style=3D"font-family:mono=
space,monospace"></code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">I am not sure that waiting is reall=
y needed. We could wait to ensure that the child really exits. [=E2=80=A6]<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
ignoring SIGCHLD is good enough</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">change 747<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65099ef00822d08fd3f5480c808=
92f3bf86c56e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 24 Sep 2024 10:42:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--dx2SngZ6h7c=--

