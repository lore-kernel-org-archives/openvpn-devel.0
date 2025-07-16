From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 16 Jul 2025 08:00:41 +0000
In-Reply-To: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
References: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 antonio@...2726...
Message-ID: <5b4860c385ef47df7d30f5c919b52f57fe2f7485-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hUEikhck2G0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: Add support for
 float notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hUEikhck2G0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, ralf_=
lici.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1084?usp=3Demail )

Change subject: dco: Add support for float notifications
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1084/comment/e60039a2_6836322f :
PS1, Line 3390:             if (extract_dco_float_peer_addr(peer_id, &m->to=
p.c2.from.dest,
> This isn=E2=80=99t actually a parsing of the kernel message, but rather a=
 utility function to transpose the  [=E2=80=A6]
Yeah I would trust the kernel on Windows and add an assert to dco_handle_ov=
erlapped_success(). I think this would make the logic more simple. I could =
send you the diff and you could squash it into this patch.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75ae4261660867f
Gerrit-Change-Number: 1084
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Wed, 16 Jul 2025 08:00:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>
Comment-In-Reply-To: ralf_lici <ralf@...2726...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--hUEikhck2G0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos, r=
alf_lici. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1084/comment/e60039a2_6836322f">Patch Set #1, Line 3390:</a=
> <code style=3D"font-family:monospace,monospace">            if (extract_d=
co_float_peer_addr(peer_id, &amp;m-&gt;top.c2.from.dest,</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">This isn=E2=80=99t actually a parsing of the kernel message, but rather=
 a utility function to transpose the  [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Yeah I would trust the k=
ernel on Windows and add an assert to dco_handle_overlapped_success(). I th=
ink this would make the logic more simple. I could send you the diff and yo=
u could squash it into this patch.</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">change =
1084</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75=
ae4261660867f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1084 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Jul 2025 08:00:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@...2788...=
6...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--hUEikhck2G0=--

