Message-ID: <004a01c429d1$91f7b410$0a0aef0a@...202...>
From: "Derek Burdick" <derek@...201...>
References: <001b01c429d0$434a0f80$0a0aef0a@...202...>
Subject: Re: [Openvpn-devel] Windows and Shaper
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
Date: Sat Apr 24 00:58:09 2004
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I was greping the wrong directory.  I found the windows implementation of
gettimeofday in otime.c, contrary to the config-win32.h.  Thanks!

Derek Burdick
----- Original Message ----- 
From: "Derek Burdick" <derek@...201...>
To: <openvpn-devel@lists.sourceforge.net>
Sent: Saturday, April 24, 2004 1:46 AM
Subject: [Openvpn-devel] Windows and Shaper


>     I was browsing the online CVS repository and noticed the
> config-win32.h.in says that HAVE_GETTIMEOFDAY is specified in misc.c.
When
> I look in misc.c, I don't see the file.  Is the latest version just not
> checked in?  I also implemented a gettimeofday for windows.  It is based
on
> QueryPerformanceCounter. If you are interested in this version let me
know.
> If somebody knows the correct status of gettimeofday for the cvs code, I
> would appreciate an update.
>
> Thanks,
>     Derek Burdick
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


