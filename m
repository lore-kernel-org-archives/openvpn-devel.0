MIME-Version: 1.0
In-Reply-To: <1371532990-2853-1-git-send-email-arne@...1227...>
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<1371532990-2853-1-git-send-email-arne@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 19 Jun 2013 23:17:33 -0400
Message-ID: <CAEsd45RrzR5XAh=PN3WUPM41VrJdXeZef8KLCrtbBPEXiQJuPQ@...278...>
Subject: Re: [Openvpn-devel] [Patch v2] Add support of utun devices under
 Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Tue, Jun 18, 2013 at 1:23 AM, Arne Schwabe <arne@...1227...> wrote:
>
> Mac OS X 10.7+ natively supports tun devices (called utun). The "standard" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and tun.ko do not work together).
>
> When OpenVPN is compiled with utun support it will if no dev-node is given first try to use utun and if that is not available will try the traditional tun devices
>
> Parts of the patches are inspired from Peter Sagerson's <psagers@...1829...> utun patch
> Signed-off-by: Arne Schwabe <arne@...1227...>

I am anxious to see utun incorporated into OpenVPN and like the
functionality this patch provides. I have several comments, all based
on the updated patch in Arne's 2013-06-18 email.

(Because I am using an old version of OpenVPN, the line numbers in my
files don't correspond to those Arne's patch was based on, so the
code/patches I show below are pseudo-diffs from the code as patched by
Arne's patch, not diffs from any existing code or diffs from his
patch.)

First, I propose three minor wording changes:

Two changes in doc/openvpn.8:

-to select a speficic utun instance. To force using the tun.kext (/dev/tunX) use
+to select a specific utun instance. To force using the tun.kext (/dev/tunX) use

and

-option openvpn will try to first open utun first fallback to tun.kext.
+option openvpn will first try to open utun, and fall back to tun.kext.

One change in src/openvpn/tun.c

-  msg (M_INFO, "Openend utun device %s", utunname);
+  msg (M_INFO, "Opened utun device %s", utunname);

--------------------------------

Second, I created an experimental build of Tunnelblick that
incorporates this patch into OpenVPN 2.3.2. Because Tunnelblick is
built in OS X 10.6.8 with Xcode 3.2.2 with the 10.6 SDK (to support
PPC and OS X 10.4 - 10.9), it doesn't have /net/if_utun.h, so it
doesn't set HAVE_NET_IF_UTUN_H. That combination (TARGET_DARWIN is
set, but not HAVE_NET_IF_UTUN_H) generates errors that require some
changes:

The "}" at the end of open_tun() needs to be conditionalized (Here is
the entire routine to clarify why):

 open_tun (const char *dev, const char *dev_type, const char
*dev_node, struct tuntap *tt)
 {
 #ifdef HAVE_NET_IF_UTUN_H
     /* If dev_node does not start start with utun assume regular tun/tap */
     if ((!dev_node && strcmp (dev, "tun")==0) ||
         (dev_node && (strstr (dev_node, "utun") == dev_node)))
     {
         /* Try utun first and fall back to normal tun if utun fails
          * and dev_node is not specified */
         open_darwin_utun(dev, dev_type, dev_node, tt);

         /* No explicit utun and utun failed, try the generic way) */
         if (!dev_node && !tt->is_utun)
         {
             msg (M_INFO, "Failed to open utun device. Falling back to
/dev/tun device");
             open_tun_generic (dev, dev_type, NULL, true, true, tt);
         }
     }
     else
     {
 #endif
         /* Use plain dev-node tun to select /dev/tun style
          * Unset dev_node variable prior to passing to open_tun_generic to
          * let open_tun_generic pick the first available tun device */

         if (dev_node && strcmp (dev_node, "tun")==0)
             dev_node=NULL;

         open_tun_generic (dev, dev_type, dev_node, true, true, tt);
+#ifdef HAVE_NET_IF_UTUN_H
    }
+#endif
}

(Or, if you want, you can move the existing #endif up one line instead.)


The changes to write_tun and read_tun need to be conditioned on
HAVE_NET_IF_UTUN_H being defined:

 int
 write_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
+#ifdef HAVE_NET_IF_UTUN_H
   if (tt->is_utun)
     return write_tun_header (tt, buf, len);
   else
+#endif
     return write (tt->fd, buf, len);
 }

 int
 read_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
+#ifdef HAVE_NET_IF_UTUN_H
  if (tt->is_utun)
     return read_tun_header (tt, buf, len);
   else
+#endif
    return read (tt->fd, buf, len);
 }

The resulting binary works on 10.5.8, 10.6.8, and 10.7.5. (Of course,
it uses tun, not utun.)

--------------------------------

I removed all the the references to HAVE_NET_IF_UTUN_H (so the utun
code is compiled even though it is not it is available in the SDK
being used) and changed:

-#include <net/if_utun.h>
+#define UTUN_CONTROL_NAME "com.apple.net.utun_control"
+#define UTUN_OPT_IFNAME   2

>>>>> Note: This change should not be put in an OpenVPN patch; it is solely to allow me to compile it with the 10.6 SDK.

(The values for the UTUN_* variables are taken from 10.7), and it
built without problems.

--------------------------------

The resulting binary works fine and uses utun on 10.6.8 and 10.7.5.

(Interesting that utun isn't in the 10.6 SDK but utun works on 10.6.8.
Since it isn't in the SDK, I assume it may be flakey and/or only in
some OS X > 10.6.0. If it is flakey in 10.6.8, that's a problem
because it will be used by default, but if it is just that it isn't in
all of 10.6.*, that should be OK.)

On 10.5.8, however, attempting to connect to a server fails with the
following messages from the OpenVPN log:

2013-06-19 10:06:28 Opening utun (ioctl(CTLIOCGINFO)): No such file or
directory: No such file or directory (errno=2)
2013-06-19 10:06:28 Exiting due to fatal error

Someone should build with the patch properly (i.e. not like I did) on
10.7 or 10.8 and test it on 10.5 (and 10.4, ideally) to make sure the
fallback really works. (I may be misunderstanding the code, but if
"msg (M_ERR..." doesn't return, then that's at least part of the
problem.)

If fallback doesn't work in 10.4 and 10.5, then my view is that it
should be changed so it does work (mostly because Tunnelblick supports
10.4 - 10.8 with a single OpenVPN binary). If OpenVPN doesn't want to
support 10.5 or 10.4 to this extent, or if the fallback failure is
caused by with the way I worked around not using the 10.7 SDK, I guess
I'll just have to deal with it.

