Message-ID: <4C6AE7AC.2010605@...1114...>
Date: Tue, 17 Aug 2010 21:49:00 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100808194847.GN740@...1296...>
In-Reply-To: <20100808194847.GN740@...1296...>
Subject: Re: [Openvpn-devel] RFD: VPN client test framework
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/08/10 21:48, Gert Doering wrote:
> Hi,
> 
> as discussed in one of the previous the IRC meetings, I've been working
> on a test framework to enable full "fire up openvpn client, establish
> VPN connection, run ping tests, clean up, verify cleanup" automated 
> tests.
> 
> The framework is appended below (as patch, should apply cleanly against
> all branches in git) and has been checked & pushed into my feat_ipv6_payload
> branch (dazo, feel free to pull & merge wherever you find this useful).
> 

ACK

commit 97750e7d4571a0c28695aac1530a91fe98d25d06
Author: Gert Doering <gert@...1296...>
Date:   Sun Aug 8 21:24:30 2010 +0200

    [...snipped verbose explanation ...]

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>

Applied to bugfix2.1, merged into allmerged and beta2.2.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxq56wACgkQDC186MBRfrrZvACfQRML9cLvkmBjNW3ODoNcZxWi
GlQAniyRw+4sYFpuNuUn0FeJrB79m9Xb
=77TI
-----END PGP SIGNATURE-----

