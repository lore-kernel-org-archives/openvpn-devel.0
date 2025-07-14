From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 14 Jul 2025 09:14:44 +0000
In-Reply-To: <gerrit.1752140383000.I8cefa9a406fe90bb3cbe481304782c639691a3a0@...2715...>
References: <gerrit.1752140383000.I8cefa9a406fe90bb3cbe481304782c639691a3a0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5407b7eb72c475c83cd492630a6e00f948fa5fbc-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RZOqSwF6lW0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: Review and
 fix gc_arena usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RZOqSwF6lW0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1083?usp=3Demail )

Change subject: reliable: Review and fix gc_arena usage
......................................................................


Patch Set 3: Code-Review+1

(1 comment)

Patchset:

PS3:
This looks generally good to me - move `int i` declarations inside `for (in=
t i;...)` loops, move `gc_arena` declarations into the error case, thus avo=
iding malloc/free calls in the fast path.

The OpenBSD test fails were due to local problems (stuck openvpn process, s=
o t_client failed the "must not ping before OpenVPN is up" check).

I would prefer a second pair of eyes on this, though... thus only +1



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1083?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8cefa9a406fe90bb3cbe481304782c639691a3a0
Gerrit-Change-Number: 1083
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 14 Jul 2025 09:14:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--RZOqSwF6lW0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1083?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1083?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">This looks generally good to me - move `int =
i` declarations inside `for (int i;...)` loops, move `gc_arena` declaration=
s into the error case, thus avoiding malloc/free calls in the fast path.</p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">The OpenBSD tes=
t fails were due to local problems (stuck openvpn process, so t_client fail=
ed the &quot;must not ping before OpenVPN is up&quot; check).</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I would prefer a second =
pair of eyes on this, though... thus only +1</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1083?usp=3Demai=
l">change 1083</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1083?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8cefa9a406fe90bb3cbe4813047=
82c639691a3a0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1083 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 14 Jul 2025 09:14:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RZOqSwF6lW0=--

