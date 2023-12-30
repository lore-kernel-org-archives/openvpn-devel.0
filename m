From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 30 Dec 2023 15:47:46 +0000
In-Reply-To: <gerrit.1702052980000.I0abeec9f862aea1f6a8fdf350fa0008cf2e5d613@...2715...>
References: <gerrit.1702052980000.I0abeec9f862aea1f6a8fdf350fa0008cf2e5d613@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2e67e905f41433fecf0294a8c513ed3a3d509330-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zju9HXOtovM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: misc: make
 get_auth_challenge static
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Zju9HXOtovM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/47=
6?usp=3Demail )

Change subject: misc: make get_auth_challenge static
......................................................................

misc: make get_auth_challenge static

Not used outside of misc.c.

Rename to parse_auth_challenge since it really just parses
the string that you put in into the struct.

Add doxygen documentation.

v2:
 - change if(auth_challenge) to ASSERT(auth_challenge)

Change-Id: I0abeec9f862aea1f6a8fdf350fa0008cf2e5d613
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20231230143248.1625-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
864.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/misc.c
M src/openvpn/misc.h
M src/openvpn/ssl.h
3 files changed, 79 insertions(+), 85 deletions(-)




diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index bce63ed..08f274d 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -124,6 +124,83 @@
     }
     return true;
 }
+
+/**
+ * Parses an authentication challenge string and returns an auth_challenge=
_info structure.
+ * The authentication challenge string should follow the dynamic challenge=
/response protocol.
+ *
+ * See doc/management-notes.txt for more info on the the dynamic challenge=
/response protocol
+ * implemented here.
+ *
+ * @param auth_challenge The authentication challenge string to parse. Can=
't be NULL.
+ * @param gc             The gc_arena structure for memory allocation.
+ *
+ * @return               A pointer to the parsed auth_challenge_info struc=
ture, or NULL if parsing fails.
+ */
+static struct auth_challenge_info *
+parse_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
+{
+    ASSERT(auth_challenge);
+
+    struct auth_challenge_info *ac;
+    const int len =3D strlen(auth_challenge);
+    char *work =3D (char *) gc_malloc(len+1, false, gc);
+    char *cp;
+
+    struct buffer b;
+    buf_set_read(&b, (const uint8_t *)auth_challenge, len);
+
+    ALLOC_OBJ_CLEAR_GC(ac, struct auth_challenge_info, gc);
+
+    /* parse prefix */
+    if (!buf_parse(&b, ':', work, len))
+    {
+        return NULL;
+    }
+    if (strcmp(work, "CRV1"))
+    {
+        return NULL;
+    }
+
+    /* parse flags */
+    if (!buf_parse(&b, ':', work, len))
+    {
+        return NULL;
+    }
+    for (cp =3D work; *cp !=3D '\0'; ++cp)
+    {
+        const char c =3D *cp;
+        if (c =3D=3D 'E')
+        {
+            ac->flags |=3D CR_ECHO;
+        }
+        else if (c =3D=3D 'R')
+        {
+            ac->flags |=3D CR_RESPONSE;
+        }
+    }
+
+    /* parse state ID */
+    if (!buf_parse(&b, ':', work, len))
+    {
+        return NULL;
+    }
+    ac->state_id =3D string_alloc(work, gc);
+
+    /* parse user name */
+    if (!buf_parse(&b, ':', work, len))
+    {
+        return NULL;
+    }
+    ac->user =3D (char *) gc_malloc(strlen(work)+1, true, gc);
+    openvpn_base64_decode(work, (void *)ac->user, -1);
+
+    /* parse challenge text */
+    ac->challenge_text =3D string_alloc(BSTR(&b), gc);
+
+    return ac;
+}
+
 #endif /* ifdef ENABLE_MANAGEMENT */

 /*
@@ -287,7 +364,7 @@
 #ifdef ENABLE_MANAGEMENT
             if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE=
) && response_from_stdin)
             {
-                struct auth_challenge_info *ac =3D get_auth_challenge(auth=
_challenge, &gc);
+                struct auth_challenge_info *ac =3D parse_auth_challenge(au=
th_challenge, &gc);
                 if (ac)
                 {
                     char *response =3D (char *) gc_malloc(USER_PASS_LEN, f=
alse, &gc);
@@ -392,83 +469,6 @@
     return true;
 }

-#ifdef ENABLE_MANAGEMENT
-
-/*
- * See management/management-notes.txt for more info on the
- * the dynamic challenge/response protocol implemented here.
- */
-struct auth_challenge_info *
-get_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
-{
-    if (auth_challenge)
-    {
-        struct auth_challenge_info *ac;
-        const int len =3D strlen(auth_challenge);
-        char *work =3D (char *) gc_malloc(len+1, false, gc);
-        char *cp;
-
-        struct buffer b;
-        buf_set_read(&b, (const uint8_t *)auth_challenge, len);
-
-        ALLOC_OBJ_CLEAR_GC(ac, struct auth_challenge_info, gc);
-
-        /* parse prefix */
-        if (!buf_parse(&b, ':', work, len))
-        {
-            return NULL;
-        }
-        if (strcmp(work, "CRV1"))
-        {
-            return NULL;
-        }
-
-        /* parse flags */
-        if (!buf_parse(&b, ':', work, len))
-        {
-            return NULL;
-        }
-        for (cp =3D work; *cp !=3D '\0'; ++cp)
-        {
-            const char c =3D *cp;
-            if (c =3D=3D 'E')
-            {
-                ac->flags |=3D CR_ECHO;
-            }
-            else if (c =3D=3D 'R')
-            {
-                ac->flags |=3D CR_RESPONSE;
-            }
-        }
-
-        /* parse state ID */
-        if (!buf_parse(&b, ':', work, len))
-        {
-            return NULL;
-        }
-        ac->state_id =3D string_alloc(work, gc);
-
-        /* parse user name */
-        if (!buf_parse(&b, ':', work, len))
-        {
-            return NULL;
-        }
-        ac->user =3D (char *) gc_malloc(strlen(work)+1, true, gc);
-        openvpn_base64_decode(work, (void *)ac->user, -1);
-
-        /* parse challenge text */
-        ac->challenge_text =3D string_alloc(BSTR(&b), gc);
-
-        return ac;
-    }
-    else
-    {
-        return NULL;
-    }
-}
-
-#endif /* ifdef ENABLE_MANAGEMENT */
-
 void
 purge_user_pass(struct user_pass *up, const bool force)
 {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 70a24dd..d51609d 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -86,8 +86,6 @@
     const char *challenge_text;
 };

-struct auth_challenge_info *get_auth_challenge(const char *auth_challenge,=
 struct gc_arena *gc);
-
 /*
  * Challenge response info on client as pushed by server.
  */
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 6ba6ff8..71b99db 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -410,11 +410,7 @@
 bool ssl_clean_auth_token(void);

 #ifdef ENABLE_MANAGEMENT
-/*
- * ssl_get_auth_challenge will parse the server-pushed auth-failed
- * reason string and return a dynamically allocated
- * auth_challenge_info struct.
- */
+
 void ssl_purge_auth_challenge(void);

 void ssl_put_auth_challenge(const char *cr_str);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/476?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0abeec9f862aea1f6a8fdf350fa0008cf2e5d613
Gerrit-Change-Number: 476
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Zju9HXOtovM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/476?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">misc: make get_auth_challenge static<br><br>No=
t used outside of misc.c.<br><br>Rename to parse_auth_challenge since it re=
ally just parses<br>the string that you put in into the struct.<br><br>Add =
doxygen documentation.<br><br>v2:<br> - change if(auth_challenge) to ASSERT=
(auth_challenge)<br><br>Change-Id: I0abeec9f862aea1f6a8fdf350fa0008cf2e5d61=
3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20231230143248.162=
5-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg27864.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>---<br>M src/openvpn/misc.c<br>M src/openvpn/misc.h<br>M=
 src/openvpn/ssl.h<br>3 files changed, 79 insertions(+), 85 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><span>ind=
ex bce63ed..08f274d 100644</span><br><span>--- a/src/openvpn/misc.c</span><=
br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -124,6 +124,83 @@</spa=
n><br><span>     }</span><br><span>     return true;</span><br><span> }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Parses an authentication challenge string and returns =
an auth_challenge_info structure.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * The authentication challenge string should follow the dyna=
mic challenge/response protocol.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * S=
ee doc/management-notes.txt for more info on the the dynamic challenge/resp=
onse protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * imp=
lemented here.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param auth_challen=
ge The authentication challenge string to parse. Can&#39;t be NULL.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc             Th=
e gc_arena structure for memory allocation.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return               A pointer to the parsed auth_challenge_info=
 structure, or NULL if parsing fails.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static struct auth_challenge_info *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+parse_auth_challenge(const char *auth_challenge, struct g=
c_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(auth_challenge=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct auth_challenge_info *ac;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int len =
=3D strlen(auth_challenge);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    char *work =3D (char *) gc_malloc(len+1, false, gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char *cp;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer b;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_set_read(&amp;b, (const uint8_t *)auth_challen=
ge, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(ac, st=
ruct auth_challenge_info, gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* p=
arse prefix */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!buf_parse(&amp;b, &#39;:&#39;, work, len))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (strcmp(work, &quot;CRV1&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* parse flags */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_parse(&amp;=
b, &#39;:&#39;, work, len))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (cp =3D wor=
k; *cp !=3D &#39;\0&#39;; ++cp)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const char c =3D *cp;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (c =3D=3D &#39;E&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            ac-&gt;flags |=3D CR_ECHO;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        else if (c =3D=3D &#39;R&#39;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            ac-&gt;flags |=3D CR_RESPONSE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* parse state ID */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!buf_parse(&amp;b, &#39;:&#39;, work, len))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ac-&gt;state_id =3D string_alloc(work, gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* parse user name */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!buf_parse(&amp;b, &#39;:&#39;,=
 work, len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ac-&gt;user =3D (char *) gc_ma=
lloc(strlen(work)+1, true, gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    openvpn_base64_decode(work, (void *)ac-&gt;user, -1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* parse challenge text */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ac-&gt;challenge_text =3D str=
ing_alloc(BSTR(&amp;b), gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 ac;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifdef=
 ENABLE_MANAGEMENT */</span><br><span> </span><br><span> /*</span><br><span=
>@@ -287,7 +364,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><s=
pan>             if (auth_challenge &amp;&amp; (flags &amp; GET_USER_PASS_D=
YNAMIC_CHALLENGE) &amp;&amp; response_from_stdin)</span><br><span>         =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
struct auth_challenge_info *ac =3D get_auth_challenge(auth_challenge, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 struct auth_challenge_info *ac =3D parse_auth_challenge(auth_challenge, &a=
mp;gc);</span><br><span>                 if (ac)</span><br><span>          =
       {</span><br><span>                     char *response =3D (char *) g=
c_malloc(USER_PASS_LEN, false, &amp;gc);</span><br><span>@@ -392,83 +469,6 =
@@</span><br><span>     return true;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMEN=
T</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * See management/management-notes.txt for more info on the<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the dynamic challen=
ge/response protocol implemented here.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
truct auth_challenge_info *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-get_auth_challenge(const char *auth_challenge, struct gc_arena *gc)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (auth_challenge)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct auth_challenge_info *ac;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        const int len =3D strlen(auth_c=
hallenge);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cha=
r *work =3D (char *) gc_malloc(len+1, false, gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        char *cp;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        struct buffer b;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        buf_set_read(&amp;b, (const uint8_t *)auth_challenge, len);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ALLOC_OBJ_CLEAR_GC(ac, struct auth_=
challenge_info, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* parse prefi=
x */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!buf_=
parse(&amp;b, &#39;:&#39;, work, len))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            return NULL;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (strcmp(work, &quot;CRV1&quot;))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            return NULL;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* parse flags *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!buf_par=
se(&amp;b, &#39;:&#39;, work, len))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 for (cp =3D work; *cp !=3D &#39;\0&#39;; ++cp)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            const char c =3D *cp;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (c =3D=3D &#39;E&#39;)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                ac-&gt;flags |=3D CR_ECHO=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (c =3D=
=3D &#39;R&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   ac-&gt;flags |=3D CR_RESPONSE;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /* parse state ID */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!buf_parse=
(&amp;b, &#39;:&#39;, work, len))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a=
c-&gt;state_id =3D string_alloc(work, gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* parse user name */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (!buf_parse(&amp;b, &#39;:&#39;, work, len))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return NULL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        ac-&gt;user =3D (char *) gc_malloc(strlen(wo=
rk)+1, true, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    openvpn_base64_decode(work, (void *)ac-&gt;user, -1);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        /* parse challenge text */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        ac-&gt;challenge_text =3D string_alloc(=
BSTR(&amp;b), gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return ac;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> =
purge_user_pass(struct user_pass *up, const bool force)</span><br><span> {<=
/span><br><span>diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h</span>=
<br><span>index 70a24dd..d51609d 100644</span><br><span>--- a/src/openvpn/m=
isc.h</span><br><span>+++ b/src/openvpn/misc.h</span><br><span>@@ -86,8 +86=
,6 @@</span><br><span>     const char *challenge_text;</span><br><span> };<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stru=
ct auth_challenge_info *get_auth_challenge(const char *auth_challenge, stru=
ct gc_arena *gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> /*</span><br><span>  * Challenge response info on client as p=
ushed by server.</span><br><span>  */</span><br><span>diff --git a/src/open=
vpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index 6ba6ff8..71b99db 100644=
</span><br><span>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/=
ssl.h</span><br><span>@@ -410,11 +410,7 @@</span><br><span> bool ssl_clean_=
auth_token(void);</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEME=
NT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * ssl_get_auth_challenge will parse t=
he server-pushed auth-failed</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * reason string and return a dynamically allocated</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * auth_challenge_info struct.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> void ssl_purge_auth_challen=
ge(void);</span><br><span> </span><br><span> void ssl_put_auth_challenge(co=
nst char *cr_str);</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/476?usp=3Demail">change 476</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/476?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0abeec9f862aea1f6a8fdf350fa=
0008cf2e5d613 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 476 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Zju9HXOtovM=--

