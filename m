Message-ID: <4D699795.6060302@...1114...>
Date: Sun, 27 Feb 2011 01:15:17 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1297436985-18991-1-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH 01/13] Added ENABLE_PASSWORD_SAVE
	to	config-win32.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/02/11 16:09, Samuli Sepp=E4nen wrote:
| This change adds ENABLE_PASSWORD_SAVE to config-win32.h. This option is a=
lso
| defined in win/settings.in, but it does not have any effect there.
| ---
|   config-win32.h |    3 +++
|   1 files changed, 3 insertions(+), 0 deletions(-)
|

All patches (01-13 + the extra additional patch) have been applied to the
beta2.2 branch and is pushed out to the git tree.

[PATCH 01/13] Added ENABLE_PASSWORD_SAVE to config-win32.h
	commit 980d44047f4ab1541f80df1c9c2cfe6a2c572af8

[PATCH 02/13] Added a nmake makefile for openvpnserv.exe building
	commit da51a175ed364ae8d41950858d8ebb2a25b742ee

[PATCH 03/13] Moved TAP-driver version info to version.m4. Cleaned up
~              win/settings.in.
	commit 9e178ebe41233c228a3f76c1adb623a633057249

[PATCH 04/13] Added helper functionality to win/wb.py
	commit a8220492b30f2780c55c57d110253f310c170b73

[PATCH 05/13] Added support for viewing config-win32.h paramters to
~              win/show.py
	commit 3b44aa49400647b785721e77da9c5e38eeb9fd83

[PATCH 06/13] Added comments and made small modifications to win/msvc.mak.in
	commit 292cf21a64b4afb3b22a6ba19967f965b486600a

[PATCH 07/13] Added command-line switch to win/build_all.py to skip TAP
~              driver building
	commit 8c1c666e65db37fe680f7760c6ef52c2dd031932

[PATCH 08/13] Added configure.h and version.m4 variable parsing to
~              win/config.py
	commit a7f0fc316caf3fbbe7c75866b4d8d21e2e931fc1

[PATCH 09/13] Added openvpnserv.exe building to win/build.py
	commit 5e0b636ba6cb26a69ce5e863526e44d0fbd33ffc

[PATCH 10/13] Added comments to win/build_ddk.py
	commit 26e127cd59e07825a0785db2247fdac76ff01693

[PATCH 11/13] Several modifications to win/make_dist.py to allow building t=
he
~              NSI installer
	commit 4e4aa65e9df1bfe4b9726eacea2c75cad32c0927

[PATCH 12/13] Copied install-win32/setpath.nsi to win/setpath.nsi
	commit 21c60e9f11d8d53c11611ea66698afea9c0350ef

[PATCH 13/13] Added first version of NSI installer script to win/openvpn.nsi
	commit 3b315a57d579d9ba8e259216f722094f1c1dbcde

[PATCH] Changes to buildsystem patchset
	commit c75a8976f070ef86cfced71b3df5cbce0e32e01a



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1pl5UACgkQDC186MBRfrp8qACfcyglwAMWVKgeKtWzQyLZbgfI
uJYAnRTzTkgzLFbnx9+Vn98MnDCS4Mgk
=3DiUJx
-----END PGP SIGNATURE-----

