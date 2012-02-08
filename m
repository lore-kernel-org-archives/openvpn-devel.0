Message-ID: <4F32A2CD.4040004@...1114...>
Date: Wed, 08 Feb 2012 17:29:01 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120205131601.GA26602@...1296...>
	<4F2E8C00.6090909@...384...>
	<20120205154846.GB13929@...1296...>
In-Reply-To: <20120205154846.GB13929@...1296...>
Subject: Re: [Openvpn-devel] OpenBSD platform cleanup
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

On 05/02/12 16:48, Gert Doering wrote:
> Hi,
> 
> On Sun, Feb 05, 2012 at 03:02:40PM +0100, David Sommerseth wrote:
>>> as promised :-) - it now passes all my t_client.rc tests, and 
>>> smells a lot less funny.  We now might even throw out all these 
>>> weird #ifdefs from tun.h...
>> 
>> Maybe an attachment would be nice? ;-)
> 
> And I thought you could just fetch this from the git repo on my laptop
> (suspended to disk and turned off, of course!).  Well, that's what you
> get when debugging assert() crashes instead concentrating on your
> e-mail :-)

ACK.  Applied to master and pushed to -stable and -testing trees.

commit 82d4e12068774b0a6ca787ef1345b8a16c460466
Author: Gert Doering <gert@...1296...>
Date:   Sun Feb 5 13:35:03 2012 +0100

    Platform cleanup for OpenBSD

    Turn around initialization order (IFCONFIG_AFTER_TUN_OPEN) to make it
    "the same as all other platforms besides Windows" (tun.h).

    Remove "ifconfig destroy / ifconfig create" from open_tun() and change
    to generic "create tun device by opening /dev/tunN" approach, thus
    cleaning up the IFCONFIG_BEFORE_TUN_OPEN bit.

    Add "-link0" for ifconfig calls in tun mode, to make sure that even if
    we happen to re-use a not-cleaned-up tun interface in tap mode, it will
    then be setup correctly (-link0 -> tun, link0 -> tap).

    Add correct ifconfig calls for "topology subnet".

    On tunnel close, only call "ifconfig destroy" if it was a tap interface
    (tun + link0), because those do not auto-disappear (OpenBSD bug?)

    Get rid of READV/WRITEV #ifdef's - as per the man page, these calls have
    been added to 4.2BSD, and there never was an OpenBSD version without.

    Tested on OpenBSD 4.9 with tun+tap, ipv4+ipv6, topology net30+subnet

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8yos0ACgkQDC186MBRfrrVqgCffQQV0Dbpv9r3aKPVE/Vc9So/
wxIAnR37yPY1qGC7hzZQcyRReRLOjCRw
=TDBp
-----END PGP SIGNATURE-----

