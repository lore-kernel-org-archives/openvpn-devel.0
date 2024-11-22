From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 22 Nov 2024 15:36:03 +0000
In-Reply-To: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
References: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <62b468f5ff7dbc35299282ea9df6cb030be742a1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2fZTuLW7Bx0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp.c: keep offset
 value when resetting buffer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2fZTuLW7Bx0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail

to look at the new patch set (#2).


Change subject: mudp.c: keep offset value when resetting buffer
......................................................................

mudp.c: keep offset value when resetting buffer

dco-win requires control packets to be prepended
with sockaddr. For that, an offset value in buffer
must be kept. Doing it always doesn't harm and makes
code cleaner compared to adding "if (dco_win_server)"
condition.

Change-Id: I145573555aaace5e94774b5f977d032d3747ed72
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/mudp.c
1 file changed, 3 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/814/2

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 5fbd7b0..bba34ef 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -54,7 +54,9 @@

     struct context *c =3D &m->top;

-    buf_reset_len(&c->c2.buffers->aux_buf);
+    /* dco-win server requires prepend with sockaddr, so preserve offset */
+    ASSERT(buf_init(&c->c2.buffers->aux_buf, buf.offset));
+
     buf_copy(&c->c2.buffers->aux_buf, &buf);
     m->hmac_reply =3D c->c2.buffers->aux_buf;
     m->hmac_reply_dest =3D &m->top.c2.from;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I145573555aaace5e94774b5f977d032d3747ed72
Gerrit-Change-Number: 814
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--2fZTuLW7Bx0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">mudp.c: keep offset value when resetting buffer<br><br>dco-win requires c=
ontrol packets to be prepended<br>with sockaddr. For that, an offset value =
in buffer<br>must be kept. Doing it always doesn&#39;t harm and makes<br>co=
de cleaner compared to adding &quot;if (dco_win_server)&quot;<br>condition.=
<br><br>Change-Id: I145573555aaace5e94774b5f977d032d3747ed72<br>Signed-off-=
by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/mudp.c<br>1 =
file changed, 3 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/14/814/2</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 5fbd7b0..bba34ef =
100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/o=
penvpn/mudp.c</span><br><span>@@ -54,7 +54,9 @@</span><br><span> </span><br=
><span>     struct context *c =3D &amp;m-&gt;top;</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_reset_len(&amp;c-&gt;=
c2.buffers-&gt;aux_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* dco-win server requires prepend with sockaddr, so preserve offs=
et */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf=
_init(&amp;c-&gt;c2.buffers-&gt;aux_buf, buf.offset));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     buf_copy(&amp;c-&g=
t;c2.buffers-&gt;aux_buf, &amp;buf);</span><br><span>     m-&gt;hmac_reply =
=3D c-&gt;c2.buffers-&gt;aux_buf;</span><br><span>     m-&gt;hmac_reply_des=
t =3D &amp;m-&gt;top.c2.from;</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail">cha=
nge 814</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I145573555aaace5e94774b5f977=
d032d3747ed72 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 814 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--2fZTuLW7Bx0=--

