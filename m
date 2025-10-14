From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 14 Oct 2025 11:50:52 +0000
In-Reply-To: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
References: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <239197ec395a6d9ab5ce31635b27b41ae94c4a9f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oaZUoRodlRs="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oaZUoRodlRs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail

to look at the new patch set (#2).


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
---
M src/openvpn/tun.c
1 file changed, 14 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1272/2

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 06b7ae5..8b2d5f4 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3803,7 +3803,12 @@
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
+            msg(M_FATAL, "Error constructing unit string for %s", enum_nam=
e);
+        }

         status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, unit_string, 0, KEY_RE=
AD, &unit_key);

@@ -3912,8 +3917,14 @@
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
+            msg(M_FATAL, "Error constructing connection string for %s", en=
um_name);
+        }
+

         status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, connection_string, 0, =
KEY_READ, &connection_key);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1e8678b24bd852
Gerrit-Change-Number: 1272
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--oaZUoRodlRs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Silence compiler truncation warning by checking snp=
rintf return value<br><br>On the more recent mingw compilers (homebrew ming=
w 13.0.0, GCC 15.2.0) the<br>compiler complains about a potential truncatio=
n in these two places.<br><br>  src/openvpn/tun.c:3806:57:<br>  error: &#39=
;%s&#39; directive output may be truncated writing up<br>  to 255 bytes int=
o a region of size 178<br>  [-Werror=3Dformat-truncation=3D]<br><br>This no=
t very helpful but checking the snprintf return value<br>will make the comp=
iler not warn about this.<br><br>Change-Id: I54b11a5540fb236580a3b80c6d1e86=
78b24bd852<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br=
>M src/openvpn/tun.c<br>1 file changed, 14 insertions(+), 3 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/72/1272/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/t=
un.c</span><br><span>index 06b7ae5..8b2d5f4 100644</span><br><span>--- a/sr=
c/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ =
-3803,7 +3803,12 @@</span><br><span>             msg(M_FATAL, &quot;Error e=
numerating registry subkeys of key: %s&quot;, ADAPTER_KEY);</span><br><span=
>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        snprintf(unit_string, sizeof(unit_string), &quot;%s\\%s&quo=
t;, ADAPTER_KEY, enum_name);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        int ret =3D snprintf(unit_string, sizeof(unit_string), &qu=
ot;%s\\%s&quot;, ADAPTER_KEY, enum_name);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (ret &lt; 0 || ret &gt;=3D sizeof(unit_string))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;Error cons=
tructing unit string for %s&quot;, enum_name);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><span>    =
     status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, unit_string, 0, KEY_READ, =
&amp;unit_key);</span><br><span> </span><br><span>@@ -3912,8 +3917,14 @@</s=
pan><br><span>             msg(M_FATAL, &quot;Error enumerating registry su=
bkeys of key: %s&quot;, NETWORK_CONNECTIONS_KEY);</span><br><span>         =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      snprintf(connection_string, sizeof(connection_string), &quot;%s\\%s\\=
Connection&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
             NETWORK_CONNECTIONS_KEY, enum_name);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        int ret =3D snprintf(connection_strin=
g, sizeof(connection_string), &quot;%s\\%s\\Connection&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                           NETWOR=
K_CONNECTIONS_KEY, enum_name);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (ret &lt; 0 || ret &gt;=3D sizeof(connection_string))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;Error constructin=
g connection string for %s&quot;, enum_name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> </span><br><span>         status =3D RegO=
penKeyEx(HKEY_LOCAL_MACHINE, connection_string, 0, KEY_READ, &amp;connectio=
n_key);</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail">change=
 1272</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1=
e8678b24bd852 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1272 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--oaZUoRodlRs=--

