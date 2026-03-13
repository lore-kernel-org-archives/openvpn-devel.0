From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 12:25:10 +0000
In-Reply-To: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
References: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <29c5708abb75934e3c48c7a221efd57e5f639c41-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mCrWi3KouY4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: [GHA] Install aws-lc
 under /opt/aws-lc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mCrWi3KouY4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1565?usp=3Demail )

Change subject: [GHA] Install aws-lc under /opt/aws-lc
......................................................................


Patch Set 2:

(2 comments)

Patchset:

PS2:
GHA build: https://github.com/schwabe/openvpn/actions/runs/23050632702


File .github/workflows/build.yaml:

http://gerrit.openvpn.net/c/openvpn/+/1565/comment/d29ff2c2_8cd5970c?usp=3D=
email :
PS1, Line 476:           ref: ${{ env.AWS_LC_VERSION }}
> This breaks the renovate update
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8
Gerrit-Change-Number: 1565
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 13 Mar 2026 12:25:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--mCrWi3KouY4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1565?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">GHA build: htt=
ps://github.com/schwabe/openvpn/actions/runs/23050632702</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File .github/workflows/build.yaml:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1565/comment/d29ff2c2_8cd5970c?usp=3Demail">Patch =
Set #1, Line 476:</a> <code style=3D"font-family:monospace,monospace">     =
     ref: ${{ env.AWS_LC_VERSION }}</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This breaks the r=
enovate update</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail">chang=
e 1565</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I090f5b201d67f51d2e42df1914a=
8466bcfcb6bf8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1565 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 13 Mar 2026 12:25:10=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--mCrWi3KouY4=--

