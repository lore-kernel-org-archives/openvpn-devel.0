Message-ID: <4E54F53E.2040001@...1114...>
Date: Wed, 24 Aug 2011 14:57:34 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1313662581-30181-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1313662581-30181-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] remove function is_proto_tcp()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/08/11 12:16, Heiko Hund wrote:
| The implementation of is_proto_tcp() was invalid since the IPv6 stuff got
| merged into master. There's proto_is_tcp() that does the same job right.
|
| Remove is_proto_tcp() and make its only caller use proto_is_tcp() instead.
|
| Signed-off-by: Heiko Hund<heiko.hund@...1489...>

Applied to testing and stable master branches.

commit 834eba7597e2582c44f69e03a762b838308c8df0


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk5U9T4ACgkQDC186MBRfrrFjwCfYEujAn3CRSQGvbxGTV4BK712
nG0Anj+Fpt0GSML97nf104WVnvMVVdbA
=EYty
-----END PGP SIGNATURE-----

