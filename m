Subject: Re: [Openvpn-devel] Windows and Shaper
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1083184262.10378@...41...>
In-Reply-To: <005901c42ca7$e7226c90$65ecd3d8@...202...>
References: <twig.1083091691.91354@...41...>
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
Date: Wed Apr 28 13:31:09 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Derek Burdick <derek@...201...>, openvpn-devel@lists.sourceforge.net

Derek,

Thanks for the function, I like it better than the previous function which was
using timeGetTime (and therefore has wraparound problems).

I've merged it in test26 which should be released soon.

James

Derek Burdick <derek@...201...> said:

> Here is the function.  Don't forget to #DEFINE HAVE_GETTIMEOFDAY in
> config-win32.h.  Let me know what you think.

> Derek Burdick
> ----- Original Message ----- 
> From: "James Yonan" <jim@...41...>
> To: "Derek Burdick" <derek@...201...>;
> <openvpn-devel@lists.sourceforge.net>
> Sent: Tuesday, April 27, 2004 12:48 PM
> Subject: Re: [Openvpn-devel] Windows and Shaper
> 
> 
> > Derek Burdick <derek@...201...> said:
> >
> > >     I was browsing the online CVS repository and noticed the
> > > config-win32.h.in says that HAVE_GETTIMEOFDAY is specified in misc.c.
> When
> > > I look in misc.c, I don't see the file.  Is the latest version just not
> > > checked in?  I also implemented a gettimeofday for windows.  It is based
> on
> > > QueryPerformanceCounter. If you are interested in this version let me
> know.
> > > If somebody knows the correct status of gettimeofday for the cvs code, I
> > > would appreciate an update.
> >
> > Derek,
> >
> > Yes, I'd like to see your gettimeofday for Windows that uses
> > QueryPerformanceCounter.  OpenVPN 2.0 will have a gettimeofday function
> for
> > Windows so that --shaper and --mode server can be supported.
> >
> > James
> >
> >
> 



-- 




