From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 27 Jun 2024 08:44:04 +0000
In-Reply-To: <gerrit.1717673612000.I6662605b60d4859949970cfe256c55cbcbd4a672@...2715...>
References: <gerrit.1717673612000.I6662605b60d4859949970cfe256c55cbcbd4a672@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <bb4562982bca06530779c44c9365247229bc375b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H3tl0ECgKjk="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Lay the foundation
 to support both old and new versions of DCO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--H3tl0ECgKjk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/662?usp=3Demail )

Change subject: Lay the foundation to support both old and new versions of =
DCO
......................................................................


Patch Set 1:

(3 comments)

File src/openvpn/dco_linux.h:

http://gerrit.openvpn.net/c/openvpn/+/662/comment/86f99d7c_43678f20 :
PS1, Line 129:  * @param nl_msg    the message to use
> "The"
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/662/comment/88a96579_919aab40 :
PS1, Line 174:  * extended in the future if we need to lookup more than one=
 mcast id.
> "can be extended" ?
Acknowledged


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/662/comment/2f02c26a_4ad35d7f :
PS1, Line 1233:     int cmd_del_peer =3D OVPN_CMD_DEL_PEER;
> Why is this indirection required?
Because with the next commit that will introduce support for dco_v3, the co=
mmands will be completely different (the names will be shared between dco_v=
3 linux and bsd while dco_v2 will use the *current* commands with the addit=
ion of the acronym v2 (i.e. OVPN_V2_CMD_GET_PEER) and since the commands th=
at will be used will change based on the platform and the version of dco lo=
aded, that differentiation must be made via #if defined



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/662?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6662605b60d4859949970cfe256c55cbcbd4a672
Gerrit-Change-Number: 662
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 27 Jun 2024 08:44:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--H3tl0ECgKjk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/662?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.h:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/662/comment/86f99d7c_43678f20">Patch Set #1, Line 129:<=
/a> <code style=3D"font-family:monospace,monospace"> * @param nl_msg    the=
 message to use</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">&quot;The&quot;</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/662/comment/88a96579_9=
19aab40">Patch Set #1, Line 174:</a> <code style=3D"font-family:monospace,m=
onospace"> * extended in the future if we need to lookup more than one mcas=
t id.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">&quot;can be extended&quot; ?</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forw=
ard.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/662/comment/2f02c26a_4ad35d7f">Patch Set #1=
, Line 1233:</a> <code style=3D"font-family:monospace,monospace">    int cm=
d_del_peer =3D OVPN_CMD_DEL_PEER;</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why is this indirec=
tion required?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Because with the next commit that will introduce support for=
 dco_v3, the commands will be completely different (the names will be share=
d between dco_v3 linux and bsd while dco_v2 will use the *current* commands=
 with the addition of the acronym v2 (i.e. OVPN_V2_CMD_GET_PEER) and since =
the commands that will be used will change based on the platform and the ve=
rsion of dco loaded, that differentiation must be made via #if defined</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/662?usp=3Demail">change 662</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/662?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6662605b60d4859949970cfe256=
c55cbcbd4a672 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 662 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 27 Jun 2024 08:44:04=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--H3tl0ECgKjk=--

