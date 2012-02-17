Message-ID: <4F3E38DE.6050409@...1114...>
Date: Fri, 17 Feb 2012 12:24:14 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329477191-634-1-git-send-email-davids@...1347...>
	<CAOazyz2YPRM9WEt4LjEVOR05FrYkVr4W1OMWcbHVeDf7m6E+-Q@...278...>
In-Reply-To: <CAOazyz2YPRM9WEt4LjEVOR05FrYkVr4W1OMWcbHVeDf7m6E+-Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Makefile.am referenced a now
 non-existing config-win32.h
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: David Sommerseth <davids@...1347...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 17/02/12 12:18, Alon Bar-Lev wrote:
> When did this file gone? Anyway, this was required with compiling 
> using MSVC...

This is the commit referenced:

commit 4b312378e9e7084a0699ca6d4b895bdadb7540db
Author: Samuli Seppänen <samuli@...515...>
Date:   Tue Mar 15 16:37:41 2011 +0200

    Replaced config-win32.h with win/config.h.in

    The original config-win32.h - a static header file - has been
    superceded by both "domake-win" script and the new Python-based
    buildsystem. Transformed it into a template file, win/config.h.in,
    which obtains the most commonly used build parameters from
    win/settings.in.

    Added support code to win/config.py and win/wb.py to preprocess
    win/config.h.in and copy it to config.h, from where source and header
    files can find it.

    Removed all references to config-win32.h. Also removed obsolete
    PACKAGE_BUGREPORT and USE_PTHREAD variables from the win/config.h.in
    file.

    Signed-off-by: Samuli Seppänen <samuli@...515...>
    Acked-by: James Yonan <james@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8+ONwACgkQDC186MBRfrociQCfTopQrINB9mjNUnqgPShF7hvA
d7gAoJvf0XjI59upjzKdKdqDVqh7n3Eo
=vB7z
-----END PGP SIGNATURE-----

