From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 9 Mar 2023 14:21:34 +0000
In-Reply-To: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
References: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <68b85d5c6ff254e3fb51e76202292f56fd388d43-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ScbYP621bGE="; charset=UTF-8
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

--ScbYP621bGE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/28?usp=3Demail )

Change subject: dco: don't use NetLink to exchange control packets
......................................................................


Patch Set 4:

(5 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/edcaa03e_7d307609
PS4, Line 1702:  */
> Maybe move that comment (the part that still applies) to the new socket_i=
s_dco_win method?
hmm I'd add a different working because it is not about where to send contr=
ol packets, but just checking if DCO is enabled on a link or not. but yeah,=
 we could definitely add some doc to socket_is_dco_win


File src/openvpn/ovpn_dco_linux.h:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/be25a0d8_f403b236
PS4, Line 30: 	OVPN_CMD_NEW_PEER,
> Didn't you want to add a length field for the residual TCP buffer and jus=
t 0 here to avoid another A [=E2=80=A6]
nah, adding a field does not break the API. We can add it later as it fixes=
 a separate issue.


File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/28/comment/fdce9d57_fe86f5e0
PS4, Line 1184:         /* unified UDPv4 and UDPv6 and DCO (kernel adds siz=
e header) */
> But here we remove the comment, even though it is also true here.
again, why do we talk about size header if this is UDP?


http://gerrit.openvpn.net/c/openvpn/+/28/comment/af827c3f_5e4fc158
PS4, Line 209: #define SF_DCO_WIN (1<<5)
> Is using a flag really better than a bool here?
this is Lev's doing :-D
Technically we already have the socketflags bitfield, so re-using it is not=
 a bad idea and it is less invasive compared to adding a member that is use=
d by one platform only.


http://gerrit.openvpn.net/c/openvpn/+/28/comment/c793d3d9_3d0bef67
PS4, Line 1069:      * will strip the length header */
> here the comment is kept (since it is still true)
I am confused. this is UDP, how come we talk about length header?



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
Gerrit-Comment-Date: Thu, 09 Mar 2023 14:21:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: comment

--ScbYP621bGE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">View Ch=
ange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/28/comment/edcaa03e_7d307609">Patch Set #4, Line 1702:</a>=
 <code style=3D"font-family:monospace,monospace"> */</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Maybe move that comment (the part that still applies) to the new socket_is_=
dco_win method?</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">hmm I&#39;d add a different working because it is not about=
 where to send control packets, but just checking if DCO is enabled on a li=
nk or not. but yeah, we could definitely add some doc to socket_is_dco_win<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
ovpn_dco_linux.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/28/comment/be25a0d8_f403b236">P=
atch Set #4, Line 30:</a> <code style=3D"font-family:monospace,monospace">	=
OVPN_CMD_NEW_PEER,</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Didn&#39;t you want to add a lengt=
h field for the residual TCP buffer and just 0 here to avoid another A [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">nah, adding a field does not break the API. We can add it later as =
it fixes a separate issue.</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/socket.h:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28/comment/fd=
ce9d57_fe86f5e0">Patch Set #4, Line 1184:</a> <code style=3D"font-family:mo=
nospace,monospace">        /* unified UDPv4 and UDPv6 and DCO (kernel adds =
size header) */</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">But here we remove the comment, even =
though it is also true here.</blockquote></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">again, why do we talk about size header if thi=
s is UDP?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28/c=
omment/af827c3f_5e4fc158">Patch Set #4, Line 209:</a> <code style=3D"font-f=
amily:monospace,monospace">#define SF_DCO_WIN (1&lt;&lt;5)</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Is using a flag really better than a bool here?</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">this is Lev&#39;s doi=
ng :-D<br>Technically we already have the socketflags bitfield, so re-using=
 it is not a bad idea and it is less invasive compared to adding a member t=
hat is used by one platform only.</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/28/comment/c793d3d9_3d0bef67">Patch Set #4, Line 1069:<=
/a> <code style=3D"font-family:monospace,monospace">     * will strip the l=
ength header */</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">here the comment is kept (since it is=
 still true)</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">I am confused. this is UDP, how come we talk about length head=
er?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/28?usp=3Demail">change 28</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
28?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Mar 2023 14:21:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ScbYP621bGE=--

