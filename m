Message-ID: <4F33D9EA.1050801@...1114...>
Date: Thu, 09 Feb 2012 15:36:26 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120207102413.GQ13929@...1296...>
In-Reply-To: <20120207102413.GQ13929@...1296...>
Subject: Re: [Openvpn-devel] configure patch for MacOS 10.7
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

On 07/02/12 11:24, Gert Doering wrote:
> Hi,
> 
> I'm forwarding this "as-is", as I do not have enough understanding of 
> autoconf to say whether this is necessary, or "the right fix" - but 
> anyway, I've been told that this is needed to make our configure 
> behave on MacOS 10.7.
> 
> gert
> 

Applied to the master branch on -stable and -testing trees.


commit 3a90edbd194140eef51c245edfcf9afc0ecb2d13
Author: Byron Ellacott <bje@...1544...>
Date:   Mon Feb 6 19:57:00 2012 +0100

    autoconf fixes for building on OSX

    [DS: a few whitespace fixes was added as well during the merge]

    Signed-off-by: Byron Ellacott <bje@...1544...>
    Acked-by: Gilles Espinasse <g.esp@...260...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8z2ecACgkQDC186MBRfrp2uQCgnwNsEiwhHfgbdi9Bs1ttkNHL
oqIAoJB18nrWOeF4izWXMSSG56KxgUST
=FiKQ
-----END PGP SIGNATURE-----

