From: P Kern <pkern@...345...>
Message-Id: <05Jan28.134635est.1628422@...346...>
Subject: [Openvpn-devel] syslog facility config choice
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Jan 28 10:47:45 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: pkern@...345...

Hello.

It would be useful if the syslog facility could be optionally set to
something other than LOG_DAEMON.  There are too many things logging
to LOG_DAEMON, already.  Something like what's included below would be
great. Then "LOG_OPENVPN" (or whatever) could be chosen at config time.
(eg. local6.* is idle here so I used "-DLOG_OPENVPN=LOG_LOCAL6").

Thanks in advance.
pk.


===================================================================
RCS file: error.c,v
retrieving revision 1.1
diff -c -r1.1 error.c
*** error.c	2005/01/25 18:54:13	1.1
--- error.c	2005/01/25 18:57:35
***************
*** 49,54 ****
--- 49,60 ----
  
  #include "memdbg.h"
  
+ #if SYSLOG_CAPABILITY
+ #ifndef LOG_OPENVPN
+ #define LOG_OPENVPN LOG_DAEMON
+ #endif
+ #endif
+ 
  /* Globals */
  unsigned int x_debug_level; /* GLOBAL */
  
***************
*** 394,400 ****
        if (!use_syslog)
  	{
  	  pgmname_syslog = string_alloc (pgmname ? pgmname : PACKAGE, NULL);
! 	  openlog (pgmname_syslog, LOG_PID, LOG_DAEMON);
  	  use_syslog = true;
  
  	  /* Better idea: somehow pipe stdout/stderr output to msg() */
--- 400,406 ----
        if (!use_syslog)
  	{
  	  pgmname_syslog = string_alloc (pgmname ? pgmname : PACKAGE, NULL);
! 	  openlog (pgmname_syslog, LOG_PID, LOG_OPENVPN);
  	  use_syslog = true;
  
  	  /* Better idea: somehow pipe stdout/stderr output to msg() */

