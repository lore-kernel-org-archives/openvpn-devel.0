From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 3 Dec 2024 20:40:38 +0000
In-Reply-To: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
References: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <215bab62dca170a041993d1dddd283ded87e8c6a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="665x6F8PC7A="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Added
 remove_option() and do_update().
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--665x6F8PC7A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

mrbff has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/809?usp=3Demail )

Change subject: PUSH_UPDATE: Added remove_option() and do_update().
......................................................................


Patch Set 7:

(2 comments)

File src/openvpn/init.h:

http://gerrit.openvpn.net/c/openvpn/+/809/comment/c56bc11c_d397fa0c :
PS4, Line 89: bool do_update(struct context *c, unsigned int option_types_f=
ound);
> Doxygen
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/809/comment/f9991389_446e70bf :
PS7, Line 3300:              && (opt->routes->flags & RG_DEF1))
> this gives me "access violation" on Windows, opt->routes is nullptr.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I507180d7397b6959844a30908010132bc3411067
Gerrit-Change-Number: 809
Gerrit-PatchSet: 7
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Tue, 03 Dec 2024 20:40:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--665x6F8PC7A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.h:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/809/comment/c56bc11c_d397fa0c">Patch Set #4, Line 89:</a> <c=
ode style=3D"font-family:monospace,monospace">bool do_update(struct context=
 *c, unsigned int option_types_found);</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Doxygen</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/o=
ptions.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/809/comment/f9991389_446e70bf">Patch Set=
 #7, Line 3300:</a> <code style=3D"font-family:monospace,monospace">       =
      &amp;&amp; (opt-&gt;routes-&gt;flags &amp; RG_DEF1))</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">this gives me &quot;access violation&quot; on Windows, opt-&gt;routes=
 is nullptr.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail">change 809</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/809?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I507180d7397b6959844a3090801=
0132bc3411067 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 809 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Dec 2024 20:40:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--665x6F8PC7A=--

