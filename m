From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 26 Mar 2025 15:35:54 +0000
In-Reply-To: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
References: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <1fad0605ed77d31829d80b0f4a3a26a66dd7a184-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D/roE3/nedQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix compatibility
 with mbedTLS 2.28.10+ and 3.6.3+
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--D/roE3/nedQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/918?usp=3Demail )

Change subject: Fix compatibility with mbedTLS 2.28.10+ and 3.6.3+
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/918/comment/7a6475b0_b3aabe55 :
PS1, Line 1250:     mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL);
> Should we check the return value? [=E2=80=A6]
That applies to a lot of calls in this function, right?
So what are you thinking? `ASSERT(mbed_ok(` ?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef
Gerrit-Change-Number: 918
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 26 Mar 2025 15:35:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--D/roE3/nedQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/918/comment/7a6475b0_b3aabe55">Patch Set #1, Line 1250=
:</a> <code style=3D"font-family:monospace,monospace">    mbedtls_ssl_set_h=
ostname(ks_ssl-&gt;ctx, NULL);</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should we check the re=
turn value? [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">That applies to a lot of calls in this function, ri=
ght?<br>So what are you thinking? `ASSERT(mbed_ok(` ?</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/918?us=
p=3Demail">change 918</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8bbb6ffdac7d0029dbf3c13e62c=
11b61813c15ef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 918 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Mar 2025 15:35:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--D/roE3/nedQ=--

