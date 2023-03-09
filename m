From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 9 Mar 2023 15:02:36 +0000
In-Reply-To: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
References: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <31f77f3e88c9573387ff4ca5c43efca4ea9588e8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0vpYSa5d9jI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco: don't use
 NetLink to exchange control packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>

--0vpYSa5d9jI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/28?usp=3Demail )

Change subject: dco: don't use NetLink to exchange control packets
......................................................................


Patch Set 5:

(2 comments)

File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/1357b934_a0d12dbd
PS4, Line 1184:         /* unified UDPv4 and UDPv6 and DCO (kernel adds siz=
e header) */
> not anymore on linux as packets are just left untouched.
Ack


http://gerrit.openvpn.net/c/openvpn/+/28/comment/757247af_5fb67f04
PS4, Line 1069:      * will strip the length header */
> aaah makes sense now. [=E2=80=A6]
Ack



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d
Gerrit-Change-Number: 28
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2
Gerrit-Comment-Date: Thu, 09 Mar 2023 15:02:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--0vpYSa5d9jI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">View Ch=
ange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.h:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/28/comment/1357b934_a0d12dbd">Patch Set #4, Line 1184:</a> =
<code style=3D"font-family:monospace,monospace">        /* unified UDPv4 an=
d UDPv6 and DCO (kernel adds size header) */</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">not anym=
ore on linux as packets are just left untouched.</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Ack</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/28/comment/757247af_5fb67f04">Pat=
ch Set #4, Line 1069:</a> <code style=3D"font-family:monospace,monospace"> =
    * will strip the length header */</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">aaah makes sens=
e now. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Ack</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">change 28</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/28?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1297c3ae9a28b188ed21ad21ae=
96fff3d02ee4d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 28 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Mar 2023 15:02:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0vpYSa5d9jI=--

