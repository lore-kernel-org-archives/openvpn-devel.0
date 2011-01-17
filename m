Message-ID: <4D34B911.6000700@...68...>
Date: Mon, 17 Jan 2011 22:48:01 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <20110117213043.GH12114@...1296...>
In-Reply-To: <20110117213043.GH12114@...1296...>
Subject: Re: [Openvpn-devel] configure not finding lzo (Solaris, NetBSD)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 17.01.2011 22:30, schrieb Gert Doering:

> since there's folks on this list that understand configure way better
> than I do...
> 
> Building OpenVPN on Solaris and on NetBSD fails "as is" because configure
> does not find the lzo headers and library.
> 
> On NetBSD, these are (usually) installed by pkgsrc, and live in
> /usr/pkg/include and /usr/pkg/lib.

There would surely be a pkgsrc package that passes the proper CPPFLAGS/LDFLAGS.
ftp://ftp.netbsd.org/pub/pkgsrc/current/pkgsrc/net/openvpn/README.html

> On Solaris, if installed "from the source", the LZO stuff lives in
> /usr/local/include and /usr/local/lib (same place the libraries would
> end up on NetBSD if installed manually, not from pkgsrc).

Unless you install from Blastware, or Sunfreeware, or Pkgsrc, or OpenPKG, or...
(you name it) -- each with its own default directories.

> "Other packages" don't seem to have problems finding libraries in 
> "the usual places for this operating system", even if it's not plain
> /usr/include + /usr/lib.
> 
> So - should this be fixed?  If yes, what's the "right" way to get it
> fixed?

Same story on FreeBSD.  Should be fixed, but those fixes likely belong into
autoconf proper, rather than each and every package that uses autoconf.  Such
workarounds don't belong into OpenVPN.

Until that time, passing CPPFLAGS and LDFLAGS on the ./configure command line
like ./configure CPPFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib would do
the trick.

-- 
Matthias Andree

