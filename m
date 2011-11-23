Message-ID: <4ECD8481.40000@...1114...>
Date: Thu, 24 Nov 2011 00:40:49 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20111123102344.GA8496@...1296...>
In-Reply-To: <20111123102344.GA8496@...1296...>
Subject: Re: [Openvpn-devel] extra patches needed for tap driver bugfix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/11/11 11:23, Gert Doering wrote:
> Hi,
> 
> bugfixing the tap driver is nice and well, but I think we MUST bump 
> the driver version as well, and we SHOULD have a check in tun.c to 
> refuse operation if the known-buggy version (9.8) is detected.
> 
> Patches below.
> 
> gert

Both pathces ACKed and applied to master branch on -testing and -stable.
 In addition
these two patches are cherry-picked for the release/2.2 branch on -stable.


commit 03ab4ead8295e005f72dbffcffdaa74487d9668c (master)
commit ed77e8ad8e892c14d7613a4eb377b8d03078a872 (release/2.2)
Author: Gert Doering <gert@...1296...>
Date:   Wed Nov 23 11:11:54 2011 +0100

    log error message and exit for "win32, tun mode, tap driver version 9.8"
    ...
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


commit 1523d1101222340b7ef305020ed7eba0dd1676cf (master)
commit 066df6aa44c154bb94403b364f585c4ed569bf47 (release/2.2)
Author: Gert Doering <gert@...1296...>
Date:   Wed Nov 23 11:07:09 2011 +0100

    bump tap driver version from 9.8 to 9.9
    ...
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7NhIEACgkQDC186MBRfroUtgCfVURvAGlLd+tOOfFaffQBzkhp
17MAoJusIucq6LN58HRG1ikgDUlnnV9U
=GTYP
-----END PGP SIGNATURE-----

