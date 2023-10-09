From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 9 Oct 2023 10:43:14 +0000
In-Reply-To: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
References: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bfc2b91cbfb9eb622dbc4c9110ed592765fe96a8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="njxyAKBFpEA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Print SSL peer
 signature information in handshake debug details
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--njxyAKBFpEA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/365?usp=3Demail )

Change subject: Print SSL peer signature information in handshake debug det=
ails
......................................................................


Patch Set 7:

(2 comments)

File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/365/comment/3b343ee7_423d9351 :
PS5, Line 2166:     openvpn_snprintf(buf, buflen, ", peer temporary key: %s=
",
> This probably belongs in the previous commit.
Done


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/365/comment/be8eca11_de41140b :
PS7, Line 2214:     const char *peer_sig_type =3D "";
With libressl or openssl 1.0.2 this will print "" for now. Should we maybe =
change the default to "UNKNOWN" or something similar? Or would you consider=
 that useless clutter?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5
Gerrit-Change-Number: 365
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 09 Oct 2023 10:43:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--njxyAKBFpEA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/365/comment/3b343ee7_423d9351">Patch Set #5, Line 216=
6:</a> <code style=3D"font-family:monospace,monospace">    openvpn_snprintf=
(buf, buflen, &quot;, peer temporary key: %s&quot;,</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">T=
his probably belongs in the previous commit.</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/365/comment/be8eca11_de41140b">Patch Set #7, Line 2214:</a> =
<code style=3D"font-family:monospace,monospace">    const char *peer_sig_ty=
pe =3D &quot;&quot;;</code></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">With libressl or openssl 1.0.2 this will print &quot;&quot; =
for now. Should we maybe change the default to &quot;UNKNOWN&quot; or somet=
hing similar? Or would you consider that useless clutter?</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/36=
5?usp=3Demail">change 365</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5fc0c4b8f164596681ac5ad730=
02068ec6de1e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 365 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Oct 2023 10:43:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--njxyAKBFpEA=--

