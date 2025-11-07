From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 13:24:20 +0000
In-Reply-To: <gerrit.1762292654000.Ife55cb78401dad921b75f6c86d9bd0642f6a6e83@...2715...>
References: <gerrit.1762292654000.Ife55cb78401dad921b75f6c86d9bd0642f6a6e83@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <5f619a8f654fbc217046abb0d71a305d8ccee7db-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7qwjpnZXwo0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_freebsd.c: add
 D_DCO_DEBUG messages for counters and notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7qwjpnZXwo0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change by cron2. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1349?usp=3Demail )

Change subject: dco_freebsd.c: add D_DCO_DEBUG messages for counters and no=
tifications
......................................................................


Patch Set 2:

(1 comment)

File src/openvpn/dco_freebsd.c:

http://gerrit.openvpn.net/c/openvpn/+/1349/comment/7d84545b_9e9f9371?usp=3D=
email :
PS2, Line 581:     msg(D_DCO_DEBUG, "%s: peer-id %d, dco_read_bytes: " coun=
ter_format " dco_write_bytes: " counter_format,
peer-id should be "%u" since it is uint32_t.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ife55cb78401dad921b75f6c86d9bd0642f6a6e83
Gerrit-Change-Number: 1349
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Fri, 07 Nov 2025 13:24:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--7qwjpnZXwo0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_freebsd.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1349/comment/7d84545b_9e9f9371?usp=3Demail">Patch Set=
 #2, Line 581:</a> <code style=3D"font-family:monospace,monospace">    msg(=
D_DCO_DEBUG, &quot;%s: peer-id %d, dco_read_bytes: &quot; counter_format &q=
uot; dco_write_bytes: &quot; counter_format,</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">peer-id should be &=
quot;%u&quot; since it is uint32_t.</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail">change=
 1349</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1349?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ife55cb78401dad921b75f6c86d9=
bd0642f6a6e83 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1349 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 07 Nov 2025 13:24:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--7qwjpnZXwo0=--

