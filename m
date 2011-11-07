Message-ID: <4EB7E6D8.4040708@...1114...>
Date: Mon, 07 Nov 2011 15:10:32 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1319368508-3411-1-git-send-email-davids@...1347...>
In-Reply-To: <1319368508-3411-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix plugin_call() struct env_set
	corruption
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/10/11 13:15, David Sommerseth wrote:
> For some odd reasons, the static inline plugin_call() function
> managed to corrupt the struct env_set *es pointer.  The result was
> that es->list pointed at an invalid address, which again caused SEGV.
> 
> This patch replaces the static inline function with a macro instead,
> and let the plugin_call_ssl() keep all its arguments - no matter if
> SSL is enabled or not.
> 
> This issues appeared first in commit
> 1876ccd012e9e2ca6f8e1cd9e7e9bb4bf24ccecb, which does modify the plugin
> system.
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- plugin.c |
> 5 +---- plugin.h |   21 +++------------------ 2 files changed, 4
> insertions(+), 22 deletions(-)

This patch is obsoleted by this patch:
<http://thread.gmane.org/gmane.network.openvpn.devel/5080/focus=5076>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk635tgACgkQDC186MBRfrqDzwCggGdglsuRKYERtPMpET7U5ewT
wHYAn1koidWoqGEOtda6hMotf1vze36f
=GFgo
-----END PGP SIGNATURE-----

