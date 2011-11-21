Message-ID: <4ECA44A7.5070107@...1114...>
Date: Mon, 21 Nov 2011 13:31:35 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1321876765-16500-1-git-send-email-davids@...1347...>
In-Reply-To: <1321876765-16500-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix FreeBSD/OpenBSD/NetBSD compiler
 warnings in get_default_gateway()
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

On 21/11/11 12:59, David Sommerseth wrote:
> On these platforms (including DragonFly), get_default_gateway() would 
> in some cases return false.  As get_default_gateway() is defined as a 
> void function, and none of the callers expect a return value -> just 
> return without any value.
> 
> Signed-off-by: David Sommerseth <davids@...1347...>

Applied to -testing and -stable master branches

commit 93626f2cf71b4803aa1248a928bfc1ac8c9da18b
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7KRKUACgkQDC186MBRfroGogCggUMfWYvTxmiiOBRyp+/FcGSL
lJAAn3Z79b24KQazk/Rw+7fKKKMe0xmu
=MdL+
-----END PGP SIGNATURE-----

