From: "dave" <dev@...575...>
Date: Wed, 8 Apr 2009 07:58:12 -0500
Message-ID: <F9B005F620B74BD29BB0A36AF509BCED@...576...>
MIME-Version: 1.0
In-Reply-To: <1239166995l.18482l.9l@...1207...>
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
	building 2.1 rc15 on Windows XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Karl O. Pinc'" <kop@...1206...>, openvpn-devel@lists.sourceforge.net

> -----Original Message-----
> From: Karl O. Pinc [mailto:kop@...1206...] 
...
> I suspect that what I want is exactly what OpenVPN already has at
> http://openvpn.net/prebuilt/.  The problem is that it's not
> labeled as such and does not seem to have the same "supported"
...
> So I guess what I'm asking is for this build to be documented
> and placed on the download page with the rest of the
> official downloads.  (Assuming I can just run
> install-win32/buildinstaller and have an installer
> produced.)
...

I'm pretty sure you can setup MinGW to build on Linux, though I haven't.

Agreed on the binary tarball, but brace yourself:  the source tarball is
not always up-to-date to the current version either.  I've experienced
that many times when building for OpenWRT.  If you really want the
current source or for a specific version you may have to pull from
repository.

-Dave


