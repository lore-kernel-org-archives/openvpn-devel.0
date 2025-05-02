From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 2 May 2025 20:24:03 +0000
In-Reply-To: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
References: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <3d054cf62c7bbac894580c0daa7140bfe074f78c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="soxgfGN0LN4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: support running
 up/down command with privsep
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--soxgfGN0LN4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, d12fk, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/839?usp=3Demail )

Change subject: dns: support running up/down command with privsep
......................................................................


Patch Set 22:

(1 comment)

File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/839/comment/cb719551_d3fda8ef :
PS22, Line 3973:=20
this would tie the necessity for the persistent runner to "user *or* group =
defined" - but technically if only the GID is changed ("no idea why one wou=
ld *do* that, but we have those options") the runner isn't needed... so thi=
s could be `=3D user_defined`.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b67e3a00dd84bf348b6af28115ee11138c3a111
Gerrit-Change-Number: 839
Gerrit-PatchSet: 22
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Fri, 02 May 2025 20:24:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--soxgfGN0LN4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, d12fk, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/839/comment/cb719551_d3fda8ef">Patch Set #22, Line 3973:</a> =
<code style=3D"font-family:monospace,monospace"></code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">this would tie the necessity for=
 the persistent runner to &quot;user *or* group defined&quot; - but technic=
ally if only the GID is changed (&quot;no idea why one would *do* that, but=
 we have those options&quot;) the runner isn&#39;t needed... so this could =
be `=3D user_defined`.</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail">change 839</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/839?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b67e3a00dd84bf348b6af28115=
ee11138c3a111 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 839 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 02 May 2025 20:24:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--soxgfGN0LN4=--

