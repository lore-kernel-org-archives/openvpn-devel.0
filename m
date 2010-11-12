Message-ID: <4CDDA847.9080302@...1114...>
Date: Fri, 12 Nov 2010 21:49:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CB24484.4050605@...277...>
In-Reply-To: <4CB24484.4050605@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Socks5 username/password authentication
 support
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
To: Pierre Bourdon <delroth@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/10/10 00:56, Pierre Bourdon wrote:
> Hello,
> 
> This patch adds support for SOCKS plain text (username/password)
> authentication as described in RFC 1929. It adds an optional third
> parameter to the socks-proxy option, which is a file containing the
> login credentials.
> 
> I submitted this patch on the Trac (#62) two days ago, but cron2 asked
> me to send it here too. It is my first contribution to the OpenVPN
> project so this patch will probably need to be reworked a bit :) .
> 
> I've been using this patch for two weeks now and it does not seem to
> cause any problem. The only modifications are in the SOCKS handshake
> handling and the options parser.
> 
> Signed-Off-By: Pierre Bourdon <delroth@...277...>

Applied to feat_misc, to be merged into allmerged and beta2.2

commit fc1fa9ffc7e3356458ec38d43816e5ddeb0c580a
Author: Pierre Bourdon <delroth@?>
Date: Mon Oct 11 00:56:04 2010 +0200


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzdqEcACgkQDC186MBRfrrmRQCcCDgla4fbkxMbvOXFZzJ6dgLE
nUgAn24xN/fbpRIQ54TrdLHB1UnaLB9m
=IZqf
-----END PGP SIGNATURE-----

