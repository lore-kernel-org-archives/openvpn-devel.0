Message-ID: <4B8D78FE.90704@...1114...>
Date: Tue, 02 Mar 2010 21:45:50 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267425265-10612-1-git-send-email-kop@...1206...>
In-Reply-To: <1267425265-10612-1-git-send-email-kop@...1206...>
Subject: Re: [Openvpn-devel] [PATCH] Yet another tweak of openvpn(8)
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

On 01/03/10 07:34, Karl O. Pinc wrote:
> From: Karl O. Pinc <kop@...1304...>
> 
> ---
>  openvpn.8 |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/openvpn.8 b/openvpn.8
> index 9512fc3..70e1e68 100644
> --- a/openvpn.8
> +++ b/openvpn.8
> @@ -4235,8 +4235,8 @@ should return 0 to allow the TLS handshake to proceed, or 1 to fail.
>  
>  Note that
>  .B cmd
> -is a command line and as such may contain arguments separated by
> -whitespace (if enclosed in quotes).  The first word of
> +is a command line and as such may (if enclosed in quotes) contain
> +arguments separated by whitespace.  The first word of
>  .B cmd
>  is the shell command to execute and the remaining words are its
>  arguments.

Applied to the feat_misc branch, to be merged into allmerged.
Commit 87afefff8fe7b43b2c5cbba7a03a887fd9c02336


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuNeP4ACgkQDC186MBRfrrpIACfeEixXYP4fBXRe1daBemh+Bcf
1FUAn0OWzEcrrsUjJ00+CIHJpJdI/+qv
=CGim
-----END PGP SIGNATURE-----

