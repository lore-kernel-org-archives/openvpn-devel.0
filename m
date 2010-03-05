Date: Fri, 5 Mar 2010 10:11:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100305091151.GI25238@...1296...>
References: <20100228145001.GM9556@...1296...>
	<201003050942.23706.hhund@...194...>
Mime-Version: 1.0
In-Reply-To: <201003050942.23706.hhund@...194...>
Subject: Re: [Openvpn-devel] special-case code for OpenBSD - advice needed
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
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Mar 05, 2010 at 09:42:23AM +0100, Heiko Hund wrote:
> On Sunday 28 February 2010 15:50:01 Gert Doering wrote:
> > Now, for all operatings systems *except* Win32 and OpenBSD, the sequence
> > of execution is
> > 
> >  open_tun()
> >  do_ifconfig()
> 
> That seems to make sense for OpenBSD. I just had a colleague (kudos Moritz) 
> try to connect with ifconfig_order() changed to
> 
>  static inline int
>  ifconfig_order(void)
>  {
>  #if defined(WIN32)
>    return IFCONFIG_BEFORE_TUN_OPEN;
>  #else
>    return IFCONFIG_AFTER_TUN_OPEN;
>  #endif
>  }
> 
> and it broke the tunnel.

OK, this is interesting, and thanks a lot for testing.  

What happened exactly?  Could you ask your colleague for a log file?

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

