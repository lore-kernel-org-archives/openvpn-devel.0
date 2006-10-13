Date: Fri, 13 Oct 2006 08:03:29 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20061013060329.GA20080@...33...>
References: <200610111319.43536.uberlord@...594...>
MIME-Version: 1.0
In-Reply-To: <200610111319.43536.uberlord@...594...>
Subject: Re: [Openvpn-devel] [PATCH] Use PAM correctly
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 11 Oct 2006, Roy Marples wrote:

> openvpn pam plugin does not use PAM correctly. Namely it requires a private 
> LinuxPAM header and links using -ldl which is Linux only.

To top this off, someone would have to rewrite the Makefile so that it
works with POSIX makes, too, and not just GNU make as it is now.

> This enables openvpn pam plugin to compile correctly on default LinuxPAM and 
> OpenPAM installs.

We've needed to do the equivalent for the FreeBSD port, Michael Helmeste
was so kind as to make me aware of the issue and this possible solution.

IOW, if you're installing on FreeBSD, use the official port in version
2.0.6_4 and all this is automatic - no 2.0.9 port needed since all fixes
since then were relevant for Windoze and we don't need to toss hundreds
of MBytes around for no good.

-- 
Matthias Andree

