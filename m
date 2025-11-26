From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:37:44 +0000
In-Reply-To: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
References: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <858a80b1999299e627acf011ffeaa05b791cebc3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2wLDZCD+cZE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change '--multihome'
 behaviour regarding egress interface selection.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2wLDZCD+cZE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by cron2. ( http://gerrit.openvpn.=
net/c/openvpn/+/1383?usp=3Demail )

Change subject: Change '--multihome' behaviour regarding egress interface s=
election.
......................................................................


Patch Set 5:

(1 comment)

File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/1383/comment/19cb23a9_f2199b79?usp=3D=
email :
PS4, Line 329: - the default for `multihome` egress interface handling has =
changed.  2.7.0
> \` is not valid rst syntax. You need to use \`\`. [=E2=80=A6]
fixed in here for the new text, sent a separate patch to fix all the pre-ex=
isting backquotes ("not part of this change")



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1383?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id429241e1b17a8ff51d9019efc357c910f3bde4c
Gerrit-Change-Number: 1383
Gerrit-PatchSet: 5
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 26 Nov 2025 11:37:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--2wLDZCD+cZE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1383?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File Changes.rst:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1383/comment/19cb23a9_f2199b79?usp=3Demail">Patch Set #4, Line 329:=
</a> <code style=3D"font-family:monospace,monospace">- the default for `mul=
tihome` egress interface handling has changed.  2.7.0</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>\` is not valid rst syntax. You need to use \`\`. [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">fixed in here for the new text, sent a separate patch to fix all the p=
re-existing backquotes (&quot;not part of this change&quot;)</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1383?usp=3Demail">change 1383</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/13=
83?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id429241e1b17a8ff51d9019efc3=
57c910f3bde4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1383 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Nov 2025 11:37:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--2wLDZCD+cZE=--

