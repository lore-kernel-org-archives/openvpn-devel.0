Message-ID: <4EA5432A.2070301@...1114...>
Date: Mon, 24 Oct 2011 12:51:22 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1319445962-21686-1-git-send-email-dejong@...1435...>
In-Reply-To: <1319445962-21686-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Got rid of a few magic numbers in
 ntlm.c
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
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/10/11 10:46, Adriaan de Jong wrote:
> Signed-off-by: Adriaan de Jong <dejong@...1435...> --- 
> crypto_backend.h  |    6 +++--- crypto_openssl.c  |    2 +- 
> crypto_openssl.h  |    3 +++ crypto_polarssl.c |    2 +- 
> crypto_polarssl.h |    2 ++ ntlm.c            |   30
> +++++++++++++++--------------- 6 files changed, 25 insertions(+), 20
> deletions(-)

As this is the same patch [1] as the one in the original PolarSSL patch
inclusion round [2], I kept James Yonan's ACK and gave myself an extra
ACK to this one.  The reason it failed was due to a formatting patch
which was NACKed during the review which the previous patch [1] depended on.

Pushed out new master branch to -testing and -stable trees.

commit 9788322b9566101119484d992364e8b1bb1d4dd4
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Oct 24 10:46:00 2011 +0200

    Got rid of a few magic numbers in ntlm.c

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: James Yonan <james@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6lQygACgkQDC186MBRfroNbgCfUAuA7TMrvyuh4sEv/ZYy8wyB
k14AnA2gpY0cL+M/36UNDyF96XnPOLtD
=dLJr
-----END PGP SIGNATURE-----

