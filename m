Message-ID: <4E79E638.9080403@...1114...>
Date: Wed, 21 Sep 2011 15:27:20 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20110916180039.GR8496@...1296...>
In-Reply-To: <20110916180039.GR8496@...1296...>
Subject: Re: [Openvpn-devel] NetBSD platform cleanup
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/09/11 20:00, Gert Doering wrote:
> Hi,
> 
> testing today's "master" for problems due to the SVN merger (what bit
> ecrist on FreeBSD), I noticed a number of problems on NetBSD with the
> way tun/tap devices are handled, and (not) cleaned up at session end.
> 
> The attached patch cleans up the tun.c code for NetBSD, and has been
> tested with IPv4 + IPv6, TUN mode, TUN/top-subnet mode and TAP mode,
> and passes all tests *except* TAP+IPv6 (and that one seems to be a
> NetBSD kernel side issue, still investigating).
> 
> David, please ACK and merge :-)
> 

ACK.  Applied to testing and stable master branches.
commit 8ca19c014c149cf69257798afa6c75d1ff8f11a7


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk555jUACgkQDC186MBRfrq4QQCaApUgHs7lVi9hPDFwfN7aarp3
H7wAoLF7l7SY7hdcT047SIy6HsxZmWPz
=WCZq
-----END PGP SIGNATURE-----

