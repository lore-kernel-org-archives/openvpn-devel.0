Message-ID: <4DFF120B.9070200@...1114...>
Date: Mon, 20 Jun 2011 11:25:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1308302282-27985-1-git-send-email-samuli@...515...>
In-Reply-To: <1308302282-27985-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix a build-ca issue on Windows
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
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 17/06/11 11:18, samuli@...515... wrote:
> From: Samuli Seppänen <samuli@...515...>
> 
> Fixes Trac ticket #125
> ---
>  easy-rsa/Windows/init-config.bat |    1 -
>  win/openvpn.nsi                  |    5 +++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

ACK.  Applied to master and release/2.2.

commit 38108434db7b2d574133dd645d01df03848532d6 (master)
commit 09282a688bd16d1572a7cc4fd20d3785fb2b4c1e (release/2.2)
Author: Samuli Seppänen <samuli@...515...>
Date:   Fri Jun 17 12:18:02 2011 +0300

    Fix a build-ca issue on Windows

    Fixes Trac ticket #125

    Signed-off-by: Samuli Seppänen <samuli@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

Trac reference: <https://community.openvpn.net/openvpn/ticket/125>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3/EgUACgkQDC186MBRfrr3jACfWhWA5sIYhkI61z+w9Q/BE4ag
6gsAnj7Jj1Ca39mko64iqyyPpgcZXdyq
=sg9T
-----END PGP SIGNATURE-----

