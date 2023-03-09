From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 9 Mar 2023 14:32:02 +0000
In-Reply-To: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
References: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 lstipakov@...277..., a@...2181...
Message-ID: <b7994711a566ddf7cc9877e2ca9ed13f07447b8d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RYJrNAOvPyY="; charset=UTF-8
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
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lstipakov@...277...>

--RYJrNAOvPyY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/28?usp=3Demail )

Change subject: dco: don't use NetLink to exchange control packets
......................................................................


Patch Set 4:

(5 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/247c9792_e7b2c3b6
PS4, Line 1702:  */
> hmm I'd add a different working because it is not about where to send con=
trol packets, but just chec [=E2=80=A6]
Ack


File src/openvpn/ovpn_dco_linux.h:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/9b1a1741_9fe75f0a
PS4, Line 30: 	OVPN_CMD_NEW_PEER,
> nah, adding a field does not break the API. We can add it later as it fix=
es a separate issue.
Ack


File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/f7ee8257_3b07557c
PS4, Line 1184:         /* unified UDPv4 and UDPv6 and DCO (kernel adds siz=
e header) */
> again, why do we talk about size header if this is UDP?
when we have TCP we need to add the size header but in the DCO case, the ke=
rnel does that for us.


http://gerrit.openvpn.net/c/openvpn/+/28/comment/97dc5bba_a14de127
PS4, Line 209: #define SF_DCO_WIN (1<<5)
> this is Lev's doing :-D [=E2=80=A6]
Ack


http://gerrit.openvpn.net/c/openvpn/+/28/comment/3f58627e_3e6501af
PS4, Line 1069:      * will strip the length header */
> I am confused. [=E2=80=A6]
Basically in this codepath it is basically more like read_packet_with_heade=
r vs read_packet_without_header but we call them udp and tcp here. And ther=
efore use the udp path even for tcp when dco is enabled since that header i=
s already removed.



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
Gerrit-Attention: cron2
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Thu, 09 Mar 2023 14:32:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--RYJrNAOvPyY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">View Ch=
ange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/28/comment/247c9792_e7b2c3b6">Patch Set #4, Line 1702:</a>=
 <code style=3D"font-family:monospace,monospace"> */</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
hmm I&#39;d add a different working because it is not about where to send c=
ontrol packets, but just chec [=E2=80=A6]</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Ack</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/ovpn_dco_linux.h:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/28/comment/9b1a1741_9fe75f0a">Patch Set #4, Line 30:</a> <c=
ode style=3D"font-family:monospace,monospace">	OVPN_CMD_NEW_PEER,</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">nah, adding a field does not break the API. We can add it late=
r as it fixes a separate issue.</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Ack</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/socket.h:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28/c=
omment/f7ee8257_3b07557c">Patch Set #4, Line 1184:</a> <code style=3D"font-=
family:monospace,monospace">        /* unified UDPv4 and UDPv6 and DCO (ker=
nel adds size header) */</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">again, why do we talk about =
size header if this is UDP?</blockquote></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">when we have TCP we need to add the size header=
 but in the DCO case, the kernel does that for us.</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/28/comment/97dc5bba_a14de127">Patch Se=
t #4, Line 209:</a> <code style=3D"font-family:monospace,monospace">#define=
 SF_DCO_WIN (1&lt;&lt;5)</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">this is Lev&#39;s doing :-D =
[=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Ack</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/28/comment/3f58627e_3e6501af">Patch Set #4, Line 1069:</a> <code style=3D=
"font-family:monospace,monospace">     * will strip the length header */</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">I am confused. [=E2=80=A6]</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Basically in this codepath i=
t is basically more like read_packet_with_header vs read_packet_without_hea=
der but we call them udp and tcp here. And therefore use the udp path even =
for tcp when dco is enabled since that header is already removed.</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/28?usp=3Demail">change 28</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Mar 2023 14:32:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RYJrNAOvPyY=--

