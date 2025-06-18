From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Jun 2025 14:08:30 +0000
In-Reply-To: <gerrit.1749198097000.I32effed9e273fbe8986d1f4e8da4a4d0ac216463@...2715...>
References: <gerrit.1749198097000.I32effed9e273fbe8986d1f4e8da4a4d0ac216463@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <796eec542393d11b4ae6f23187c86c736bc43b49-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="elitkq0xSAo="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--elitkq0xSAo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
39?usp=3Demail )

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
Gerrit-MessageType: merged

--elitkq0xSAo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1039?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Multi-socket: local_list clean-up<br><br>Opti=
mize the current local_list implementation<br>by replacing the static array=
 with a resizable<br>one, as the static allocation serves no real<br>purpos=
e, particularly on the client side.<br><br>Github: OpenVPN/openvpn#682<br><=
br>Change-Id: I32effed9e273fbe8986d1f4e8da4a4d0ac216463<br>Signed-off-by: G=
ianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: Gert Doering =
&lt;gert@...1296...&gt;<br>Message-Id: &lt;20250618140016.2766-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg31927.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>2 files c=
hanged, 14 insertions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index d758a67..3cf8c2a 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2067,12 +=
2067,20 @@</span><br><span>     struct local_list *l =3D alloc_local_list_i=
f_undef(ce, gc);</span><br><span>     struct local_entry *e;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (l-&gt;len =
&gt;=3D CONNECTION_LIST_SIZE)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (l-&gt;len &gt;=3D l-&gt;capacity)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, =
&quot;Maximum number of &#39;local&#39; options (%d) exceeded&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            CONNECTION_LIST_=
SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 int new_cap =3D l-&gt;capacity + 1;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        const size_t elem_size =3D sizeof(*l-&gt;array);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct local_entry **new_array =3D gc_realloc(l-&gt;array, new_cap * el=
em_size, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (!new_array)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(msglevel, &quot;Unable to process more local options: out of memory. Nu=
mber of entries =3D %d&quot;, l-&gt;len);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      l-&gt;array =3D new_array;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        l-&gt;capacity =3D new_cap;</span><br><span>     }</sp=
an><br><span> </span><br><span>     ALLOC_OBJ_CLEAR_GC(e, struct local_entr=
y, gc);</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/op=
tions.h</span><br><span>index b28ad58..46ec32b 100644</span><br><span>--- a=
/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><b=
r><span>@@ -188,8 +188,9 @@</span><br><span> </span><br><span> struct local=
_list</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int capacity;</span><br><span>     int len;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct local_entry *array[CONNECTION_LI=
ST_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 local_entry **array;</span><br><span> };</span><br><span> </span><br><span=
> struct connection_list</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1039?usp=3Demail">change =
1039</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1039?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--elitkq0xSAo=--

