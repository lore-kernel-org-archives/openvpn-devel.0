Message-ID: <4EE0033C.9050403@...1114...>
Date: Thu, 08 Dec 2011 01:22:20 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1322840064-30528-1-git-send-email-davids@...1347...>
In-Reply-To: <1322840064-30528-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Don't look for 'stdin' file when using
 --auth-user-pass
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/12/11 16:34, David Sommerseth wrote:
> This argument allows the keyword 'stdin' to indicate that the input is
> to be read from the stdin.  Don't check for file existence if the file
> name is set to 'stdin'
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- options.c |
> 5 +++-- 1 files changed, 3 insertions(+), 2 deletions(-)
> 

Applied and pushed out to -testing and -stable master branches.

commit 870cf166add7ea0aa15c9d12b7916e669a9f441f
Author: David Sommerseth <davids@...1347...>
Date:   Fri Dec 2 16:32:56 2011 +0100

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7gAzoACgkQDC186MBRfrrEZACfdekwNa5Vkxx68fMvnLD75+v0
FkQAn0FjLR5Pihduhva/oPuVzQhratnL
=Zui4
-----END PGP SIGNATURE-----

