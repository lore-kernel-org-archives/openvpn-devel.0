Message-ID: <4D87B901.8040407@...1114...>
Date: Mon, 21 Mar 2011 21:45:53 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1300199801-4712-1-git-send-email-samuli@...515...>
In-Reply-To: <1300199801-4712-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fixes to win/openvpn.nsi
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

On 15/03/11 15:36, Samuli Seppänen wrote:
> Added support for generating installer with unsigned TAP drivers. Fixed Windows
> Vista/7 Start menu shortcut uninstall failure.
> 
> Signed-off-by: Samuli Seppänen <samuli@...515...>
> ---
>  win/openvpn.nsi |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)
> 

Applied to beta2.2 and merged into allmerged.

commit 110e42d199e735ab1a31388c5678f59d0fa9510c
Author: Samuli Seppänen <samuli@...515...>
Date:   Tue Mar 15 16:36:41 2011 +0200

    Fixes to win/openvpn.nsi

    Signed-off-by: Samuli Seppänen <samuli@...515...>
    Acked-by: James Yonan <james@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2HuQEACgkQDC186MBRfrqyFACfep720cLd3ge1VTmikFqdznet
OxgAnjE8SaUs+3hIRwmDQuHMlzKdqQGn
=v1/4
-----END PGP SIGNATURE-----

