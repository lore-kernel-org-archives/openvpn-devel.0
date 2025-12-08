From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 21:50:59 +0000
In-Reply-To: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
References: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <9f2011a1f6fd2db21da10ded1bcdd608cefd19f9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jj8cC/YC9nQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pull-filter:
 improve documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Jj8cC/YC9nQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

selvanair has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1415?usp=3Demail )

Change subject: pull-filter: improve documentation
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
> ewww... who permitted such ugliness to pass the parser... [=E2=80=A6]
I had an inkling that there could be more ways than just spaces to defeat t=
his -- and you challenged me to find one =F0=9F=98=8A

Anyway, such "unknown unknowns" is what prompted me to write this in a nuan=
ced and hedged fashion... Now we know at least one concrete way to break it=
, we could just say:

  *Warning:* ``pull-filter`` cannot be relied upon as a security measure to
  protect against offending options pushed by a server. For example, the
  filter could be defeated by pushing options with extra spaces between
  tokens or other formatting variations.

I thought about improving the matching algorithm, but it doesn't look trivi=
al. For now it has to remain a convenience option.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a
Gerrit-Change-Number: 1415
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Mon, 08 Dec 2025 21:50:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: selvanair <selva.nair@...277...>

--Jj8cC/YC9nQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1415?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">ewww=
... who permitted such ugliness to pass the parser... [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">I had an inkling that there could be more ways than just spaces to =
defeat this -- and you challenged me to find one =F0=9F=98=8A</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Anyway,=
 such &quot;unknown unknowns&quot; is what prompted me to write this in a n=
uanced and hedged fashion... Now we know at least one concrete way to break=
 it, we could just say:</p><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">  *Warning:* ``pull-filter`` canno=
t be relied upon as a security measure to<br>  protect against offending op=
tions pushed by a server. For example, the<br>  filter could be defeated by=
 pushing options with extra spaces between<br>  tokens or other formatting =
variations.</pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I thought about improving the matching algorithm, but it =
doesn&#39;t look trivial. For now it has to remain a convenience option.</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1415?usp=3Demail">change 1415</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1415?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1=
e6a2f9255c59a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1415 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Dec 2025 21:50:59=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>

</body></html>=

--Jj8cC/YC9nQ=--

