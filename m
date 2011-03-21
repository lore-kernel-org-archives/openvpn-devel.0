Message-ID: <4D87B8C5.4010508@...1114...>
Date: Mon, 21 Mar 2011 21:44:53 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1300199861-4776-1-git-send-email-samuli@...515...>
In-Reply-To: <1300199861-4776-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Replaced config-win32.h with
	win/config.h.in
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

On 15/03/11 15:37, Samuli Seppänen wrote:
> The original config-win32.h - a static header file - has been superceded by both
> "domake-win" script and the new Python-based buildsystem. Transformed it into a
> template file, win/config.h.in, which obtains the most commonly used build
> parameters from win/settings.in.
> 
> Added support code to win/config.py and win/wb.py to preprocess win/config.h.in
> and copy it to config.h, from where source and header files can find it.
> 
> Removed all references to config-win32.h. Also removed obsolete
> PACKAGE_BUGREPORT and USE_PTHREAD variables from the win/config.h.in file.
> 
> Signed-off-by: Samuli Seppänen <samuli@...515...>
> ---
>  config-win32.h              |  308 -----------------------------------------
>  openvpn.8                   |    4 +-
>  service-win32/openvpnserv.c |    4 -
>  syshead.h                   |    4 -
>  tap-win32/SOURCES.in        |    3 +-
>  win/config.h.in             |  316 +++++++++++++++++++++++++++++++++++++++++++
>  win/config.py               |   37 +++---
>  win/settings.in             |   12 ++-
>  win/wb.py                   |   30 +++--
>  9 files changed, 366 insertions(+), 352 deletions(-)
>  delete mode 100644 config-win32.h
>  create mode 100644 win/config.h.in
> 

Applied to beta2.2 and merged into allmerged.

commit 4b312378e9e7084a0699ca6d4b895bdadb7540db
Author: Samuli Seppänen <samuli@...515...>
Date:   Tue Mar 15 16:37:41 2011 +0200

    Replaced config-win32.h with win/config.h.in

    Signed-off-by: Samuli Seppänen <samuli@...515...>
    Acked-by: James Yonan <james@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2HuMUACgkQDC186MBRfrooWgCdEaE/YF9wGyHPiVo3SC2B2x68
dp0An1UruGyjDPTl5TGkaVBWXNoFuPFi
=U+Ak
-----END PGP SIGNATURE-----

