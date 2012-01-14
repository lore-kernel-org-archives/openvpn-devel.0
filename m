Message-ID: <4F116C87.5090805@...1114...>
Date: Sat, 14 Jan 2012 12:52:39 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F116B5F.1070100@...1114...>
In-Reply-To: <4F116B5F.1070100@...1114...>
Content-Type: multipart/mixed; boundary="------------080604090001000103080509"
Subject: Re: [Openvpn-devel] [PATCH] Fix pool logging when IPv6 is not
	enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080604090001000103080509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/01/12 12:47, David Sommerseth wrote:
|
| Hi,
|
| I'm running the master branch (commit 330baf2aee70b35) on a site where IPv6
| tunnelling is not enabled.  I found some odd IPv6 addresses in the log file
| when clients connected.  Attached is a patch solving this issue.  It's
| basically a bogus message, and nothing seems to be pushed to the client.
|
| This site is now running with this patch applied, and it behaves better.
|

New improvement, now even with an attachment ... duh!  ;-)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk8RbIYACgkQDC186MBRfrreXgCdGNPaFkQ7Fk0PBixv73t4JXpR
E2kAnRut4h8V0/3SoFcCTty6WjXhC5IC
=mghf
-----END PGP SIGNATURE-----

--------------080604090001000103080509
Content-Type: text/plain;
	name="0001-Fix-pool-logging-when-IPv6-is-not-enabled.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Fix-pool-logging-when-IPv6-is-not-enabled.patch"

From 7e05a5b08d2a6a6d2017de2e12c36294b8aa5326 Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Sat, 14 Jan 2012 12:34:59 +0100
Subject: [PATCH] Fix pool logging when IPv6 is not enabled

If IPv6 tunnelling is not enabled, a bogus IPv6 address would be
printed in the log, like this:

  MULTI_sva: pool returned IPv4=10.8.0.4, IPv6=2180:8:2100:0:d4b4:f11d:18bf:2f00

It turns out that the remote_ipv6 buffer was not cleared.  Added
an extra check to also replace a "IPv6=::" log message with
information that the IPv6 feature is disabled in these cases.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 multi.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/multi.c b/multi.c
index 9535f43..90483fc 100644
--- a/multi.c
+++ b/multi.c
@@ -1307,6 +1307,7 @@ multi_select_virtual_addr (struct multi_context *m, struct multi_instance *mi)
       if (!mi->context.options.duplicate_cn)
 	cn = tls_common_name (mi->context.c2.tls_multi, true);
 
+      CLEAR(remote_ipv6);
       mi->vaddr_handle = ifconfig_pool_acquire (m->ifconfig_pool, &local, &remote, &remote_ipv6, cn);
       if (mi->vaddr_handle >= 0)
 	{
@@ -1314,8 +1315,10 @@ multi_select_virtual_addr (struct multi_context *m, struct multi_instance *mi)
 	  const int tunnel_topology = TUNNEL_TOPOLOGY (mi->context.c1.tuntap);
 
 	  msg( M_INFO, "MULTI_sva: pool returned IPv4=%s, IPv6=%s", 
-		    print_in_addr_t( remote, 0, &gc ),
-		    print_in6_addr( remote_ipv6, 0, &gc ) );
+	       print_in_addr_t( remote, 0, &gc ),
+	       (mi->context.options.ifconfig_ipv6_pool_defined
+		? print_in6_addr( remote_ipv6, 0, &gc )
+		: "(Not enabled)") );
 
 	  /* set push_ifconfig_remote_netmask from pool ifconfig address(es) */
 	  mi->context.c2.push_ifconfig_local = remote;
-- 
1.7.3.4


--------------080604090001000103080509
Content-Type: application/pgp-signature;
	name="0001-Fix-pool-logging-when-IPv6-is-not-enabled.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0001-Fix-pool-logging-when-IPv6-is-not-enabled.patch.sig"

iEYEABECAAYFAk8RbIcACgkQDC186MBRfrodRwCdHI/Zq/oJIJ89//yLw32aM5sRzEAAn0b3
A4NebBF3O3emTcB4XiPov3Mi
--------------080604090001000103080509--

