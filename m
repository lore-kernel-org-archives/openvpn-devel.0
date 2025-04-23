From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 23 Apr 2025 10:52:03 +0000
In-Reply-To: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
References: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <50b69af99f42472033b2b78efd79884e98084cbe-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2jzOXZ+VFWc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: deal with
 --dhcp-options when --dns is active
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2jzOXZ+VFWc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/904?usp=3Demail )

Change subject: dns: deal with --dhcp-options when --dns is active
......................................................................


Patch Set 14:

(1 comment)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/904/comment/af9bbdf4_cef7db0a :
PS14, Line 8350:         }
is "else" missing here? I have "--dhcp-option DNS 8.8.4.4" pushed by server=
 which got applied, but I also got a warning "Options error: --dhcp-option:=
 unknown option type 'DNS' or missing or unknown parameter".



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Gerrit-Change-Number: 904
Gerrit-PatchSet: 14
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Wed, 23 Apr 2025 10:52:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--2jzOXZ+VFWc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/904/comment/af9bbdf4_cef7db0a">Patch Set #14, Line 8350:</=
a> <code style=3D"font-family:monospace,monospace">        }</code></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">is &quot;else&quot; =
missing here? I have &quot;--dhcp-option DNS 8.8.4.4&quot; pushed by server=
 which got applied, but I also got a warning &quot;Options error: --dhcp-op=
tion: unknown option type &#39;DNS&#39; or missing or unknown parameter&quo=
t;.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/904?usp=3Demail">change 904</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/904?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb=
2e9cb2570cd6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Apr 2025 10:52:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--2jzOXZ+VFWc=--

