Message-ID: <4DFF165D.7070501@...1114...>
Date: Mon, 20 Jun 2011 11:43:57 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1308302282-27985-1-git-send-email-samuli@...515...>	<1308556181-20317-1-git-send-email-samuli@...515...>
	<4DFF127B.1060006@...1114...> <4DFF1488.4040509@...1147...>
In-Reply-To: <4DFF1488.4040509@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Add new openssl.cnf to easy-rsa/Windows
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/06/11 11:36, Jan Just Keijser wrote:
> NACK on this patch - the openssl.cnf file should be (almost) the same as
> the one used in easy-rsa/2.0
> that way the certificates are generated in the same manner (*with*
> EKU=ServerAuth)
> 

Okay, I'll revert commit 663860ad04dd4190fddbee63e724d3fdceafd937 (master)
and 6989cbde616a00380acf3a390959987765a5325b (release/2.2) immediately.

Samuli, can you please look closer into this?  I did a more careful diff
from 2.0/openssl.cnf and Windows/openssl.cnf ... and it seems quite
different.  Can we please unite them?

JJK: Do you know which differences are needed between Windows and non-Windows?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3/Fl0ACgkQDC186MBRfrpmVwCeMIIaJNAzihq7SSHJ3BQdxMoW
/ioAoKbAENB4uekWYa0LCWmj1/ZM3TNm
=LrKg
-----END PGP SIGNATURE-----

