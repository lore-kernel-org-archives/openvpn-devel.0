From: chantra <chantra@...1258...>
Content-Type: multipart/mixed; boundary="=-9HY6a4F45dYetKLbY3nR"
Date: Mon, 02 Aug 2010 12:41:46 +0200
Message-ID: <1280745707.15672.19.camel@...1259...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [Patch] Typo in openvpn plugin documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-9HY6a4F45dYetKLbY3nR
Content-Type: multipart/alternative; boundary="=-DJbHYJHz7pAPohu8tKbd"

--=-DJbHYJHz7pAPohu8tKbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi all,

I have found some inconsistency in openvpn-plugin.h documentation, see
https://community.openvpn.net/openvpn/ticket/31

It is a pretty trivial change which only affect documentation so it is
safe to apply.

chantra

-- 
http://www.debuntu.org

--=-DJbHYJHz7pAPohu8tKbd
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.3">
</HEAD>
<BODY>
Hi all,<BR>
<BR>
I have found some inconsistency in openvpn-plugin.h documentation, see <A HREF="https://community.openvpn.net/openvpn/ticket/31">https://community.openvpn.net/openvpn/ticket/31</A><BR>
<BR>
It is a pretty trivial change which only affect documentation so it is safe to apply.<BR>
<BR>
chantra<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<PRE>
-- 
<A HREF="http://www.debuntu.org">http://www.debuntu.org</A>
</PRE>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-DJbHYJHz7pAPohu8tKbd--

--=-9HY6a4F45dYetKLbY3nR
Content-Disposition: attachment;
	filename="0001-Fix-errors-in-openvpn-plugin.h-documentation.patch"
Content-Type: text/x-patch;
	name="0001-Fix-errors-in-openvpn-plugin.h-documentation.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 5d1d06bd472be699163928069d898029a8492cfe Mon Sep 17 00:00:00 2001
From: chantra <chantra@...1258...>
Date: Fri, 30 Jul 2010 20:48:50 +0200
Subject: [PATCH] Fix errors in openvpn-plugin.h documentation


Signed-off-by: chantra <chantra@...1258...>
---
 openvpn-plugin.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/openvpn-plugin.h b/openvpn-plugin.h
index 56b0a70..173a0c1 100644
--- a/openvpn-plugin.h
+++ b/openvpn-plugin.h
@@ -41,6 +41,7 @@
  * New Client Connection:
  *
  * FUNC: openvpn_plugin_client_constructor_v1
+ * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_ENABLE_PF
  * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_TLS_VERIFY (called once for every cert
  *                                                     in the server chain)
  * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
@@ -72,7 +73,7 @@
  * [Client session continues]
  *
  * FUNC: openvpn_plugin_func_v1 OPENVPN_PLUGIN_CLIENT_DISCONNECT
- * FUNC: openvpn_plugin_client_constructor_v1
+ * FUNC: openvpn_plugin_client_destructor_v1
  *
  * [ some time may pass ]
  *
-- 
1.7.0.4


--=-9HY6a4F45dYetKLbY3nR--



