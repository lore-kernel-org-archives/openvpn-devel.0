Message-ID: <4C6AE952.6040905@...1114...>
Date: Tue, 17 Aug 2010 21:56:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B7EB12E.5000405@...1114...>
	<loom.20100716T203449-26@...171...>
In-Reply-To: <loom.20100716T203449-26@...171...>
Subject: Re: [Openvpn-devel] Compiler warnings when using openssl-1.0.0 -
 beta4
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
To: chantra <chantra@...1258...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/07/10 20:36, chantra wrote:
> 
>>
>> If nobody responds, I'll try to find some time looking into this in the
>> near future.
>>
> 
> I did in https://community.openvpn.net/openvpn/ticket/5#comment:3
> 
> chantra

ACK

I've smoke tested this on two 32bit boxes using openssl-0.9.8* - both as
OpenVPN server and client, to make sure this patch is backwards
compatible.  Likewise, generic quick tests have been done on a 64bit box
using openssl-1.0.0.  Testing seems to work very fine.

commit db3fb3d489df234c78ddcb9fce66de4d8fbb28e6
Author: chantra <chantra@...1258...>
Date:   Fri Jul 16 20:09:07 2010 +0200
    Fixes openssl-1.0.0 compilation warning

    When compiling against OpenSSL v1.0.0, the following compiler
    warnings appears.

    [...snip...comiler warning...]

    Trac ticket #5
    https://community.openvpn.net/openvpn/ticket/5

    Signed-off-by: chantra <chantra@...1258...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>

Applied to bugfix2.1, merged into allmerged and beta2.2.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxq6VIACgkQDC186MBRfrp0BACfREpGZjOD0X4jC5oY+IM4Q7Bo
8FcAn3PAUDfbxZ4XpvRkovH+bn9c95gb
=JtjU
-----END PGP SIGNATURE-----

