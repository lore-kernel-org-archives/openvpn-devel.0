Message-ID: <4EE7B33D.50500@...1114...>
Date: Tue, 13 Dec 2011 21:19:09 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1323796440-15966-1-git-send-email-davids@...1347...>
In-Reply-To: <1323796440-15966-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Only warn about non-tackled IPv6
 packets once
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/12/11 18:14, David Sommerseth wrote:
> When using OpenVPN 2.2 on clients and server with Windows based 
> clients, it will try to push IPv6 packets through the tunnel.  This 
> causes the server log to be filled up with log entries like this:
> 
> Wed Jun 29 22:12:51 2011 username/1.2.3.4:56990 Need IPv6 code in
> mroute_extract_addr_from_packet
> 
> This patch modifies this message to state that IPv6 packets are not 
> tackled in tun mode, and prints it only once.
> 
> Trac: 147 Signed-off-by: David Sommerseth <davids@...1347...> --- 
> mroute.c |    7 ++++++- 1 files changed, 6 insertions(+), 1
> deletions(-)
> 

Applied to the release/2.2 branch on -stable.

commit b7bbe47a7fcfa74297ff04a50982b70113f28f96
Author: David Sommerseth <davids@...1347...>
Date:   Tue Dec 13 18:08:24 2011 +0100

    Trac: 147
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7nszsACgkQDC186MBRfrrNwgCfeoFmvRVlo2FHfPdAbIFTyKSO
//0An0C09d33Oo0FhwrDsr3M1ax6GxV7
=irRp
-----END PGP SIGNATURE-----

