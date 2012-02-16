Message-ID: <4F3D1030.4000408@...1114...>
Date: Thu, 16 Feb 2012 15:18:24 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CB62CAA7.E8F%brabander@...1435...>
In-Reply-To: <CB62CAA7.E8F%brabander@...1435...>
Subject: Re: [Openvpn-devel] Cipher problem on Mac OS X
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

On 16/02/12 15:00, Frank de Brabander wrote:
> Sorry, patch format got broken in previous email. Hope this works
> better.

No worries, patches is tricky in quite some MUAs.

Anyhow, patch is applied to master on -testing and -stable trees.

commit 6449a149f850e9e1207233f3ca642d9342fbfbaf
Author: Frank de Brabander <brabander@...1435...>
Date:   Thu Feb 16 13:51:04 2012 +0100

    Fixed wrong return type of cipher_kt_mode

    The cipher_kt_mode uses bool as return type, this should be int. On
    some platforms like OS X, any returned value larger than one will
    be converted to 1.

    Signed-off-by: Frank de Brabander <brabander@...1435...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: David Sommerseth <davids@...1347...>


Kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk89EC4ACgkQDC186MBRfrpLNgCcDo+3ZRWi5T62iUZVEjaVOsBH
+cIAoKQbItKZqgR+f372PCqCy8Fuo3ia
=pey+
-----END PGP SIGNATURE-----

