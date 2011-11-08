Message-ID: <4EB9549B.2020104@...1114...>
Date: Tue, 08 Nov 2011 17:11:07 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1319439215-4363-1-git-send-email-davids@...1347...>
In-Reply-To: <1319439215-4363-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix PolarSSL and --pkcs12 option
	issues
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

On 24/10/11 08:53, David Sommerseth wrote:
> PolarSSL does not support PKCS#12 certificate/key bundles, but had a 
> typo where #ifdef USE_POLARSSL was used, and it should have been 
> #ifndef instead.
> 
> Also added a few extra exclusions of PKCS#12 messages where 
> appropriate, to avoid confusing users.
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- options.c | 8
> +++++++- 1 files changed, 7 insertions(+), 1 deletions(-)
> 

ACKed on IRC by Adriaan.  Pushed to -testing and -stable master branches.

commit 93ee3932aaaa806dddbc1524515f45837d94aa8f
Author: David Sommerseth <davids@...1347...>
Date:   Mon Oct 24 08:53:35 2011 +0200

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Adriaan de Jong <dejong@...1435...>



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk65VJsACgkQDC186MBRfrpuWgCglI5KRkZs3JEM7t6Sc0RuI4tK
1jEAniQhputcBRZGriFxYyUxE+JMM/ex
=51xX
-----END PGP SIGNATURE-----

