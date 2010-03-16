Message-ID: <4B9FFDAD.6070103@...1114...>
Date: Tue, 16 Mar 2010 22:52:45 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B8C11ED.6000605@...1114...>
In-Reply-To: <4B8C11ED.6000605@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] The man page needs dash escaping in
 UTF-8 environments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net, Jan Brinkmann <the-luckyduck@...384...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/10 20:13, David Sommerseth wrote:
> From: Jan Brinkmann <the-luckyduck@...384...>
> 
> There was a debian bugreport which was filed in 2005 . It was patched but
> it seems that nobody forwarded the patch to the openvpn project itself.
> 
> The problem is quite simple:
> The dashes for options (the double dashes) are not escaped. This causes
> trouble in relationship with utf-8 .
> 
> Since the bugreport was closed it was patched within the debian/ubuntu
> packages itself. I've attached the patch to get it atleast reviewed by the
> openvpn project itself.
> 
> See <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=296133> for details.
> 
> sf.net tracker:
> <https://sourceforge.net/tracker/?func=detail&aid=2935611&group_id=48978&atid=454721>
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  openvpn.8 | 1612
> ++++++++++++++++++++++++++++++------------------------------
>  1 files changed, 806 insertions(+), 806 deletions(-)
> 

Applied to the bugfix2.1 branch, merged into allmerged.
Commit 54283b9c6acac245f96c611e82f6a9049d694294


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuf/a0ACgkQDC186MBRfroybACfRsQXqQvU6seA4OMTvlfs++VP
ErQAn3Hd4VDW0LxSVwAB7E22LYjmZi0Y
=TwdF
-----END PGP SIGNATURE-----

