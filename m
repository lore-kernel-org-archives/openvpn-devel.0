Message-ID: <4F1406EA.7030709@...1114...>
Date: Mon, 16 Jan 2012 12:15:54 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1326709901-16246-1-git-send-email-davids@...1347...>
	<1326711858-18337-1-git-send-email-davids@...1347...>
In-Reply-To: <1326711858-18337-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] Don't check for file presence on
 inline files
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

On 16/01/12 12:04, David Sommerseth wrote:
> The configuration file supports inline files for --ca, --cert, --dh, 
> --extra-certs, --key, --pkcs12, --secret and --tls-auth.  When this
> is used, the filename is set to [[INLINE]] (defined by
> INLINE_FILE_TAG).
> 
> If the filename is set to INLINE_FILE_TAG for these options, don't 
> call check_file_access().
> 
> [v2 Simplify the code, using a flag to check_file_access()]
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- options.c | 23
> +++++++++++++++-------- 1 files changed, 15 insertions(+), 8 
> deletions(-)

Applied to master on -testing and -stable trees.

commit 06e781f885125b05de0a731743acd90d4492a435
Author: David Sommerseth <davids@...1347...>
Date:   Mon Jan 16 12:00:33 2012 +0100

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8UBugACgkQDC186MBRfrp8cwCfT8dwBmDTEnctTskfPZKCupxF
/LkAnA3Yo850ws19VLT0380fJbwI+GhX
=TeDU
-----END PGP SIGNATURE-----

