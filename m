From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 9 Mar 2023 14:37:36 +0000
In-Reply-To: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
References: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <94cff27ac38a4623177efe4ac9365ae59c306ee0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BfBa82y8IKQ="; charset=UTF-8
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

--BfBa82y8IKQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/28?usp=3Demail )

Change subject: dco: don't use NetLink to exchange control packets
......................................................................


Patch Set 4:

(2 comments)

File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/6956503d_6dfb58db
PS4, Line 1184:         /* unified UDPv4 and UDPv6 and DCO (kernel adds siz=
e header) */
> when we have TCP we need to add the size header but in the DCO case, the =
kernel does that for us.
not anymore on linux as packets are just left untouched.


http://gerrit.openvpn.net/c/openvpn/+/28/comment/f80fb018_e8c00ace
PS4, Line 1069:      * will strip the length header */
> Basically in this codepath it is basically more like read_packet_with_hea=
der vs read_packet_without_ [=E2=80=A6]
aaah makes sense now. However, now the length header has to be set/unset by=
 userland, because control packets are left untouched by DCO-linux



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d
Gerrit-Change-Number: 28
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2
Gerrit-Comment-Date: Thu, 09 Mar 2023 14:37:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--BfBa82y8IKQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">View Ch=
ange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.h:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/28/comment/6956503d_6dfb58db">Patch Set #4, Line 1184:</a> =
<code style=3D"font-family:monospace,monospace">        /* unified UDPv4 an=
d UDPv6 and DCO (kernel adds size header) */</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">when we =
have TCP we need to add the size header but in the DCO case, the kernel doe=
s that for us.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">not anymore on linux as packets are just left untouched.</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28/comment/f80fb0=
18_e8c00ace">Patch Set #4, Line 1069:</a> <code style=3D"font-family:monosp=
ace,monospace">     * will strip the length header */</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Basically in this codepath it is basically more like read_packet_with_head=
er vs read_packet_without_ [=E2=80=A6]</blockquote></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">aaah makes sense now. However, now t=
he length header has to be set/unset by userland, because control packets a=
re left untouched by DCO-linux</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">change 28</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/28?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1297c3ae9a28b188ed21ad21ae=
96fff3d02ee4d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 28 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Mar 2023 14:37:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--BfBa82y8IKQ=--

