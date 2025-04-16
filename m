From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 16 Apr 2025 11:52:42 +0000
In-Reply-To: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
References: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b3cc2afd321396a7561d35457b974e0d51b0f230-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pPCsCltRbVk="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Reformat the whole
 project with clang-format
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pPCsCltRbVk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/791?usp=3Demail )

Change subject: Reformat the whole project with clang-format
......................................................................


Patch Set 14:

(2 comments)

File sample/sample-plugins/client-connect/sample-client-connect.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/cd08c6bb_0b6173ee :
PS14, Line 252:                    "env has UV_WANT_CC_ASYNC=3D%d, but "
> Has nothing to do with this patch though, AFAICT
You're right. I thought it was the right moment to trigger the discussion, =
so we can possibly find a clang-format option that addresses this.


File sample/sample-plugins/defer/multi-auth.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/6b1aef69_72e254a0 :
PS14, Line 294:                       const char *envp[])
> yes. This is BinPackParameters. [=E2=80=A6]
I think we should. It will also make BinPackParameters consistent with BinP=
ackArguments



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b8973463404e3e
Gerrit-Change-Number: 791
Gerrit-PatchSet: 14
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 16 Apr 2025 11:52:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ordex <antonio@...2726...>
Gerrit-MessageType: comment

--pPCsCltRbVk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File sample/sample-plugins/client-c=
onnect/sample-client-connect.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/cd08c6=
bb_0b6173ee">Patch Set #14, Line 252:</a> <code style=3D"font-family:monosp=
ace,monospace">                   &quot;env has UV_WANT_CC_ASYNC=3D%d, but =
&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Has nothing to do with this patch though, AFAI=
CT</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">You&#39;re right. I thought it was the right moment to trigger the discu=
ssion, so we can possibly find a clang-format option that addresses this.</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample/sample=
-plugins/defer/multi-auth.c:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/6b1aef69_=
72e254a0">Patch Set #14, Line 294:</a> <code style=3D"font-family:monospace=
,monospace">                      const char *envp[])</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>yes. This is BinPackParameters. [=E2=80=A6]</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">I think we should. It will als=
o make BinPackParameters consistent with BinPackArguments</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/79=
1?usp=3Demail">change 791</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b=
8973463404e3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 791 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Apr 2025 11:52:42=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--pPCsCltRbVk=--

