Message-ID: <4F0DE05F.1090305@...1114...>
Date: Wed, 11 Jan 2012 20:17:51 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1326290252-25076-1-git-send-email-davids@...1347...>
In-Reply-To: <1326290252-25076-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] autotools ./configure don't like
	compat.h
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/01/12 14:57, David Sommerseth wrote:
> The compat.h include file cannot be loaded when ./configure runs, as
> many of the HAVE_* declarations are not set.  This makes test 
> compilations when looking for features fail.
> 
> As ./configure will load syshead.h, it pulls in compat.h this way. 
> Looking more carefully at syshead.h, there's a #ifndef PACKAGE_NAME 
> check if config.h should be included.  This looks like a check if 
> syshead.h is loaded via ./configure or if it is a more normal 
> compilation.  Moving the compat.h inclusion into this #ifndef block.
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- syshead.h |
> 2 +- 1 files changed, 1 insertions(+), 1 deletions(-)

Applied to master branches on -stable and -testing trees.

commit 330baf2aee70b351cce2d138299118837adbe237
Author: David Sommerseth <davids@...1347...>
Date:   Wed Jan 11 14:52:21 2012 +0100

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8N4F0ACgkQDC186MBRfrrKXACgl9S32mQ5DXHZwuI8VEyykoSm
Hi8AoLF2f1+NEd32qflZIqn4f812CbG3
=6SVX
-----END PGP SIGNATURE-----

