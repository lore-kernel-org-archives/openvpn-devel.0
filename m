From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 17 Apr 2025 11:36:32 +0000
In-Reply-To: <gerrit.1744889440000.I4507be07cd5573b2117e837ef03187535a38a4b1@...2715...>
References: <gerrit.1744889440000.I4507be07cd5573b2117e837ef03187535a38a4b1@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <97e067a3913c7d3b1b5e37e349a4d0e3bf77407a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IxjsTPo7fXk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl.c:
 Prevent potential double-free
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IxjsTPo7fXk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/942?usp=3Demail )

Change subject: ssl_openssl.c: Prevent potential double-free
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/942/comment/765fe0e2_13dcd7b5 :
PS1, Line 1158:     while (!OSSL_STORE_eof(store_ctx))
> what you describe if possible only if this check if false immediately, ri=
ght? [=E2=80=A6]
Yes, this is what happened with mattock's certs.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4507be07cd5573b2117e837ef03187535a38a4b1
Gerrit-Change-Number: 942
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Thu, 17 Apr 2025 11:36:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>
Gerrit-MessageType: comment

--IxjsTPo7fXk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/942/comment/765fe0e2_13dcd7b5">Patch Set #1, Line 1158=
:</a> <code style=3D"font-family:monospace,monospace">    while (!OSSL_STOR=
E_eof(store_ctx))</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">what you describe if possible only =
if this check if false immediately, right? [=E2=80=A6]</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Yes, this is what ha=
ppened with mattock&#39;s certs.</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail">change 942=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4507be07cd5573b2117e837ef03=
187535a38a4b1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Apr 2025 11:36:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--IxjsTPo7fXk=--

