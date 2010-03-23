Message-ID: <4BA8B9FF.2010702@...1114...>
Date: Tue, 23 Mar 2010 13:54:23 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BA780EF.9000702@...515...>
In-Reply-To: <4BA780EF.9000702@...515...>
Subject: Re: [Openvpn-devel] Old autotools support + UTF8 man-page patch
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/03/10 15:38, Samuli Seppänen wrote:
> Here are a couple things that needed testing/inquiries from our users
> before we take any action. I suggest giving both of them an ACK.
>
[...snip...]
> UTF-8 man-page patch
> - http://thread.gmane.org/gmane.network.openvpn.devel/3351/
> - works on all tested Linux distros, old (FC5, Debian Etch) and modern
> (e.g. Debian Lenny, Ubuntu 9.10)
> - I suggest an ACK

I might have been a bit too quick here, as it's merged into allmerged
already.

Commit 54283b9c6acac245f96c611e82f6a9049d694294
Signed-off-by: David Sommerseth <dazo@...384...>
Tested-by: Jan Just Keijser <janjust@...1147...>
Tested-by: Pavel Shramov <shramov@...1064...>
Tested-by: Samuli Seppänen <samuli@...515...>

It's no "official" ACK in this commit, but with three testers, it seemed
reasonable enough for me to include it after this.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuoufwACgkQDC186MBRfrrRZwCffSKizhn8ls4GdbVZzGte5bZh
Q1MAn3Yu05iZvLyqXM1ZZXgty3MtgP5B
=1UKo
-----END PGP SIGNATURE-----

