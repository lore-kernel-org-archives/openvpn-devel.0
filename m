Message-ID: <4BD6FCAF.9090303@...1114...>
Date: Tue, 27 Apr 2010 17:03:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BD56520.9070807@...1114...>
	<1272367205-1912-1-git-send-email-dave_br@...1278...>
In-Reply-To: <1272367205-1912-1-git-send-email-dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Serial number export, better
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 27/04/10 13:20, Davide Brini wrote:
>     contrib/OCSP_check/OCSP_check.sh:
>              New barebone script to demonstrate how to use $tls_serial_{n}
>              to perform simple OCSP queries using OpenSSL command line
>              "openssl ocsp". Minimal sanity checks to fail if user tries to
>              use it without customizing.
> 
>     openvpn.8:
>              Added some notes about $tls_serial_{n} format and usage to the
>              existing description.
> 
>     ssl.c:
>              correctly manage and export serial numbers of any size (as
>              parsed by OpenSSL) into the environment. Set to empty string
>              in case of errors, as 0 and negative numbers are all possible
>              (although illegal) certificate serial numbers. Use an OpenSSL
>              BIO object to do the job. Conforms to coding style guidelines.
> 
>     See the discussion at
> 
>     http://article.gmane.org/gmane.network.openvpn.devel/3588
> 
>     for more details.
> 
> Signed-off-by: Davide Brini <dave_br@...1278...>
> ---
>  contrib/OCSP_check/OCSP_check.sh |   89 ++++++++++++++++++++++++++++++++++++++
>  openvpn.8                        |    7 +++-
>  ssl.c                            |   27 ++++++++++-
>  3 files changed, 119 insertions(+), 4 deletions(-)
>  create mode 100644 contrib/OCSP_check/OCSP_check.sh
> 

ACK!  This is looking good!  I've put it into my work queue and will try
to get time sometime this week to get it into the bugfix2.1 branch.

Thanks a lot for your hard work on this one!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvW/KwACgkQDC186MBRfrqUNACfRKjQww+GT1Pf3whbN5a8xr04
2hEAn2p0z1jg9nWYfg7oadIEFWkk5tgD
=juOA
-----END PGP SIGNATURE-----

