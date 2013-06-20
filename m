Message-ID: <51C30AAF.20308@...1227...>
Date: Thu, 20 Jun 2013 15:59:11 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1371718217-12974-1-git-send-email-arne@...1227...>
	<1371719106-17292-1-git-send-email-arne@...1227...>
	<CAEsd45TXXa_X8=k91K9-wwYEdXWYnkJrzCg3dSx=v-dnbONZcw@...278...>
In-Reply-To: <CAEsd45TXXa_X8=k91K9-wwYEdXWYnkJrzCg3dSx=v-dnbONZcw@...278...>
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
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 20.06.13 15:32, schrieb Jonathan K. Bullard:
> A minor problem is that for each of the 255 attempts to get a utun
> device (device #0 through device #254), it generates the following
> warning message:
>      Opening utun (ioctl(CTLIOCGINFO)): No such file or directory
> It's ugly, but cosmetic. Perhaps it could be displayed only at verb=4
> and higher? (I don't know how to do that.)

I have changed the patch to only try to open that once in case of early
initialization failure. I also change the log level to M_INFO.

>
> The larger problem is that it still fails to connect, with the error message:
>      Error retrieving utun interface name: Bad file descriptor (errno=9)
>
> I think this is because open_darwin_utun ignores the error (fd == -1)
> returned from utun_open_helper.
fd == -1 was overloaded in
 - utun failed to open at all
 - this specific utun failed (like utun1, utun2, ....)
>
> If so, it can be fixed by changing open_darwin_utun as follows:
>
>      else
>      {
>          fd = utun_open_helper (ctlInfo, utunnum);
>      }
>
> +    if (fd==-1)
> +       tt->is_utun = false;
> +       return;
> +
>      /* Retrieve the assigned interface name. */
>      if (getsockopt (fd, SYSPROTO_CONTROL, UTUN_OPT_IFNAME, utunname,
> &utunname_len))
>          msg (M_ERR | M_ERRNO, "Error retrieving utun interface name");
>
>      tt->actual_name = string_alloc (utunname, NULL);
>
> (I added the " tt->is_utun = false;" just to be sure; I'm not clear on
> the initialization of tt->is_utun, and it is used in the test that
> follows the call to open_darwin_utun to test for success/failure.)
>
Thanks for spotting this.

Arne

