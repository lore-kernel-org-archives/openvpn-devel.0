Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AF606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VJd/70b+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CBwcU2Wr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Zi6Fr2nQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0oMZCKTq0sfde/Ujkgzd/vRQnyWWcBSfhTzfsqr1y5c=; b=VJd/70b+ANGSM0
	pAui4Dzp/XQ3eobtxbvP3YyAGS5Te07rzKJlNdN4T/yZRrVNVod5QRzUiLvHctviLLG3E0/vx3uvW
	+QRo0AFzr8kg+KN56geppp3oxb9Cv21R9uErBmZyq7xVZehNYqqxF1/LMesQSKk9mRUP3IRe+W5TG
	rkk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWf3V-00000000477-3xYW;
	Thu, 26 Nov 2026 19:22:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWf3V-0000000046z-0ZZU for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 19:22:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UxiXnPBkn48QSubIWjmGjZ3Ir6Hv3yoiFVEoSHQmxdc=; b=CBwcU2WrkJc3XTWIBaPupK0svI
 zUh8umJq2QEbJAIU33oH8RqwHx5ItLh3nWa9ScbFlAH76mIG58PXn2qwEDRjZQw3Q4zsHsQ3male7
 q3QLWfkiLA37iQ5cMhNYumGgt91HMYBUpE5i5c5/kwVjJ9fwgZgvwPfjzv4NbOJpJ91g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UxiXnPBkn48QSubIWjmGjZ3Ir6Hv3yoiFVEoSHQmxdc=; b=Zi6Fr2nQUwp9cFBf8y5eaT9if2
 zT99O04doTHCet/rkBeyDMgRPCewg8ADI3iVVxRUp8AWBpYNXmimKEamAVFk1fYLE9yuhgTdg7pAH
 EEqoGjK/PgQvC5vRzdsJp8Q3U1aUPXSvtzo9BcNUdg5ymeJ1WTazaV2Wb2VpxmQMeuMg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWf3T-000000008BI-1Jti for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 19:22:52 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AQJMidJ018974
 for <openvpn-devel@lists.sourceforge.net>; Thu, 26 Nov 2026 20:22:44 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQJMiGt018973
 for openvpn-devel@lists.sourceforge.net; Thu, 26 Nov 2026 20:22:44 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 20:22:39 +0100
Message-ID: <20261126192244.18961-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
References: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWf3T-000000008BI-1Jti
Subject: [Openvpn-devel] [PATCH v2] Cleaning up Windows error handling for
 sign conversion
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

This is a mess, generally. Most functions return errors
as DWORD, but the Reg* ones use LSTATUS which is signed.

Trying to untangle this a bit, but still requires copious
casting.

Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2355
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2355
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index dd20f7b..9f0c9ce 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -157,7 +157,7 @@
 typedef struct
 {
     message_header_t header;
-    int error_number;
+    DWORD error_number;
 } ack_message_t;
 
 typedef struct
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index a3f7990..18d0b57 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -219,18 +219,13 @@
     va_end(arglist);
 }
 
-#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static const char *
 openvpn_strerror(int err, bool crt_error, struct gc_arena *gc)
 {
 #ifdef _WIN32
     if (!crt_error)
     {
-        return strerror_win32(err, gc);
+        return strerror_win32((DWORD)err, gc);
     }
 #endif
     return strerror(err);
@@ -694,10 +689,6 @@
     }
 }
 
-#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * In multiclient mode, put a client-specific prefix
  * before each message.
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 0056d05..91d4ffe 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -406,18 +406,13 @@
 }
 #endif
 
-#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static inline int
 openvpn_errno_maybe_crt(bool *crt_error)
 {
     int err = 0;
 #ifdef _WIN32
     *crt_error = false;
-    err = GetLastError();
+    err = (int)GetLastError();
     if (err == ERROR_SUCCESS)
     {
         /* error is likely C runtime */
@@ -431,10 +426,6 @@
     return err;
 }
 
-#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic pop
-#endif
-
 #include "errlevel.h"
 
 #endif /* ifndef ERROR_H */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 82cb7f0..0a1e65f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2805,7 +2805,7 @@
         ret = (ack.error_number == ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
         if (ret == RTA_ERROR)
         {
-            msg(M_WARN, "ERROR: route %s failed using service: %s [status=%d if_index=%lu]",
+            msg(M_WARN, "ERROR: route %s failed using service: %s [status=%lu if_index=%lu]",
                 (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
                 ack.error_number, rt->iface.index);
         }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 65edf73..074fe20 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -157,7 +157,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s address failed using service: %s [status=%d if_index=%lu]",
+        msg(M_WARN, "TUN: %s address failed using service: %s [status=%lu if_index=%lu]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc), ack.error_number,
             addr.iface.index);
         goto out;
@@ -228,7 +228,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s DNS domains failed using service: %s [status=%d if_name=%s]",
+        msg(M_WARN, "TUN: %s DNS domains failed using service: %s [status=%lu if_name=%s]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc), ack.error_number,
             dns.iface.name);
         goto out;
@@ -297,7 +297,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s %s dns failed using service: %s [status=%d if_name=%s]",
+        msg(M_WARN, "TUN: %s %s dns failed using service: %s [status=%lu if_name=%s]",
             (add ? "adding" : "deleting"), ip_proto_name, strerror_win32(ack.error_number, &gc),
             ack.error_number, dns.iface.name);
         goto out;
@@ -353,7 +353,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s WINS failed using service: %s [status=%d if_name=%s]",
+        msg(M_WARN, "TUN: %s WINS failed using service: %s [status=%lu if_name=%s]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
             ack.error_number, wins.iface.name);
         goto out;
@@ -391,7 +391,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=%d if_index=%lu]",
+        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=%lu if_index=%lu]",
             family_name, strerror_win32(ack.error_number, &gc), ack.error_number,
             mtu_msg.iface.index);
     }
@@ -469,7 +469,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: creating %s adapter using service failed: %s [status=%d]",
+        msg(M_NONFATAL, "TUN: creating %s adapter using service failed: %s [status=%lu]",
             print_tun_backend_driver(driver_type), strerror_win32(ack.error_number, &gc),
             ack.error_number);
     }
@@ -5305,7 +5305,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=%d if_index=%lu]",
+        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=%lu if_index=%lu]",
             strerror_win32(ack.error_number, &gc), ack.error_number, dhcp.iface.index);
     }
     else
@@ -5477,7 +5477,7 @@
 
     else if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "Register_dns failed using service: %s [status=0x%x]",
+        msg(M_WARN, "Register_dns failed using service: %s [status=0x%lx]",
             strerror_win32(ack.error_number, &gc), ack.error_number);
     }
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 2415847..a4ed152 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1239,7 +1239,7 @@
     if (ack.error_number != NO_ERROR)
     {
         msg(M_WARN,
-            "WFP block: %s block filters using service failed: %s [status=0x%x if_index=%lu]",
+            "WFP block: %s block filters using service failed: %s [status=0x%lx if_index=%lu]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc), ack.error_number,
             data.iface.index);
         goto out;
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index e20feb7..de7847e 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -38,7 +38,7 @@
 static DWORD
 GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR default_value)
 {
-    LONG status = RegGetValue(key, NULL, value, RRF_RT_REG_SZ, NULL, (LPBYTE)data, &size);
+    LSTATUS status = RegGetValue(key, NULL, value, RRF_RT_REG_SZ, NULL, (LPBYTE)data, &size);
 
     if (status == ERROR_FILE_NOT_FOUND && default_value)
     {
@@ -51,7 +51,7 @@
 
     if (status != ERROR_SUCCESS)
     {
-        SetLastError(status);
+        SetLastError((DWORD)status);
         return MsgToEventLog(
             M_SYSERR,
             L"Error querying registry value: HKLM\\SOFTWARE\\" _L(PACKAGE_NAME) L"%ls\\%ls",
@@ -91,19 +91,18 @@
 
     swprintf(reg_path, _countof(reg_path), L"SOFTWARE\\" _L(PACKAGE_NAME) L"%ls", service_instance);
 
-    LONG status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
+    LSTATUS status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
     if (status != ERROR_SUCCESS)
     {
-        SetLastError(status);
+        SetLastError((DWORD)status);
         return MsgToEventLog(M_SYSERR, L"Could not open Registry key HKLM\\%ls not found",
                              reg_path);
     }
 
     /* The default value of REG_KEY is the install path */
-    status = GetRegString(key, NULL, install_path, sizeof(install_path), NULL);
-    if (status != ERROR_SUCCESS)
+    error = GetRegString(key, NULL, install_path, sizeof(install_path), NULL);
+    if (error != ERROR_SUCCESS)
     {
-        error = status;
         goto out;
     }
 
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 1cb191a..0792a51 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -545,7 +545,7 @@
     return sa_inet;
 }
 
-static DWORD
+static NETIO_STATUS
 InterfaceLuid(const char *iface_name, PNET_LUID luid)
 {
     NETIO_STATUS convert_status;
@@ -569,16 +569,10 @@
     return memcmp(item, address, sizeof(MIB_UNICASTIPADDRESS_ROW)) == 0 ? TRUE : FALSE;
 }
 
-static DWORD
-DeleteAddress(PMIB_UNICASTIPADDRESS_ROW addr_row)
-{
-    return DeleteUnicastIpAddressEntry(addr_row);
-}
-
-static DWORD
+static NETIO_STATUS
 HandleAddressMessage(address_message_t *msg, undo_lists_t *lists)
 {
-    DWORD err;
+    NETIO_STATUS err;
     PMIB_UNICASTIPADDRESS_ROW addr_row;
     BOOL add = msg->header.type == msg_add_address;
 
@@ -621,12 +615,12 @@
         err = AddListItem(&(*lists)[address], addr_row);
         if (err)
         {
-            DeleteAddress(addr_row);
+            DeleteUnicastIpAddressEntry(addr_row);
         }
     }
     else
     {
-        err = DeleteAddress(addr_row);
+        err = DeleteUnicastIpAddressEntry(addr_row);
         if (err)
         {
             goto out;
@@ -1225,10 +1219,10 @@
  *
  * @return NO_ERROR on success, or the Windows error code for the failure
  */
-static DWORD
+static NETIO_STATUS
 InterfaceIdString(PCSTR itf_name, PWSTR str, size_t len)
 {
-    DWORD err;
+    NETIO_STATUS err;
     GUID guid;
     NET_LUID luid;
     PWSTR iid_str = NULL;
@@ -1784,10 +1778,10 @@
  * The gpol value is only valid if the function returns no error. In the error
  * case nothing is changed.
  */
-static DWORD
+static LSTATUS
 SetDnsSearchDomains(PCSTR itf_name, PCSTR domains, PBOOL gpol, undo_lists_t *lists)
 {
-    DWORD err = ERROR_OUTOFMEMORY;
+    LSTATUS err = ERROR_OUTOFMEMORY;
 
     HKEY list_key;
     BOOL have_list = GetDnsSearchListKey(itf_name, gpol, &list_key);
@@ -1882,12 +1876,12 @@
  * @param family    internet address family to set the servers for
  * @param value     the value to set the name servers to
  *
- * @return DWORD NO_ERROR on success, a Windows error code otherwise
+ * @return NO_ERROR on success, a Windows error code otherwise
  */
-static DWORD
+static LSTATUS
 SetNameServersValue(PCWSTR itf_id, ADDRESS_FAMILY family, PCSTR value)
 {
-    DWORD err;
+    LSTATUS err;
 
     HKEY itfs;
     if (!GetInterfacesKey(family, &itfs))
@@ -1929,9 +1923,9 @@
  * @param itf_id    the interface id to clear the servers for
  * @param family    internet address family to clear the servers for
  *
- * @return DWORD NO_ERROR on success, a Windows error code otherwise
+ * @return NO_ERROR on success, a Windows error code otherwise
  */
-static DWORD
+static LSTATUS
 ResetNameServers(PCWSTR itf_id, ADDRESS_FAMILY family)
 {
     return SetNameServersValue(itf_id, family, "");
@@ -1940,7 +1934,6 @@
 static DWORD
 HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
 {
-    DWORD err = 0;
     undo_type_t undo_type = (msg->family == AF_INET6) ? undo_dns6 : undo_dns4;
     unsigned int addr_len = msg->addr_len;
 
@@ -1965,10 +1958,10 @@
     }
 
     WCHAR iid[64];
-    err = InterfaceIdString(msg->iface.name, iid, _countof(iid));
-    if (err)
+    DWORD iid_err = InterfaceIdString(msg->iface.name, iid, _countof(iid));
+    if (iid_err)
     {
-        return err;
+        return iid_err;
     }
 
     /* We delete all current addresses before adding any
@@ -1976,10 +1969,10 @@
      */
     if (addr_len > 0 || msg->header.type == msg_del_dns_cfg)
     {
-        err = ResetNameServers(iid, msg->family);
+        LSTATUS err = ResetNameServers(iid, msg->family);
         if (err)
         {
-            return err;
+            return (DWORD)err;
         }
         free(RemoveListItem(&(*lists)[undo_type], CmpAny, iid));
     }
@@ -1987,13 +1980,14 @@
     if (msg->header.type == msg_del_dns_cfg)
     {
         BOOL gpol = FALSE;
+        LSTATUS err = 0;
         if (msg->domains[0])
         {
             /* setting an empty domain list removes any previous value */
             err = SetDnsSearchDomains(msg->iface.name, NULL, &gpol, lists);
         }
         ApplyDnsSettings(gpol);
-        return err; /* job done */
+        return (DWORD)err; /* job done */
     }
 
     if (addr_len > 0)
@@ -2020,10 +2014,10 @@
             offset = strlen(addrs);
         }
 
-        err = SetNameServersValue(iid, msg->family, addrs);
+        LSTATUS err = SetNameServersValue(iid, msg->family, addrs);
         if (err)
         {
-            return err;
+            return (DWORD)err;
         }
 
         wchar_t *tmp_iid = _wcsdup(iid);
@@ -2036,13 +2030,14 @@
     }
 
     BOOL gpol = FALSE;
+    LSTATUS domain_err = 0;
     if (msg->domains[0])
     {
-        err = SetDnsSearchDomains(msg->iface.name, msg->domains, &gpol, lists);
+        domain_err = SetDnsSearchDomains(msg->iface.name, msg->domains, &gpol, lists);
     }
     ApplyDnsSettings(gpol);
 
-    return err;
+    return (DWORD)domain_err;
 }
 
 /**
@@ -2076,7 +2071,7 @@
  * @param itf_id        the VPN interface ID to set the name servers for
  * @param addresses     the list of NRPT addresses
  *
- * @return LSTATUS NO_ERROR in case of success, a Windows error code otherwise
+ * @return NO_ERROR in case of success, a Windows error code otherwise
  */
 static LSTATUS
 SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addresses)
@@ -2147,7 +2142,7 @@
  * @param  size       pointer to the size of the buffer, contains the
  *                    size of the addresses on return
  *
- * @return LSTATUS NO_ERROR on success, a Windows error code otherwise
+ * @return NO_ERROR on success, a Windows error code otherwise
  */
 static LSTATUS
 GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)
@@ -2193,7 +2188,7 @@
  * @param  size       pointer to the size of the buffer, contains the
  *                    size of the addresses on return
  *
- * @return LSTATUS NO_ERROR on success, a Windows error code otherwise
+ * @return NO_ERROR on success, a Windows error code otherwise
  */
 static LSTATUS
 GetItfDnsServersV6(HKEY itf_key, PSTR addrs, PDWORD size)
@@ -2304,7 +2299,7 @@
  *                                the terminating zeros or 0.
  * @param[in]     capacity        capacity of the \p domains buffer in bytes
  *
- * @return LSTATUS NO_ERROR if all domain suffix(es) were converted successfully,
+ * @return NO_ERROR if all domain suffix(es) were converted successfully,
  *         ERROR_FILE_NOT_FOUND if no domain was left after the conversion,
  *         ERROR_MORE_DATA if not all converted domains did fit into the buffer.
  *         ERROR_OUTOFMEMORY if the temporary buffer could not be allocated.
@@ -2402,7 +2397,7 @@
  *                         set to the size of the string returned, including
  *                         the terminating zeros or 0.
  *
- * @return LSTATUS NO_ERROR if the domain suffix(es) were read successfully,
+ * @return NO_ERROR if the domain suffix(es) were read successfully,
  *         ERROR_FILE_NOT_FOUND if no domain was found for the interface,
  *         ERROR_MORE_DATA if the list did not fit into the buffer,
  *         any other error indicates an error while reading from the registry.
@@ -2415,7 +2410,7 @@
         return ERROR_INVALID_PARAMETER;
     }
 
-    LSTATUS err = ERROR_FILE_NOT_FOUND;
+    LSTATUS err;
     const DWORD buf_size = *size;
     const DWORD glyph_size = sizeof(*domains);
     PWSTR values[] = { L"SearchList", L"Domain", L"DhcpDomainSearchList", L"DhcpDomain", NULL };
@@ -2621,12 +2616,12 @@
  *
  * @return NO_ERROR on success, or Windows error code
  */
-static DWORD
+static LSTATUS
 SetNrptRule(HKEY nrpt_key, PCWSTR subkey, PCSTR address, PCWSTR domains, DWORD dom_size,
             BOOL dnssec)
 {
     /* Create rule subkey */
-    DWORD err = NO_ERROR;
+    LSTATUS err = NO_ERROR;
     HKEY rule_key;
     err = RegCreateKeyExW(nrpt_key, subkey, 0, NULL, 0, KEY_ALL_ACCESS, NULL, &rule_key, NULL);
     if (err)
@@ -2729,13 +2724,12 @@
             break;
         }
 
-        DWORD err;
         WCHAR subkey[48];
         swprintf(subkey, _countof(subkey), L"OpenVPNDNSRoutingX-%02x-%lu", ++n, ovpn_pid);
-        err = SetNrptRule(nrpt_key, subkey, d->addresses, d->domains, d->domains_size, FALSE);
+        LSTATUS err = SetNrptRule(nrpt_key, subkey, d->addresses, d->domains, d->domains_size, FALSE);
         if (err)
         {
-            MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func__, subkey, err);
+            MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%ld)", __func__, subkey, err);
         }
     }
 }
@@ -2752,11 +2746,11 @@
  *
  * @return NO_ERROR on success, or a Windows error code
  */
-static DWORD
+static LSTATUS
 SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses, const char *domains,
              const char *search_domains, BOOL dnssec, DWORD ovpn_pid)
 {
-    DWORD err = NO_ERROR;
+    LSTATUS err = NO_ERROR;
     PWSTR wide_domains = L".\0"; /* DNS route everything by default */
     DWORD dom_size = 6;
 
@@ -2815,7 +2809,7 @@
         err = SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_size, dnssec);
         if (err)
         {
-            MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func__, subkey, err);
+            MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%ld)", __func__, subkey, err);
         }
     }
 
@@ -3033,14 +3027,15 @@
     }
 
     HKEY key;
-    LSTATUS err = OpenNrptBaseKey(&key, &gpol_nrpt);
-    if (err)
+    LSTATUS reg_err = OpenNrptBaseKey(&key, &gpol_nrpt);
+    if (reg_err)
     {
-        return err;
+        return (DWORD)reg_err;
     }
 
     /* Add undo information first in case there's no heap left */
     PDWORD pid = malloc(sizeof(ovpn_pid));
+    DWORD err = 0;
     if (!pid)
     {
         err = ERROR_OUTOFMEMORY;
@@ -3056,10 +3051,11 @@
 
     /* Set NRPT rules */
     BOOL dnssec = (msg->flags & nrpt_dnssec) != 0;
-    err = SetNrptRules(key, msg->addresses, msg->resolve_domains, msg->search_domains, dnssec,
-                       ovpn_pid);
-    if (err)
+    reg_err = SetNrptRules(key, msg->addresses, msg->resolve_domains, msg->search_domains, dnssec,
+                           ovpn_pid);
+    if (reg_err)
     {
+        err = (DWORD)reg_err;
         goto out;
     }
 
@@ -3071,9 +3067,10 @@
      */
     if (msg->search_domains[0] || !msg->resolve_domains[0])
     {
-        err = SetNameServerAddresses(iid, msg->addresses);
-        if (err)
+        reg_err = SetNameServerAddresses(iid, msg->addresses);
+        if (reg_err)
         {
+            err = (DWORD)reg_err;
             goto out;
         }
     }
@@ -3081,7 +3078,7 @@
     /* Set search domains, if any */
     if (msg->search_domains[0])
     {
-        err = SetDnsSearchDomains(msg->iface.name, msg->search_domains, &gpol_list, lists);
+        err = (DWORD)SetDnsSearchDomains(msg->iface.name, msg->search_domains, &gpol_list, lists);
     }
 
     ApplyDnsSettings(gpol_nrpt || gpol_list);
@@ -3389,7 +3386,7 @@
             switch (type)
             {
                 case address:
-                    DeleteAddress(item->data);
+                    DeleteUnicastIpAddressEntry(item->data);
                     break;
 
                 case route:
@@ -3799,7 +3796,7 @@
     RPC_STATUS rpc_stat = UuidCreate(&pipe_uuid);
     if (rpc_stat != RPC_S_OK)
     {
-        ReturnError(pipe, rpc_stat, L"UuidCreate", 1, &exit_event);
+        ReturnError(pipe, (DWORD)rpc_stat, L"UuidCreate", 1, &exit_event);
         goto out;
     }
 
@@ -3807,7 +3804,7 @@
     rpc_stat = UuidToStringW(&pipe_uuid, &pipe_uuid_str);
     if (rpc_stat != RPC_S_OK)
     {
-        ReturnError(pipe, rpc_stat, L"UuidToString", 1, &exit_event);
+        ReturnError(pipe, (DWORD)rpc_stat, L"UuidToString", 1, &exit_event);
         goto out;
     }
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
