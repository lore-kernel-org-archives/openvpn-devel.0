From: WEi W- <wwei76922@...277...>
Date: Mon, 21 Jun 2021 16:58:02 +0000
Message-ID: <CH2PR12MB3845305EE7FBD378C647BE85A40A9@...2623...>
References: <20210618155241.400-1-lstipakov@...277...>
In-Reply-To: <20210618155241.400-1-lstipakov@...277...>
Content-Language: zh-CN
Content-Type: multipart/alternative;
 boundary="_000_CH2PR12MB3845305EE7FBD378C647BE85A40A9CH2PR12MB3845namp_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix management password prompt with
 redirected log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lstipakov@...277...>
Cc: Lev Stipakov <lev@...515...>

--_000_CH2PR12MB3845305EE7FBD378C647BE85A40A9CH2PR12MB3845namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

lev@...515...

Get Outlook for Android<https://aka.ms/AAb9ysg>

________________________________
From: Lev Stipakov <lstipakov@...277...>
Sent: Friday, June 18, 2021 10:22:41 PM
To: openvpn-devel@lists.sourceforge.net <openvpn-devel@...475...=
t>
Cc: Lev Stipakov <lev@...515...>
Subject: [Openvpn-devel] [PATCH] Fix management password prompt with redire=
cted log

From: Lev Stipakov <lev@...515...>

When management interface is password protected, openvpn
writes "Enter Management Password" to stderr. As it turns out,
when log is redirected to a file, that prompt is also written to that
file and not to the "original" stderr. Moreover, on recent Insider build
(21390.2025) openvpn exits with fatal error

  get_console_input_win32(): unexpected error: No such device or address (e=
rrno=3D6)

while attempting to write that prompt.

When redirecting stdout/stderr, we use _dup2() to associate stderr
descriptor with the log file. This call closes file associated
with stderr descriptor, which might explain why it has stopped
working (original stderr is closed and WriteFile() fails) and on
current versions it appears to work "by accident" - not failing
but use redirected stderr instead of original one.

I played a bit with DuplicateHandle() for STD_ERROR_HANDLE
but got the same behavior.

Fix fatal error on Insider build by always writing prompt
to the new stderr and removing concept of "orig_stderr".
For current Windows releases behavior doesn't change.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/console_builtin.c |  2 +-
 src/openvpn/error.c           | 31 -------------------------------
 src/openvpn/error.h           |  6 ------
 3 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 9bf36347..31214536 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -73,7 +73,7 @@ get_console_input_win32(const char *prompt, const bool ec=
ho, char *input, const
     input[0] =3D '\0';

     in =3D GetStdHandle(STD_INPUT_HANDLE);
-    err =3D get_orig_stderr();
+    err =3D GetStdHandle(STD_ERROR_HANDLE);

     if (in =3D=3D INVALID_HANDLE_VALUE
         || err =3D=3D INVALID_HANDLE_VALUE
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index b94d387c..e807435c 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -490,25 +490,6 @@ close_syslog(void)
 #endif
 }

-#ifdef _WIN32
-
-static HANDLE orig_stderr;
-
-HANDLE
-get_orig_stderr(void)
-{
-    if (orig_stderr)
-    {
-        return orig_stderr;
-    }
-    else
-    {
-        return GetStdHandle(STD_ERROR_HANDLE);
-    }
-}
-
-#endif
-
 void
 redirect_stdout_stderr(const char *file, bool append)
 {
@@ -549,18 +530,6 @@ redirect_stdout_stderr(const char *file, bool append)
             }
         }

-        /* save original stderr for password prompts */
-        orig_stderr =3D GetStdHandle(STD_ERROR_HANDLE);
-
-#if 0 /* seems not be necessary with stdout/stderr redirection below*/
-        /* set up for redirection */
-        if (!SetStdHandle(STD_OUTPUT_HANDLE, log_handle)
-            || !SetStdHandle(STD_ERROR_HANDLE, log_handle))
-        {
-            msg(M_ERR, "Error: cannot redirect stdout/stderr to --log file=
: %s", file);
-        }
-#endif
-
         /* direct stdout/stderr to point to log_handle */
         log_fd =3D _open_osfhandle((intptr_t)log_handle, _O_TEXT);
         if (log_fd =3D=3D -1)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index f4528ef2..b91e54fb 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -255,12 +255,6 @@ void close_syslog(void);
 /* log file output */
 void redirect_stdout_stderr(const char *file, bool append);

-#ifdef _WIN32
-/* get original stderr handle, even if redirected by --log/--log-append */
-HANDLE get_orig_stderr(void);
-
-#endif
-
 /* exit program */
 void openvpn_exit(const int status);

--
2.23.0.windows.1



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--_000_CH2PR12MB3845305EE7FBD378C647BE85A40A9CH2PR12MB3845namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
</head>
<body>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
lev@...515...<span id=3D"ms-outlook-android-cursor"></span><br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<span id=3D"OutlookSignature">
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Get <a href=3D"https://aka.ms/AAb9ysg">Outlook for Android</a></div>
</span><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lev Stipakov &lt;lsti=
pakov@...277...&gt;<br>
<b>Sent:</b> Friday, June 18, 2021 10:22:41 PM<br>
<b>To:</b> openvpn-devel@lists.sourceforge.net &lt;openvpn-devel@...1439...=
ceforge.net&gt;<br>
<b>Cc:</b> Lev Stipakov &lt;lev@...515...&gt;<br>
<b>Subject:</b> [Openvpn-devel] [PATCH] Fix management password prompt with=
 redirected log</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Lev Stipakov &lt;lev@...515...&gt;<br>
<br>
When management interface is password protected, openvpn<br>
writes &quot;Enter Management Password&quot; to stderr. As it turns out,<br>
when log is redirected to a file, that prompt is also written to that<br>
file and not to the &quot;original&quot; stderr. Moreover, on recent Inside=
r build<br>
(21390.2025) openvpn exits with fatal error<br>
<br>
&nbsp; get_console_input_win32(): unexpected error: No such device or addre=
ss (errno=3D6)<br>
<br>
while attempting to write that prompt.<br>
<br>
When redirecting stdout/stderr, we use _dup2() to associate stderr<br>
descriptor with the log file. This call closes file associated<br>
with stderr descriptor, which might explain why it has stopped<br>
working (original stderr is closed and WriteFile() fails) and on<br>
current versions it appears to work &quot;by accident&quot; - not failing<b=
r>
but use redirected stderr instead of original one.<br>
<br>
I played a bit with DuplicateHandle() for STD_ERROR_HANDLE<br>
but got the same behavior.<br>
<br>
Fix fatal error on Insider build by always writing prompt<br>
to the new stderr and removing concept of &quot;orig_stderr&quot;.<br>
For current Windows releases behavior doesn't change.<br>
<br>
Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>
---<br>
&nbsp;src/openvpn/console_builtin.c |&nbsp; 2 +-<br>
&nbsp;src/openvpn/error.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 31 -------------------------------<br>
&nbsp;src/openvpn/error.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 6 ------<br>
&nbsp;3 files changed, 1 insertion(+), 38 deletions(-)<br>
<br>
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c<=
br>
index 9bf36347..31214536 100644<br>
--- a/src/openvpn/console_builtin.c<br>
+++ b/src/openvpn/console_builtin.c<br>
@@ -73,7 +73,7 @@ get_console_input_win32(const char *prompt, const bool ec=
ho, char *input, const<br>
&nbsp;&nbsp;&nbsp;&nbsp; input[0] =3D '\0';<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; in =3D GetStdHandle(STD_INPUT_HANDLE);<br>
-&nbsp;&nbsp;&nbsp; err =3D get_orig_stderr();<br>
+&nbsp;&nbsp;&nbsp; err =3D GetStdHandle(STD_ERROR_HANDLE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (in =3D=3D INVALID_HANDLE_VALUE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || err =3D=3D INVALID_HAND=
LE_VALUE<br>
diff --git a/src/openvpn/error.c b/src/openvpn/error.c<br>
index b94d387c..e807435c 100644<br>
--- a/src/openvpn/error.c<br>
+++ b/src/openvpn/error.c<br>
@@ -490,25 +490,6 @@ close_syslog(void)<br>
&nbsp;#endif<br>
&nbsp;}<br>
&nbsp;<br>
-#ifdef _WIN32<br>
-<br>
-static HANDLE orig_stderr;<br>
-<br>
-HANDLE<br>
-get_orig_stderr(void)<br>
-{<br>
-&nbsp;&nbsp;&nbsp; if (orig_stderr)<br>
-&nbsp;&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return orig_stderr;<br>
-&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return GetStdHandle(STD_ERROR_H=
ANDLE);<br>
-&nbsp;&nbsp;&nbsp; }<br>
-}<br>
-<br>
-#endif<br>
-<br>
&nbsp;void<br>
&nbsp;redirect_stdout_stderr(const char *file, bool append)<br>
&nbsp;{<br>
@@ -549,18 +530,6 @@ redirect_stdout_stderr(const char *file, bool append)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save original stderr for pas=
sword prompts */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; orig_stderr =3D GetStdHandle(ST=
D_ERROR_HANDLE);<br>
-<br>
-#if 0 /* seems not be necessary with stdout/stderr redirection below*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set up for redirection */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!SetStdHandle(STD_OUTPUT_HA=
NDLE, log_handle)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || !Set=
StdHandle(STD_ERROR_HANDLE, log_handle))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg(M_E=
RR, &quot;Error: cannot redirect stdout/stderr to --log file: %s&quot;, fil=
e);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-#endif<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* direct stdout/stderr to=
 point to log_handle */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; log_fd =3D _open_osfhandle=
((intptr_t)log_handle, _O_TEXT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (log_fd =3D=3D -1)<br>
diff --git a/src/openvpn/error.h b/src/openvpn/error.h<br>
index f4528ef2..b91e54fb 100644<br>
--- a/src/openvpn/error.h<br>
+++ b/src/openvpn/error.h<br>
@@ -255,12 +255,6 @@ void close_syslog(void);<br>
&nbsp;/* log file output */<br>
&nbsp;void redirect_stdout_stderr(const char *file, bool append);<br>
&nbsp;<br>
-#ifdef _WIN32<br>
-/* get original stderr handle, even if redirected by --log/--log-append */=
<br>
-HANDLE get_orig_stderr(void);<br>
-<br>
-#endif<br>
-<br>
&nbsp;/* exit program */<br>
&nbsp;void openvpn_exit(const int status);<br>
&nbsp;<br>
-- <br>
2.23.0.windows.1<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
Openvpn-devel@lists.sourceforge.net<br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel">http=
s://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CH2PR12MB3845305EE7FBD378C647BE85A40A9CH2PR12MB3845namp_--

