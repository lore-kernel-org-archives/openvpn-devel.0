Message-ID: <4DB080B3.9070901@...1114...>
Date: Thu, 21 Apr 2011 21:08:35 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1303411629-8344-1-git-send-email-davids@...1347...>
In-Reply-To: <1303411629-8344-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Improve the mysprintf() issue
	in	openvpnserv.c
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/04/11 20:47, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
>
> A quick and dirty compile fix was introduced in commit 77d244050964525417,
> and was accepted under the condition that it would be a temporary fix.
>
> As the usage of _snprintf() is realy not ideal on Windows, this patch
> uses the same well tested openvpn_snprintf() function from buffer.c.
> It was a longer discussion of several possibilities to re-use that code,
> but in the end it seemed easier to just copy-paste this function to
> openvpnserv.c for now.
>
> The reason for this conclusion was that the function is really simple,
> well defined and will most likely not be changed much in the future.
> It is also added a comment in openvpnserv.c where this function
> has its origins.
>
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  service-win32/openvpnserv.c |   39 ++++++++++++++++++++++++++++-----------
>  1 files changed, 28 insertions(+), 11 deletions(-)

ACKed by James Yonan on IRC 2011-04-11 18:51 UTC:

<dazo> jamesyonan: do you have time to have a look at this patch?  and ACK
it if you agree ... <http://thread.gmane.org/gmane.network.openvpn.devel/4621>
<jamesyonan> looking at it now...
<jamesyonan> dazo: sure, looks fine

Applied to master and cherry-picked to beta2.2.

commit 47dd9a4d7b2930f6e1b5d6f0ce0c154efc87ac29 (beta2.2)
commit df5a4380c3931520d5fae2b18f0fc2e67a883aae (master)
Author: David Sommerseth <dazo@...384...>
Date:   Thu Apr 21 20:32:26 2011 +0200

    Improve the mysprintf() issue in openvpnserv.c

    Signed-off-by: David Sommerseth <dazo@...384...>
    Acked-by: James Yonan <james@...515...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2wgLMACgkQDC186MBRfrpHowCgnEQbjP2foyBbNtHcxULaVd4B
MzEAn02/K92yp6ujE3d39gLpngghV7YG
=jMRx
-----END PGP SIGNATURE-----

