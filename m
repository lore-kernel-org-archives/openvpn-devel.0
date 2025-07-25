From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 25 Jul 2025 10:21:55 +0000
References: <gerrit.1753438913000.I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <41f1d1a0135ae2cf561803dbad4903acf43402d9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9rtBBNtVcNQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Clean up
 function setenv_foreign_option
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

--9rtBBNtVcNQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail

to review the following change.


Change subject: options: Clean up function setenv_foreign_option
......................................................................

options: Clean up function setenv_foreign_option

- Remove unnecessary len > 0 check by reordering
  the code slightly.
- Remove -Wconversion warning by making the len argument
  size_t.

Change-Id: I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
1 file changed, 25 insertions(+), 29 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1112/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 70b5799..4d94211 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1067,41 +1067,37 @@

 #ifndef _WIN32
 static void
-setenv_foreign_option(struct options *o, const char *argv[], int len, stru=
ct env_set *es)
+setenv_foreign_option(struct options *o, const char *argv[], size_t len, s=
truct env_set *es)
 {
-    if (len > 0)
-    {
-        struct gc_arena gc =3D gc_new();
-        struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
-        struct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
-        int i;
-        bool first =3D true;
-        bool good =3D true;
+    struct gc_arena gc =3D gc_new();
+    struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+    struct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+    bool first =3D true;
+    bool good =3D true;

-        good &=3D buf_printf(&name, "foreign_option_%d", o->foreign_option=
_index + 1);
-        ++o->foreign_option_index;
-        for (i =3D 0; i < len; ++i)
+    good &=3D buf_printf(&name, "foreign_option_%d", o->foreign_option_ind=
ex + 1);
+    for (size_t i =3D 0; i < len; ++i)
+    {
+        if (argv[i])
         {
-            if (argv[i])
+            if (!first)
             {
-                if (!first)
-                {
-                    good &=3D buf_printf(&value, " ");
-                }
-                good &=3D buf_printf(&value, "%s", argv[i]);
-                first =3D false;
+                good &=3D buf_printf(&value, " ");
             }
+            good &=3D buf_printf(&value, "%s", argv[i]);
+            first =3D false;
         }
-        if (good)
-        {
-            setenv_str(es, BSTR(&name), BSTR(&value));
-        }
-        else
-        {
-            msg(M_WARN, "foreign_option: name/value overflow");
-        }
-        gc_free(&gc);
     }
+    if (good)
+    {
+        setenv_str(es, BSTR(&name), BSTR(&value));
+        ++o->foreign_option_index;
+    }
+    else
+    {
+        msg(M_WARN, "foreign_option: name/value overflow");
+    }
+    gc_free(&gc);
 }
 #endif /* ifndef _WIN32 */

@@ -3679,7 +3675,7 @@
     {
         /* Set foreign option env vars from --dns config */
         const char *p[] =3D { "dhcp-option", NULL, NULL };
-        size_t p_len =3D sizeof(p) / sizeof(p[0]);
+        const size_t p_len =3D sizeof(p) / sizeof(p[0]);

         p[1] =3D "DOMAIN";
         const struct dns_domain *d =3D dns->search_domains;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201
Gerrit-Change-Number: 1112
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--9rtBBNtVcNQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">options: Clean up function setenv_foreign_option<br><br>- Re=
move unnecessary len &gt; 0 check by reordering<br>  the code slightly.<br>=
- Remove -Wconversion warning by making the len argument<br>  size_t.<br><b=
r>Change-Id: I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/options.c<=
br>1 file changed, 25 insertions(+), 29 deletions(-)<br><br></pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/12/1112/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 7=
0b5799..4d94211 100644</span><br><span>--- a/src/openvpn/options.c</span><b=
r><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1067,41 +1067,37 @@=
</span><br><span> </span><br><span> #ifndef _WIN32</span><br><span> static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-setenv_foreign_op=
tion(struct options *o, const char *argv[], int len, struct env_set *es)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_foreign_option(=
struct options *o, const char *argv[], size_t len, struct env_set *es)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(len &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer value =3D=
 alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        bool first =3D true;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        bool good =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer name =3D all=
oc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 first =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 bool good =3D true;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        good &amp;=3D buf_printf(&amp;name, &quot;foreign_=
option_%d&quot;, o-&gt;foreign_option_index + 1);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        ++o-&gt;foreign_option_index;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; le=
n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    good &am=
p;=3D buf_printf(&amp;name, &quot;foreign_option_%d&quot;, o-&gt;foreign_op=
tion_index + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (size_t i =3D 0; i &lt; len; ++i)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (argv[i])</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (argv[i])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (!first)</span><br><spa=
n>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           if (!first)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 good &amp;=3D buf_printf(&amp;value, &quot; &quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                good &amp;=3D b=
uf_printf(&amp;value, &quot;%s&quot;, argv[i]);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                first =3D false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                good &amp;=3D buf_pr=
intf(&amp;value, &quot; &quot;);</span><br><span>             }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            good &amp;=3D buf_p=
rintf(&amp;value, &quot;%s&quot;, argv[i]);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            first =3D false;</span><br><span>      =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (good)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            setenv_str(es, BSTR(&=
amp;name), BSTR(&amp;value));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &=
quot;foreign_option: name/value overflow&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        gc_free(&amp;gc);</span><br><span>     }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (good)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        setenv_str(es, BSTR(&amp;name), BSTR(&amp;v=
alue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ++o-=
&gt;foreign_option_index;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;foreign=
_option: name/value overflow&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span> }</span><br><span> #endif /* ifnd=
ef _WIN32 */</span><br><span> </span><br><span>@@ -3679,7 +3675,7 @@</span>=
<br><span>     {</span><br><span>         /* Set foreign option env vars fr=
om --dns config */</span><br><span>         const char *p[] =3D { &quot;dhc=
p-option&quot;, NULL, NULL };</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        size_t p_len =3D sizeof(p) / sizeof(p[0]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const size_t p_len =3D sizeo=
f(p) / sizeof(p[0]);</span><br><span> </span><br><span>         p[1] =3D &q=
uot;DOMAIN&quot;;</span><br><span>         const struct dns_domain *d =3D d=
ns-&gt;search_domains;</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail">change 11=
12</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7efc77f63734501dfa8a8f5bed1=
7b1a1b4e9e201 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1112 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--9rtBBNtVcNQ=--

