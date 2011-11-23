Message-ID: <4ECD8474.2050903@...1114...>
Date: Thu, 24 Nov 2011 00:40:36 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1321619990-12173-1-git-send-email-davids@...1347...>
In-Reply-To: <1321619990-12173-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Make '--win-sys env' default
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

On 18/11/11 13:39, David Sommerseth wrote:
> Without this patch, the default path used by OpenVPN is hard coded to 
> C:\WINDOWS.  As users might install Windows in a different directory, 
> this approach will cause OpenVPN to malfunction in some 
> configurations.
> 
> OpenVPN have supported using the system path, by adding --win-sys env.
> This patch removes the hard coded approach and uses the --win-sys env
> approach by default instead.
> 
> Trac-ticket: 66 URL: 
> http://thread.gmane.org/gmane.network.openvpn.user/32508 
> Signed-off-by: David Sommerseth <davids@...1347...> Tested-by: Samuli 
> Seppänen <samuli@...515...> --- openvpn.8 |   19 +++++++++++--------
> openvpn.c |    2 +- options.c |    8 +++++--- win32.c   |    6 ------
> win32.h   |    2 -- 5 files changed, 17 insertions(+), 20
> deletions(-)

Pushed to master branch in -testing and -stable trees.
Commit 9f6ac06b6d15e14566b820018f295233e831eb68


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7NhHIACgkQDC186MBRfrpaDgCgo78kW5xf1VmKRv71trzfj7kD
qncAnjkv0tDxiQSyo0g1qZXnsReu0DXq
=miUe
-----END PGP SIGNATURE-----

