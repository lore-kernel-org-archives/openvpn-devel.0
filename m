From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 21 Jul 2023 13:55:45 +0000
References: <gerrit.1689947729000.If4a67adac4d2e870fd719b58075d39efcd67c671@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net
Message-ID: <d7b6927717998457359ab0517697ddb1650b3424-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1EinAFXaOZM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: buffer: use
 memcpy in buf_catrunc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1EinAFXaOZM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/314?usp=3Demail )


Change subject: buffer: use memcpy in buf_catrunc
......................................................................

buffer: use memcpy in buf_catrunc

Since we use strlen() to determine the length
and then check it ourselves, there is really
no point in using strncpy.

But the compiler might complain that we use
the output of strlen() for the length of
strncpy which is usually a sign for bugs:

error: =E2=80=98strncpy=E2=80=99 specified bound depends
 on the length of the source argument
 [-Werror=3Dstringop-overflow=3D]

Warning was at least triggered for
mingw-gcc version 10-win32 20220113.

Also change the type of len to size_t
which avoids potential problems with
signed overflow.

v2:
 - make len size_t and change code to avoid any theoretical overflows
 - remove useless casts
v3:
 - fix off-by-one introduced by v2 %)
v4:
 - ignore unsigned overflow to simplify code

Change-Id: If4a67adac4d2e870fd719b58075d39efcd67c671
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
(cherry picked from commit c89a97e449baaf60924a362555d35184f188a646)
---
M src/openvpn/buffer.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/314/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index d099795..7725438 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -316,10 +316,10 @@
 {
     if (buf_forward_capacity(buf) <=3D 1)
     {
-        int len =3D (int) strlen(str) + 1;
+        size_t len =3D strlen(str) + 1;
         if (len < buf_forward_capacity_total(buf))
         {
-            strncpynt((char *)(buf->data + buf->capacity - len), str, len);
+            memcpy(buf->data + buf->capacity - len, str, len);
         }
     }
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/314?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: If4a67adac4d2e870fd719b58075d39efcd67c671
Gerrit-Change-Number: 314
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newchange

--1EinAFXaOZM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/314?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">buffer: use memcpy in buf_catrunc<br><br>Since we use strlen() to d=
etermine the length<br>and then check it ourselves, there is really<br>no p=
oint in using strncpy.<br><br>But the compiler might complain that we use<b=
r>the output of strlen() for the length of<br>strncpy which is usually a si=
gn for bugs:<br><br>error: =E2=80=98strncpy=E2=80=99 specified bound depend=
s<br> on the length of the source argument<br> [-Werror=3Dstringop-overflow=
=3D]<br><br>Warning was at least triggered for<br>mingw-gcc version 10-win3=
2 20220113.<br><br>Also change the type of len to size_t<br>which avoids po=
tential problems with<br>signed overflow.<br><br>v2:<br> - make len size_t =
and change code to avoid any theoretical overflows<br> - remove useless cas=
ts<br>v3:<br> - fix off-by-one introduced by v2 %)<br>v4:<br> - ignore unsi=
gned overflow to simplify code<br><br>Change-Id: If4a67adac4d2e870fd719b580=
75d39efcd67c671<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>(cherry picked from =
commit c89a97e449baaf60924a362555d35184f188a646)<br>---<br>M src/openvpn/bu=
ffer.c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/314/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>index =
d099795..7725438 100644</span><br><span>--- a/src/openvpn/buffer.c</span><b=
r><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -316,10 +316,10 @@</s=
pan><br><span> {</span><br><span>     if (buf_forward_capacity(buf) &lt;=3D=
 1)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        int len =3D (int) strlen(str) + 1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        size_t len =3D strlen(str) + 1;</span><=
br><span>         if (len &lt; buf_forward_capacity_total(buf))</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      strncpynt((char *)(buf-&gt;data + buf-&gt;capacity - len), str, len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(=
buf-&gt;data + buf-&gt;capacity - len, str, len);</span><br><span>         =
}</span><br><span>     }</span><br><span> }</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/314?us=
p=3Demail">change 314</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/314?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If4a67adac4d2e870fd719b58075=
d39efcd67c671 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 314 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--1EinAFXaOZM=--

