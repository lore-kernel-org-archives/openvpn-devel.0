Date: Sun, 28 Feb 2010 15:50:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100228145001.GM9556@...1296...>
Mime-Version: 1.0
Subject: [Openvpn-devel] special-case code for OpenBSD - advice needed
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

while working on "make IPv6 payload work on Win32", I found something
quite peculiar for OpenBSD in the OpenVPN code.

In "init.c", do_open_tun(), calls two other functions from tun.c for
tunnel setup:

 open_tun() --> find free /dev/tun<n> device, open() it, thereby 
                activating a "tun<n>" network interface, store the device 
                name in "struct tuntap", etc.  

and

 do_ifconfig() --> run "ifconfig tun<n> 1.2.3.4" system commands
                   (basically consists of a ton of 
                   #if defined(TARGET_nnn) ... #else blocks, containing
                   the system specific variations of "ifconfig" commands.
                   

Now, for all operatings systems *except* Win32 and OpenBSD, the sequence
of execution is

 open_tun()
 do_ifconfig()

and for the named two systems, it's 

 do_ifconfig()
 open_tun()

This is controlled by the inline_function "ifconfig_order()" in tun.h,
which returns IFCONFIG_BEFORE_TUN_OPEN or IFCONFIG_AFTER_TUN_OPEN:

---------- quote ----------
/*
 * Should ifconfig be called before or after
 * tun dev open?
 */   
      
#define IFCONFIG_BEFORE_TUN_OPEN 0
#define IFCONFIG_AFTER_TUN_OPEN  1
        
#define IFCONFIG_DEFAULT         IFCONFIG_AFTER_TUN_OPEN

static inline int                               
ifconfig_order(void)  
{     
#if defined(TARGET_LINUX)
  return IFCONFIG_AFTER_TUN_OPEN;
#elif defined(TARGET_SOLARIS)
  return IFCONFIG_AFTER_TUN_OPEN;
#elif defined(TARGET_OPENBSD)
  return IFCONFIG_BEFORE_TUN_OPEN;
#elif defined(TARGET_DARWIN)
  return IFCONFIG_AFTER_TUN_OPEN;
#elif defined(TARGET_NETBSD)
  return IFCONFIG_AFTER_TUN_OPEN;
#elif defined(WIN32)
  return IFCONFIG_BEFORE_TUN_OPEN;
#else 
  return IFCONFIG_DEFAULT;
#endif
}       
---------- quote ----------

I am ready to accept that Windows is weird, and needs special-casing of
stuff, but the OpenBSD case baffles me - it's a BSD after all, and all
other BSDs do it the other way round.


Now, reading through the code, OpenBSD, NetBSD and Darwin (MacOS X)
are actually very similar - that is, tun devices are persistent, and you
need to do "ifconfig tun<n> destroy" before doing the target ifconfig,
otherwise you can have "leftover" configuration garbage there.  Still,
NetBSD and Darwin do "IFCONFIG_AFTER_TUN_OPEN".


So...

Question #1: why is OpenBSD treated differently?  Does anyone on this list 
know why this is so, and whether it needs to be kept that way?  (I have no 
OpenBSD system to test on, right now).

Question #2: (more a style question) - why is this function so convoluted,
if all the operating systems default to the default anyway - so why not
change it to:

static inline int                               
ifconfig_order(void)  
{     
#if defined(TARGET_OPENBSD)
  return IFCONFIG_BEFORE_TUN_OPEN;
#elif defined(WIN32)
  return IFCONFIG_BEFORE_TUN_OPEN;
#else 
  return IFCONFIG_AFTER_TUN_OPEN;
#endif
}


I'm purposely not sending a patch right now, because I don't understand
the reason for the code being what it is.

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

