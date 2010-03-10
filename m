Message-ID: <4B978D0E.9090606@...1114...>
Date: Wed, 10 Mar 2010 13:14:06 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
 not	defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/03/10 11:49, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> This is to include peercred support on hosts where _GNU_SOURCE is not
> defined by default.  This issue has been found on Gentoo with glibc-2.8.
> 
> The solution was discussed on the IRC meeting March 4, 2010
> in #openvpn-discussions.
> <http://thread.gmane.org/gmane.network.openvpn.devel/3242>
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  syshead.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 

This is the "Gentoo patch", modified to be more generic.  In the IRC
meeting I said I would try to make this change only in socket.c, but
that was not possible.

TARGET_LINUX is defined in config.h, and not available before syshead.h
is included, as that is a wrapper which either includes config.h or
config-win32.h, depending on OS.  Further defining _GNU_SOURCE after
including syshead.h would not make any difference at all, as it needs to
be defined before sys/socket.h is loaded.

Therefore, I'd prefer a second review on this patch.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuXjQsACgkQDC186MBRfrorFQCePuxnsCBq3pIcPJ3mG1zZO2Y9
4FAAniyfy82e0vJhep0TUvQeI+7nzZsr
=bTNV
-----END PGP SIGNATURE-----

