Message-ID: <4C6AEA2A.9080901@...1114...>
Date: Tue, 17 Aug 2010 21:59:38 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100709083102.GZ361@...1296...>
	<20100710094839.GY361@...1296...>
In-Reply-To: <20100710094839.GY361@...1296...>
Subject: Re: [Openvpn-devel] Patch for compile-time problems on NetBSD and
 OpenBSD (trac #17)
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

On 10/07/10 11:48, Gert Doering wrote:
> Hi,
> 
> On Fri, Jul 09, 2010 at 10:31:02AM +0200, Gert Doering wrote:
>> the following patch fixes the IFF_MULTICAST compile-time problems on NetBSD,
>> and it should also fix them on OpenBSD (trac entry #17).
> 
> This would have been too easy...  on NetBSD, <sys/socket.h> can be 
> include before <sys/types.h> (which the original patch does), on OpenBSD,
> this fails.
> 
> So I have swapped around these two includes in the <net/if.h> test program
> compiled by configure, and it now configure and compiles both on NetBSD
> and on OpenBSD just fine.  (Last time I had no OpenBSD to test - in the
> mean time, I've setup an OpenBSD 4.7 VM and tested it myself, so I'm *sure*
> it works :-) ).
> 
> Due to the fact that I've commited this in two goes, it's "two patches"
> now...  I've appended both.  Please apply to a clean configure.ac file,
> and to be sure, run "autoreconf" to rebuild "configure" (to Matthias: 
> well, the magic might do this automatically, but before I get another 
> bug report "your patch did not help" which could then be due to 
> "autoreconf not run", I'll just make *sure* it was rebuilt).
> 
> "David needs an independent ACK on this, so please test on NetBSD and
> OpenBSD and give feedback".
> 
> gert
> 

ACK received in Trac:
<https://community.openvpn.net/openvpn/ticket/17>

commit 422e5e751e73de8a17760acf2f15f61ea4f0394e
Author: Gert Doering <gert@...1296...>
Date:   Sat Jul 10 11:24:41 2010 +0200

    Fix <net/if.h> compile time problems on OpenBSD for good

    Previous fix (commit eb973e055bc249948) fixed NetBSD but not OpenBSD
    (include <sys/socket.h> *after* <sys/types.h>)

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: krzee <jeff@...1394...>
    Signed-off-by: David Sommerseth <dazo@...384...>


Applied to bugfix2.1, merged into allmerged and beta2.2.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxq6ioACgkQDC186MBRfrpX8ACfaGqn2ywOCYha0SKGRfdQBj+n
MkYAmgJLR8trKICDgc+khYeMzrWzQVg3
=zOS4
-----END PGP SIGNATURE-----

