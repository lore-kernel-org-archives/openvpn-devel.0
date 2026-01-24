From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 24 Jan 2026 15:49:54 +0000
In-Reply-To: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
References: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <36fddac46eb4999de6de5a0e28105601d0463eb3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EInvfZk4VvM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Silence compiler
 truncation warning by checking snprintf return value
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EInvfZk4VvM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
72?usp=3Demail )

Change subject: Silence compiler truncation warning by checking snprintf re=
turn value
......................................................................

Silence compiler truncation warning by checking snprintf return value

On the more recent mingw compilers (homebrew mingw 13.0.0, GCC 15.2.0) the
compiler complains about a potential truncation in these two places.

  src/openvpn/tun.c:3806:57:
  error: '%s' directive output may be truncated writing up
  to 255 bytes into a region of size 178
  [-Werror=3Dformat-truncation=3D]

This not very helpful but checking the snprintf return value
will make the compiler not warn about this.

Change-Id: I54b11a5540fb236580a3b80c6d1e8678b24bd852
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1272
Message-Id: <20260121121830.27244-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
367.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
1 file changed, 16 insertions(+), 3 deletions(-)




diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0399b4a..e38df3e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3558,7 +3558,13 @@
             msg(M_FATAL, "Error enumerating registry subkeys of key: %s", =
ADAPTER_KEY);
         }

-        snprintf(unit_string, sizeof(unit_string), "%s\\%s", ADAPTER_KEY, =
enum_name);
+        int ret =3D snprintf(unit_string, sizeof(unit_string), "%s\\%s", A=
DAPTER_KEY, enum_name);
+
+        if (ret < 0 || ret >=3D sizeof(unit_string))
+        {
+            msg(M_WARN, "Error constructing unit string for %s", enum_name=
);
+            continue;
+        }

         status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, unit_string, 0, KEY_RE=
AD, &unit_key);

@@ -3667,8 +3673,15 @@
             msg(M_FATAL, "Error enumerating registry subkeys of key: %s", =
NETWORK_CONNECTIONS_KEY);
         }

-        snprintf(connection_string, sizeof(connection_string), "%s\\%s\\Co=
nnection",
-                 NETWORK_CONNECTIONS_KEY, enum_name);
+        int ret =3D snprintf(connection_string, sizeof(connection_string),=
 "%s\\%s\\Connection",
+                           NETWORK_CONNECTIONS_KEY, enum_name);
+
+        if (ret < 0 || ret >=3D sizeof(connection_string))
+        {
+            msg(M_WARN, "Error constructing connection string for %s", enu=
m_name);
+            continue;
+        }
+

         status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, connection_string, 0, =
KEY_READ, &connection_key);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1e8678b24bd852
Gerrit-Change-Number: 1272
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EInvfZk4VvM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1272?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Silence compiler truncation warning by checking =
snprintf return value<br><br>On the more recent mingw compilers (homebrew m=
ingw 13.0.0, GCC 15.2.0) the<br>compiler complains about a potential trunca=
tion in these two places.<br><br>  src/openvpn/tun.c:3806:57:<br>  error: &=
#39;%s&#39; directive output may be truncated writing up<br>  to 255 bytes =
into a region of size 178<br>  [-Werror=3Dformat-truncation=3D]<br><br>This=
 not very helpful but checking the snprintf return value<br>will make the c=
ompiler not warn about this.<br><br>Change-Id: I54b11a5540fb236580a3b80c6d1=
e8678b24bd852<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Ack=
ed-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://ge=
rrit.openvpn.net/c/openvpn/+/1272<br>Message-Id: &lt;20260121121830.27244-1=
-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg35367.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file changed, 16 insertion=
s(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index=
 0399b4a..e38df3e 100644</span><br><span>--- a/src/openvpn/tun.c</span><br>=
<span>+++ b/src/openvpn/tun.c</span><br><span>@@ -3558,7 +3558,13 @@</span>=
<br><span>             msg(M_FATAL, &quot;Error enumerating registry subkey=
s of key: %s&quot;, ADAPTER_KEY);</span><br><span>         }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        snprintf(u=
nit_string, sizeof(unit_string), &quot;%s\\%s&quot;, ADAPTER_KEY, enum_name=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int ret =
=3D snprintf(unit_string, sizeof(unit_string), &quot;%s\\%s&quot;, ADAPTER_=
KEY, enum_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ret &lt; 0=
 || ret &gt;=3D sizeof(unit_string))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_WARN, &quot;Error constructing unit string for %s&=
quot;, enum_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span> </span><br><span>         status =3D RegOpenKey=
Ex(HKEY_LOCAL_MACHINE, unit_string, 0, KEY_READ, &amp;unit_key);</span><br>=
<span> </span><br><span>@@ -3667,8 +3673,15 @@</span><br><span>            =
 msg(M_FATAL, &quot;Error enumerating registry subkeys of key: %s&quot;, NE=
TWORK_CONNECTIONS_KEY);</span><br><span>         }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        snprintf(connection_=
string, sizeof(connection_string), &quot;%s\\%s\\Connection&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                 NETWORK_CONNE=
CTIONS_KEY, enum_name);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        int ret =3D snprintf(connection_string, sizeof(connection_strin=
g), &quot;%s\\%s\\Connection&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                           NETWORK_CONNECTIONS_KEY, enum_na=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (ret &lt; 0 || ret &gt;=
=3D sizeof(connection_string))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(M_WARN, &quot;Error constructing connection string for %s&=
quot;, enum_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> </span><br><span>         status =3D RegOpenKeyEx(HKEY_LOCAL_MACHI=
NE, connection_string, 0, KEY_READ, &amp;connection_key);</span><br><span> =
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1272?usp=3Demail">change 1272</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1272?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1=
e8678b24bd852 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1272 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--EInvfZk4VvM=--

