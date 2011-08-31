Message-ID: <4E5E71BB.3070400@...1114...>
Date: Wed, 31 Aug 2011 19:39:07 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1314801488-25380-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1314801488-25380-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] lowercase include header name in
	syshead.h
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
To: Heiko Hund <heiko.hund@...1489...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/08/11 16:38, Heiko Hund wrote:
> Cross compiling for Windows is broken since commit
> 739fa9881f12e67dc8b9cadc7230e59e7fe42423 added the mixed
> case header name "NtDDNdis.h" to the file. While this header
> exists in a MinGW build environment it's lowercase there.
> 
> Windows doesn't mind the case of a file name, but Linux does.
> So, lowercasing the filename will make openvpn build in both
> worlds.
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>

ACK.  Applied to testing and stable master branches.
Commit a18c2b025c851a50bd2df33af5bad99b467da595


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk5ecbsACgkQDC186MBRfrodcwCggiac4FmGOzLpHbO87fO1PzXZ
TicAn3Uo0hCE70SIqn6hJ8sin08DCft6
=uWWT
-----END PGP SIGNATURE-----

