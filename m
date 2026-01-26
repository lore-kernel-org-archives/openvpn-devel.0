From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 12:47:43 +0000
In-Reply-To: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
References: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <6673cecd7da8faac23b9f8647fc870d5cb5f72b9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hhFT4yaD1yI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: status: Avoid
 conversion warnings in status_read/status_printf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hhFT4yaD1yI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change by flichtenheld. ( http://g=
errit.openvpn.net/c/openvpn/+/1485?usp=3Demail )

Change subject: status: Avoid conversion warnings in status_read/status_pri=
ntf
......................................................................


Patch Set 2:

(1 comment)

File src/openvpn/status.c:

http://gerrit.openvpn.net/c/openvpn/+/1485/comment/9696cdac_b218c0bb?usp=3D=
email :
PS2, Line 241:                 if (write(so->fd, buf, (unsigned int)len) !=
=3D len)
> this change confuses me. [=E2=80=A6]
This is required for Windows (see https://learn.microsoft.com/en-us/cpp/c-r=
untime-library/reference/write?view=3Dmsvc-170)
In some of the places we have comments that this is for Windows (e.g. in te=
st_ssl.c). Shall I add one here as well?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9
Gerrit-Change-Number: 1485
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Mon, 26 Jan 2026 12:47:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>

--hhFT4yaD1yI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/status.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1485/comment/9696cdac_b218c0bb?usp=3Demail">Patch Set #2, =
Line 241:</a> <code style=3D"font-family:monospace,monospace">             =
   if (write(so-&gt;fd, buf, (unsigned int)len) !=3D len)</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">this change confuses me. [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">This is required=
 for Windows (see https://learn.microsoft.com/en-us/cpp/c-runtime-library/r=
eference/write?view=3Dmsvc-170)<br>In some of the places we have comments t=
hat this is for Windows (e.g. in test_ssl.c). Shall I add one here as well?=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1485?usp=3Demail">change 1485</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1485?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff1343a2f8cc7e32b8f36b359a0=
0248e4dc3e8c9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1485 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 26 Jan 2026 12:47:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>

</body></html>=

--hhFT4yaD1yI=--

