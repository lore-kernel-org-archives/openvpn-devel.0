Message-ID: <4EA54043.9000404@...1114...>
Date: Mon, 24 Oct 2011 12:38:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1319445962-21686-1-git-send-email-dejong@...1435...>
	<1319445962-21686-2-git-send-email-dejong@...1435...>
In-Reply-To: <1319445962-21686-2-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Fixed disabling crypto and SSL
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

On 24/10/11 10:46, Adriaan de Jong wrote:
> Signed-off-by: Adriaan de Jong <dejong@...1435...> --- Makefile.am
> |   23 ++++++++--------------- configure.ac          |    2 -- 
> crypto_openssl.c      |    4 ++++ crypto_polarssl.c     |    4 ++++ 
> options.h             |    2 +- pkcs11_openssl.c      |    4 ++-- 
> pkcs11_polarssl.c     |    4 ++-- ssl_openssl.c         |    5 +++++ 
> ssl_polarssl.c        |    5 +++++ ssl_verify.c          |    4 ++++ 
> ssl_verify_openssl.c  |    6 ++++++ ssl_verify_polarssl.c |    6
> ++++++ 12 files changed, 47 insertions(+), 22 deletions(-)
> 

ACK!

I've tried this on master, configuring with all combinations of
- --disable-crypto and --disable-ssl ... and all compiled for me without
any issues now.  Pushed to master branch on -testing and -stable.


commit 31ea2ee4ca642a4d8bbdac3dadb44eca11f52e35
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Oct 24 10:46:01 2011 +0200

    Fixed disabling crypto and SSL

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6lQEAACgkQDC186MBRfrp3YwCfaglxEXMbvjLx+2wt7gpWghl/
SG4AoINQiI7emZn8ra5JqRMJu5XnAwGd
=3tgB
-----END PGP SIGNATURE-----

