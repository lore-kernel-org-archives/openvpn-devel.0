MIME-Version: 1.0
In-Reply-To: <1371719106-17292-1-git-send-email-arne@...1227...>
References: <1371718217-12974-1-git-send-email-arne@...1227...>
	<1371719106-17292-1-git-send-email-arne@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Thu, 20 Jun 2013 09:32:55 -0400
Message-ID: <CAEsd45TXXa_X8=k91K9-wwYEdXWYnkJrzCg3dSx=v-dnbONZcw@...278...>
Subject: Re: [Openvpn-devel] [Patch v3.1] Add support of utun devices under
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

On Thu, Jun 20, 2013 at 4:58 AM, Arne Schwabe <arne@...1227...> wrote:
> I have a OS X 10.6 VM with Xcode 3.2.6 installed and this VM has the
> if/utun.h header. I probably was added somewhere between 10.6.0 and 10.6.8.

Ah. Thanks for mentioning this. That makes sense.


> I changed the M_ERR to M_WARN. It should now work on 10.5.x but without
> a 10.5 to test on it is difficult to say...

OK, thanks; now I better understand how the error handling works.


On Thu, Jun 20, 2013 at 5:05 AM, Arne Schwabe <arne@...1227...> wrote:
> Mac OS X 10.7+ natively supports tun devices (called utun). The "standard" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and tun.ko do not work together).
>
> When OpenVPN is compiled with utun support it will if no dev-node is given first try to use utun and if that is not available will try the traditional tun devices
>
> Parts of the patches are inspired from Peter Sagerson's <psagers@...1829...> utun patch
> Signed-off-by: Arne Schwabe <arne@...1227...>


First, I should mention that the most recent version of this patch (in
your Thu, Jun 20, 2013 at 5:05 AM email) seems to make some other,
major changes, too, at least when compared to the earlier version (in
your  email of Tue, Jun 18, 2013 at 1:23 AM). I have ignored those
changes (I don't really understand them), and I have just made the
changes that I mentioned, plus one typo that you caught that I missed,
and the M_ERR to M_WARN changes.

Unfortunately, this patch still fails if the utun code is included and
executed on 10.5.

A minor problem is that for each of the 255 attempts to get a utun
device (device #0 through device #254), it generates the following
warning message:
     Opening utun (ioctl(CTLIOCGINFO)): No such file or directory
It's ugly, but cosmetic. Perhaps it could be displayed only at verb=4
and higher? (I don't know how to do that.)

The larger problem is that it still fails to connect, with the error message:
     Error retrieving utun interface name: Bad file descriptor (errno=9)

I think this is because open_darwin_utun ignores the error (fd == -1)
returned from utun_open_helper.

If so, it can be fixed by changing open_darwin_utun as follows:

     else
     {
         fd = utun_open_helper (ctlInfo, utunnum);
     }

+    if (fd==-1)
+       tt->is_utun = false;
+       return;
+
     /* Retrieve the assigned interface name. */
     if (getsockopt (fd, SYSPROTO_CONTROL, UTUN_OPT_IFNAME, utunname,
&utunname_len))
         msg (M_ERR | M_ERRNO, "Error retrieving utun interface name");

     tt->actual_name = string_alloc (utunname, NULL);

(I added the " tt->is_utun = false;" just to be sure; I'm not clear on
the initialization of tt->is_utun, and it is used in the test that
follows the call to open_darwin_utun to test for success/failure.)

After making that change, it works on OS X 10.5.8 and 10.4.11.

