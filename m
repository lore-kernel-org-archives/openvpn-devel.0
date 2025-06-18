From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Jun 2025 14:08:28 +0000
In-Reply-To: <gerrit.1749198097000.I32effed9e273fbe8986d1f4e8da4a4d0ac216463@...2715...>
References: <gerrit.1749198097000.I32effed9e273fbe8986d1f4e8da4a4d0ac216463@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <796eec542393d11b4ae6f23187c86c736bc43b49-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/Yipibhmu2Q="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Multi-socket:
 local_list clean-up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/Yipibhmu2Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/1039?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Multi-socket: local_list clean-up
......................................................................

Multi-socket: local_list clean-up

Optimize the current local_list implementation
by replacing the static array with a resizable
one, as the static allocation serves no real
purpose, particularly on the client side.

Github: OpenVPN/openvpn#682

Change-Id: I32effed9e273fbe8986d1f4e8da4a4d0ac216463
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250618140016.2766-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
927.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/options.h
2 files changed, 14 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1039/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d758a67..3cf8c2a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2067,12 +2067,20 @@
     struct local_list *l =3D alloc_local_list_if_undef(ce, gc);
     struct local_entry *e;

-    if (l->len >=3D CONNECTION_LIST_SIZE)
+    if (l->len >=3D l->capacity)
     {
-        msg(msglevel, "Maximum number of 'local' options (%d) exceeded",
-            CONNECTION_LIST_SIZE);
+        const int new_cap =3D l->capacity + 1;
+        const size_t elem_size =3D sizeof(*l->array);

-        return NULL;
+        struct local_entry **new_array =3D gc_realloc(l->array, new_cap * =
elem_size, gc);
+        if (!new_array)
+        {
+            msg(msglevel, "Unable to process more local options: out of me=
mory. Number of entries =3D %d", l->len);
+            return NULL;
+        }
+
+        l->array =3D new_array;
+        l->capacity =3D new_cap;
     }

     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b28ad58..46ec32b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -188,8 +188,9 @@

 struct local_list
 {
+    int capacity;
     int len;
-    struct local_entry *array[CONNECTION_LIST_SIZE];
+    struct local_entry **array;
 };

 struct connection_list

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1039?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I32effed9e273fbe8986d1f4e8da4a4d0ac216463
Gerrit-Change-Number: 1039
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--/Yipibhmu2Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1039?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Multi-socket: local_list clean-up<br><br>Optimize th=
e current local_list implementation<br>by replacing the static array with a=
 resizable<br>one, as the static allocation serves no real<br>purpose, part=
icularly on the client side.<br><br>Github: OpenVPN/openvpn#682<br><br>Chan=
ge-Id: I32effed9e273fbe8986d1f4e8da4a4d0ac216463<br>Signed-off-by: Gianmarc=
o De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>Message-Id: &lt;20250618140016.2766-1-gert@...1296...&g=
t;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg31927.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>--=
-<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>2 files changed,=
 14 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/39/1039/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/op=
tions.c b/src/openvpn/options.c</span><br><span>index d758a67..3cf8c2a 1006=
44</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/op=
envpn/options.c</span><br><span>@@ -2067,12 +2067,20 @@</span><br><span>   =
  struct local_list *l =3D alloc_local_list_if_undef(ce, gc);</span><br><sp=
an>     struct local_entry *e;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (l-&gt;len &gt;=3D CONNECTION_LIST_SIZE)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (l-&gt;len &g=
t;=3D l-&gt;capacity)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;Maximum number of &#39;l=
ocal&#39; options (%d) exceeded&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            CONNECTION_LIST_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const int new_cap =3D l-&gt;capac=
ity + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st size_t elem_size =3D sizeof(*l-&gt;array);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct local_entry **new=
_array =3D gc_realloc(l-&gt;array, new_cap * elem_size, gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (!new_array)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;Unable t=
o process more local options: out of memory. Number of entries =3D %d&quot;=
, l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        l-&gt;array =3D new_ar=
ray;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l-&gt;c=
apacity =3D new_cap;</span><br><span>     }</span><br><span> </span><br><sp=
an>     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);</span><br><span>diff=
 --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>inde=
x b28ad58..46ec32b 100644</span><br><span>--- a/src/openvpn/options.h</span=
><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -188,8 +188,9 @@<=
/span><br><span> </span><br><span> struct local_list</span><br><span> {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int capacity;</span=
><br><span>     int len;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct local_entry *array[CONNECTION_LIST_SIZE];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct local_entry **array;</span><=
br><span> };</span><br><span> </span><br><span> struct connection_list</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1039?usp=3Demail">change 1039</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1039?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I32effed9e273fbe8986d1f4e8da=
4a4d0ac216463 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1039 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--/Yipibhmu2Q=--

