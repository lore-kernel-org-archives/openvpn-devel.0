Message-ID: <4C5B0D5D.5050403@...1114...>
Date: Thu, 05 Aug 2010 21:13:33 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1280745707.15672.19.camel@...1259...>
In-Reply-To: <1280745707.15672.19.camel@...1259...>
Subject: Re: [Openvpn-devel] [Patch] Typo in openvpn plugin documentation
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
To: chantra <chantra@...1258...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/08/10 12:41, chantra wrote:
> Hi all,
> 
> I have found some inconsistency in openvpn-plugin.h documentation, see
> https://community.openvpn.net/openvpn/ticket/31
> 
> It is a pretty trivial change which only affect documentation so it is
> safe to apply.
> 
> chantra
> 

Applied to bugfix2.1 and merged into allmerged.

commit e249bff0288cf0581d7263ee14c21300976bb3cc
Author: chantra <chantra@...1258...>
Date:   Fri Jul 30 20:48:50 2010 +0200

    Fix errors in openvpn-plugin.h documentation

    Just minor updates to comments in openvpn-plugin.h

    Signed-off-by: chantra <chantra@...1258...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxbDV0ACgkQDC186MBRfrrQQQCgnpE0HRNdhRXbGlM8OmHXYtyf
N4YAnRmFV6wLeQMgEyL/kRoDmgMsVcV7
=BWhS
-----END PGP SIGNATURE-----

