From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 11:07:29 +0000
In-Reply-To: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
References: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5e2970092a2e0f5cdf305eebfe63c656449ac85a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fJAJr2DgITI="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fJAJr2DgITI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, selvanair.

cron2 has posted comments on this change by selvanair. ( http://gerrit.open=
vpn.net/c/openvpn/+/1415?usp=3Demail )

Change subject: pull-filter: improve documentation
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File doc/man-sections/client-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1415/comment/733a8042_b2df151c?usp=3D=
email :
PS1, Line 349:   protect against offending options pushed by a server. For =
example, the
I would word the first part slightly differently (just as a suggestion)

```
*Warning:* if using ``pull-filter`` as a security measure to protect agains=
t offending options pushed by a server, a negative match (ignore/reject) mi=
ght be circumvented by pushing options with extra spaces...
```

and then the rest as is - except that I think it needs to be the other way =
round, first the specific ``accept`` and then the generic ``ignore`` - the =
logic is "first match decided"...  so

```
pull-filter accept route 1.2.3.0
pull-filter ignore route
```

would permit 1.2.3.0, while the other way round would ignore all routes.  A=
t least this is what I remember and the code seems to agree with me :-)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a
Gerrit-Change-Number: 1415
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Mon, 08 Dec 2025 11:07:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--fJAJr2DgITI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, selvanair. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-op=
tions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1415/comment/733a8042_b2df151c?usp=3Dem=
ail">Patch Set #1, Line 349:</a> <code style=3D"font-family:monospace,monos=
pace">  protect against offending options pushed by a server. For example, =
the</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">I would word the first part slightly differently (just as a =
suggestion)</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">```<br>*Warning:* if using ``pull-filter`` as a security me=
asure to protect against offending options pushed by a server, a negative m=
atch (ignore/reject) might be circumvented by pushing options with extra sp=
aces...<br>```<br></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">and then the rest as is - except that I think it nee=
ds to be the other way round, first the specific ``accept`` and then the ge=
neric ``ignore`` - the logic is &quot;first match decided&quot;...  so</p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
```<br>pull-filter accept route 1.2.3.0<br>pull-filter ignore route<br>```<=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">would permit 1.2.3.0, while the other way round would ignore all routes=
.  At least this is what I remember and the code seems to agree with me :-)=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1415?usp=3Demail">change 1415</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1415?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1=
e6a2f9255c59a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1415 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Dec 2025 11:07:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--fJAJr2DgITI=--

