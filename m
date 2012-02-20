Message-ID: <4F421C5D.6040007@...1114...>
Date: Mon, 20 Feb 2012 11:11:41 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329730625-21681-1-git-send-email-davids@...1347...>
In-Reply-To: <1329730625-21681-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Revamp check_file_access() checks in
 stdin scenarios
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

On 20/02/12 10:37, David Sommerseth wrote:
> It was discovered that --management also can take stdin as argument 
> instead of a file.  Enabled this by revamping the check_file_access() 
> flags by adding CHKACC_ACPTSTDIN.  Setting this flag will then
> consider filenames as 'stdin' as always present.
> 
> The other place where 'stdin' was accepted is also modified to use
> this flag instead.
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- options.c |
> 16 ++++++++++++---- 1 files changed, 12 insertions(+), 4 deletions(-)
> 

Applied to master branch on -testing and -stable trees.

commit a4de190b92f9464602222454dd753072eecc0407
Author: David Sommerseth <davids@...1347...>
Date:   Mon Feb 20 10:31:54 2012 +0100

    Revamp check_file_access() checks in stdin scenarios

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9CHF0ACgkQDC186MBRfrrYsgCfdgdGMYuHGL7ZMKwRbir2YkSO
EsUAnRh509YrV7S/NcvBxNJFayVzmLXW
=hQNt
-----END PGP SIGNATURE-----

