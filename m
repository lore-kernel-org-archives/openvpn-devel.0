From: "MaxF (Code Review)" <gerrit@...515...>
Date: Sun, 22 Feb 2026 22:14:40 +0000
In-Reply-To: <gerrit.1771607942000.I53d47e4a0d33c380ee95e0e33aecad3db3197940@...2715...>
References: <gerrit.1771607942000.I53d47e4a0d33c380ee95e0e33aecad3db3197940@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, steffan@...1856...
Message-ID: <b6a5f3c79011916da454ea1430044125f19e1e2d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+ZyEn/szXCA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Avoid unbounded
 allocations in pkcs11_mbedtls.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: syzzer <steffan@...1856...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+ZyEn/szXCA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, syzzer.

MaxF has posted comments on this change by MaxF. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1549?usp=3Demail )

Change subject: Avoid unbounded allocations in pkcs11_mbedtls.c
......................................................................


Patch Set 1:

(2 comments)

Patchset:

PS1:
I don't understand why the tests are failing. Some of them don't even use m=
bedtls. Can someone else take a look?


PS1:
> The change itself looks good. And might even be good practice. [=E2=80=A6]
You're right, that's why this is not a CVE. I discussed it with Gert in the=
 private-issues repo and we agreed to label it as "minibug". We can't prote=
ct against a malicious pkcs11 provider, but maybe we can be more robust aga=
inst a buggy one.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53d47e4a0d33c380ee95e0e33aecad3db3197940
Gerrit-Change-Number: 1549
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Sun, 22 Feb 2026 22:14:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: syzzer <steffan@...1856...>

--+ZyEn/szXCA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, syzzer. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1549?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;t un=
derstand why the tests are failing. Some of them don&#39;t even use mbedtls=
. Can someone else take a look?</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1549?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">The change itself looks good. And might even be good practice=
. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">You&#39;re right, that&#39;s why this is not=
 a CVE. I discussed it with Gert in the private-issues repo and we agreed t=
o label it as &quot;minibug&quot;. We can&#39;t protect against a malicious=
 pkcs11 provider, but maybe we can be more robust against a buggy one.</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1549?usp=3Demail">change 1549</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1549?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53d47e4a0d33c380ee95e0e33ae=
cad3db3197940 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1549 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: syzzer &lt;steffan@...1856...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 22 Feb 2026 22:14:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: syzzer &lt;steffan@...1852...=
6...&gt; </div>

</body></html>=

--+ZyEn/szXCA=--

