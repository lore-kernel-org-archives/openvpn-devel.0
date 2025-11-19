From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 13:47:52 +0000
In-Reply-To: <gerrit.1762945572000.I1104044701145fa37cea857e2e0e0fcac7a2bee3@...2715...>
References: <gerrit.1762945572000.I1104044701145fa37cea857e2e0e0fcac7a2bee3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ebc329dae79c7bb3ad26ccf43864713c25c0ca6f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aPyU0Tg1QLY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix dco with null
 cipher being enabled without auth none
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aPyU0Tg1QLY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

cron2 has posted comments on this change by plaisthos. ( http://gerrit.open=
vpn.net/c/openvpn/+/1369?usp=3Demail )

The change is no longer submittable: Code-Review is unsatisfied now.

Change subject: Fix dco with null cipher being enabled without auth none
......................................................................


Patch Set 1: Code-Review-2

(2 comments)

Patchset:

PS1:
this is missing the required "return false" + gc cleanup


File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/1369/comment/bb353f92_d38bfc69?usp=3D=
email :
PS1, Line 486:         }
should this have a `gc_free(&gc); return false;` here?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1369?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1104044701145fa37cea857e2e0e0fcac7a2bee3
Gerrit-Change-Number: 1369
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 19 Nov 2025 13:47:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--aPyU0Tg1QLY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p>The change is no longer submittable: Code-Review is unsatisfied now.=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1369?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1369?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">this is mi=
ssing the required &quot;return false&quot; + gc cleanup</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1369/comment/bb353f92_d38bfc69?usp=3Demail">Patch Set #1, Lin=
e 486:</a> <code style=3D"font-family:monospace,monospace">        }</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">should this have a `gc_free(&amp;gc); return false;` here?</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1369?usp=3Demail">change 1369</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1369?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1104044701145fa37cea857e2e0=
e0fcac7a2bee3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1369 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Nov 2025 13:47:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--aPyU0Tg1QLY=--

