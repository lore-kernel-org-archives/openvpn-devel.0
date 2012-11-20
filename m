From: Joachim Schipper <joachim.schipper@...1435...>
Date: Tue, 20 Nov 2012 11:10:22 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B901323AF01D4@...1436...>
References: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
	<50AB4AFB.9030908@...1114...>
In-Reply-To: <50AB4AFB.9030908@...1114...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Yes, that seems to be correct. Sorry!

		Joachim

-----Original Message-----
From: David Sommerseth [mailto:openvpn.list@...1114...]=20
Sent: dinsdag 20 november 2012 10:19
To: Joachim Schipper
Cc: openvpn-devel@lists.sourceforge.net; Adriaan de Jong
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids

On 14/11/12 10:03, Adriaan de Jong wrote:
> [PATCH] Fix --show-pkcs11-ids (Bug #239)
>=20
> Broken by 75b49e406430299b187964744f82e50a9035a0d3.
>=20
> Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
> ---
>  src/openvpn/pkcs11.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Joachim,

Thanks a lot for you fix!  Just a little question.  You mention this commit=
 as being the offending commit:

commit 75b49e406430299b187964744f82e50a9035a0d3
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sun Apr 1 16:46:28 2012 +0300

    cleanup: gc usage

    Cleanup of "Use the garbage collector when retrieving x509 fields"
    patch series.

    Discussed at [1].

    There should be an effort to produce common function prologue
    and epilogue, so that cleanups will be done at single point.

    [1] http://comments.gmane.org/gmane.network.openvpn.devel/5401

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: David Sommerseth <davids@...1347...>


I'm just wondering how this could be related to you fix.  As I see it, the =
syntax of the if() statement you change didn't change, neither the behaviou=
r of pkcs11_certificate_dn().

I see that commit 00b973f8af85c3ea8fa3cef80eec55e8dc139b27 changes the beha=
viour of pkcs11_certificate_dn() in both the OpenSSL and PolarSSL implement=
ation.  So I'm suspecting you referenced the wrong commit.  Right?


--
kind regards,

David Sommerseth


