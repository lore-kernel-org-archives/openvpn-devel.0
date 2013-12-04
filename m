MIME-Version: 1.0
Date: Wed, 4 Dec 2013 19:12:57 +0600
Message-ID: <CAFHpkQE_3xeGuVe+Ouydz70WN1cdhm2dwHsibV+e-ysyp2fGpg@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: [Openvpn-devel] uninitialized handle fix (serious issue on Win 8.1)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello!

I confirm issue described here: https://forums.openvpn.net/topic13246.html
also, I confirm that it is due to random handle value (which somehow
was null before Win 8.1 was released)

also, I do not understand why we should check "err" handle on
INVALID_HANDLE_VALUE, it will fail anyway on WriteFile, that check is
useless.

I do not insist on being perfect, if someone has better idea how to
solve https://forums.openvpn.net/topic13246.html - I do not mind.

I can make git pull request from
https://github.com/chipitsine/openvpn/commit/3987bd0e035b653a5017c5eccbd54eaf22746852
if it's better.

people encounter problems on Win 8.1 (well, just couple of people
here, we are running openvpn with tens of customers on Win 8.1), I
beleive it is serious issue, please consider release of openvpn.

diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index afda8ca..3ec5758 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -62,7 +62,6 @@ get_console_input_win32 (const char *prompt, const
bool echo, char *input, const
   err = get_orig_stderr ();

   if (in != INVALID_HANDLE_VALUE
-      && err != INVALID_HANDLE_VALUE
       && !win32_service_interrupt (&win32_signal)
       && WriteFile (err, prompt, strlen (prompt), &len, NULL))
     {
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 6848425..acc7977 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -454,12 +454,12 @@ close_syslog ()

 #ifdef WIN32

-static HANDLE orig_stderr;
+static HANDLE orig_stderr = INVALID_HANDLE_VALUE;

 HANDLE
 get_orig_stderr (void)
 {
-  if (orig_stderr)
+  if (orig_stderr != INVALID_HANDLE_VALUE)
     return orig_stderr;
   else
     return GetStdHandle (STD_ERROR_HANDLE);

