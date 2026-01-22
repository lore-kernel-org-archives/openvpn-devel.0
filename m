From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 22 Jan 2026 14:01:14 +0000
In-Reply-To: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
References: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ae7d3807a70536e7604a3ac36a0f4f8ce3b2f569-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2uuNniQpeos="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2uuNniQpeos=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
---
M src/openvpn/status.c
1 file changed, 4 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/1485/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--2uuNniQpeos=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">status: Avoid conversion warnin=
gs in status_read/status_printf<br><br>Just use explicit casts. len is limi=
ted by BCAP and<br>c is limited by being from buf_read_u8. So they are<br>s=
afe.<br><br>In case of status_printf this is only for Windows.<br>len is li=
mited by sizeof(buf), so also a safe cast.<br><br>Change-Id: Iff1343a2f8cc7=
e32b8f36b359a00248e4dc3e8c9<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>M src/openvpn/status.c<br>1 file changed, 4 inserti=
ons(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/85/1485/2</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/status.c b/src/openvpn/status.c</span><br><span>index 3f57244..d09f367=
 100644</span><br><span>--- a/src/openvpn/status.c</span><br><span>+++ b/sr=
c/openvpn/status.c</span><br><span>@@ -206,11 +206,6 @@</span><br><span>   =
  return ret;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> #define STATUS_PRINTF_MAXLEN 512</span><br><span> </span=
><br><span> void</span><br><span>@@ -243,7 +238,7 @@</span><br><span>      =
       size_t len =3D strlen(buf);</span><br><span>             if (len &gt=
; 0)</span><br><span>             {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                if (write(so-&gt;fd, buf, len) !=3D len)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (writ=
e(so-&gt;fd, buf, (unsigned int)len) !=3D len)</span><br><span>            =
     {</span><br><span>                     so-&gt;errors =3D true;</span><=
br><span>                 }</span><br><span>@@ -274,16 +269,14 @@</span><br=
><span>             /* read more of file into buffer */</span><br><span>   =
          if (c =3D=3D -1)</span><br><span>             {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                int len;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>                 AS=
SERT(buf_init(&amp;so-&gt;read_buf, 0));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                len =3D read(so-&gt;fd, BPTR(&amp;so-&gt=
;read_buf), BCAP(&amp;so-&gt;read_buf));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                ssize_t len =3D read(so-&gt;fd, BPTR(&=
amp;so-&gt;read_buf), BCAP(&amp;so-&gt;read_buf));</span><br><span>        =
         if (len &lt;=3D 0)</span><br><span>                 {</span><br><s=
pan>                     break;</span><br><span>                 }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    ASSERT(buf_inc_len(&amp;so-&gt;read_buf, len));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ASSERT(buf_inc_len(&amp;s=
o-&gt;read_buf, (int)len));</span><br><span>                 continue;</spa=
n><br><span>             }</span><br><span> </span><br><span>@@ -299,7 +292=
,7 @@</span><br><span>                 break;</span><br><span>             =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          buf_write_u8(buf, c);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            buf_write_u8(buf, (uint8_t)c);</span><br><span>    =
     }</span><br><span> </span><br><span>         buf_null_terminate(buf);<=
/span><br><span>@@ -307,7 +300,3 @@</span><br><span> </span><br><span>     =
return ret;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail">change 148=
5</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff1343a2f8cc7e32b8f36b359a0=
0248e4dc3e8c9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1485 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--2uuNniQpeos=--

