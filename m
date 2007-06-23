Date: Sat, 23 Jun 2007 11:32:01 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20070623093201.GA29596@...33...>
References: <20070618214117.GA12194@...438...>
MIME-Version: 1.0
In-Reply-To: <20070618214117.GA12194@...438...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc4 fixes for NetBSD
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

On Mon, 18 Jun 2007, Johnny C. Lam wrote:

> I've attached diff that includes the following changes for NetBSD:
> 
> (1) Teach OpenVPN about NetBSD's tap(4) driver.
> 	(syshead.h, tun.c, config.h.in)
> 
> (2) Fix header detection for <net/if.h> and <net/if_ether.h> in the
>     aftermath of the FreeBSD autoconf changes.  These changes should
>     be neutral for FreeBSD but are necessary for NetBSD.
> 	(configure.ac)

I didn't run extensive tests, but at least on FreeBSD 6.2-RELEASE-p5
i386, the patch doesn't cause compilation or "make check" failures.

-- 
Matthias Andree

