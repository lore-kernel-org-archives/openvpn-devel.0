Message-ID: <4BCB8753.8010608@...1114...>
Date: Mon, 19 Apr 2010 00:27:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <201004151952.02756.dave_br@...1278...>
In-Reply-To: <201004151952.02756.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Mention mssfix default value in the man
 page
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/04/10 20:52, Davide Brini wrote:
> The man page does not mention that the default value of "mssfix" is 1450.
> 
> --- openvpn-2.1.1/openvpn.8     2010-02-28 22:17:45.000000000 +0000
> +++ openvpn-2.1.1-a/openvpn.8   2010-04-15 19:43:53.000000000 +0100
> @@ -1223,7 +1223,8 @@ their send packet sizes such that after
>  the resulting UDP packet size that OpenVPN sends to its peer will not
>  exceed
>  .B max
> -bytes.
> +bytes. The default value is
> +.B 1450.
> 
>  The
>  .B max

ACK.

Added as commit 38025abb47f74363c3ee87ca7265e99a4055459e to bugfix2.1
and merged into allmerged.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvLh1MACgkQDC186MBRfro4qwCfbNYIFyLe1b5jyxrKuo32Zgoh
DAgAnRaxn8RUfls7G6gFE/E+t/VYJetS
=bP2r
-----END PGP SIGNATURE-----

