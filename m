Message-ID: <4F7459FF.7090000@...1114...>
Date: Thu, 29 Mar 2012 14:47:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1330446587-5727-1-git-send-email-dejong@...1435...>
In-Reply-To: <1330446587-5727-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fixed off-by-one in serial length
	calculation
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
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/12 17:29, Adriaan de Jong wrote:
> The serial length was one digit too short, resulting in missing
> digits at the end of the certificate's stringified serial number.
> 
> Signed-off-by: Adriaan de Jong <dejong@...1435...> --- 
> ssl_verify_polarssl.c |    2 +- 1 files changed, 1 insertions(+), 1
> deletions(-)
> 

ACK!  Applied to master branches on -testing and -stable git trees.

commit 6a47aa0a975d219c2cddab33dc43f75f983957ca
Author: Adriaan de Jong <dejong@...1435...>
Date:   Tue Feb 28 17:29:47 2012 +0100

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk90Wf8ACgkQDC186MBRfrp9IgCgh7g/eC6/HTuebxZ4HrfWlyUX
JksAn0zCkhJ2z76lNUhh4onVeBa3N5wt
=G7u2
-----END PGP SIGNATURE-----

