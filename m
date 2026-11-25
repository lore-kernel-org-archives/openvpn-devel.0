Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C80606A32A
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YBu0fP1X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DIPUF6c2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UmlnBXbH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hZTsIOwB4Ju0H5XTo6e8ZhfPNLdcwGzJzbmdD8dO7pA=; b=YBu0fP1Xq1yl/E
	vcyJf8KzwTJXF+RFsanRSClHKBDAhAp6XkBUVefbDmINHL4Hg5bwmE8rG6eRRoX4Jzh6e9ovRgDZ9
	zUB0b7oTbKexNtz8dAvD6oN0edQGFjxjctsoXCoCkNNfuZKfeC/ukZB9rXqS/lqKEHbAOPBj7fH2V
	/Gk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWGpl-000000004Pr-3qQm;
	Wed, 25 Nov 2026 17:31:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWGpl-000000004Pl-16sq for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:31:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IYybyHfaRUEawxN1fb8KtE/9dclm5EpqsGzm3Ivi8ks=; b=DIPUF6c2SwrvjnLARFNy6kUj3y
 gQ/KrxHFUpkmnVBNsHwosGEVy+rdyO17n/0QQKzsdDXJT09gNVQPh2c6Rj4LyakTwLdH8NbdKY0Sj
 men94z7pPbQwL4u+DXghZjstSxwJ7YaUD0T4OqCVWPMMeUQebx+1kM3/RlWN2s8iyJnI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IYybyHfaRUEawxN1fb8KtE/9dclm5EpqsGzm3Ivi8ks=; b=UmlnBXbH+blwjrbrVhb9Yg/NTC
 9VjXX+OiNDge4pGK06ROoP15BQHjDFNH8U+onDq1vCKqPozLWETPNJbbonC2/pD7UK6us5/bK9Pns
 01idGvqwMiElVzi4kryQZJsdSCxPx8+nIwM1gK2cuPyE2g/WY4XX3mvx76tFdaO2CNWg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWGpj-000000005sj-1Y7b for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:31:05 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6APHUuOk023358
 for <openvpn-devel@lists.sourceforge.net>; Wed, 25 Nov 2026 18:30:56 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6APHUuKb023357
 for openvpn-devel@lists.sourceforge.net; Wed, 25 Nov 2026 18:30:56 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 25 Nov 2026 18:30:50 +0100
Message-ID: <20261125173055.23341-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWGpj-000000005sj-1Y7b
Subject: [Openvpn-devel] [PATCH v2] Windows: Switch all uses of address
 family to ADDRESS_FAMILY type
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Lichtenheld <frank@lichtenheld.com>

Previously we had conversion errors between short
and unsigned short.

Also remove useless SetNameServers wrapper. Wrapping
only a name is really not that useful.

Add a definition for ADDRESS_FAMILY for cppcheck.
The built-in windows platform definition doesn't
cover it.

Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2342
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2342
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/openvpn-cppcheck-windows.cfg b/dev-tools/openvpn-cppcheck-windows.cfg
index dca2b07..19d32a1 100644
--- a/dev-tools/openvpn-cppcheck-windows.cfg
+++ b/dev-tools/openvpn-cppcheck-windows.cfg
@@ -8,6 +8,7 @@
       <formatstr />
     </arg>
   </function>
+  <podtype name="ADDRESS_FAMILY" sign="u" size="2" />
   <!-- MinGW uses GCC, so we need to handle GCC builtins. gnu.cfg has these,
        but we do not load it for Windows. Without this cppcheck does not
        understand our likely()/unlikely() macros. -->
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index ca3267e8..dd20f7b 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -80,7 +80,7 @@
 typedef struct
 {
     message_header_t header;
-    short family;
+    ADDRESS_FAMILY family;
     inet_address_t address;
     int prefix_len;
     interface_t iface;
@@ -89,7 +89,7 @@
 typedef struct
 {
     message_header_t header;
-    short family;
+    ADDRESS_FAMILY family;
     inet_address_t prefix;
     int prefix_len;
     inet_address_t gateway;
@@ -102,7 +102,7 @@
     message_header_t header;
     interface_t iface;
     char domains[512];
-    short family;
+    ADDRESS_FAMILY family;
     unsigned int addr_len;
     inet_address_t addr[4]; /* support up to 4 dns addresses */
 } dns_cfg_message_t;
@@ -150,7 +150,7 @@
 typedef struct
 {
     message_header_t header;
-    short family;
+    ADDRESS_FAMILY family;
     interface_t iface;
 } flush_neighbors_message_t;
 
@@ -177,7 +177,7 @@
 {
     message_header_t header;
     interface_t iface;
-    short family;
+    ADDRESS_FAMILY family;
     int mtu;
 } set_mtu_message_t;
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index fe1af45..65edf73 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -101,7 +101,7 @@
 static void netsh_ifconfig(const struct tuntap_options *to, DWORD adapter_index, const in_addr_t ip,
                            const in_addr_t netmask, const unsigned int flags);
 
-static void windows_set_mtu(const int iface_index, const short family, const int mtu);
+static void windows_set_mtu(const int iface_index, const ADDRESS_FAMILY family, const int mtu);
 
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list, const unsigned int addr_len,
                                    DWORD adapter_index);
@@ -118,7 +118,7 @@
 #endif
 
 static bool
-do_address_service(const bool add, const short family, const struct tuntap *tt)
+do_address_service(const bool add, const ADDRESS_FAMILY family, const struct tuntap *tt)
 {
     bool ret = false;
     ack_message_t ack;
@@ -241,7 +241,7 @@
 }
 
 static void
-do_dns_service(bool add, const short family, const struct tuntap *tt)
+do_dns_service(bool add, const ADDRESS_FAMILY family, const struct tuntap *tt)
 {
     ack_message_t ack;
     struct gc_arena gc = gc_new();
@@ -366,7 +366,7 @@
 }
 
 static bool
-do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
+do_set_mtu_service(const struct tuntap *tt, const ADDRESS_FAMILY family, const int mtu)
 {
     bool ret = false;
     ack_message_t ack;
@@ -5320,7 +5320,7 @@
 }
 
 static void
-windows_set_mtu(const int iface_index, const short family, const int mtu)
+windows_set_mtu(const int iface_index, const ADDRESS_FAMILY family, const int mtu)
 {
     DWORD err = 0;
     MIB_IPINTERFACE_ROW ipiface;
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ad0fda2..fb7463a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -536,7 +536,7 @@
 #endif
 
 static SOCKADDR_INET
-sockaddr_inet(short family, const inet_address_t *addr)
+sockaddr_inet(ADDRESS_FAMILY family, const inet_address_t *addr)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet));
@@ -1865,7 +1865,7 @@
  * @return BOOL to indicate success or failure
  */
 static BOOL
-GetInterfacesKey(short family, PHKEY key)
+GetInterfacesKey(ADDRESS_FAMILY family, PHKEY key)
 {
     PCSTR itfs_key = family == AF_INET6
                          ? "SYSTEM\\CurrentControlSet\\Services\\Tcpip6\\Parameters\\Interfaces"
@@ -1875,7 +1875,7 @@
     if (err)
     {
         *key = INVALID_HANDLE_VALUE;
-        MsgToEventLog(M_SYSERR, L"%S: could not open interfaces registry key for family %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not open interfaces registry key for family %hu (%lu)",
                       __func__, family, err);
     }
 
@@ -1892,7 +1892,7 @@
  * @return DWORD NO_ERROR on success, a Windows error code otherwise
  */
 static DWORD
-SetNameServersValue(PCWSTR itf_id, short family, PCSTR value)
+SetNameServersValue(PCWSTR itf_id, ADDRESS_FAMILY family, PCSTR value)
 {
     DWORD err;
 
@@ -1906,7 +1906,7 @@
     err = RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &itf);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%S: could not open interface key for %s family %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not open interface key for %s family %hu (%lu)",
                       __func__, itf_id, family, err);
         goto out;
     }
@@ -1914,7 +1914,7 @@
     err = RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, (DWORD)strlen(value) + 1);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%S: could not set name servers '%S' for %s family %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not set name servers '%S' for %s family %hu (%lu)",
                       __func__, value, itf_id, family, err);
     }
 
@@ -1931,21 +1931,6 @@
 }
 
 /**
- * Set the DNS name servers in a registry interface configuration
- *
- * @param itf_id    the interface id to set the servers for
- * @param family    internet address family to set the servers for
- * @param addrs     comma separated list of name server addresses
- *
- * @return DWORD NO_ERROR on success, a Windows error code otherwise
- */
-static DWORD
-SetNameServers(PCWSTR itf_id, short family, PCSTR addrs)
-{
-    return SetNameServersValue(itf_id, family, addrs);
-}
-
-/**
  * Delete all DNS name servers from a registry interface configuration
  *
  * @param itf_id    the interface id to clear the servers for
@@ -1954,7 +1939,7 @@
  * @return DWORD NO_ERROR on success, a Windows error code otherwise
  */
 static DWORD
-ResetNameServers(PCWSTR itf_id, short family)
+ResetNameServers(PCWSTR itf_id, ADDRESS_FAMILY family)
 {
     return SetNameServersValue(itf_id, family, "");
 }
@@ -2042,7 +2027,7 @@
             offset = strlen(addrs);
         }
 
-        err = SetNameServers(iid, msg->family, addrs);
+        err = SetNameServersValue(iid, msg->family, addrs);
         if (err)
         {
             return err;
@@ -2103,10 +2088,10 @@
 static LSTATUS
 SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addresses)
 {
-    const short families[] = { AF_INET, AF_INET6 };
+    const ADDRESS_FAMILY families[] = { AF_INET, AF_INET6 };
     for (size_t i = 0; i < _countof(families); i++)
     {
-        short family = families[i];
+        ADDRESS_FAMILY family = families[i];
 
         /* Create a comma sparated list of addresses of this family */
         size_t offset = 0;
@@ -2134,7 +2119,7 @@
         }
 
         /* Set name server addresses */
-        LSTATUS err = SetNameServers(itf_id, family, addr_list);
+        LSTATUS err = SetNameServersValue(itf_id, family, addr_list);
         if (err)
         {
             return err;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
