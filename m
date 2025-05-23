From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 23 May 2025 06:14:05 +0000
In-Reply-To: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
References: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5f08d08d5013665d56a0f580198773e6bd1169a8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r/CMiOE2TbA="; charset=UTF-8
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
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r/CMiOE2TbA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/904?usp=3Demail )

Change subject: dns: deal with --dhcp-options when --dns is active
......................................................................


Patch Set 21:

(1 comment)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/904/comment/aaf0a34c_938d33d0 :
PS15, Line 4299:         tuntap_options_postprocess_dns(o);
> The reason why is that both had DNS before and they were using the DNS re=
lated elements in `struct t [=E2=80=A6]
I have thought about this a while now, and would suggest to do the following

- *if and only if* we are using the tap driver with ip-win32 dhcp, keep DNS=
 things "as they are in 2.6" -> fill in DHCP options, do not set DNS via is=
ervice
- if DCO is used or a non-DHCP mode -> use iservice

this will effectively make us use iservice most of the time, but if someone=
 really wants old behaviour and relies on DHCP, they can have that (... and=
, alas, we see users that use a) tap, b) dhcp, and c) no iservice... - whic=
h is strongly not recommended, but...)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Gerrit-Change-Number: 904
Gerrit-PatchSet: 21
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 23 May 2025 06:14:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: d12fk <heiko@...515...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--r/CMiOE2TbA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos, s=
tipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/904/comment/aaf0a34c_938d33d0">Patch Set #15, Line 4299:</=
a> <code style=3D"font-family:monospace,monospace">        tuntap_options_p=
ostprocess_dns(o);</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">The reason why is that both had DN=
S before and they were using the DNS related elements in `struct t [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">I have thought about this a while now, and would suggest to do the fol=
lowing</p><ul><li>*if and only if* we are using the tap driver with ip-win3=
2 dhcp, keep DNS things &quot;as they are in 2.6&quot; -&gt; fill in DHCP o=
ptions, do not set DNS via iservice</li><li>if DCO is used or a non-DHCP mo=
de -&gt; use iservice</li></ul><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">this will effectively make us use iservice most of the time,=
 but if someone really wants old behaviour and relies on DHCP, they can hav=
e that (... and, alas, we see users that use a) tap, b) dhcp, and c) no ise=
rvice... - which is strongly not recommended, but...)</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?us=
p=3Demail">change 904</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb=
2e9cb2570cd6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 23 May 2025 06:14:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--r/CMiOE2TbA=--

