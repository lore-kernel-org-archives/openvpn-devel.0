Message-ID: <4DA80295.9070305@...1114...>
Date: Fri, 15 Apr 2011 10:32:21 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1302792033-9032-1-git-send-email-samuli@...515...>
In-Reply-To: <1302792033-9032-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix a bug in devcon source code handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/04/11 16:40, Samuli Sepp=E4nen wrote:
> The win/config_ti.py build script assumes to find ../tapinstall/7600/sour=
ces.in
> which does not exists in devcon.exe source code directory. This makes
> config_ti.py look for ../tapinstall/7600/sources instead.
> ---
>  win/config_ti.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20

ACK.  Applied to master and beta2.2.

commit 6f0ded58250d4b4fef9cfdd314165d88d8f8f80e (beta2.2)
commit a18752d4febdaa91f87efcc487ac865d6587c527 (master)
Author: Samuli Sepp=E4nen <samuli@...515...>
Date:   Thu Apr 14 17:40:33 2011 +0300

    Fix a bug in devcon source code handling

    The win/config_ti.py build script assumes to find ../tapinstall
    /7600/sources.in
    which does not exists in devcon.exe source code directory. This makes
    config_ti.py look for ../tapinstall/7600/sources instead.

    Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2oApUACgkQDC186MBRfrpBwQCfegsKnY91cdlJsXU05r6Y8Ynl
ZJ8An1bGQENjDv06d4pdF81XPE9BOyj8
=3DsMaT
-----END PGP SIGNATURE-----

