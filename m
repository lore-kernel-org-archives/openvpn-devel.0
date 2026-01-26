From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 16:34:03 +0000
In-Reply-To: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
References: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <29af9f48281f432f1dedaab2368cad0f555f4e3a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="edPXQXCHagw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: status: Avoid
 conversion warnings in status_read/status_printf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--edPXQXCHagw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2.

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: status: Avoid conversion warnings in status_read/status_pri=
ntf
......................................................................

status: Avoid conversion warnings in status_read/status_printf

Just use explicit casts. len is limited by BCAP and
c is limited by being from buf_read_u8. So they are
safe.

In case of status_printf this is only for Windows.
len is limited by sizeof(buf), so also a safe cast.

Change-Id: Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1485
Message-Id: <20260122154751.155227-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
398.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/status.c
1 file changed, 4 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/1485/3

diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 3f57244..d09f367 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -206,11 +206,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 #define STATUS_PRINTF_MAXLEN 512

 void
@@ -243,7 +238,7 @@
             size_t len =3D strlen(buf);
             if (len > 0)
             {
-                if (write(so->fd, buf, len) !=3D len)
+                if (write(so->fd, buf, (unsigned int)len) !=3D len)
                 {
                     so->errors =3D true;
                 }
@@ -274,16 +269,14 @@
             /* read more of file into buffer */
             if (c =3D=3D -1)
             {
-                int len;
-
                 ASSERT(buf_init(&so->read_buf, 0));
-                len =3D read(so->fd, BPTR(&so->read_buf), BCAP(&so->read_b=
uf));
+                ssize_t len =3D read(so->fd, BPTR(&so->read_buf), BCAP(&so=
->read_buf));
                 if (len <=3D 0)
                 {
                     break;
                 }

-                ASSERT(buf_inc_len(&so->read_buf, len));
+                ASSERT(buf_inc_len(&so->read_buf, (int)len));
                 continue;
             }

@@ -299,7 +292,7 @@
                 break;
             }
=20
-            buf_write_u8(buf, c);
+            buf_write_u8(buf, (uint8_t)c);
         }

         buf_null_terminate(buf);
@@ -307,7 +300,3 @@

     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9
Gerrit-Change-Number: 1485
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>

--edPXQXCHagw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2. </p>
<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1485?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">status: Avoid conversion warnings i=
n status_read/status_printf<br><br>Just use explicit casts. len is limited =
by BCAP and<br>c is limited by being from buf_read_u8. So they are<br>safe.=
<br><br>In case of status_printf this is only for Windows.<br>len is limite=
d by sizeof(buf), so also a safe cast.<br><br>Change-Id: Iff1343a2f8cc7e32b=
8f36b359a00248e4dc3e8c9<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1485<br>Mes=
sage-Id: &lt;20260122154751.155227-1-frank@...2641...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35398.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/s=
tatus.c<br>1 file changed, 4 insertions(+), 15 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85=
/1485/3</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/status.c b/src/openvpn/status.c</s=
pan><br><span>index 3f57244..d09f367 100644</span><br><span>--- a/src/openv=
pn/status.c</span><br><span>+++ b/src/openvpn/status.c</span><br><span>@@ -=
206,11 +206,6 @@</span><br><span>     return ret;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define STATUS_PRINT=
F_MAXLEN 512</span><br><span> </span><br><span> void</span><br><span>@@ -24=
3,7 +238,7 @@</span><br><span>             size_t len =3D strlen(buf);</spa=
n><br><span>             if (len &gt; 0)</span><br><span>             {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (write=
(so-&gt;fd, buf, len) !=3D len)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                if (write(so-&gt;fd, buf, (unsigned int)len) !=
=3D len)</span><br><span>                 {</span><br><span>               =
      so-&gt;errors =3D true;</span><br><span>                 }</span><br>=
<span>@@ -274,16 +269,14 @@</span><br><span>             /* read more of fi=
le into buffer */</span><br><span>             if (c =3D=3D -1)</span><br><=
span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              int len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>                 ASSERT(buf_init(&amp;so-&gt;read_buf, 0)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                len=
 =3D read(so-&gt;fd, BPTR(&amp;so-&gt;read_buf), BCAP(&amp;so-&gt;read_buf)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
size_t len =3D read(so-&gt;fd, BPTR(&amp;so-&gt;read_buf), BCAP(&amp;so-&gt=
;read_buf));</span><br><span>                 if (len &lt;=3D 0)</span><br>=
<span>                 {</span><br><span>                     break;</span>=
<br><span>                 }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                ASSERT(buf_inc_len(&amp;so-&gt;rea=
d_buf, len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          ASSERT(buf_inc_len(&amp;so-&gt;read_buf, (int)len));</span><br><s=
pan>                 continue;</span><br><span>             }</span><br><sp=
an> </span><br><span>@@ -299,7 +292,7 @@</span><br><span>                 b=
reak;</span><br><span>             }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            buf_write_u8(buf, c);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            buf_write_u8(buf=
, (uint8_t)c);</span><br><span>         }</span><br><span> </span><br><span=
>         buf_null_terminate(buf);</span><br><span>@@ -307,7 +300,3 @@</spa=
n><br><span> </span><br><span>     return ret;</span><br><span> }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1485?usp=3Demail">change 1485</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1485?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff1343a2f8cc7e32b8f36b359a0=
0248e4dc3e8c9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1485 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>

</body></html>=

--edPXQXCHagw=--

