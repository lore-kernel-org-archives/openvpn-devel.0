Message-ID: <4B97D8F5.5080503@...1114...>
Date: Wed, 10 Mar 2010 18:37:57 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>	<4B978D0E.9090606@...1114...>	<9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>	<4B97CDF3.6060703@...1114...>	<9e0cf0bf1003100903k3647ba78t40bb93d5d9a5d8d8@...278...>	<4B97D385.3010506@...1114...>
	<20100310172636.20173.qmail@...1287...>
In-Reply-To: <20100310172636.20173.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE	if
 not defined
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

On 10/03/10 18:26, Peter Stuge wrote:
> David Sommerseth wrote:
>> it's a requirement to be able to build OpenVPN on RHEL4.6.
> 
> As Alon explained, building is not the problem. autotools are used
> when preparing git source for build. This is done for every release,
> so that there is a ready-made configure script included in the
> tarball.
> 
> When building a release (or snapshot, if there are any) from such a
> tarball then autoconf is no longer relevant, it was run only when the
> tarball was created.
> 
> RHEL4.6 can easily build a release that was prepared using the most
> recent autoconf. That RHEL4.6 system doesn't need autoconf installed
> at all.
> 
> The only way autoconf on that RHEL4.6 would be relevant is if those
> RHEL4.6 systems strictly need to build directly from git source, as
> opposed to building from a prepared tarball. Is that the case?

I will get that clarified on the meeting tomorrow, as this might be a
scenario.  But to be honest, I have troubles seeing that people want to
do active development on RHEL4.6, at least do changes which require
changing autotools files or pulling down SVN or git trees.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuX2PUACgkQDC186MBRfrpN2QCgn5/NRRY9Je63J6Lgx1LJVjWg
WC0AoIDf6ZCBo3ulh3K1JakEnL8u+zXa
=adty
-----END PGP SIGNATURE-----

