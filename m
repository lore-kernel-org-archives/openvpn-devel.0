Message-ID: <4FA235B8.6010901@...1114...>
Date: Thu, 03 May 2012 09:37:28 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1335981252-7390-1-git-send-email-davids@...1347...>
In-Reply-To: <1335981252-7390-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Simplify check_cmd_access() function
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

On 02/05/12 19:54, David Sommerseth wrote:
> To avoid confusion between check_file_access() and
> check_cmd_access() in the future, remove unneeded arguments from
> check_cmd_access()
> 
> As a command will always be a file, it should always check for
> CHKACC_FILE and nothing else.  And as the commands always will need
> X_OK, check only for that.
> 
> One change from earlier behaviour is that R_OK is not checked for.
> The reason is that only scripts require R_OK to work.  However, a
> system might be installed with binaries with only X_OK set.  If a
> script is missing R_OK, then the execution will fail due to lacking
> permissions.
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- 
> src/openvpn/options.c |   48
> ++++++++++++++++++++++++++---------------------- 1 files changed,
> 26 insertions(+), 22 deletions(-)

Applied to master branches on -testing and -stable trees.


commit 0576a9f2f8c8a7cf2d50579e6762df6c86b388c5
Author: David Sommerseth <davids@...1347...>
Date:   Wed May 2 19:54:12 2012 +0200

    Simplify check_cmd_access() function

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Alon Bar-Lev <alon.barlev@...277...>
    Message-Id: 1335981252-7390-1-git-send-email-davids@...1347...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6391


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+iNbgACgkQDC186MBRfrqS+QCgjAEP5G6I4ZuPIENYMZXSxMoo
3UQAn2jZpM5ufBNPimZLvd/XV5ahbKeI
=Xyxv
-----END PGP SIGNATURE-----

