Message-ID: <4CE0615E.4060303@...1114...>
Date: Sun, 14 Nov 2010 23:23:26 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CDD63D3.2000902@...515...>
In-Reply-To: <4CDD63D3.2000902@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Added check for variable
 CONFIGURE_DEFINES into options.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/10 16:57, Samuli Sepp=E4nen wrote:
>

Applied to the feat_misc branch, to be merged into allmerged and beta2.2.

commit 5682d3394204c788988b3cf67b3443a717704d2c
Author: Samuli Sepp=E4nen <samuli@...515...>
Date:   Fri Nov 12 17:30:07 2010 +0200

    Added check for variable CONFIGURE_DEFINES into options.c

    The file containing CONFIGURE_DEFINES variable, configure.h, is not
    present if openvpn is built using the Python + Visual C -based
    buildsystem. This causes the build to fail. This patch adds a check
    to see if variable exists before trying to use it.

    Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
    Acked-by: Peter Stuge <peter@...1287...>
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzgYV4ACgkQDC186MBRfrqvhgCgkOuHDMxSEy2hn6jjqqYfV68J
XjkAn0w+Ry7AlH/SoS+M1nRRHCMxl4y6
=3DEEdp
-----END PGP SIGNATURE-----

