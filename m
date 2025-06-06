From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 6 Jun 2025 08:21:39 +0000
References: <gerrit.1749198097000.I32effed9e273fbe8986d1f4e8da4a4d0ac216463@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f90585579a6acbbbe45a27f59f27e198f78d1ec3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v+Ytc8PjCKI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--v+Ytc8PjCKI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1039?usp=3Demail

to review the following change.


Change subject: Multi-socket: local_list clean-up
......................................................................

Multi-socket: local_list clean-up

Optimize the current local_list implementation
by replacing the static array with a resizable
one, as the static allocation serves no real
purpose, particularly on the client side.

Github: #682

Change-Id: I32effed9e273fbe8986d1f4e8da4a4d0ac216463
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/options.c
M src/openvpn/options.h
2 files changed, 14 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1039/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6ea01d4..70337b1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2212,12 +2212,20 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--v+Ytc8PjCKI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1039?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Multi-socket: local_list clean-up<br><br>Optimize the curren=
t local_list implementation<br>by replacing the static array with a resizab=
le<br>one, as the static allocation serves no real<br>purpose, particularly=
 on the client side.<br><br>Github: #682<br><br>Change-Id: I32effed9e273fbe=
8986d1f4e8da4a4d0ac216463<br>Signed-off-by: Gianmarco De Gregori &lt;gianma=
rco@...2726...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/optio=
ns.h<br>2 files changed, 14 insertions(+), 5 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1039/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>ind=
ex 6ea01d4..70337b1 100644</span><br><span>--- a/src/openvpn/options.c</spa=
n><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2212,12 +2212,2=
0 @@</span><br><span>     struct local_list *l =3D alloc_local_list_if_unde=
f(ce, gc);</span><br><span>     struct local_entry *e;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (l-&gt;len &gt;=
=3D CONNECTION_LIST_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (l-&gt;len &gt;=3D l-&gt;capacity)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quo=
t;Maximum number of &#39;local&#39; options (%d) exceeded&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            CONNECTION_LIST_SIZE=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int=
 new_cap =3D l-&gt;capacity + 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        const size_t elem_size =3D sizeof(*l-&gt;array);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct local_entry **new_array =3D gc_realloc(l-&gt;array, new_cap * elem_s=
ize, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!new_array)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
msglevel, &quot;Unable to process more local options: out of memory. Number=
 of entries =3D %d&quot;, l-&gt;len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  l-&gt;array =3D new_array;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        l-&gt;capacity =3D new_cap;</span><br><span>     }</span><=
br><span> </span><br><span>     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, g=
c);</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/option=
s.h</span><br><span>index b28ad58..46ec32b 100644</span><br><span>--- a/src=
/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><s=
pan>@@ -188,8 +188,9 @@</span><br><span> </span><br><span> struct local_lis=
t</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int capacity;</span><br><span>     int len;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct local_entry *array[CONNECTION_LIST_SI=
ZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct loca=
l_entry **array;</span><br><span> };</span><br><span> </span><br><span> str=
uct connection_list</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1039?usp=3Demail">change 1039<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1039?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I32effed9e273fbe8986d1f4e8da=
4a4d0ac216463 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1039 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--v+Ytc8PjCKI=--

