From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Dec 2023 14:03:21 +0000
In-Reply-To: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
References: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <76acb9582ef76adec7cef23df22a8c1ce2e60259-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0iyLFeGXwUY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make it more
 explicit and visible when pkg-config is not found
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0iyLFeGXwUY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/465?usp=3Demail )

Change subject: Make it more explicit and visible when pkg-config is not fo=
und
......................................................................


Patch Set 1:

(1 comment)

File configure.ac:

http://gerrit.openvpn.net/c/openvpn/+/465/comment/1f49058a_883de55c :
PS1, Line 387: 	pkg_config_found=3D"(not found)"
> indent
Damn indenting with tabs instead of spaces. I will double check all other i=
ndents as well.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iebaa35a23e217a4cd7739af229cbfc08a3d8854a
Gerrit-Change-Number: 465
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 11 Dec 2023 14:03:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--0iyLFeGXwUY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File configure.ac:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/465/comment/1f49058a_883de55c">Patch Set #1, Line 387:</a> <code st=
yle=3D"font-family:monospace,monospace">	pkg_config_found=3D&quot;(not foun=
d)&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">indent</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Damn indenting with tabs instead of s=
paces. I will double check all other indents as well.</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?us=
p=3Demail">change 465</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iebaa35a23e217a4cd7739af229c=
bfc08a3d8854a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 465 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 11 Dec 2023 14:03:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0iyLFeGXwUY=--

