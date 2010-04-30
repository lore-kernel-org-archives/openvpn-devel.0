Message-ID: <4BDB4DA0.30104@...1114...>
Date: Fri, 30 Apr 2010 23:37:36 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272268309-15859-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1272268309-15859-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid repetition of "this config may
 cache	passwords in memory" (v2)
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

On 26/04/10 09:51, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> For OpenVPN clients with long living connections, this message is repeated
> everytime the connection is renegotiated.  This patch removes this behaviour
> and will only show this warning once.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  misc.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 

This patch received an ACK on the developers meeting 2010-04-29
<http://thread.gmane.org/gmane.network.openvpn.devel/3673>

Applied to feat_misc and merged into allmerged.
Commit 793e2baffbe8b6cc34570046d9329f8abfd68c77


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvbTaAACgkQDC186MBRfrrkZACgi44P4rcPYDGibCfN/8oR8JlF
CD0AoJ8atZqXJRXcaCyee0CdWZqShH5H
=OWHH
-----END PGP SIGNATURE-----

