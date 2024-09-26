From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 26 Sep 2024 12:58:02 +0000
In-Reply-To: <gerrit.1727273213000.Id99a3ba13c0f1d0bc7e4699fb67ee9dff6221639@...2715...>
References: <gerrit.1727273213000.Id99a3ba13c0f1d0bc7e4699fb67ee9dff6221639@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a11a47722132dde8872bcfecafda6d6d271f7321-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="08UqmZ6XvA4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix socketpair
 return status not being checked in port share code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--08UqmZ6XvA4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/770?usp=3Demail )

Change subject: Fix socketpair return status not being checked in port shar=
e code
......................................................................


Patch Set 2: Code-Review-1

(1 comment)

File src/openvpn/ps.c:

http://gerrit.openvpn.net/c/openvpn/+/770/comment/299616be_4ad3018f :
PS2, Line 854:     if (!(socketpair(PF_UNIX, SOCK_DGRAM, 0, fd) =3D=3D 0))
can we please not do double-negate-conditions for standard syscall return v=
alue checking??  `=3D=3D -1` or `<0` is perfectly fine, according to the ma=
npage.  My brain hurts.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id99a3ba13c0f1d0bc7e4699fb67ee9dff6221639
Gerrit-Change-Number: 770
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Thu, 26 Sep 2024 12:58:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--08UqmZ6XvA4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ps.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/770/comment/299616be_4ad3018f">Patch Set #2, Line 854:</a> =
<code style=3D"font-family:monospace,monospace">    if (!(socketpair(PF_UNI=
X, SOCK_DGRAM, 0, fd) =3D=3D 0))</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">can we please not do double-negate-conditions fo=
r standard syscall return value checking??  `=3D=3D -1` or `&lt;0` is perfe=
ctly fine, according to the manpage.  My brain hurts.</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/770?us=
p=3Demail">change 770</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id99a3ba13c0f1d0bc7e4699fb67=
ee9dff6221639 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 770 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Sep 2024 12:58:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--08UqmZ6XvA4=--

