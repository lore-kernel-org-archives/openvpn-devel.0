From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 06:51:10 +0000
In-Reply-To: <gerrit.1754490554000.Ifc183e42b190e19e1d8c351d1cd460a038626e63@...2715...>
References: <gerrit.1754490554000.Ifc183e42b190e19e1d8c351d1cd460a038626e63@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2f6fb446816b3af66183259364fc263fe083e1c5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="naGAZnIh2Us="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--naGAZnIh2Us=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1136?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: manage: Change command_line_* API to use size_t for lengths
......................................................................

manage: Change command_line_* API to use size_t for lengths

The used functions already expect this.

Change-Id: Ifc183e42b190e19e1d8c351d1cd460a038626e63
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1136
Message-Id: <20250914174638.6867-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
929.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
2 files changed, 7 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1136/6

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 114e4c6..4decdfe 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2334,7 +2334,7 @@
         bool processed_command =3D false;

         ASSERT(len <=3D (int)sizeof(buf));
-        command_line_add(man->connection.in, buf, len);
+        command_line_add(man->connection.in, buf, (size_t)len);

         /*
          * Reset output object
@@ -3873,7 +3873,7 @@
  */

 struct command_line *
-command_line_new(const int buf_len)
+command_line_new(const size_t buf_len)
 {
     struct command_line *cl;
     ALLOC_OBJ_CLEAR(cl, struct command_line);
@@ -3903,10 +3903,9 @@
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
@@ -3921,10 +3920,9 @@
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
index 0bce25e..7c189ba 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -80,11 +80,11 @@
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
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--naGAZnIh2Us=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1136?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">manage: Change command_line_* API to use size_t for =
lengths<br><br>The used functions already expect this.<br><br>Change-Id: If=
c183e42b190e19e1d8c351d1cd460a038626e63<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1136<br>Message-Id: =
&lt;20250914174638.6867-1-gert@...1296...&gt;<br>URL: https://www.mail-arch=
ive.com/openvpn-devel@lists.sourceforge.net/msg32929.html<br>Signed-off-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/manage.c<br>M=
 src/openvpn/manage.h<br>2 files changed, 7 insertions(+), 9 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/11=
36/6</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span=
><br><span>index 114e4c6..4decdfe 100644</span><br><span>--- a/src/openvpn/=
manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -233=
4,7 +2334,7 @@</span><br><span>         bool processed_command =3D false;</=
span><br><span> </span><br><span>         ASSERT(len &lt;=3D (int)sizeof(bu=
f));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        command_l=
ine_add(man-&gt;connection.in, buf, len);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        command_line_add(man-&gt;connection.in, buf, =
(size_t)len);</span><br><span> </span><br><span>         /*</span><br><span=
>          * Reset output object</span><br><span>@@ -3873,7 +3873,7 @@</spa=
n><br><span>  */</span><br><span> </span><br><span> struct command_line *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-command_line_new(const =
int buf_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+command=
_line_new(const size_t buf_len)</span><br><span> {</span><br><span>     str=
uct command_line *cl;</span><br><span>     ALLOC_OBJ_CLEAR(cl, struct comma=
nd_line);</span><br><span>@@ -3903,10 +3903,9 @@</span><br><span> }</span><=
br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-command_line_add(struct command_line *cl, const unsigned char *b=
uf, const int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
ommand_line_add(struct command_line *cl, const unsigned char *buf, const si=
ze_t len)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
for (i =3D 0; i &lt; len; ++i)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (size_t i =3D 0; i &lt; len; ++i)</span><br><span>     {=
</span><br><span>         if (buf[i] &amp;&amp; char_class(buf[i], (CC_PRIN=
T | CC_NEWLINE)))</span><br><span>         {</span><br><span>@@ -3921,10 +3=
920,9 @@</span><br><span> const char *</span><br><span> command_line_get(st=
ruct command_line *cl)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int i;</span><br><span>     const char *ret =3D NUL=
L;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   i =3D buf_substring_len(&amp;cl-&gt;buf, &#39;\n&#39;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int i =3D buf_substring_len(&amp=
;cl-&gt;buf, &#39;\n&#39;);</span><br><span>     if (i &gt;=3D 0)</span><br=
><span>     {</span><br><span>         buf_copy_excess(&amp;cl-&gt;residual=
, &amp;cl-&gt;buf, i);</span><br><span>diff --git a/src/openvpn/manage.h b/=
src/openvpn/manage.h</span><br><span>index 0bce25e..7c189ba 100644</span><b=
r><span>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/manage=
.h</span><br><span>@@ -80,11 +80,11 @@</span><br><span>     struct buffer r=
esidual;</span><br><span> };</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-struct command_line *command_line_new(const int bu=
f_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct comma=
nd_line *command_line_new(const size_t buf_len);</span><br><span> </span><b=
r><span> void command_line_free(struct command_line *cl);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void command_line_add=
(struct command_line *cl, const unsigned char *buf, const int len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void command_line_add(struc=
t command_line *cl, const unsigned char *buf, const size_t len);</span><br>=
<span> </span><br><span> const char *command_line_get(struct command_line *=
cl);</span><br><span> </span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1136?usp=3Demail">change 11=
36</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1136?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc183e42b190e19e1d8c351d1cd=
460a038626e63 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1136 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--naGAZnIh2Us=--

