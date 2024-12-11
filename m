From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Dec 2024 14:23:26 +0000
In-Reply-To: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
References: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5ac033bcd649168d77e97e8dcb95dc9304da8bb9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HM2sxGhGTj0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HM2sxGhGTj0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/827?usp=3Demail )

Change subject: forward: Fix potential unaligned access in drop_if_recursiv=
e_routing
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/827/comment/70a6dbae_af15a5b9 :
PS1, Line 1406:         memcpy(&pip, BPTR(buf) + ip_hdr_offset, sizeof(stru=
ct openvpn_iphdr));
I don't like that.  We're in the per-packet fast path here, and this is exe=
cuted for every single packet - so we shouldn't memcpy() the whole I header=
 around.

I'd suggest doing a `memcmp(pip->daddr, ..., sizeof(pip->daddr))`.  That sh=
ould be of similar cost.


http://gerrit.openvpn.net/c/openvpn/+/827/comment/d54bde03_5397571d :
PS1, Line 1432:         if (IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, =
&pip6.daddr))
This is doing the `memcmp()` already, so we should be fine here...

```
#define IN6_ARE_ADDR_EQUAL(a, b)                        \
    (memcmp(&(a)->s6_addr[0], &(b)->s6_addr[0], sizeof(struct in6_addr)) =
=3D=3D 0)
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4c
Gerrit-Change-Number: 827
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 11 Dec 2024 14:23:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--HM2sxGhGTj0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/827/comment/70a6dbae_af15a5b9">Patch Set #1, Line 140=
6:</a> <code style=3D"font-family:monospace,monospace">        memcpy(&amp;=
pip, BPTR(buf) + ip_hdr_offset, sizeof(struct openvpn_iphdr));</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;t like t=
hat.  We&#39;re in the per-packet fast path here, and this is executed for =
every single packet - so we shouldn&#39;t memcpy() the whole I header aroun=
d.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;d su=
ggest doing a `memcmp(pip-&gt;daddr, ..., sizeof(pip-&gt;daddr))`.  That sh=
ould be of similar cost.</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/827/comment/d54bde03_5397571d">Patch Set #1, Line 1432:</a> <cod=
e style=3D"font-family:monospace,monospace">        if (IN6_ARE_ADDR_EQUAL(=
&amp;tun_sa.addr.in6.sin6_addr, &amp;pip6.daddr))</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">This is doing the `memcmp()` al=
ready, so we should be fine here...</p><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">```<br>#define IN6_ARE_ADDR_EQUAL(a, b)=
                        \<br>    (memcmp(&amp;(a)-&gt;s6_addr[0], &amp;(b)-=
&gt;s6_addr[0], sizeof(struct in6_addr)) =3D=3D 0)<br>```</pre></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
827?usp=3Demail">change 827</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74a9eec4954f3f9d208792b6b34=
357571f76ae4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 827 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Dec 2024 14:23:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--HM2sxGhGTj0=--

