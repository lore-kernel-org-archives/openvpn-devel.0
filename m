From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 17:32:29 +0000
In-Reply-To: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
References: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <71958b48a70604ca1ad4becd898b7824599df679-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nHTOAqUlLC8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix logic when
 pushed cipher triggers tun reopen and ignore more options
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

--nHTOAqUlLC8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by plaisthos. ( http://gerrit.open=
vpn.net/c/openvpn/+/1321?usp=3Demail )

Change subject: Fix logic when pushed cipher triggers tun reopen and ignore=
 more options
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

Patchset:

PS1:
I don't think the logic is right now (neither before nor afterwards).  The =
commit message actually speaks about `link-mtu` but the code tests `tun_mtu=
_defined`.


File src/openvpn/push.c:

http://gerrit.openvpn.net/c/openvpn/+/1321/comment/d77bec25_18f7eaaa?usp=3D=
email :
PS1, Line 1046:         if (strprefix(line, "cipher ") && opt->ce.tun_mtu_d=
efined)
I don't think this is actually correct - `--tun-mtu` is the *inner* MTU, an=
d that never changes on `--cipher`.  So the original variant means "if we h=
ave a configured tun-mtu, a cipher change will not affect this, so we don't=
 care".

A more clear expression would be "if a `--link-mtu` was defined and `--ciph=
er changes` (because in that case, `--tun-mtu` would be recalculated - or w=
ould it?)

Maybe that whole thing needs to go after the big mtu refactoring?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76eb584024610a6054a069340adbac988abf686c
Gerrit-Change-Number: 1321
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 28 Oct 2025 17:32:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--nHTOAqUlLC8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1321?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;=
t think the logic is right now (neither before nor afterwards).  The commit=
 message actually speaks about `link-mtu` but the code tests `tun_mtu_defin=
ed`.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/push.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1321/comment/d77bec25_18f7eaaa?usp=3D=
email">Patch Set #1, Line 1046:</a> <code style=3D"font-family:monospace,mo=
nospace">        if (strprefix(line, &quot;cipher &quot;) &amp;&amp; opt-&g=
t;ce.tun_mtu_defined)</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">I don&#39;t think this is actually correct=
 - `--tun-mtu` is the *inner* MTU, and that never changes on `--cipher`.  S=
o the original variant means &quot;if we have a configured tun-mtu, a ciphe=
r change will not affect this, so we don&#39;t care&quot;.</p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A more clear=
 expression would be &quot;if a `--link-mtu` was defined and `--cipher chan=
ges` (because in that case, `--tun-mtu` would be recalculated - or would it=
?)</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Maybe that whole thing needs to go after the big mtu refactoring?</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1321?usp=3Demail">change 1321</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1321?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76eb584024610a6054a069340ad=
bac988abf686c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1321 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Oct 2025 17:32:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--nHTOAqUlLC8=--

