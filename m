Message-ID: <4E5E7C37.6000300@...1114...>
Date: Wed, 31 Aug 2011 20:23:51 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1314813915-30115-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1314813915-30115-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] add --mark option to set SO_MARK sockopt
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

On 31/08/11 20:05, Heiko Hund wrote:
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  init.c    |    1 +
>  openvpn.8 |    6 ++++++
>  options.c |   14 ++++++++++++++
>  options.h |    3 +++
>  socket.c  |   13 +++++++++++++
>  socket.h  |    1 +
>  6 files changed, 38 insertions(+), 0 deletions(-)
> 

ACK!  This makes sense.  Should probably be noted that you need a kernel
which is 2.6.25 or newer (unless some distros have backported it).
Upstream kernel commit 4a19ec5800fc3bb64e2d87c4d9fdd9e636086fe0 [1]
contains this feature.

Applied to master braches in testing and stable.  Commit
d90428d141102a646a20b1310de1716621e32bd6


kind regards,

David Sommerseth


[1]
<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4a19ec5800fc3bb64e2d87c4d9fdd9e636086fe0>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk5efDIACgkQDC186MBRfrrkhQCfdS2weWvTSC/YWa5otp0K4R+e
AUkAn3Kl65yoRxoEkeUJnw8V2HlPZMkD
=Z0UP
-----END PGP SIGNATURE-----

