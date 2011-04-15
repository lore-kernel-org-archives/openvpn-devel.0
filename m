Message-ID: <4DA80325.8030201@...1114...>
Date: Fri, 15 Apr 2011 10:34:45 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1302791399-23728-1-git-send-email-davids@...1347...>
In-Reply-To: <1302791399-23728-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] Change the default --tmp-dir path to
 a	more suitable path
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/04/11 16:29, David Sommerseth wrote:
> After all the discussions regarding the --tmp-dir patch [1], I have now
> condenced everything into one single patch.  The main change is that
> the new win_get_tempdir() function is simplified by using GetTempPath()
> instead.
> 
> On Windows the fallback solution, if GetTempPath() returns NULL, is now to
> behave as before - write temporary files in the directory where OpenVPN was
> started.
> 
> 
> [1] <http://thread.gmane.org/gmane.network.openvpn.devel/4561>
> 
> 
> David Sommerseth (1):
>   Change the default --tmp-dir path to a more suitable path
> 
>  options.c |   18 ++++++++++++++----
>  win32.c   |   19 +++++++++++++++++++
>  win32.h   |    3 +++
>  3 files changed, 36 insertions(+), 4 deletions(-)

Applied to master and beta2.2.

commit eb4b1bb6adc7fb1828839967a7807b6317305145 (beta2.2)
commit eb4b1bb6adc7fb1828839967a7807b6317305145 (master)
Author: David Sommerseth <davids@...1347...>
Date:   Thu Apr 14 16:21:16 2011 +0200

    Signed-off-by: David Sommerseth <davids@...1347...>
    Tested-by: Jan Just Keijser <janjust@...1147...>
    Acked-by: Gert Doering <gert@...1296...>


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2oAyUACgkQDC186MBRfroWKgCdFp47roG5t8GlwBUtbqSWl36I
N1AAn2uPVZgh8itgrQlLUi/hZcfrUEOz
=t8A0
-----END PGP SIGNATURE-----

