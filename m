Message-ID: <4D87B958.3090908@...1114...>
Date: Mon, 21 Mar 2011 21:47:20 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1299593269-10302-1-git-send-email-samuli@...515...>
In-Reply-To: <1299593269-10302-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Added support for prebuilt TAP-drivers.
 Automated embedding manifests.
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

On 08/03/11 15:07, Samuli Sepp=E4nen wrote:
> Removed win/make_dist.py's dependency on TAP-driver and tapinstall.exe bu=
ilding.
> Also added manifest embedding commands to win/make_dist.py. To avoid dupl=
icate
> code moved the "build_vc" method from win/build.py to win/wb.py and renam=
ed it
> "run_in_vs_shell".
> ---
>  win/build.py     |   16 +++--------
>  win/build_all.py |   13 +++++----
>  win/make_dist.py |   75 +++++++++++++++++++++++++++++++++++++-----------=
-----
>  win/settings.in  |    3 ++
>  win/tap_span.py  |    2 +-
>  win/wb.py        |    5 +++
>  6 files changed, 73 insertions(+), 41 deletions(-)
>=20

Applied to beta2.2 and merged into allmerged

commit 58704ea66478942ae82c013d0d48c7931cb79fa0
Author: Samuli Sepp=E4nen <samuli@...515...>
Date:   Tue Mar 15 16:38:07 2011 +0200

    Updated INSTALL-win32.txt

    Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2HuVgACgkQDC186MBRfroGXACeJuuMM9Kxmlc0wAeAsSnSNO2Y
nEAAnR63nK8M1EyNvcXybcZqUXPQ1QFQ
=3D5HUu
-----END PGP SIGNATURE-----

