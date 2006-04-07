From: Roy Marples <uberlord@...594...>
Subject: Re: [Openvpn-devel] Re: [PATCH] Enable compliation under Darwin
References: <200604051130.00196.uberlord@...594...> <4433CAD4.50807@...601...>
In-Reply-To: <4433CAD4.50807@...601...>
MIME-Version: 1.0
Message-Id: <200604072046.49104.uberlord@...594...>
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
Date: Fri Apr  7 12:47:05 2006
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wednesday 05 April 2006 14:49, Johnny Lam wrote:
> According to the Fink porting documents[1], this is not the right way to
> link loadable modules on Mac OS X.  The module should properly end with
> ".so", and the compiler flags should include "-bundle" and not
> "-dynamiclib", which should only be used when linking a shared library.
>
> [1] http://fink.sf.net/doc/porting/shared.php?phpLang=en#lib-and-mod
>
> 	Cheers,
>
> 	-- Johnny Lam <jlam@...601...>

I've forward this to our ppc-macos team. Their initial response was that the 
document is out of date, but they'll get back with a definite answer.

Thanks

-- 
Roy Marples <uberlord@...594...>
Gentoo Linux Developer

