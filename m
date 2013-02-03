Message-ID: <510E77F3.4090603@...1114...>
Date: Sun, 03 Feb 2013 15:45:07 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1358854613-7150-1-git-send-email-heiko.hund@...1489...>
	<1359895812-13871-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1359895812-13871-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCHv2] ignore UTF-8 byte order mark
Reply-To: openvpn-users@lists.sourceforge.net
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
To: openvpn-devel@lists.sourceforge.net, Heiko Hund <heiko.hund@...1489...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/02/13 13:50, Heiko Hund wrote:
> Currently openvpn exits when reading configuration from a file that
> has an UTF-8 byte order mark (EF BB BF) at its start.
> 
> While it is useless to put a BOM into UTF-8 encoded files, the 
> Unicode standard [1] permits it (on page 36):
> 
> "Use of a BOM is neither required nor recommended for UTF-8, but
> may be encountered in contexts where UTF-8 data is converted from
> other encoding forms that use a BOM or where the BOM is used as a
> UTF-8 signature."
> 
> Notepad.exe, the default text editor on Windows, always puts the
> BOM into UTF-8 encoded files when saving them. Others may do as
> well.
> 
> Just ignoring the UTF-8 BOM will make config files with UTF-8 BOM 
> readable.
> 
> [1] http://www.unicode.org/versions/Unicode5.0.0/ch02.pdf
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- 
> src/openvpn/options.c |    6 +++++- 1 file changed, 5
> insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c index
> 8ca41a3..c52b699 100644 --- a/src/openvpn/options.c +++
> b/src/openvpn/options.c @@ -3773,7 +3773,11 @@ read_config_file
> (struct options *options, { CLEAR (p); ++line_num; -	      if
> (parse_line (line, p, SIZE (p), file, line_num, msglevel,
> &options->gc)) +              /* Ignore UTF-8 BOM at start of
> stream */ +              int offset = 0;

Some compilers will complain with int being declared here.  Moving it
up to before the CLEAR (p); line is probably going to work better ...


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEOd/EACgkQDC186MBRfrr9+wCghuv++EJkTlCAb3p0YoLzSkGv
b1YAn3PKYmvfaIZzaYsu3NAXl6m2Dutz
=Fyps
-----END PGP SIGNATURE-----

