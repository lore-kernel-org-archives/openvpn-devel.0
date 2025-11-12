From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 13:24:18 +0000
In-Reply-To: <gerrit.1762949155000.I4104d7e34fbc7232b677e937fc598128a8b7b3bc@...2715...>
References: <gerrit.1762949155000.I4104d7e34fbc7232b677e937fc598128a8b7b3bc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <95d2f21f9a545c54c8c0a580dbbf44b35057508f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BWYt1+9A+q0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tapctl: use better
 wording for adapters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BWYt1+9A+q0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
71?usp=3Demail )

Change subject: tapctl: use better wording for adapters
......................................................................

tapctl: use better wording for adapters

"TUN/TAP" is a bit confusing, so use more generic "VPN network adapter"
wording.

Change-Id: I4104d7e34fbc7232b677e937fc598128a8b7b3bc
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1371
Message-Id: <20251112130149.10890-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
364.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/tapctl/main.c
1 file changed, 10 insertions(+), 10 deletions(-)




diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 031e262..84da161 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -50,9 +50,9 @@
     L"\n"
     L"Commands:\n"
     L"\n"
-    L"create     Create a new TUN/TAP adapter\n"
-    L"list       List TUN/TAP adapters\n"
-    L"delete     Delete specified network adapter\n"
+    L"create     Create a new VPN network adapter\n"
+    L"list       List VPN network adapters\n"
+    L"delete     Delete specified VPN network adapter\n"
     L"help       Display this text\n"
     L"\n"
     L"Hint: Use \"tapctl help <command>\" to display help for particular c=
ommand.\n"
@@ -61,7 +61,7 @@
 static const WCHAR usage_message_create[] =3D
     L"%ls\n"
     L"\n"
-    L"Creates a new TUN/TAP adapter\n"
+    L"Creates a new VPN network adapter\n"
     L"\n"
     L"Usage:\n"
     L"\n"
@@ -69,8 +69,8 @@
     L"\n"
     L"Options:\n"
     L"\n"
-    L"--name <name>  Set TUN/TAP adapter name. Should the adapter with giv=
en name    \n"
-    L"               already exist, an error is returned. If this option i=
s not      \n"
+    L"--name <name>  Set VPN network adapter name. Should the adapter with=
 given     \n"
+    L"               name already exist, an error is returned. If this opt=
ion is not \n"
     L"               specified, a default adapter name is chosen by Window=
s.         \n"
     L"               Note: This name can also be specified as OpenVPN's --=
dev-node   \n"
     L"               option.                                              =
           \n"
@@ -80,13 +80,13 @@
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints newly created TUN/TAP adapter's GUID to stdout. =
           \n"
+    L"This command prints newly created VPN network adapter's GUID to stdo=
ut.        \n"
 ;

 static const WCHAR usage_message_list[] =3D
     L"%ls\n"
     L"\n"
-    L"Lists TUN/TAP adapters\n"
+    L"Lists VPN network adapters\n"
     L"\n"
     L"Usage:\n"
     L"\n"
@@ -99,13 +99,13 @@
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints all TUN/TAP adapters to stdout.                 =
           \n"
+    L"This command prints all VPN network adapters to stdout.             =
           \n"
 ;

 static const WCHAR usage_message_delete[] =3D
     L"%ls\n"
     L"\n"
-    L"Deletes the specified network adapter\n"
+    L"Deletes the specified VPN network adapter\n"
     L"\n"
     L"Usage:\n"
     L"\n"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1371?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4104d7e34fbc7232b677e937fc598128a8b7b3bc
Gerrit-Change-Number: 1371
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BWYt1+9A+q0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1371?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tapctl: use better wording for adapters<br><br>&=
quot;TUN/TAP&quot; is a bit confusing, so use more generic &quot;VPN networ=
k adapter&quot;<br>wording.<br><br>Change-Id: I4104d7e34fbc7232b677e937fc59=
8128a8b7b3bc<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-=
by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.open=
vpn.net/c/openvpn/+/1371<br>Message-Id: &lt;20251112130149.10890-1-gert@...493...=
1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1659...=
forge.net/msg34364.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&=
gt;<br>---<br>M src/tapctl/main.c<br>1 file changed, 10 insertions(+), 10 d=
eletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index=
 031e262..84da161 100644</span><br><span>--- a/src/tapctl/main.c</span><br>=
<span>+++ b/src/tapctl/main.c</span><br><span>@@ -50,9 +50,9 @@</span><br><=
span>     L&quot;\n&quot;</span><br><span>     L&quot;Commands:\n&quot;</sp=
an><br><span>     L&quot;\n&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    L&quot;create     Create a new TUN/TAP adapter\n&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    L&quot;list       List=
 TUN/TAP adapters\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    L&quot;delete     Delete specified network adapter\n&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;create     Create=
 a new VPN network adapter\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    L&quot;list       List VPN network adapters\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;delete     De=
lete specified VPN network adapter\n&quot;</span><br><span>     L&quot;help=
       Display this text\n&quot;</span><br><span>     L&quot;\n&quot;</span=
><br><span>     L&quot;Hint: Use \&quot;tapctl help &lt;command&gt;\&quot; =
to display help for particular command.\n&quot;</span><br><span>@@ -61,7 +6=
1,7 @@</span><br><span> static const WCHAR usage_message_create[] =3D</span=
><br><span>     L&quot;%ls\n&quot;</span><br><span>     L&quot;\n&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    L&quot;Creates a new =
TUN/TAP adapter\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    L&quot;Creates a new VPN network adapter\n&quot;</span><br><span>  =
   L&quot;\n&quot;</span><br><span>     L&quot;Usage:\n&quot;</span><br><sp=
an>     L&quot;\n&quot;</span><br><span>@@ -69,8 +69,8 @@</span><br><span> =
    L&quot;\n&quot;</span><br><span>     L&quot;Options:\n&quot;</span><br>=
<span>     L&quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    L&quot;--name &lt;name&gt;  Set TUN/TAP adapter name. Should the a=
dapter with given name    \n&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    L&quot;               already exist, an error is returned.=
 If this option is not      \n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    L&quot;--name &lt;name&gt;  Set VPN network adapter na=
me. Should the adapter with given     \n&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    L&quot;               name already exist, an=
 error is returned. If this option is not \n&quot;</span><br><span>     L&q=
uot;               specified, a default adapter name is chosen by Windows. =
        \n&quot;</span><br><span>     L&quot;               Note: This name=
 can also be specified as OpenVPN&#39;s --dev-node   \n&quot;</span><br><sp=
an>     L&quot;               option.                                      =
                   \n&quot;</span><br><span>@@ -80,13 +80,13 @@</span><br><=
span>     L&quot;\n&quot;</span><br><span>     L&quot;Output:\n&quot;</span=
><br><span>     L&quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    L&quot;This command prints newly created TUN/TAP adapter&#39;=
s GUID to stdout.            \n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    L&quot;This command prints newly created VPN network =
adapter&#39;s GUID to stdout.        \n&quot;</span><br><span> ;</span><br>=
<span> </span><br><span> static const WCHAR usage_message_list[] =3D</span>=
<br><span>     L&quot;%ls\n&quot;</span><br><span>     L&quot;\n&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    L&quot;Lists TUN/TAP a=
dapters\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
L&quot;Lists VPN network adapters\n&quot;</span><br><span>     L&quot;\n&qu=
ot;</span><br><span>     L&quot;Usage:\n&quot;</span><br><span>     L&quot;=
\n&quot;</span><br><span>@@ -99,13 +99,13 @@</span><br><span>     L&quot;\n=
&quot;</span><br><span>     L&quot;Output:\n&quot;</span><br><span>     L&q=
uot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    L&quo=
t;This command prints all TUN/TAP adapters to stdout.                      =
      \n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L=
&quot;This command prints all VPN network adapters to stdout.              =
          \n&quot;</span><br><span> ;</span><br><span> </span><br><span> st=
atic const WCHAR usage_message_delete[] =3D</span><br><span>     L&quot;%ls=
\n&quot;</span><br><span>     L&quot;\n&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    L&quot;Deletes the specified network adapter\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;Del=
etes the specified VPN network adapter\n&quot;</span><br><span>     L&quot;=
\n&quot;</span><br><span>     L&quot;Usage:\n&quot;</span><br><span>     L&=
quot;\n&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1371?usp=3Demail">change 1371</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1371?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4104d7e34fbc7232b677e937fc5=
98128a8b7b3bc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1371 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--BWYt1+9A+q0=--

