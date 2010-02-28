Date: Sun, 28 Feb 2010 21:18:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100228201811.GR9556@...1296...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Win XP problem with framedyn.dll and PATH settings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I've been working on IPv6-Payload support on Windows over the last few
days, and made some progress.  Cross-compile succeeds, the resulting binary
works fine for IPv6 and does some of the movements needed for IPv6.

I have decided to use "netsh" commands to setup IPv6, as this seems to be
"the canonical way" to do things.

There is one problem here: for every "netsh interface ipv6 add route" 
command that I call (via openvpn_execve_check()), I get an error popup
about "framedyn.dll" not being found.

If I run the very same command from "cmd.exe", it succeeds.

Googling suggests that this might be a %PATH% setting issue:

  http://www.dll-error-fixes.com/guide-fix-missing-framedyndll-error/

but checking the path on my system, everything seems to be fine (and the
DLL is there, in c:\windows\system32\Wbem\framedyn.dll, just fine).

If I change the config file and add "script-security 1 system" (instead of
the default, "... execve"), the commands work and yield no errors.


So.  Looking at the code, it seems that %PATH% is never set for the execve
method - there's a set_win_sys_path() routine, but that sets %SystemRoot%,
not %PATH%.

I'm not exactly sure what the best way to fix this, which is why I bring
this up here, for discussion and feedback.

My current workaround is to have win32/env_block always add a static 
PATH if no PATH is found in "es" - this is ugly, and not the right way
to go forward, but it helps me to work on the IPv6 bits for the time
being.  (See below).  An alternative way would be to copy %PATH% to "es"
upn startup (on Windows), or add another config variable "win-path" or
whatever.

Feedback requested!

gert

diff --git a/win32.c b/win32.c
index eb94eb8..7c57f1e 100644
--- a/win32.c
+++ b/win32.c
@@ -874,16 +874,21 @@ win_safe_filename (const char *fn)
 static char *
 env_block (const struct env_set *es)
 {
+  char * force_path = "PATH=C:\\Windows\\System32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem";
+
   if (es)
     {
       struct env_item *e;
       char *ret;
       char *p;
       size_t nchars = 1;
+      bool path_seen = false;
       
       for (e = es->list; e != NULL; e = e->next)
 	nchars += strlen (e->string) + 1;
 
+      nchars += strlen(force_path)+1;
+
       ret = (char *) malloc (nchars);
       check_malloc_return (ret);
 
@@ -895,7 +900,18 @@ env_block (const struct env_set *es)
 	      strcpy (p, e->string);
 	      p += strlen (e->string) + 1;
 	    }
+	  if ( strncmp(e->string, "PATH=", 5 ) == 0 )
+	    path_seen = true;
+	}
+
+      /* make sure PATH is set */
+      if ( !path_seen )
+	{
+	  msg( M_INFO, "env_block: add %s", force_path );
+	  strcpy( p, force_path );
+	  p += strlen(force_path) + 1;
 	}
+
       *p = '\0';
       return ret;
     }
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

