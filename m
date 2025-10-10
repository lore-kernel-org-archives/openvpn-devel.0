From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 09:56:24 +0000
In-Reply-To: <gerrit.1758731785000.I04542e678f81d5d4a853b4370d9b8adc4dac1212@...2715...>
References: <gerrit.1758731785000.I04542e678f81d5d4a853b4370d9b8adc4dac1212@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cc6fae79d12e8e60d1eaf7f5e6a84325a66ecacd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xK0XOLmftjw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: console: Simplify
 query_user_add interface
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

--xK0XOLmftjw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
16?usp=3Demail )

Change subject: console: Simplify query_user_add interface
......................................................................

console: Simplify query_user_add interface

- Removes unused field prompt_len
- Change field reponse_len to int since that
  is what the code actually expects. Most callers
  user a constant either way.

Change-Id: I04542e678f81d5d4a853b4370d9b8adc4dac1212
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1216
Message-Id: <20251010094753.2825-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59244794/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/console.c
M src/openvpn/console.h
M src/openvpn/console_builtin.c
M src/openvpn/misc.c
M src/openvpn/pkcs11.c
5 files changed, 16 insertions(+), 41 deletions(-)




diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index bdceaf2..3cb23b3 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -53,14 +53,14 @@


 void
-query_user_add(char *prompt, size_t prompt_len, char *resp, size_t resp_le=
n, bool echo)
+query_user_add(char *prompt, char *resp, int resp_len, bool echo)
 {
     int i;

     /* Ensure input is sane.  All these must be present otherwise it is
      * a programming error.
      */
-    ASSERT(prompt_len > 0 && prompt !=3D NULL && resp_len > 0 && resp !=3D=
 NULL);
+    ASSERT(prompt !=3D NULL && resp_len > 0 && resp !=3D NULL);

     /* Seek to the last unused slot */
     for (i =3D 0; i < QUERY_USER_NUMSLOTS; i++)
@@ -74,7 +74,6 @@

     /* Save the information needed for the user interaction */
     query_user[i].prompt =3D prompt;
-    query_user[i].prompt_len =3D prompt_len;
     query_user[i].response =3D resp;
     query_user[i].response_len =3D resp_len;
     query_user[i].echo =3D echo;
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 14b6116..fba2a09 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -32,11 +32,10 @@
  */
 struct _query_user
 {
-    char *prompt;        /**< Prompt to present to the user */
-    size_t prompt_len;   /**< Length of the prompt string */
-    char *response;      /**< The user's response */
-    size_t response_len; /**< Length the of the user response */
-    bool echo;           /**< True: The user should see what is being type=
d, otherwise mask it */
+    char *prompt;     /**< Prompt to present to the user */
+    char *response;   /**< The user's response */
+    int response_len; /**< Length the of the user response */
+    bool echo;        /**< True: The user should see what is being typed, =
otherwise mask it */
 };

 #define QUERY_USER_NUMSLOTS 10
@@ -53,13 +52,12 @@
  * Adds an item to ask the user for
  *
  * @param prompt     Prompt to display to the user
- * @param prompt_len Length of the prompt string
  * @param resp       String containing the user response
  * @param resp_len   Length of the response string
  * @param echo       Should the user input be echoed to the user?  If Fals=
e, input will be masked
  *
  */
-void query_user_add(char *prompt, size_t prompt_len, char *resp, size_t re=
sp_len, bool echo);
+void query_user_add(char *prompt, char *resp, int resp_len, bool echo);


 /**
@@ -117,10 +115,10 @@
  *
  */
 static inline bool
-query_user_SINGLE(char *prompt, size_t prompt_len, char *resp, size_t resp=
_len, bool echo)
+query_user_SINGLE(char *prompt, char *resp, int resp_len, bool echo)
 {
     query_user_clear();
-    query_user_add(prompt, prompt_len, resp, resp_len, echo);
+    query_user_add(prompt, resp, resp_len, echo);
     return query_user_exec();
 }

diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 71c0025..2a925d6 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -45,11 +45,6 @@

 #include "win32.h"

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Get input from a Windows console.
  *
@@ -73,7 +68,7 @@
     HANDLE in =3D GetStdHandle(STD_INPUT_HANDLE);
     int orig_stderr =3D get_orig_stderr(); /* guaranteed to be always vali=
d */
     if ((in =3D=3D INVALID_HANDLE_VALUE) || win32_service_interrupt(&win32=
_signal)
-        || (_write(orig_stderr, prompt, strlen(prompt)) =3D=3D -1))
+        || (_write(orig_stderr, prompt, (unsigned int)strlen(prompt)) =3D=
=3D -1))
     {
         msg(M_WARN | M_ERRNO, "get_console_input_win32(): unexpected error=
");
         return false;
@@ -139,10 +134,6 @@
     return false;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* _WIN32 */


@@ -273,11 +264,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * @copydoc query_user_exec()
  *
@@ -309,7 +295,3 @@

     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index caf4725..188f44e 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -239,8 +239,7 @@
                 struct buffer user_prompt =3D alloc_buf_gc(128, &gc);

                 buf_printf(&user_prompt, "NEED-OK|%s|%s:", prefix, up->use=
rname);
-                if (!query_user_SINGLE(BSTR(&user_prompt), BLEN(&user_prom=
pt), up->password,
-                                       USER_PASS_LEN, false))
+                if (!query_user_SINGLE(BSTR(&user_prompt), up->password, U=
SER_PASS_LEN, false))
                 {
                     msg(M_FATAL, "ERROR: could not read %s ok-confirmation=
 from stdin", prefix);
                 }
@@ -362,7 +361,7 @@
                     buf_printf(&challenge, "CHALLENGE: %s", ac->challenge_=
text);
                     buf_set_write(&packed_resp, (uint8_t *)up->password, U=
SER_PASS_LEN);
=20
-                    if (!query_user_SINGLE(BSTR(&challenge), BLEN(&challen=
ge), response,
+                    if (!query_user_SINGLE(BSTR(&challenge), response,
                                            USER_PASS_LEN, BOOL_CAST(ac->fl=
ags & CR_ECHO)))
                     {
                         msg(M_FATAL, "ERROR: could not read challenge resp=
onse from stdin");
@@ -387,14 +386,12 @@

                 if (username_from_stdin && !(flags & GET_USER_PASS_PASSWOR=
D_ONLY))
                 {
-                    query_user_add(BSTR(&user_prompt), BLEN(&user_prompt),=
 up->username,
-                                   USER_PASS_LEN, true);
+                    query_user_add(BSTR(&user_prompt), up->username, USER_=
PASS_LEN, true);
                 }

                 if (password_from_stdin)
                 {
-                    query_user_add(BSTR(&pass_prompt), BLEN(&pass_prompt),=
 up->password,
-                                   USER_PASS_LEN, false);
+                    query_user_add(BSTR(&pass_prompt), up->password, USER_=
PASS_LEN, false);
                 }

                 if (!query_user_exec())
@@ -421,8 +418,7 @@
                     challenge =3D alloc_buf_gc(14 + strlen(auth_challenge)=
, &gc);
                     buf_printf(&challenge, "CHALLENGE: %s", auth_challenge=
);

-                    if (!query_user_SINGLE(BSTR(&challenge), BLEN(&challen=
ge), response,
-                                           USER_PASS_LEN,
+                    if (!query_user_SINGLE(BSTR(&challenge), response, USE=
R_PASS_LEN,
                                            BOOL_CAST(flags & GET_USER_PASS=
_STATIC_CHALLENGE_ECHO)))
                     {
                         msg(M_FATAL, "ERROR: could not retrieve static cha=
llenge response");
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 16149ca..ce64135 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -671,7 +671,7 @@
     ASSERT(token !=3D NULL);

     buf_printf(&pass_prompt, "Please enter '%s' token PIN or 'cancel': ", =
token->display);
-    if (!query_user_SINGLE(BSTR(&pass_prompt), BLEN(&pass_prompt), pin, pi=
n_max, false))
+    if (!query_user_SINGLE(BSTR(&pass_prompt), pin, (int)pin_max, false))
     {
         msg(M_FATAL, "Could not retrieve the PIN");
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1216?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04542e678f81d5d4a853b4370d9b8adc4dac1212
Gerrit-Change-Number: 1216
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xK0XOLmftjw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1216?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">console: Simplify query_user_add interface<br><b=
r>- Removes unused field prompt_len<br>- Change field reponse_len to int si=
nce that<br>  is what the code actually expects. Most callers<br>  user a c=
onstant either way.<br><br>Change-Id: I04542e678f81d5d4a853b4370d9b8adc4dac=
1212<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-=
by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.open=
vpn.net/c/openvpn/+/1216<br>Message-Id: &lt;20251010094753.2825-1-gert@...1386...=
296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/592447=
94/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/=
openvpn/console.c<br>M src/openvpn/console.h<br>M src/openvpn/console_built=
in.c<br>M src/openvpn/misc.c<br>M src/openvpn/pkcs11.c<br>5 files changed, =
16 insertions(+), 41 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/console.c b/src/openvpn/console.c</span><br><sp=
an>index bdceaf2..3cb23b3 100644</span><br><span>--- a/src/openvpn/console.=
c</span><br><span>+++ b/src/openvpn/console.c</span><br><span>@@ -53,14 +53=
,14 @@</span><br><span> </span><br><span> </span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-query_user_add(char *prompt, siz=
e_t prompt_len, char *resp, size_t resp_len, bool echo)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+query_user_add(char *prompt, char *resp=
, int resp_len, bool echo)</span><br><span> {</span><br><span>     int i;</=
span><br><span> </span><br><span>     /* Ensure input is sane.  All these m=
ust be present otherwise it is</span><br><span>      * a programming error.=
</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ASSERT(prompt_len &gt; 0 &amp;&amp; prompt !=3D NULL &amp;&amp; res=
p_len &gt; 0 &amp;&amp; resp !=3D NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ASSERT(prompt !=3D NULL &amp;&amp; resp_len &gt; 0=
 &amp;&amp; resp !=3D NULL);</span><br><span> </span><br><span>     /* Seek=
 to the last unused slot */</span><br><span>     for (i =3D 0; i &lt; QUERY=
_USER_NUMSLOTS; i++)</span><br><span>@@ -74,7 +74,6 @@</span><br><span> </s=
pan><br><span>     /* Save the information needed for the user interaction =
*/</span><br><span>     query_user[i].prompt =3D prompt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    query_user[i].prompt_len =3D prompt_=
len;</span><br><span>     query_user[i].response =3D resp;</span><br><span>=
     query_user[i].response_len =3D resp_len;</span><br><span>     query_us=
er[i].echo =3D echo;</span><br><span>diff --git a/src/openvpn/console.h b/s=
rc/openvpn/console.h</span><br><span>index 14b6116..fba2a09 100644</span><b=
r><span>--- a/src/openvpn/console.h</span><br><span>+++ b/src/openvpn/conso=
le.h</span><br><span>@@ -32,11 +32,10 @@</span><br><span>  */</span><br><sp=
an> struct _query_user</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    char *prompt;        /**&lt; Prompt to present to t=
he user */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t =
prompt_len;   /**&lt; Length of the prompt string */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char *response;      /**&lt; The user&#=
39;s response */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
ize_t response_len; /**&lt; Length the of the user response */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool echo;           /**&lt; T=
rue: The user should see what is being typed, otherwise mask it */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *prompt;     /**&lt=
; Prompt to present to the user */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *response;   /**&lt; The user&#39;s response */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int response_len; /=
**&lt; Length the of the user response */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    bool echo;        /**&lt; True: The user should s=
ee what is being typed, otherwise mask it */</span><br><span> };</span><br>=
<span> </span><br><span> #define QUERY_USER_NUMSLOTS 10</span><br><span>@@ =
-53,13 +52,12 @@</span><br><span>  * Adds an item to ask the user for</span=
><br><span>  *</span><br><span>  * @param prompt     Prompt to display to t=
he user</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param prom=
pt_len Length of the prompt string</span><br><span>  * @param resp       St=
ring containing the user response</span><br><span>  * @param resp_len   Len=
gth of the response string</span><br><span>  * @param echo       Should the=
 user input be echoed to the user?  If False, input will be masked</span><b=
r><span>  *</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void query_user_add(char *prompt, size_t prompt_len, char *resp,=
 size_t resp_len, bool echo);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void query_user_add(char *prompt, char *resp, int resp_len, bool =
echo);</span><br><span> </span><br><span> </span><br><span> /**</span><br><=
span>@@ -117,10 +115,10 @@</span><br><span>  *</span><br><span>  */</span><=
br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-query_user_SINGLE(char *prompt, size_t prompt_len, char *resp, size_=
t resp_len, bool echo)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+query_user_SINGLE(char *prompt, char *resp, int resp_len, bool echo)</sp=
an><br><span> {</span><br><span>     query_user_clear();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    query_user_add(prompt, prompt_len, r=
esp, resp_len, echo);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    query_user_add(prompt, resp, resp_len, echo);</span><br><span>     re=
turn query_user_exec();</span><br><span> }</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.=
c</span><br><span>index 71c0025..2a925d6 100644</span><br><span>--- a/src/o=
penvpn/console_builtin.c</span><br><span>+++ b/src/openvpn/console_builtin.=
c</span><br><span>@@ -45,11 +45,6 @@</span><br><span> </span><br><span> #in=
clude &quot;win32.h&quot;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ig=
nored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> /**</span><br><span>  * Get input from a Windows console.</span=
><br><span>  *</span><br><span>@@ -73,7 +68,7 @@</span><br><span>     HANDL=
E in =3D GetStdHandle(STD_INPUT_HANDLE);</span><br><span>     int orig_stde=
rr =3D get_orig_stderr(); /* guaranteed to be always valid */</span><br><sp=
an>     if ((in =3D=3D INVALID_HANDLE_VALUE) || win32_service_interrupt(&am=
p;win32_signal)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  || (_write(orig_stderr, prompt, strlen(prompt)) =3D=3D -1))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        || (_write(orig_stderr, p=
rompt, (unsigned int)strlen(prompt)) =3D=3D -1))</span><br><span>     {</sp=
an><br><span>         msg(M_WARN | M_ERRNO, &quot;get_console_input_win32()=
: unexpected error&quot;);</span><br><span>         return false;</span><br=
><span>@@ -139,10 +134,6 @@</span><br><span>     return false;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> #endif /* _WIN32 */</span><br><span> </s=
pan><br><span> </span><br><span>@@ -273,11 +264,6 @@</span><br><span>     r=
eturn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> /**</span><br><span>  * @copydoc query_user_exec()</span><b=
r><span>  *</span><br><span>@@ -309,7 +295,3 @@</span><br><span> </span><br=
><span>     return ret;</span><br><span> }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span>diff --git a/src/openvpn/=
misc.c b/src/openvpn/misc.c</span><br><span>index caf4725..188f44e 100644</=
span><br><span>--- a/src/openvpn/misc.c</span><br><span>+++ b/src/openvpn/m=
isc.c</span><br><span>@@ -239,8 +239,7 @@</span><br><span>                 =
struct buffer user_prompt =3D alloc_buf_gc(128, &amp;gc);</span><br><span> =
</span><br><span>                 buf_printf(&amp;user_prompt, &quot;NEED-O=
K|%s|%s:&quot;, prefix, up-&gt;username);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                if (!query_user_SINGLE(BSTR(&amp;user_p=
rompt), BLEN(&amp;user_prompt), up-&gt;password,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                       USER_PASS=
_LEN, false))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          if (!query_user_SINGLE(BSTR(&amp;user_prompt), up-&gt;password, U=
SER_PASS_LEN, false))</span><br><span>                 {</span><br><span>  =
                   msg(M_FATAL, &quot;ERROR: could not read %s ok-confirmat=
ion from stdin&quot;, prefix);</span><br><span>                 }</span><br=
><span>@@ -362,7 +361,7 @@</span><br><span>                     buf_printf(=
&amp;challenge, &quot;CHALLENGE: %s&quot;, ac-&gt;challenge_text);</span><b=
r><span>                     buf_set_write(&amp;packed_resp, (uint8_t *)up-=
&gt;password, USER_PASS_LEN);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    if (!query_user_SINGLE(BSTR(&=
amp;challenge), BLEN(&amp;challenge), response,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    if (!query_user_SINGLE(BSTR=
(&amp;challenge), response,</span><br><span>                               =
             USER_PASS_LEN, BOOL_CAST(ac-&gt;flags &amp; CR_ECHO)))</span><=
br><span>                     {</span><br><span>                         ms=
g(M_FATAL, &quot;ERROR: could not read challenge response from stdin&quot;)=
;</span><br><span>@@ -387,14 +386,12 @@</span><br><span> </span><br><span> =
                if (username_from_stdin &amp;&amp; !(flags &amp; GET_USER_P=
ASS_PASSWORD_ONLY))</span><br><span>                 {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    query_user_add(BSTR(&a=
mp;user_prompt), BLEN(&amp;user_prompt), up-&gt;username,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                   USER=
_PASS_LEN, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  query_user_add(BSTR(&amp;user_prompt), up-&gt;username, U=
SER_PASS_LEN, true);</span><br><span>                 }</span><br><span> </=
span><br><span>                 if (password_from_stdin)</span><br><span>  =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               query_user_add(BSTR(&amp;pass_prompt), BLEN(&amp;pass_prompt=
), up-&gt;password,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                 USER_PASS_LEN, false);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    query_user_add(BSTR=
(&amp;pass_prompt), up-&gt;password, USER_PASS_LEN, false);</span><br><span=
>                 }</span><br><span> </span><br><span>                 if (=
!query_user_exec())</span><br><span>@@ -421,8 +418,7 @@</span><br><span>   =
                  challenge =3D alloc_buf_gc(14 + strlen(auth_challenge), &=
amp;gc);</span><br><span>                     buf_printf(&amp;challenge, &q=
uot;CHALLENGE: %s&quot;, auth_challenge);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    if (!query_user_S=
INGLE(BSTR(&amp;challenge), BLEN(&amp;challenge), response,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
      USER_PASS_LEN,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    if (!query_user_SINGLE(BSTR(&amp;challenge), response,=
 USER_PASS_LEN,</span><br><span>                                           =
 BOOL_CAST(flags &amp; GET_USER_PASS_STATIC_CHALLENGE_ECHO)))</span><br><sp=
an>                     {</span><br><span>                         msg(M_FA=
TAL, &quot;ERROR: could not retrieve static challenge response&quot;);</spa=
n><br><span>diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c</span>=
<br><span>index 16149ca..ce64135 100644</span><br><span>--- a/src/openvpn/p=
kcs11.c</span><br><span>+++ b/src/openvpn/pkcs11.c</span><br><span>@@ -671,=
7 +671,7 @@</span><br><span>     ASSERT(token !=3D NULL);</span><br><span> =
</span><br><span>     buf_printf(&amp;pass_prompt, &quot;Please enter &#39;=
%s&#39; token PIN or &#39;cancel&#39;: &quot;, token-&gt;display);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!query_user_SINGLE(BST=
R(&amp;pass_prompt), BLEN(&amp;pass_prompt), pin, pin_max, false))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!query_user_SINGLE(B=
STR(&amp;pass_prompt), pin, (int)pin_max, false))</span><br><span>     {</s=
pan><br><span>         msg(M_FATAL, &quot;Could not retrieve the PIN&quot;)=
;</span><br><span>     }</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1216?usp=3Demail">change =
1216</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1216?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04542e678f81d5d4a853b4370d9=
b8adc4dac1212 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1216 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--xK0XOLmftjw=--

