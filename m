Message-ID: <4B9FFCF7.6060209@...1114...>
Date: Tue, 16 Mar 2010 22:49:43 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <9e0cf0bf1003110808m50e523ecn3262918ba9904e10@...278...>
	<1268324921-9307-1-git-send-email-dazo@...384...>
In-Reply-To: <1268324921-9307-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCHv2] Fix autotools cross-compiling support
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

On 11/03/10 17:28, David Sommerseth wrote:
> This is a modified version of a patch sent to the sf.net
> patch tracker:
> <http://sourceforge.net/tracker/?func=detail&aid=2491190&group_id=48978&atid=454721>
> 
> After having disucssed this patch on IRC (#openvpn-discussions)
> March 4, 2010, it was decided to accept this patch when not modifying
> TARGET_* defines through out the code.  Further, in a mail comment
> Alon Bar-Lev had some other comments of what would be needed to be done.
> 
> Mail reference:
> <http://thread.gmane.org/gmane.network.openvpn.devel/3176>
> 
> This patch has been tested by bootstrapping the code on a RHEL4.6 box.
> with the following autotools packages installed:
> autoconf-2.59-5
> automake-1.9.2-3
> libtool-1.5.6-4.EL4.2
> 
> It builds cleanly and 'make check' passes.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  acinclude.m4 |   10 +++++-----
>  configure.ac |   33 ++++++++++++++++-----------------
>  2 files changed, 21 insertions(+), 22 deletions(-)
> 

Applied to the bugfix2.1 branch, to be merged into allmerged.
Commit ec40407472ce2df50d9f3826d984738108563695


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuf/PcACgkQDC186MBRfrp/oQCdEy3PzQbf2Qv717aHjrgJDJsi
1LQAnRTncAfE3XbFE0+glgC/2/EuHOZG
=80do
-----END PGP SIGNATURE-----

