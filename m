Date: Sun, 28 Feb 2010 17:35:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100228163524.GP9556@...1296...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Macos X / Darwin funny in the code
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

today is the day... :-)

tun.c, do_ifconfig() contains this beauty...

--------------------------------------------------------
#elif defined(TARGET_DARWIN) 
    
      /* 
       * Darwin (i.e. Mac OS X) seems to exhibit similar behaviour to OpenBSD...
       */
 
      argv_printf (&argv,
                        "%s %s delete", 
                        IFCONFIG_PATH,
                        actual);
      argv_msg (M_INFO, &argv);
      openvpn_execve_check (&argv, es, 0, NULL);
      msg (M_INFO, "NOTE: Tried to delete pre-existing tun/tap instance -- No Pr
oblem if failure");     
--------------------------------------------------------

... which doesn't work on 10.5 (at least), because there is no 
"ifconfig ... delete" command - to get rid of an interface, you need
to call "ifconfig ... destroy".  

So all this would do is configure the tun interface to the IP address
of a host named "delete", if such a host exists...

Sun Feb 28 17:22:03 2010 us=91225 /sbin/ifconfig tun0 delete
ifconfig: ioctl (SIOCDIFADDR): Can't assign requested address


At least on 10.5, this code is not needed at all, because the tun0 interface
is auto-destroyed after closing it, so it's just superfluous and broken
code.

What I cannot test is: is it required on 10.4, 10.3, ...?  If yes, which
versions of MacOS X need it, and should we add a "configure" test for it?

(I'm afraid this needs going back in the svn logs who did the MacOS X port
and check with him...)

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

