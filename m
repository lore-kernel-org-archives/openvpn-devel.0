From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 9 Mar 2023 14:04:30 +0000
In-Reply-To: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
References: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 lstipakov@...277..., a@...2181...
Message-ID: <eccf513603dee9f3710f13873b30ca5a39c63f5a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LxQnKJyWO4o="; charset=UTF-8
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

--LxQnKJyWO4o=
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

http://gerrit.openvpn.net/c/openvpn/+/28/comment/79ae6092_3d114668
PS4, Line 1702:  */
Maybe move that comment (the part that still applies) to the new socket_is_=
dco_win method?


File src/openvpn/ovpn_dco_linux.h:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/7e5b2aa7_22504803
PS4, Line 30: 	OVPN_CMD_NEW_PEER,
Didn't you want to add a length field for the residual TCP buffer and just =
0 here to avoid another API revision?


File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/4472fe5d_39cf056b
PS4, Line 1184:         /* unified UDPv4 and UDPv6 and DCO (kernel adds siz=
e header) */
But here we remove the comment, even though it is also true here.


http://gerrit.openvpn.net/c/openvpn/+/28/comment/f0531361_fcbd90ef
PS4, Line 209: #define SF_DCO_WIN (1<<5)
Is using a flag really better than a bool here?


http://gerrit.openvpn.net/c/openvpn/+/28/comment/b7557dab_78851b42
PS4, Line 1069:      * will strip the length header */
here the comment is kept (since it is still true)



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
Gerrit-Comment-Date: Thu, 09 Mar 2023 14:04:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--LxQnKJyWO4o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">View Ch=
ange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/28/comment/79ae6092_3d114668">Patch Set #4, Line 1702:</a>=
 <code style=3D"font-family:monospace,monospace"> */</code></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Maybe move that comment (the=
 part that still applies) to the new socket_is_dco_win method?</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ovpn_dco_lin=
ux.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/28/comment/7e5b2aa7_22504803">Patch Set #4, =
Line 30:</a> <code style=3D"font-family:monospace,monospace">	OVPN_CMD_NEW_=
PEER,</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Didn&#39;t you want to add a length field for the residual TCP buffer and j=
ust 0 here to avoid another API revision?</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/socket.h:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/28/comment/4472fe5d_39cf056b">Patch Set #4, Line 1184:</a> <code style=3D=
"font-family:monospace,monospace">        /* unified UDPv4 and UDPv6 and DC=
O (kernel adds size header) */</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">But here we remove the comment, even though it is =
also true here.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/28/comment/f0531361_fcbd90ef">Patch Set #4, Line 209:</a> <code style=3D"=
font-family:monospace,monospace">#define SF_DCO_WIN (1&lt;&lt;5)</code></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Is using a flag =
really better than a bool here?</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/28/comment/b7557dab_78851b42">Patch Set #4, Line 1069:</a=
> <code style=3D"font-family:monospace,monospace">     * will strip the len=
gth header */</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">here the comment is kept (since it is still true)</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28=
?usp=3Demail">change 28</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail"/><me=
ta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Mar 2023 14:04:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--LxQnKJyWO4o=--

