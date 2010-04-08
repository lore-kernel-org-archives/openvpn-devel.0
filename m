Message-ID: <4BBE3205.1040303@...1114...>
Date: Thu, 08 Apr 2010 21:44:05 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1269951178-30419-1-git-send-email-dazo@...384...>
In-Reply-To: <1269951178-30419-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
 ./configure information to --version
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

On 30/03/10 14:12, David Sommerseth wrote:
> This patch will create ./configure.h which will contain two new #define
> strings.  CONFIGURE_DEFINES will contain all USE, ENABLED, DISABLED and
> DEPRECATED defines from ./config.h.  CONFIGURE_CALL will contain the
> complete ./configure line which was used when configuring the package
> for building.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  Makefile.am       |    7 +++++++
>  configure_h.awk   |   39 +++++++++++++++++++++++++++++++++++++++
>  configure_log.awk |   36 ++++++++++++++++++++++++++++++++++++
>  options.c         |    3 +++
>  4 files changed, 85 insertions(+), 0 deletions(-)
>  create mode 100644 configure_h.awk
>  create mode 100644 configure_log.awk

Applied to the openvpn-testing.git feat_misc branch.  To be merged into
allmerged soon.
Commit f27bf509315a48b0070294c3993a718df0c2626c


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAku+MgUACgkQDC186MBRfrrSTQCfZcZ1BbzdmGO7GwKhwMRyYfd3
f90AnieGGtEskxG+E5Ng/AxjwnL++6k6
=qKP1
-----END PGP SIGNATURE-----

