Message-ID: <4F3E287A.9080603@...1114...>
Date: Fri, 17 Feb 2012 11:14:18 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] MSVC fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/02/12 18:30, Heiko Hund wrote:
> Hi,
> 
> this patch series fixes several issues when building for Windows with
> the MSVC buildsystem discovered today:
> 
> [PATCH 1/4] replace check for TARGET_WIN32 with WIN32 [PATCH 2/4] do
> not use mode_t on Windows [PATCH 3/4] use the underscore version of
> stat on Windows [PATCH 4/4] make MSVC link against shell32 as well
> 
> For details check the commit messages of the individual patches.

All patches applied to master on -testing and -stable trees.
For patch 3/4, a v2 patch was applied.


commit 76a3c405549bf02902846a9bd0e7d0f3a25a5b4d
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Thu Feb 16 18:30:38 2012 +0100

    replace check for TARGET_WIN32 with WIN32

    Use of TARGET_WIN32 breaks MSVC builds as it is only defined
    for mingw builds done with the autotools buildsystem.

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit d0109cbf459409a84963668c78f444c97ec2b349
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Thu Feb 16 18:30:39 2012 +0100

    do not use mode_t on Windows

    The MSVC headers do not define mode_t. open() uses an int for
    the permissions instead. Fixes building with the MSVC based
    buildsystem.

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit a13cd253ca1ce987e4feca7d80bd19ff749f7787
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Thu Feb 16 18:30:40 2012 +0100

    use the underscore version of stat on Windows

    MSVC does not know wstat(). Instead _wstat() must be used here.
    Unfortunately _wstat() takes a 'struct _stat'. A type 'stat_t' is
    introduced to handle this situation in a portable way.

    [v2: Use openvpn_stat_t instead of stat_t (David Sommerseth)]

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>

commit 67fe36f888d72d2c9c2b8dac849159a229400367
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Thu Feb 16 18:30:41 2012 +0100

    make MSVC link against shell32 as well

    Windows API CommandLineToArgvW(), introduced in Windows unicode path
    commit 71bbbd76c62630c88441237d72fe5b61f0b45b2a, is defined therein.

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8+KHgACgkQDC186MBRfrrEQwCfSZXxIf3+E+iR3+0h+HI6R5KV
utwAn36V2rzrGZvdeStrp6rjG/mOtZME
=XnhK
-----END PGP SIGNATURE-----

