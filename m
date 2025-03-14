From: "d12fk (Code Review)" <gerrit@...515...>
Date: Fri, 14 Mar 2025 04:23:21 +0000
In-Reply-To: <gerrit.1741315174000.I4919af2b845a47787c08f454b108ef376ea5c0f6@...2715...>
References: <gerrit.1741315174000.I4919af2b845a47787c08f454b108ef376ea5c0f6@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5fe30a5d8123549065217a72a70bf2aabdbcff48-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yq1dOCdNex8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: match search
 domains when creating exclude rules
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yq1dOCdNex8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/905?usp=3Demail )

Change subject: win: match search domains when creating exclude rules
......................................................................


Patch Set 3:

(1 comment)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/905/comment/90f6b889_929da8d7 :
PS2, Line 2218:                 if (match && (match =3D=3D search_domains |=
| *(match - 1) =3D=3D ',')
> The code doesn't deal with partial matches in the list, before a full mat=
ch could be made. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/905?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4919af2b845a47787c08f454b108ef376ea5c0f6
Gerrit-Change-Number: 905
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 14 Mar 2025 04:23:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--yq1dOCdNex8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/905?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/905/comment/90f6b889_929da8d7">Patch Set #2, Line =
2218:</a> <code style=3D"font-family:monospace,monospace">                i=
f (match &amp;&amp; (match =3D=3D search_domains || *(match - 1) =3D=3D &#3=
9;,&#39;)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">The code doesn&#39;t deal with partial matc=
hes in the list, before a full match could be made. [=E2=80=A6]</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/905?usp=3Demail">change 905</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/905?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4919af2b845a47787c08f454b10=
8ef376ea5c0f6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 905 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Mar 2025 04:23:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--yq1dOCdNex8=--

