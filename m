From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:05:24 +0200
Message-Id: <1297436737-18876-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 00/13] Fix remaining major issues with
	Python-based buildsystem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


This patchset allows building all OpenVPN components using the new Python-b=
ased=20
buildsystem. It also allows packaging the resulting files into a functional=
=20
installer package. Only two manual steps are necessary after applying these=
=20
patches:

- embedding manifest files to the executables and DLLs
- running MakeNSIS to generate the installer=20=20=20=20=20=20=20

This patchset reuses existing variables in config-win32.h and version.m4 to=
=20
avoid duplication of configuration data. The drawback is that the buildsyst=
em=20
code is slightly more complex than it could be.

Full patch list:

[PATCH 01/13] Added ENABLE_PASSWORD_SAVE to config-win32.h
[PATCH 02/13] Added a nmake makefile for openvpnserv.exe building
[PATCH 03/13] Moved TAP-driver version info to version.m4. Cleaned up win/s=
ettings.in.
[PATCH 04/13] Added helper functionality to win/wb.py
[PATCH 05/13] Added support for viewing config-win32.h paramters to win/sho=
w.py
[PATCH 06/13] Added comments and made small modifications to win/msvc.mak.in
[PATCH 07/13] Added command-line switch to win/build_all.py to skip TAP dri=
ver building
[PATCH 08/13] Added configure.h and version.m4 variable parsing to win/conf=
ig.py
[PATCH 09/13] Added openvpnserv.exe building to win/build.py
[PATCH 10/13] Added comments to win/build_ddk.py
[PATCH 11/13] Several modifications to win/make_dist.py to allow building t=
he NSI installer
[PATCH 12/13] Copied install-win32/setpath.nsi to win/setpath.nsi
[PATCH 13/13] Added first version of NSI installer script to win/openvpn.nsi

