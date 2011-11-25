Message-ID: <4ECFC299.209@...1114...>
Date: Fri, 25 Nov 2011 17:30:17 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20111125083853.GU8496@...1296...>
	<1322218679-4946-1-git-send-email-davids@...1347...>
In-Reply-To: <1322218679-4946-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix bug after removing Linux 2.2
	support
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

On 25/11/11 11:57, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> In commit ce637abdafdc19547fc97192033a4d1703ecaf23 the Linux 2.2 
> support was removed.  When this happened an extra error check was 
> avoided which would normally kicked in if the tun/tap device would
> not be available. Instead the following line was filling the log 
> continously:
> 
> Thu Nov 24 22:33:15 2011 read from TUN/TAP : File descriptor in bad 
> state (code=77)
> 
> This patch changes the msg() declarations to use the M_FATAL *) flag, 
> which will halt the execution of the program in these error 
> sitauations. As the program will really halt, the return declarations 
> was also removed.
> 
> *) #define M_ERR   (M_FATAL | M_ERRNO)  (from error.h)
> 
> Signed-off-by: David Sommerseth <dazo@...384...> ---
> tun.c |    6 ++---- 1 files changed, 2 insertions(+), 4 deletions(-)
> 

Applied to master branch in -stable and -testing.

commit e7d1ac82f9a21ef91030e4f104d4ef0810b07f8e
Author: David Sommerseth <dazo@...384...>
Date:   Thu Nov 24 22:45:21 2011 +0100

    Fix bug after removing Linux 2.2 support

    Signed-off-by: David Sommerseth <dazo@...384...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7PwpkACgkQDC186MBRfroAkgCfdqLb4FuOFhunFZrtzBsYjrhL
yv0AniPang2dib+ltujnseCdnUWrTkxb
=2gSS
-----END PGP SIGNATURE-----

