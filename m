Message-ID: <4EB7E67D.8080900@...1114...>
Date: Mon, 07 Nov 2011 15:09:01 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
	<1320074961-3809-4-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-4-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 3/8] Fixed missing comma in plugin.h
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
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/10/11 16:29, Adriaan de Jong wrote:
> --- a/plugin.h +++ b/plugin.h @@ -132,7 +132,7 @@ plugin_call(const
> struct plugin_list *pl, { return plugin_call_ssl(pl, type, av, pr, es 
> #ifdef USE_SSL -      -1, NULL +      , -1, NULL #endif ); }

ACK!  Tested on top master (6e8b90ec0d0a074ac529541ce9515f25b30bac88),
and plugin issues found earlier is now fixed with this patch.

Applied to -testing and -stable master branches.

commit 8d22a9905d1243dbaf10493abdbb91718e8f9969
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Oct 31 16:29:16 2011 +0100

    Fixed missing comma in plugin.h

    Fixed a bug where the wrong value was being passed to plugin_call_ssl,
    due to a missing comma.

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


This patch also obsoletes the patch I sent earlier to the list, "[PATCH]
Fix plugin_call() struct env_set corruption" [1]


kind regards,

David Sommerseth



[1] <http://thread.gmane.org/gmane.network.openvpn.devel/5042>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk635nsACgkQDC186MBRfroYjgCeNUOTk6l/i+TdgZxVtCXyvofc
sR8AniMJYWmVTH6HHV1NAX/3Hj1gR0CQ
=j5Ru
-----END PGP SIGNATURE-----

