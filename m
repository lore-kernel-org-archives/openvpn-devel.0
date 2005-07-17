From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] PATCH: syslog while not running as a daemon
In-Reply-To: <42DAA4C6.3070301@...361...>
Message-ID: <Pine.LNX.4.58.0507171406500.14076@...41...>
References: <20050405173227.0AEC512120@...436...>
 <425328AB.7050307@...437...> <Pine.LNX.4.58.0504051824120.19198@...41...>
 <4253A8DC.1040808@...361...> <42DAA4C6.3070301@...361...>
MIME-Version: 1.0
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
Date: Sun Jul 17 13:10:40 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Rolf Fokkens <r.fokkens@...361...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Rolf,

A patch very similar to this one was already added in 2.0.1-rc1:

--- options.c   2005-01-26 13:17:32.851107832 -0600
+++ openvpn-2.0_rc10/options.c  2005-02-02 12:26:04.678006080 -0600
@@ -2813,6 +2813,13 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->up_restart = true;
     }
+  else if (streq (p[0], "syslog"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (p[1])
+       ++i;
+      open_syslog (p[1], false);
+    }
   else if (streq (p[0], "daemon"))
     {
       bool didit = false;

James

On Sun, 17 Jul 2005, Rolf Fokkens wrote:

> Hi!
> 
> When not running as a daemon (--daemon option), OpenVPN writes all 
> output to stderr. When OpenVPN isn't run interactively, but it actually 
> isn't run with the --daemon option as well, it's rather inconvenient 
> that syslog isn't used. This is primarily an issue for the development 
> of a VPN appliance I'm working on 
> (http://adsl-dc-3b681.adsl.wanadoo.nl/vvpn) but if for example OpenVPN 
> would be controlled by inittab the same problem is there.
> 
> Attached a patch that solves the problem for me, it may be of use to 
> others as well.
> 
> Cheers!
> 
> Rolf
> 

