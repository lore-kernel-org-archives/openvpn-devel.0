From: Dimitri Goldin <dmi@...37...>
Message-ID: <20020726215819.GA11459@...38...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
Subject: [Openvpn-devel] NetBSD patch for OpenVPN
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Fri Jul 26 14:59:02 2002
To: openvpn-devel@lists.sourceforge.net

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello list,                                                                     
                                                                                
The patch for the NetBSD "support" ist ready.                                   
I only added some entries for NetBSD and used the same ifconfig code            
as OpenBSD in tun.c.                                                            
The patch is attached.                                            
I hope I did everything right.              
                                                                                
Cheers,                                                                         
        Dimitri               
--                                                                              
pub  1024D/3A264EA8 2002-07-07 Dimitri Goldin <dmi@...37...>              
Fingerprint: 3AA9 1264 51AA 0BB5 EB29  A6E3 9648 F42A 3A26 4EA8                 
                                                "Don't Panic."                  
                                                                                                                    

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-netbsd.diff"

*** ../openvpn-1.3.1/configure.ac	Thu Jul 11 07:17:04 2002
--- configure.ac	Fri Jul 26 22:19:27 2002
***************
*** 114,123 ****
--- 114,126 ----
  	AC_DEFINE(TARGET_OPENBSD, 1, [Are we running on OpenBSD?])
  	;;
  *freebsd*)
  	AC_DEFINE(TARGET_FREEBSD, 1, [Are we running on FreeBSD?])
  	;;
+ *netbsd*) 
+ 	AC_DEFINE(TARGET_NETBSD, 1, [Are we running NetBSD?])
+ 	;;
  *darwin*)
  	dnl some Mac OS X tendering (we use vararg macros...)
  	AC_DEFINE(TARGET_DARWIN, 1, [Are we running on Mac OS X?])
  	CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
  	;;
*** ../openvpn-1.3.1/syshead.h	Thu Jun 13 20:50:28 2002
--- syshead.h	Fri Jul 26 21:14:24 2002
***************
*** 194,203 ****
--- 194,211 ----
  #include <net/if_tun.h>
  #endif
  
  #endif /* TARGET_FREEBSD */
  
+ #ifdef TARGET_NETBSD
+ 
+ #ifdef HAVE_NET_IF_TUN_H
+ #include <net/if_tun.h>
+ #endif
+ 
+ #endif /* TAGET_NETBSD */
+ 
  #ifdef HAVE_SYS_MMAN_H
  #ifdef TARGET_DARWIN
  #define _P1003_1B_VISIBLE
  #endif /* TARGET_DARWIN */
  #include <sys/mman.h>
*** ../openvpn-1.3.1/tun.c	Tue Jul  2 19:09:26 2002
--- tun.c	Fri Jul 26 21:14:24 2002
***************
*** 147,156 ****
--- 147,168 ----
  		tun_mtu
  		);
        msg (M_INFO, "%s", command_line);
        system_check (command_line, "OpenBSD ifconfig failed", true);
  
+ #elif defined(TARGET_NETBSD)
+ 
+       snprintf (command_line, sizeof (command_line),
+ 	        IFCONFIG_PATH " %s %s %s mtu %d netmask 255.255.255.255 up",
+ 	        dev,
+ 		ifconfig_local,
+                 ifconfig_remote,
+                 tun_mtu
+                 );
+       msg (M_INFO, "%s", command_line);
+       system_check (command_line, "NetBSD ifconfig failed", true);
+ 
  #elif defined(TARGET_DARWIN)
  
        /*
         * Darwin seems to exibit similar behaviour to OpenBSD...
         */

*** ../openvpn-1.3.1/tun.h	Tue Jul  2 19:09:27 2002
--- tun.h	Fri Jul 26 21:21:58 2002
***************
*** 92,100 ****
--- 92,102 ----
    return IFCONFIG_AFTER_TUN_OPEN;
  #elif defined(TARGET_OPENBSD)
    return IFCONFIG_BEFORE_TUN_OPEN;
  #elif defined(TARGET_DARWIN)
    return IFCONFIG_AFTER_TUN_OPEN;
+ #elif defined(TARGET_NETBSD)
+   return IFCONFIG_DEFAULT;
  #else
    return IFCONFIG_DEFAULT;
  #endif
  }

--M9NhX3UHpAaciwkO--

