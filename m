From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 17:00:06 +0000
In-Reply-To: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
References: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <96a652f23f129ef48f6bc23f4fa63ed9cac856d5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jIr/+tdjxYw="; charset=UTF-8
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

--jIr/+tdjxYw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, selvanair.

cron2 has posted comments on this change by selvanair. ( http://gerrit.open=
vpn.net/c/openvpn/+/1415?usp=3Demail )

Change subject: pull-filter: improve documentation
......................................................................


Patch Set 1:

(1 comment)

File doc/man-sections/client-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1415/comment/9a5b4c11_dfcbcb2d?usp=3D=
email :
PS1, Line 349:   protect against offending options pushed by a server. For =
example, the
> This is what I wanted to say: Pull filter was not designed as a security =
measure, so do not use it f [=E2=80=A6]
Mmmh.  I do think it's reasonably secure if used correctly (allowlist) *but=
* I agree that one needs to take care and it's easy to produce something th=
at works against a non-malicious server that just pushes an unwanted route,=
 and consider that "secure".  Which it quite likely won't be.

This is what my suggested wording was intended to convey ;-)

But we can agree to disagree on this - in this case I'd go for "Option 2".



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
Gerrit-Comment-Date: Mon, 08 Dec 2025 17:00:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: selvanair <selva.nair@...277...>

--jIr/+tdjxYw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-option=
s.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1415/comment/9a5b4c11_dfcbcb2d?usp=3Demail"=
>Patch Set #1, Line 349:</a> <code style=3D"font-family:monospace,monospace=
">  protect against offending options pushed by a server. For example, the<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">This is what I wanted to say: Pull filter was not des=
igned as a security measure, so do not use it f [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Mmmh.  I do think it&#39;s reasonably secure if used correctly (allowlist=
) *but* I agree that one needs to take care and it&#39;s easy to produce so=
mething that works against a non-malicious server that just pushes an unwan=
ted route, and consider that &quot;secure&quot;.  Which it quite likely won=
&#39;t be.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">This is what my suggested wording was intended to convey ;-)=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">But we can agree to disagree on this - in this case I&#39;d go for &qu=
ot;Option 2&quot;.</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail">change 1415</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Dec 2025 17:00:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>

</body></html>=

--jIr/+tdjxYw=--

