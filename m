From: "selvanair (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jul 2024 21:39:30 +0000
In-Reply-To: <gerrit.1718418288000.I59a90446bfe73d8856516025a58a6f62cc98ab0d@...2715...>
References: <gerrit.1718418288000.I59a90446bfe73d8856516025a58a6f62cc98ab0d@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f98d0cf0c812e7f81b49f433d60e7900a8d09f4a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gcztg1ggUQU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Static-challenge
 concatenation option
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

--gcztg1ggUQU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/665?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Static-challenge concatenation option
......................................................................

Static-challenge concatenation option

Extend "--static-challenge" option to take a third
argument (=3D scrv1 or concat) to specify that the password and
response should be concatenated instead of using the
SCRV1 protocol. If unspecified, it defaults to "scrv1"
meaning that the SCRV1 protocol should be used.

v2: use scrv1|concat instead of 0|1 as option argument
    fix typos
v3: improve and correct documentation in management-notes.txt

Change-Id: I59a90446bfe73d8856516025a58a6f62cc98ab0d
---
M doc/man-sections/client-options.rst
M doc/management-notes.txt
M src/openvpn/manage.c
M src/openvpn/misc.c
M src/openvpn/misc.h
M src/openvpn/options.c
M src/openvpn/ssl.c
7 files changed, 70 insertions(+), 20 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/665/3

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index b75fe5b..a06948e 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -541,12 +541,15 @@
   Valid syntax:
   ::

-     static-challenge text echo
+     static-challenge text echo [format]

   The ``text`` challenge text is presented to the user which describes what
   information is requested.  The ``echo`` flag indicates if the user's
   input should be echoed on the screen.  Valid ``echo`` values are
-  :code:`0` or :code:`1`.
+  :code:`0` or :code:`1`. The optional ``format`` indicates whether
+  the password and response should be combined using the SCRV1 protocol
+  (``format`` =3D :code:`scrv1`) or simply concatenated (``format`` =3D :c=
ode:`concat`).
+  :code:`scrv1` is the default.

   See management-notes.txt in the OpenVPN distribution for a description of
   the OpenVPN challenge/response protocol.
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index b9947fa..b55135a 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -1320,14 +1320,20 @@

 OpenVPN's --static-challenge option is used to provide the
 challenge text to OpenVPN and indicate whether or not the response
-should be echoed.
+should be echoed and how the response should be combined with the
+password.

 When credentials are needed and the --static-challenge option is
 used, the management interface will send:

-  >PASSWORD:Need 'Auth' username/password SC:<ECHO>,<TEXT>
+  >PASSWORD:Need 'Auth' username/password SC:<flag>,<TEXT>

-  ECHO: "1" if response should be echoed, "0" to not echo
+  flag: an integer whose least significant bit is the ECHO flag and
+        the next significant bit is the FORMAT flag.
+        ECHO =3D (flag & 0x1) is 1 if response should be echoed, 0 to not =
echo
+        FORMAT =3D (flag & 0x2) is 1 if response should be concatenated wi=
th
+        password as plain text, 0 if response and password should be encod=
ed
+        as described below. Thus flag could take values 0, 1, 2, or 3.
   TEXT: challenge text that should be shown to the user to
       facilitate their response

@@ -1342,8 +1348,9 @@

 The management interface client in this case should add the static
 challenge text to the auth dialog followed by a field for the user to
-enter a response.  Then the management interface client should pack the
-password and response together into an encoded password and send:
+enter a response. If flag =3D 0 or 1 (i.e., FORMAT=3D0), the management
+interface client should pack the password and response together into
+an encoded password and send:

   username "Auth" <username>
   password "Auth" "SCRV1:<password_base64>:<response_base64>"
@@ -1354,6 +1361,12 @@
 the user. The <password_base64> and/or the <response_base64> can be
 empty strings.

+If flag =3D 2 or 3 (i.e., FORMAT=3D1), the client should simply concatenate
+password and response with no separator and send:
+
+  username "Auth" <username>
+  password "Auth" "<password><response>"
+
 (As in all username/password responses described in the "COMMAND --
 password and username" section above, the username can be in quotes,
 and special characters such as double quotes or backslashes must be
@@ -1361,10 +1374,15 @@

 For example, if user "foo" entered "bar" as the password and 8675309
 as the PIN, the following management interface commands should be
-issued:
+issued if flag =3D 0 or 1 (i.e., FORMAT =3D 0):

   username "Auth" foo
   password "Auth" "SCRV1:YmFy:ODY3NTMwOQ=3D=3D"

   ("YmFy" is the base 64 encoding of "bar" and "ODY3NTMwOQ=3D=3D" is the
    base 64 encoding of "8675309".)
+
+or, if flag =3D 2 or 3 (i.e., FORMAT =3D 1):
+
+  username "Auth" foo
+  password "Auth" "bar8675309"
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 24f3121..05b5a1a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3544,7 +3544,8 @@
         if (sc)
         {
             buf_printf(&alert_msg, " SC:%d,%s",
-                       BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_EC=
HO),
+                       BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_EC=
HO)
+                       |(BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_=
CONCAT) << 1),
                        sc);
         }

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 598fbae..516b1ed 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -438,17 +438,28 @@
                     {
                         msg(M_FATAL, "ERROR: could not retrieve static cha=
llenge response");
                     }
-                    if (openvpn_base64_encode(up->password, strlen(up->pas=
sword), &pw64) =3D=3D -1
-                        || openvpn_base64_encode(response, strlen(response=
), &resp64) =3D=3D -1)
+                    if (!(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT))
                     {
-                        msg(M_FATAL, "ERROR: could not base64-encode passw=
ord/static_response");
+                        if (openvpn_base64_encode(up->password, strlen(up-=
>password), &pw64) =3D=3D -1
+                            || openvpn_base64_encode(response, strlen(resp=
onse), &resp64) =3D=3D -1)
+                        {
+                            msg(M_FATAL, "ERROR: could not base64-encode p=
assword/static_response");
+                        }
+                        buf_set_write(&packed_resp, (uint8_t *)up->passwor=
d, USER_PASS_LEN);
+                        buf_printf(&packed_resp, "SCRV1:%s:%s", pw64, resp=
64);
+                        string_clear(pw64);
+                        free(pw64);
+                        string_clear(resp64);
+                        free(resp64);
                     }
-                    buf_set_write(&packed_resp, (uint8_t *)up->password, U=
SER_PASS_LEN);
-                    buf_printf(&packed_resp, "SCRV1:%s:%s", pw64, resp64);
-                    string_clear(pw64);
-                    free(pw64);
-                    string_clear(resp64);
-                    free(resp64);
+                    else
+                    {
+                        if (strlen(up->password) + strlen(response) >=3D U=
SER_PASS_LEN)
+                        {
+                            msg(M_FATAL, "ERROR: could not concatenate pas=
sword/static_response: string too long");
+                        }
+                        strncat(up->password, response, USER_PASS_LEN - st=
rlen(up->password) - 1);
+                    }
                 }
 #endif /* ifdef ENABLE_MANAGEMENT */
             }
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 963f3e6..f3b824e 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -91,6 +91,7 @@
  */
 struct static_challenge_info {
 #define SC_ECHO     (1<<0)  /* echo response when typed by user */
+#define SC_CONCAT   (1<<1)  /* concatenate password and response and do no=
t base64 encode */
     unsigned int flags;

     const char *challenge_text;
@@ -117,6 +118,7 @@
 #define GET_USER_PASS_STATIC_CHALLENGE_ECHO  (1<<9) /* SCRV1 protocol -- e=
cho response */
=20
 #define GET_USER_PASS_INLINE_CREDS (1<<10)  /* indicates that auth_file is=
 actually inline creds */
+#define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1<<11)  /* indicates passwo=
rd and response should be concatenated */

 /**
  * Retrieves the user credentials from various sources depending on the fl=
ags.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 64e67aa..295ed3d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -518,8 +518,10 @@
     "                  Add domains to DNS domain search list\n"
     "--auth-retry t  : How to handle auth failures.  Set t to\n"
     "                  none (default), interact, or nointeract.\n"
-    "--static-challenge t e : Enable static challenge/response protocol us=
ing\n"
+    "--static-challenge t e [<scrv1|concat>]: Enable static challenge/resp=
onse protocol using\n"
     "                  challenge text t, with e indicating echo flag (0|1)=
\n"
+    "                  and optional argument scrv1 or concat to use SCRV1 =
protocol or"
+    "                  concatenate response with password. Default is scrv=
1.\n"
     "--connect-timeout n : when polling possible remote servers to connect=
 to\n"
     "                  in a round-robin fashion, spend no more than n seco=
nds\n"
     "                  waiting for a response before trying the next serve=
r.\n"
@@ -7932,7 +7934,7 @@
         auth_retry_set(msglevel, p[1]);
     }
 #ifdef ENABLE_MANAGEMENT
-    else if (streq(p[0], "static-challenge") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "static-challenge") && p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info.challenge_text =3D p[1];
@@ -7940,6 +7942,15 @@
         {
             options->sc_info.flags |=3D SC_ECHO;
         }
+        if (p[3] && streq(p[3], "concat"))
+        {
+            options->sc_info.flags |=3D SC_CONCAT;
+        }
+        else if (p[3] && !streq(p[3], "scrv1"))
+        {
+            msg(msglevel, "--static-challenge: unknown format indicator '%=
s'", p[3]);
+            goto err;
+        }
     }
 #endif
     else if (streq(p[0], "msg-channel") && p[1])
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e0e9591..25c6ccf 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -312,6 +312,10 @@
             {
                 flags |=3D GET_USER_PASS_STATIC_CHALLENGE_ECHO;
             }
+            if (sci->flags & SC_CONCAT)
+            {
+                flags |=3D GET_USER_PASS_STATIC_CHALLENGE_CONCAT;
+            }
             get_user_pass_cr(&auth_user_pass,
                              auth_file,
                              UP_TYPE_AUTH,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/665?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I59a90446bfe73d8856516025a58a6f62cc98ab0d
Gerrit-Change-Number: 665
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--gcztg1ggUQU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>selvanair <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/665?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Static-challenge concatenation option<br><br>=
Extend &quot;--static-challenge&quot; option to take a third<br>argument (=
=3D scrv1 or concat) to specify that the password and<br>response should be=
 concatenated instead of using the<br>SCRV1 protocol. If unspecified, it de=
faults to &quot;scrv1&quot;<br>meaning that the SCRV1 protocol should be us=
ed.<br><br>v2: use scrv1|concat instead of 0|1 as option argument<br>    fi=
x typos<br>v3: improve and correct documentation in management-notes.txt<br=
><br>Change-Id: I59a90446bfe73d8856516025a58a6f62cc98ab0d<br>---<br>M doc/m=
an-sections/client-options.rst<br>M doc/management-notes.txt<br>M src/openv=
pn/manage.c<br>M src/openvpn/misc.c<br>M src/openvpn/misc.h<br>M src/openvp=
n/options.c<br>M src/openvpn/ssl.c<br>7 files changed, 70 insertions(+), 20=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/65/665/3</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-options.rst=
 b/doc/man-sections/client-options.rst</span><br><span>index b75fe5b..a0694=
8e 100644</span><br><span>--- a/doc/man-sections/client-options.rst</span><=
br><span>+++ b/doc/man-sections/client-options.rst</span><br><span>@@ -541,=
12 +541,15 @@</span><br><span>   Valid syntax:</span><br><span>   ::</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     stati=
c-challenge text echo</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     static-challenge text echo [format]</span><br><span> </span><br><spa=
n>   The ``text`` challenge text is presented to the user which describes w=
hat</span><br><span>   information is requested.  The ``echo`` flag indicat=
es if the user&#39;s</span><br><span>   input should be echoed on the scree=
n.  Valid ``echo`` values are</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  :code:`0` or :code:`1`.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  :code:`0` or :code:`1`. The optional ``format`` indicates w=
hether</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the passwor=
d and response should be combined using the SCRV1 protocol</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  (``format`` =3D :code:`scrv1`) or =
simply concatenated (``format`` =3D :code:`concat`).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  :code:`scrv1` is the default.</span><br=
><span> </span><br><span>   See management-notes.txt in the OpenVPN distrib=
ution for a description of</span><br><span>   the OpenVPN challenge/respons=
e protocol.</span><br><span>diff --git a/doc/management-notes.txt b/doc/man=
agement-notes.txt</span><br><span>index b9947fa..b55135a 100644</span><br><=
span>--- a/doc/management-notes.txt</span><br><span>+++ b/doc/management-no=
tes.txt</span><br><span>@@ -1320,14 +1320,20 @@</span><br><span> </span><br=
><span> OpenVPN&#39;s --static-challenge option is used to provide the</spa=
n><br><span> challenge text to OpenVPN and indicate whether or not the resp=
onse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-should be echoed.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+should be echoed an=
d how the response should be combined with the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+password.</span><br><span> </span><br><span> Whe=
n credentials are needed and the --static-challenge option is</span><br><sp=
an> used, the management interface will send:</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &gt;PASSWORD:Need &#39;Auth&#39=
; username/password SC:&lt;ECHO&gt;,&lt;TEXT&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  &gt;PASSWORD:Need &#39;Auth&#39; username/pa=
ssword SC:&lt;flag&gt;,&lt;TEXT&gt;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  ECHO: &quot;1&quot; if response should be=
 echoed, &quot;0&quot; to not echo</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  flag: an integer whose least significant bit is the ECHO f=
lag and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        the =
next significant bit is the FORMAT flag.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ECHO =3D (flag &amp; 0x1) is 1 if response sho=
uld be echoed, 0 to not echo</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        FORMAT =3D (flag &amp; 0x2) is 1 if response should be con=
catenated with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   password as plain text, 0 if response and password should be encoded</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        as described be=
low. Thus flag could take values 0, 1, 2, or 3.</span><br><span>   TEXT: ch=
allenge text that should be shown to the user to</span><br><span>       fac=
ilitate their response</span><br><span> </span><br><span>@@ -1342,8 +1348,9=
 @@</span><br><span> </span><br><span> The management interface client in t=
his case should add the static</span><br><span> challenge text to the auth =
dialog followed by a field for the user to</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-enter a response.  Then the management interface clien=
t should pack the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pass=
word and response together into an encoded password and send:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+enter a response. If flag =3D 0 o=
r 1 (i.e., FORMAT=3D0), the management</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+interface client should pack the password and response t=
ogether into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+an enco=
ded password and send:</span><br><span> </span><br><span>   username &quot;=
Auth&quot; &lt;username&gt;</span><br><span>   password &quot;Auth&quot; &q=
uot;SCRV1:&lt;password_base64&gt;:&lt;response_base64&gt;&quot;</span><br><=
span>@@ -1354,6 +1361,12 @@</span><br><span> the user. The &lt;password_bas=
e64&gt; and/or the &lt;response_base64&gt; can be</span><br><span> empty st=
rings.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+If flag =3D 2 or 3 (i.e., FORMAT=3D1), the client should simply concat=
enate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+password and r=
esponse with no separator and send:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  u=
sername &quot;Auth&quot; &lt;username&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  password &quot;Auth&quot; &quot;&lt;password&gt;&lt=
;response&gt;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> (As in all username/password responses described in the &=
quot;COMMAND --</span><br><span> password and username&quot; section above,=
 the username can be in quotes,</span><br><span> and special characters suc=
h as double quotes or backslashes must be</span><br><span>@@ -1361,10 +1374=
,15 @@</span><br><span> </span><br><span> For example, if user &quot;foo&qu=
ot; entered &quot;bar&quot; as the password and 8675309</span><br><span> as=
 the PIN, the following management interface commands should be</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-issued:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+issued if flag =3D 0 or 1 (i.e., FORMAT =3D 0=
):</span><br><span> </span><br><span>   username &quot;Auth&quot; foo</span=
><br><span>   password &quot;Auth&quot; &quot;SCRV1:YmFy:ODY3NTMwOQ=3D=3D&q=
uot;</span><br><span> </span><br><span>   (&quot;YmFy&quot; is the base 64 =
encoding of &quot;bar&quot; and &quot;ODY3NTMwOQ=3D=3D&quot; is the</span><=
br><span>    base 64 encoding of &quot;8675309&quot;.)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+or, if flag =3D 2 or 3 (i.e., FORMAT =3D 1):</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  username &quot;Auth&quot; foo</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  password &quot;Auth&quot; &quot;bar8675=
309&quot;</span><br><span>diff --git a/src/openvpn/manage.c b/src/openvpn/m=
anage.c</span><br><span>index 24f3121..05b5a1a 100644</span><br><span>--- a=
/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br>=
<span>@@ -3544,7 +3544,8 @@</span><br><span>         if (sc)</span><br><spa=
n>         {</span><br><span>             buf_printf(&amp;alert_msg, &quot;=
 SC:%d,%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                  BOOL_CAST(flags &amp; GET_USER_PASS_STATIC_CHALLENGE_ECHO=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      BOOL_CAST(flags &amp; GET_USER_PASS_STATIC_CHALLENGE_ECHO)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                       |(BOOL_=
CAST(flags &amp; GET_USER_PASS_STATIC_CHALLENGE_CONCAT) &lt;&lt; 1),</span>=
<br><span>                        sc);</span><br><span>         }</span><br=
><span> </span><br><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc=
.c</span><br><span>index 598fbae..516b1ed 100644</span><br><span>--- a/src/=
openvpn/misc.c</span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ =
-438,17 +438,28 @@</span><br><span>                     {</span><br><span> =
                        msg(M_FATAL, &quot;ERROR: could not retrieve static=
 challenge response&quot;);</span><br><span>                     }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    if (openvp=
n_base64_encode(up-&gt;password, strlen(up-&gt;password), &amp;pw64) =3D=3D=
 -1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      || openvpn_base64_encode(response, strlen(response), &amp;resp64) =3D=
=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        if (!(flags &amp; GET_USER_PASS_STATIC_CHALLENGE_CONCAT))</span><br=
><span>                     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        msg(M_FATAL, &quot;ERROR: could not base64-=
encode password/static_response&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        if (openvpn_base64_encode(up-&g=
t;password, strlen(up-&gt;password), &amp;pw64) =3D=3D -1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                            || openvp=
n_base64_encode(response, strlen(response), &amp;resp64) =3D=3D -1)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       msg(M_FATAL, &quot;ERROR: could not base64-encode password/static_re=
sponse&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        buf_set_write(&amp;packed_resp, (uint8_t *)up-&gt;=
password, USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        buf_printf(&amp;packed_resp, &quot;SCRV1:%s:%=
s&quot;, pw64, resp64);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        string_clear(pw64);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        free(pw64);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        string_=
clear(resp64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   free(resp64);</span><br><span>                     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    buf_s=
et_write(&amp;packed_resp, (uint8_t *)up-&gt;password, USER_PASS_LEN);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    buf_pr=
intf(&amp;packed_resp, &quot;SCRV1:%s:%s&quot;, pw64, resp64);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    string_clear(p=
w64);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    free(pw64);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              string_clear(resp64);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    free(resp64);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        if (strlen(up-&=
gt;password) + strlen(response) &gt;=3D USER_PASS_LEN)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                            msg(M_=
FATAL, &quot;ERROR: could not concatenate password/static_response: string =
too long&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        strncat(up-&gt;password, response, USER_PASS_LEN=
 - strlen(up-&gt;password) - 1);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    }</span><br><span>                 }</span=
><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span>          =
   }</span><br><span>diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h</=
span><br><span>index 963f3e6..f3b824e 100644</span><br><span>--- a/src/open=
vpn/misc.h</span><br><span>+++ b/src/openvpn/misc.h</span><br><span>@@ -91,=
6 +91,7 @@</span><br><span>  */</span><br><span> struct static_challenge_in=
fo {</span><br><span> #define SC_ECHO     (1&lt;&lt;0)  /* echo response wh=
en typed by user */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define SC_CONCAT   (1&lt;&lt;1)  /* concatenate password and response and =
do not base64 encode */</span><br><span>     unsigned int flags;</span><br>=
<span> </span><br><span>     const char *challenge_text;</span><br><span>@@=
 -117,6 +118,7 @@</span><br><span> #define GET_USER_PASS_STATIC_CHALLENGE_E=
CHO  (1&lt;&lt;9) /* SCRV1 protocol -- echo response */</span><br><span> </=
span><br><span> #define GET_USER_PASS_INLINE_CREDS (1&lt;&lt;10)  /* indica=
tes that auth_file is actually inline creds */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1=
&lt;&lt;11)  /* indicates password and response should be concatenated */</=
span><br><span> </span><br><span> /**</span><br><span>  * Retrieves the use=
r credentials from various sources depending on the flags.</span><br><span>=
diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>=
index 64e67aa..295ed3d 100644</span><br><span>--- a/src/openvpn/options.c</=
span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -518,8 +518,1=
0 @@</span><br><span>     &quot;                  Add domains to DNS domain=
 search list\n&quot;</span><br><span>     &quot;--auth-retry t  : How to ha=
ndle auth failures.  Set t to\n&quot;</span><br><span>     &quot;          =
        none (default), interact, or nointeract.\n&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &quot;--static-challenge t e : Enabl=
e static challenge/response protocol using\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;--static-challenge t e [&lt;scrv1|=
concat&gt;]: Enable static challenge/response protocol using\n&quot;</span>=
<br><span>     &quot;                  challenge text t, with e indicating =
echo flag (0|1)\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;                  and optional argument scrv1 or concat to us=
e SCRV1 protocol or&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &quot;                  concatenate response with password. Defau=
lt is scrv1.\n&quot;</span><br><span>     &quot;--connect-timeout n : when =
polling possible remote servers to connect to\n&quot;</span><br><span>     =
&quot;                  in a round-robin fashion, spend no more than n seco=
nds\n&quot;</span><br><span>     &quot;                  waiting for a resp=
onse before trying the next server.\n&quot;</span><br><span>@@ -7932,7 +793=
4,7 @@</span><br><span>         auth_retry_set(msglevel, p[1]);</span><br><=
span>     }</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;static-chall=
enge&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;st=
atic-challenge&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</sp=
an><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERA=
L);</span><br><span>         options-&gt;sc_info.challenge_text =3D p[1];</=
span><br><span>@@ -7940,6 +7942,15 @@</span><br><span>         {</span><br>=
<span>             options-&gt;sc_info.flags |=3D SC_ECHO;</span><br><span>=
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (p[3] &amp;&amp; streq(p[3], &quot;concat&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            options-&gt;sc_info.flags |=3D SC_CONCA=
T;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (p[3] &amp;=
&amp; !streq(p[3], &quot;scrv1&quot;))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(msglevel, &quot;--static-challenge: unknown format=
 indicator &#39;%s&#39;&quot;, p[3]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            goto err;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> #endi=
f</span><br><span>     else if (streq(p[0], &quot;msg-channel&quot;) &amp;&=
amp; p[1])</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl=
.c</span><br><span>index e0e9591..25c6ccf 100644</span><br><span>--- a/src/=
openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -3=
12,6 +312,10 @@</span><br><span>             {</span><br><span>            =
     flags |=3D GET_USER_PASS_STATIC_CHALLENGE_ECHO;</span><br><span>      =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (sci-&gt;flags &amp; SC_CONCAT)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                flags |=3D GET_USER_PASS_STATIC_CHALLENGE_CONCAT;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span>             get_user_pass_cr(&amp;auth_user_pass,</span><br><sp=
an>                              auth_file,</span><br><span>               =
               UP_TYPE_AUTH,</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/665?usp=3Demail">chan=
ge 665</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/665?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I59a90446bfe73d8856516025a58=
a6f62cc98ab0d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 665 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--gcztg1ggUQU=--

