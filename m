Message-ID: <4F227146.6000400@...1114...>
Date: Fri, 27 Jan 2012 10:41:26 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1327405130-22393-1-git-send-email-davids@...1347...>
In-Reply-To: <1327405130-22393-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Add
 --route-pre-down/OPENVPN_PLUGIN_ROUTE_PREDOWN script/plug-in hook
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

On 24/01/12 12:38, David Sommerseth wrote:
> This patchs adds a script/plug-in hook which is called right before 
> the network routes are taken down.  This is give external processes a 
> possibility to tear down communication over the VPN before the VPN 
> disappears.
> 
> One use case can be to mount a networked file system over the VPN via 
> --route-up.  And then to unmount this file system via 
> --route-pre-down
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- init.c |   21
> +++++++++++++++++++-- openvpn-plugin.h |    3 ++- openvpn.8 |    4
> ++++ options.c        |   11 +++++++++++ options.h        | 1 + 5
> files changed, 37 insertions(+), 3 deletions(-)

Applied to master branches in -testing and -stable git trees.

commit 415421c24ac5b62d59fb8f03076521cba6f126cc
Author: David Sommerseth <davids@...1347...>
Date:   Tue Jan 24 12:32:46 2012 +0100

    Add --route-pre-down/OPENVPN_PLUGIN_ROUTE_PREDOWN script/plug-in hook

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8icUYACgkQDC186MBRfrpD5ACdGr+2MpwXfzQyuBEp7i13KZsE
uZUAn2aIU78ovn6c0AC+8MgIm5QnAMhg
=2Oqk
-----END PGP SIGNATURE-----

