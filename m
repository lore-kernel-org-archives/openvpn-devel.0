From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 20 Jan 2026 18:17:34 +0000
In-Reply-To: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
References: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <37a8f7e7c8e01962a8ab5915cf4b5d850cee576c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NIf1tfu8zdE="; charset=UTF-8
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

--NIf1tfu8zdE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
1 file changed, 16 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1272/4

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1e8678b24bd852
Gerrit-Change-Number: 1272
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--NIf1tfu8zdE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Silence compiler truncation =
warning by checking snprintf return value<br><br>On the more recent mingw c=
ompilers (homebrew mingw 13.0.0, GCC 15.2.0) the<br>compiler complains abou=
t a potential truncation in these two places.<br><br>  src/openvpn/tun.c:38=
06:57:<br>  error: &#39;%s&#39; directive output may be truncated writing u=
p<br>  to 255 bytes into a region of size 178<br>  [-Werror=3Dformat-trunca=
tion=3D]<br><br>This not very helpful but checking the snprintf return valu=
e<br>will make the compiler not warn about this.<br><br>Change-Id: I54b11a5=
540fb236580a3b80c6d1e8678b24bd852<br>Signed-off-by: Arne Schwabe &lt;arne@...220...=
..1227...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file changed, 16 insertion=
s(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/72/1272/4</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/tun.c b/src/openvpn/tun.c</span><br><span>index 0399b4a..e38df3e 100644</=
span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tu=
n.c</span><br><span>@@ -3558,7 +3558,13 @@</span><br><span>             msg=
(M_FATAL, &quot;Error enumerating registry subkeys of key: %s&quot;, ADAPTE=
R_KEY);</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        snprintf(unit_string, sizeof(unit_s=
tring), &quot;%s\\%s&quot;, ADAPTER_KEY, enum_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int ret =3D snprintf(unit_string,=
 sizeof(unit_string), &quot;%s\\%s&quot;, ADAPTER_KEY, enum_name);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (ret &lt; 0 || ret &gt;=3D sizeof(un=
it_string))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
WARN, &quot;Error constructing unit string for %s&quot;, enum_name);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n> </span><br><span>         status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, un=
it_string, 0, KEY_READ, &amp;unit_key);</span><br><span> </span><br><span>@=
@ -3667,8 +3673,15 @@</span><br><span>             msg(M_FATAL, &quot;Error=
 enumerating registry subkeys of key: %s&quot;, NETWORK_CONNECTIONS_KEY);</=
span><br><span>         }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        snprintf(connection_string, sizeof(connection=
_string), &quot;%s\\%s\\Connection&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                 NETWORK_CONNECTIONS_KEY, enum_name);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int ret =3D s=
nprintf(connection_string, sizeof(connection_string), &quot;%s\\%s\\Connect=
ion&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                  NETWORK_CONNECTIONS_KEY, enum_name);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (ret &lt; 0 || ret &gt;=3D sizeof(connection_str=
ing))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, =
&quot;Error constructing connection string for %s&quot;, enum_name);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span=
>         status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, connection_string, 0,=
 KEY_READ, &amp;connection_key);</span><br><span> </span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1272?usp=3Demail">change 1272</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/12=
72?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1=
e8678b24bd852 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1272 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--NIf1tfu8zdE=--

