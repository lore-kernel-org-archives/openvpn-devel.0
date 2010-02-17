Message-ID: <4B7BF370.8070807@...1114...>
Date: Wed, 17 Feb 2010 14:47:28 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [IPv6 support] - usage of gethostbyname() in
	getaddr()
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
To: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all!

When reviewing the patch "FQDN for routes should expand to all IPs"
today, I spotted that there is a function called getaddr() (renamed to
getaddr_all() in the mentioned patch).  This function again makes use of
the old gethostbyname() function.  This is not compatible with IPv6
addresses.

I would strongly recommend a move to getaddrinfo() instead.  This is
based on an article [1] written by Ulrich Drepper, who is a glibc
maintainer.  Any thoughts about that?  It might even be more functions
needing to be ported as well.  The mentioned article lists most
important functions which should be ported to newer APIs.

Any comments on this issue would be appreciated.  Another issue is of
course how this will influence other platforms than Linux.


kind regards,

David Sommerseth



[1] <http://people.redhat.com/drepper/userapi-ipv6.html>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt783AACgkQDC186MBRfrrIxgCgnpCvbJMWzxutz4You8Qj8Qki
DFcAoJp5eGTHkee7Lz6AU+gKl5BOXiNv
=5ITZ
-----END PGP SIGNATURE-----

