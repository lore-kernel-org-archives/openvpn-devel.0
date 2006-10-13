From: Roy Marples <uberlord@...594...>
Date: Fri, 13 Oct 2006 10:47:00 +0100
References: <200610111319.43536.uberlord@...594...>
	<20061013060329.GA20080@...33...>
In-Reply-To: <20061013060329.GA20080@...33...>
MIME-Version: 1.0
Message-Id: <200610131047.00733.uberlord@...594...>
Subject: Re: [Openvpn-devel] [PATCH] Use PAM correctly
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Friday 13 October 2006 07:03, Matthias Andree wrote:
> We've needed to do the equivalent for the FreeBSD port, Michael Helmeste
> was so kind as to make me aware of the issue and this possible solution.
>
> IOW, if you're installing on FreeBSD, use the official port in version
> 2.0.6_4 and all this is automatic - no 2.0.9 port needed since all fixes
> since then were relevant for Windoze and we don't need to toss hundreds
> of MBytes around for no good.

I made that patch using Gentoo/FreeBSD on Sparc64 :P (currently cursing BSD 
devs for using __sparc64__ define in their code)

Gentoo enforces gmake being present on the system as it's predominately Linux, 
so the makefile wasn't an issue for us.

Thanks

-- 
Roy Marples <uberlord@...594...>
Gentoo/Linux/FreeBSD Developer (baselayout, networking)

