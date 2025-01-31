From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 31 Jan 2025 19:11:26 +0000
In-Reply-To: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
References: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <6b254c078cbcbef9622cea13d0b5aa8d344e130c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iTd2bJPlnSQ="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--iTd2bJPlnSQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/81=
4?usp=3Demail )

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250121161025.37545-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
519.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mudp.c
1 file changed, 3 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 4f2bbd7..5f43db9 100644
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
Gerrit-PatchSet: 13
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--iTd2bJPlnSQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/814?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">mudp.c: keep offset value when resetting buffe=
r<br><br>dco-win requires control packets to be prepended<br>with sockaddr.=
 For that, an offset value in buffer<br>must be kept. Doing it always doesn=
&#39;t harm and makes<br>code cleaner compared to adding &quot;if (dco_win_=
server)&quot;<br>condition.<br><br>Change-Id: I145573555aaace5e94774b5f977d=
032d3747ed72<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;202501211=
61025.37545-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/ope=
nvpn-devel@lists.sourceforge.net/msg30519.html<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/mudp.c<br>1 file changed=
, 3 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>ind=
ex 4f2bbd7..5f43db9 100644</span><br><span>--- a/src/openvpn/mudp.c</span><=
br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -54,7 +54,9 @@</span><=
br><span> </span><br><span>     struct context *c =3D &amp;m-&gt;top;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_r=
eset_len(&amp;c-&gt;c2.buffers-&gt;aux_buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* dco-win server requires prepend with sockad=
dr, so preserve offset */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(buf_init(&amp;c-&gt;c2.buffers-&gt;aux_buf, buf.offset));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  buf_copy(&amp;c-&gt;c2.buffers-&gt;aux_buf, &amp;buf);</span><br><span>  =
   m-&gt;hmac_reply =3D c-&gt;c2.buffers-&gt;aux_buf;</span><br><span>     =
m-&gt;hmac_reply_dest =3D &amp;m-&gt;top.c2.from;</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
814?usp=3Demail">change 814</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I145573555aaace5e94774b5f977=
d032d3747ed72 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 814 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--iTd2bJPlnSQ=--

