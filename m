Message-ID: <4B8D7922.9030205@...1114...>
Date: Tue, 02 Mar 2010 21:46:26 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267421466-9788-1-git-send-email-kop@...1206...>
In-Reply-To: <1267421466-9788-1-git-send-email-kop@...1206...>
Subject: Re: [Openvpn-devel] [PATCH] Frob the openvpn(8) man page tls-verify
 section to clarify
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/10 06:31, Karl O. Pinc wrote:
> From: Karl O. Pinc <kop@...1304...>
> 
> ---
>  openvpn.8 |   22 +++++++++++++---------
>  1 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/openvpn.8 b/openvpn.8
> index f1612a7..0150ba7 100644
> --- a/openvpn.8
> +++ b/openvpn.8
> @@ -4232,11 +4232,23 @@ test).
>  
>  .B cmd
>  should return 0 to allow the TLS handshake to proceed, or 1 to fail.
> +
> +Note that
> +.B cmd
> +may contain whitespace (if enclosed in quotes), in which case the first
> +word of
> +.B cmd
> +is the shell command to execute and the remaining words are its
> +arguments.
> +When
>  .B cmd
> -is executed as
> +is executed it is passed two (additional) arguments, as follows:
>  
>  .B cmd certificate_depth X509_NAME_oneline
>  
> +These arguments are, respectively, the current certificate depth and
> +the X509 common name (cn) of the peer.
> +
>  This feature is useful if the peer you want to trust has a certificate
>  which was signed by a certificate authority who also signed many
>  other certificates, where you don't necessarily want to trust all of them,
> @@ -4250,14 +4262,6 @@ in the OpenVPN distribution.
>  
>  See the "Environmental Variables" section below for
>  additional parameters passed as environmental variables.
> -
> -Note that
> -.B cmd
> -can be a shell command with multiple arguments, in which
> -case all OpenVPN-generated arguments will be appended
> -to
> -.B cmd
> -to build a command line which will be passed to the script.
>  .\"*********************************************************
>  .TP
>  .B --tls-remote name


Applied to the feat_misc branch, to be merged into allmerged.
Commit 87afefff8fe7b43b2c5cbba7a03a887fd9c02336


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuNeSIACgkQDC186MBRfrpQ8gCaAgcQzeBkUQ6gxEi0SqRy/rxT
XboAn3QVnkJ94Q2TLBCNfuRLQL660Dm5
=0x96
-----END PGP SIGNATURE-----

