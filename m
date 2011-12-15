Message-ID: <4EE9D003.5060704@...1114...>
Date: Thu, 15 Dec 2011 11:46:27 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1323882919-2145-1-git-send-email-davids@...1347...>
In-Reply-To: <1323882919-2145-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix compiling with --disable-crypto
 and/or --disable-ssl
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

On 14/12/11 18:15, David Sommerseth wrote:
> The checks introduced in commit
> 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1 didn't properly remove checks
> if crypto or SSL was disabled at compile time.
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- options.c |
> 10 +++++----- 1 files changed, 5 insertions(+), 5 deletions(-)

Applied and pushed to master branches on testing and stable git trees.


commit 1d5c4433cdb7ab0a9d9f7496e6dc2cee189d375f
Author: David Sommerseth <davids@...1347...>
Date:   Wed Dec 14 18:12:23 2011 +0100

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7p0AEACgkQDC186MBRfrp+kwCeKejrGoNeKoofE3mgZOsin+Dp
cTkAnRiZRAj+x+qT3V1/pumqoXAf/mrz
=yPJD
-----END PGP SIGNATURE-----

