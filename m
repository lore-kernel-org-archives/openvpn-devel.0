From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 13 May 2024 10:52:18 +0000
In-Reply-To: <gerrit.1715191782000.Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934@...2715...>
References: <gerrit.1715191782000.Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <7c073af107d59cdba748ea7316ce1c32649a9bf7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RdZ6+5ti9Dc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Workaround issue in
 LibreSSL crashing when enumerating digests/ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RdZ6+5ti9Dc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/586?usp=3Demail )

Change subject: Workaround issue in LibreSSL crashing when enumerating dige=
sts/ciphers
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
Submitted as github report as well.

https://github.com/libressl/openbsd/issues/150



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/586?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934
Gerrit-Change-Number: 586
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 13 May 2024 10:52:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--RdZ6+5ti9Dc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/586?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
86?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Submitted as github report as well.</p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">https://github.com/libressl=
/openbsd/issues/150</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/586?usp=3Demail">change 586</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/586?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia08a9697d0ff41721fb0acf17cc=
b4cfa23cb3934 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 586 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 13 May 2024 10:52:18=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RdZ6+5ti9Dc=--

