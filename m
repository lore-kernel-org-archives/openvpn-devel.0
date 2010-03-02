Message-ID: <4B8D790E.1070305@...1114...>
Date: Tue, 02 Mar 2010 21:46:06 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267422537-10119-1-git-send-email-kop@...1206...>
In-Reply-To: <1267422537-10119-1-git-send-email-kop@...1206...>
Subject: Re: [Openvpn-devel] [PATCH] More improvments to openvpn(8)
	--tls-verify
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

On 01/03/10 06:48, Karl O. Pinc wrote:
> From: Karl O. Pinc <kop@...1304...>
> 
> ---
>  openvpn.8 |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/openvpn.8 b/openvpn.8
> index 0150ba7..9512fc3 100644
> --- a/openvpn.8
> +++ b/openvpn.8
> @@ -4235,14 +4235,14 @@ should return 0 to allow the TLS handshake to proceed, or 1 to fail.
>  
>  Note that
>  .B cmd
> -may contain whitespace (if enclosed in quotes), in which case the first
> -word of
> +is a command line and as such may contain arguments separated by
> +whitespace (if enclosed in quotes).  The first word of
>  .B cmd
>  is the shell command to execute and the remaining words are its
>  arguments.
>  When
>  .B cmd
> -is executed it is passed two (additional) arguments, as follows:
> +is executed two arguments are appended, as follows:
>  
>  .B cmd certificate_depth X509_NAME_oneline
>  

Applied to the feat_misc branch, to be merged into allmerged.
Commit 87afefff8fe7b43b2c5cbba7a03a887fd9c02336


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuNeQ4ACgkQDC186MBRfroUdgCeJ3cBers6QOjQwV9K/aR5qFYj
GesAn0mBqpQsYtUG/Mu4DmgurTYRMtoi
=eruJ
-----END PGP SIGNATURE-----

