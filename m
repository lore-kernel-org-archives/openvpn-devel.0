From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 11 Dec 2024 16:29:37 +0000
In-Reply-To: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
References: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <faae2cd38dd3c1b93b6cd58b0399ee44996befe3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ye9+8dnyzRc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: forward: Fix
 potential unaligned access in drop_if_recursive_routing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ye9+8dnyzRc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/827?usp=3Demail )

Change subject: forward: Fix potential unaligned access in drop_if_recursiv=
e_routing
......................................................................


Patch Set 2:

(2 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/827/comment/dfd760fb_ed8dd6d9 :
PS1, Line 1406:         memcpy(&pip, BPTR(buf) + ip_hdr_offset, sizeof(stru=
ct openvpn_iphdr));
> I don't like that. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/827/comment/8481bc6e_0b647139 :
PS1, Line 1432:         if (IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, =
&pip6.daddr))
> OK, I now see that it's complaining about the in6_addr part, which I find=
 surprising - `s6_addr[]` i [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4c
Gerrit-Change-Number: 827
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Wed, 11 Dec 2024 16:29:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--ye9+8dnyzRc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/827/comment/dfd760fb_ed8dd6d9">Patch Set #1, Line 1406:</=
a> <code style=3D"font-family:monospace,monospace">        memcpy(&amp;pip,=
 BPTR(buf) + ip_hdr_offset, sizeof(struct openvpn_iphdr));</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">I don&#39;t like that. [=E2=80=A6]</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/827/comment/8481bc6e_0b647139">Patch Set #1=
, Line 1432:</a> <code style=3D"font-family:monospace,monospace">        if=
 (IN6_ARE_ADDR_EQUAL(&amp;tun_sa.addr.in6.sin6_addr, &amp;pip6.daddr))</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">OK, I now see that it&#39;s complaining about the in6_add=
r part, which I find surprising - `s6_addr[]` i [=E2=80=A6]</blockquote></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/827?usp=3Demail">change 827</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74a9eec4954f3f9d208792b6b34=
357571f76ae4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 827 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Dec 2024 16:29:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ye9+8dnyzRc=--

