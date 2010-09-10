Message-ID: <4C89C924.6060401@...1114...>
Date: Fri, 10 Sep 2010 07:59:00 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTimJy1BCQYoQsW0YNAcmqWWEi98hJL_5kCQnhPNt@...278...>
In-Reply-To: <AANLkTimJy1BCQYoQsW0YNAcmqWWEi98hJL_5kCQnhPNt@...278...>
Subject: Re: [Openvpn-devel] What changes were made from 2.1.2 to 2.1.3?
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/09/10 20:42, Jonathan K. Bullard wrote:
> The downloads page, http://openvpn.net/index.php/open-source/downloads.html,
> has release 2.1.3 (2010.08.27).
> 
> However, the release notes linked to on that page,
> http://openvpn.net/changelog-beta.html, only include changes up through
> 2.1.2 (2010.08.09). (The Documentation page,
> http://openvpn.net/index.php/open-source/documentation.html, also links to
> the same release notes.)
> 
> What changes were made from 2.1.2 to 2.1.3?
> 
One internal change to the new windows build system.  No code change in
the core OpenVPN code at all.  We had to rebuild 2.1.2 to fix the driver
signing issue we had with Windows 7 rejecting to make use of the updated
TAP device.

As our Windows build don't carry any build number, only version number.
And the current way to differentiate builds from each others are by
increasing the version number.

Of course this makes it a bit tricky, as most other *nix based
distributions do support build versions (often separated by a dash, like
2.1.3-1).  So these releases will not be affected.

So to sum it up:  2.1.2 is practically the same version as 2.1.3, code
wise.  The commit below is the only difference.

commit 5f866d914c71f010988fd85d5b178f3b8c3e2987
Author: James Yonan <james@...515...>
Date:   Fri Aug 20 20:24:42 2010 +0000

    Attempt to fix issue where domake-win build system was not properly
    signing drivers and .exe files.

    Added win/tap_span.py for building multiple versions of the TAP
    driver and tapinstall binaries using different DDK versions to span
    from Win2K to Win7 and beyond.

    Version 2.1.3


    git-svn-id:
<http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn@...1401...>
e7ae566f-a301-0410-adde-c780ea21d3b5



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkyJySIACgkQDC186MBRfrrEZQCeO4zvHJYX/4ivO9f8FD2365GH
sDEAn1LkDnNlZqdyKoUNdoeDFbNV4Tlj
=NGSz
-----END PGP SIGNATURE-----

