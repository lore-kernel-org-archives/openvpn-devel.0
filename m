Message-ID: <4C1016CB.3010701@...1114...>
Date: Thu, 10 Jun 2010 00:33:47 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BF14A59.2000200@...1369...>	<4C0E6EAB.3040304@...1369...>	<4C0F3F06.2030004@...1114...>
	<4C0F4620.7030100@...1369...>
	<4C0F89D5.6040603@...1147...> <4C100DF0.2050804@...1378...>
In-Reply-To: <4C100DF0.2050804@...1378...>
Subject: Re: [Openvpn-devel] openvpn-2.1.0-r1: easy-rsa tools creates broken
 client CERTs unusable for TLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@...1378...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/06/10 23:56, Martin MOKREJŠ wrote:
>   The patches in Gentoo I for example here:
> http://mirror.averse.net/gentoo-portage/net-misc/openvpn/files/
> 
>>> On the client:
>>> I use net-misc/openvpn-2.1.0-r1, I see there are two patches applying to
>>> my systems (no IPv6 patch):
>>>         epatch "${FILESDIR}/${PN}-2.1_rc13-peercred.patch"
>>>         epatch "${FILESDIR}/${PN}-2.1_rc20-pkcs11.patch"

[...snip...]

>
> Look at the two patches, they should probably go into you tree anyways if
> they are not just fixing some compilation/layout issues.
>

Those patches are clean, and not related at all to this issue at all.
The peercred patch has been adopted and included into the
openvpn-testing.git tree.

- -------------------------------------------------------------------------
commit 48045ace0541ec39f9c5003c0c37a23e1651f39d
Author: David Sommerseth <dazo@...384...>
Date:   Wed Mar 10 11:45:04 2010 +0100

    On TARGET_LINUX define _GNU_SOURCE if not defined

    This is to include peercred support on hosts where _GNU_SOURCE is
    not defined by default.  This issue has been found on Gentoo with
    glibc-2.8.

    The solution was discussed on the IRC meeting March 4, 2010
    in #openvpn-discussions.
    <http://thread.gmane.org/gmane.network.openvpn.devel/3242>

    Signed-off-by: David Sommerseth <dazo@...384...>
    Acked-by: James Yonan <james@...515...>
- -------------------------------------------------------------------------

[...snip...]

> Please improve the openVPN docs. Further, isn't it possible to
> provide two openssl.cf files, one for client and the other for
> server, and fill-in more default values. I never know where to place
> FQDN, where to place "server", "client", and you saw in my proposed
> patch that I had to invent even more.

The documentation needs to be reviewed, to be sure it does provide
accurate information.  Having that said, it doesn't seem to be that many
who struggles with this on the ##openvpn IRC channel.  I admit I've not
paid too much attention to the discussions there the last few weeks, but
this (VERIFY KU ERROR) is not on the "top 10" trouble list, afaik.

But on the other hand, most easy-rsa users do also make use of the
./build-key-server and ./build-key{,-pass,-pkcs12} scripts.  It might be
an issue related to ./sign-req.

I strongly do not recommend having more openssl.cnf files.  It is
possible to use one file, which makes the maintenance easier in the long
run.  The ./pkitool script should take care of providing the needed
"tweaks" to separate between client and server certificates.

For a similar script based version which might work better, take a look
at ssl-admin <http://www.secure-computing.net/wiki/index.php/Ssl-admin>.


I also noticed that Ubuntu was mentioned in the thread.  It might not be
directly related, but if you have an Ubuntu OpenVPN 2.1_rc7 - rc11
installation in use, beware that these versions do have some patches
which makes it incompatible with other versions.  And the failure in
this case is not obvious.  So, if possible, upgrade to OpenVPN
2.1.0/2.1.1 on client and server.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwQFssACgkQDC186MBRfrr0/wCdEhjMNJgNkzNEQsZRKrxghlWv
f4MAn2yLisOUr+a+eN7uzJjID1D6L4Fz
=QH6W
-----END PGP SIGNATURE-----

