From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Aug 2025 14:29:41 +0000
References: <gerrit.1754490554000.Ifc183e42b190e19e1d8c351d1cd460a038626e63@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d0654c2da2c25579cf3a8fb74542fb55a85e9c5a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+mrtQ9ZVetw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Change
 command_line_* API to use size_t for lengths
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

--+mrtQ9ZVetw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1136?usp=3Demail

to review the following change.


Change subject: manage: Change command_line_* API to use size_t for lengths
......................................................................

manage: Change command_line_* API to use size_t for lengths

The used functions already expect this.

Change-Id: Ifc183e42b190e19e1d8c351d1cd460a038626e63
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
2 files changed, 7 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1136/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 16b1b73..9750d58 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2247,7 +2247,7 @@
         bool processed_command =3D false;

         ASSERT(len <=3D (int)sizeof(buf));
-        command_line_add(man->connection.in, buf, len);
+        command_line_add(man->connection.in, buf, (size_t)len);

         /*
          * Reset output object
@@ -3786,7 +3786,7 @@
  */

 struct command_line *
-command_line_new(const int buf_len)
+command_line_new(const size_t buf_len)
 {
     struct command_line *cl;
     ALLOC_OBJ_CLEAR(cl, struct command_line);
@@ -3816,10 +3816,9 @@
 }

 void
-command_line_add(struct command_line *cl, const unsigned char *buf, const =
int len)
+command_line_add(struct command_line *cl, const unsigned char *buf, const =
size_t len)
 {
-    int i;
-    for (i =3D 0; i < len; ++i)
+    for (size_t i =3D 0; i < len; ++i)
     {
         if (buf[i] && char_class(buf[i], (CC_PRINT | CC_NEWLINE)))
         {
@@ -3834,10 +3833,9 @@
 const char *
 command_line_get(struct command_line *cl)
 {
-    int i;
     const char *ret =3D NULL;

-    i =3D buf_substring_len(&cl->buf, '\n');
+    int i =3D buf_substring_len(&cl->buf, '\n');
     if (i >=3D 0)
     {
         buf_copy_excess(&cl->residual, &cl->buf, i);
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 01d180a..e234df7 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -83,11 +83,11 @@
     struct buffer residual;
 };

-struct command_line *command_line_new(const int buf_len);
+struct command_line *command_line_new(const size_t buf_len);

 void command_line_free(struct command_line *cl);

-void command_line_add(struct command_line *cl, const unsigned char *buf, c=
onst int len);
+void command_line_add(struct command_line *cl, const unsigned char *buf, c=
onst size_t len);

 const char *command_line_get(struct command_line *cl);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1136?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc183e42b190e19e1d8c351d1cd460a038626e63
Gerrit-Change-Number: 1136
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--+mrtQ9ZVetw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1136?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">manage: Change command_line_* API to use size_t for lengths<=
br><br>The used functions already expect this.<br><br>Change-Id: Ifc183e42b=
190e19e1d8c351d1cd460a038626e63<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>---<br>M src/openvpn/manage.c<br>M src/openvpn/manage.=
h<br>2 files changed, 7 insertions(+), 9 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/36/1136/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 16b=
1b73..9750d58 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><=
span>+++ b/src/openvpn/manage.c</span><br><span>@@ -2247,7 +2247,7 @@</span=
><br><span>         bool processed_command =3D false;</span><br><span> </sp=
an><br><span>         ASSERT(len &lt;=3D (int)sizeof(buf));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        command_line_add(man-&gt;conn=
ection.in, buf, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        command_line_add(man-&gt;connection.in, buf, (size_t)len);</span>=
<br><span> </span><br><span>         /*</span><br><span>          * Reset o=
utput object</span><br><span>@@ -3786,7 +3786,7 @@</span><br><span>  */</sp=
an><br><span> </span><br><span> struct command_line *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-command_line_new(const int buf_len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+command_line_new(const size=
_t buf_len)</span><br><span> {</span><br><span>     struct command_line *cl=
;</span><br><span>     ALLOC_OBJ_CLEAR(cl, struct command_line);</span><br>=
<span>@@ -3816,10 +3816,9 @@</span><br><span> }</span><br><span> </span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-command_l=
ine_add(struct command_line *cl, const unsigned char *buf, const int len)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+command_line_add(stru=
ct command_line *cl, const unsigned char *buf, const size_t len)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt;=
 len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
size_t i =3D 0; i &lt; len; ++i)</span><br><span>     {</span><br><span>   =
      if (buf[i] &amp;&amp; char_class(buf[i], (CC_PRINT | CC_NEWLINE)))</s=
pan><br><span>         {</span><br><span>@@ -3834,10 +3833,9 @@</span><br><=
span> const char *</span><br><span> command_line_get(struct command_line *c=
l)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int i;</span><br><span>     const char *ret =3D NULL;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i =3D buf_substri=
ng_len(&amp;cl-&gt;buf, &#39;\n&#39;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int i =3D buf_substring_len(&amp;cl-&gt;buf, &#39;\n=
&#39;);</span><br><span>     if (i &gt;=3D 0)</span><br><span>     {</span>=
<br><span>         buf_copy_excess(&amp;cl-&gt;residual, &amp;cl-&gt;buf, i=
);</span><br><span>diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h=
</span><br><span>index 01d180a..e234df7 100644</span><br><span>--- a/src/op=
envpn/manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><br><span>@=
@ -83,11 +83,11 @@</span><br><span>     struct buffer residual;</span><br><=
span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-struct command_line *command_line_new(const int buf_len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct command_line *command_lin=
e_new(const size_t buf_len);</span><br><span> </span><br><span> void comman=
d_line_free(struct command_line *cl);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void command_line_add(struct command_line=
 *cl, const unsigned char *buf, const int len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void command_line_add(struct command_line *cl, =
const unsigned char *buf, const size_t len);</span><br><span> </span><br><s=
pan> const char *command_line_get(struct command_line *cl);</span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1136?usp=3Demail">change 1136</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1136?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc183e42b190e19e1d8c351d1cd=
460a038626e63 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1136 </div>
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


--+mrtQ9ZVetw=--

