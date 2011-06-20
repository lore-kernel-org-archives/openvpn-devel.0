Message-ID: <4DFF127B.1060006@...1114...>
Date: Mon, 20 Jun 2011 11:27:23 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1308302282-27985-1-git-send-email-samuli@...515...>
	<1308556181-20317-1-git-send-email-samuli@...515...>
In-Reply-To: <1308556181-20317-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Add new openssl.cnf to easy-rsa/Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/06/11 09:49, samuli@...515... wrote:
> From: Samuli Seppänen <samuli@...515...>
> 
> This is required for patch "Fix a build-ca issue on Windows" to work
> ---
>  easy-rsa/Windows/openssl.cnf |  350 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 350 insertions(+), 0 deletions(-)
>  create mode 100644 easy-rsa/Windows/openssl.cnf

ACK.  Applied to master and release/2.2

I see that 'extendedKeyUsage=serverAuth' is not set. I am not 100% sure if
that is needed or not, or just "nice to have".  This was mentioned in Trac
ticket #125 [1]. So I'm accepting the openssl.cnf patch as it is now, and
we can rather fix this attribute later on if it is not enough.

commit 663860ad04dd4190fddbee63e724d3fdceafd937 (master)
commit 6989cbde616a00380acf3a390959987765a5325b (release/2.2)
Author: Samuli Seppänen <samuli@...515...>
Date:   Mon Jun 20 10:49:41 2011 +0300

    Add new openssl.cnf to easy-rsa/Windows

    This is required for patch "Fix a build-ca issue on Windows" to work

    Signed-off-by: Samuli Seppänen <samuli@...515...>
    Acked-by: David Sommerseth <davids@...1347...>


Kind regards,

David Sommerseth


[1] <https://community.openvpn.net/openvpn/ticket/125>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3/EnsACgkQDC186MBRfroPsQCfT6am6MJsmzhaNtWEOWfs0PFp
KyMAn1M3ljU1cf6BWgL/8rraB0IBrh4O
=VmQ8
-----END PGP SIGNATURE-----

