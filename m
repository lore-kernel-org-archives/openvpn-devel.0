Message-ID: <4E5E7F97.7020901@...1114...>
Date: Wed, 31 Aug 2011 20:38:15 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1314813915-30115-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz0eyfp7kkvMZrnUwPiOc23UYFVp+RnA2mGe_Ba5yt5nVA@...278...>
In-Reply-To: <CAOazyz0eyfp7kkvMZrnUwPiOc23UYFVp+RnA2mGe_Ba5yt5nVA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] add --mark option to set SO_MARK sockopt
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
To: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/08/11 20:27, Alon Bar-Lev wrote:
> Maybe should extend the usage of parameter "socket-flags"?

I considered that too, but that would require a bigger rewrite of the
- --socket-flags parser.  Currently it only is doing "boolean flags".  And as
- --mark takes an argument, it's not a traditional flag but more a socket
option.

But changing --socket-flags and --mark to --socket-opts, making it
understand TCP_NODELAY and MARK=integer ... that would be a nice step
forward.  Such a move should deprecate --socket-flags via a warning in 2.3,
though - and be removed in 2.4.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk5ef5UACgkQDC186MBRfrrlswCeO8AgU4L58h9sL1XE358dQ2Tb
yO8An0zfR+jb2ciW3WbCarIId0K5Vq/x
=Kt9e
-----END PGP SIGNATURE-----

