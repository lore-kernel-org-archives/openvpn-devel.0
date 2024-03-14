From: Gert Doering <gert@...1296...>
Date: Thu, 14 Mar 2024 19:55:27 +0100
Message-ID: <20240314185527.26803-1-gert@...1296...>
In-Reply-To: <gerrit.1710356871000.I1879c893ed19b165fd086728fb97951eac251681@...2715...>
References: <gerrit.1710356871000.I1879c893ed19b165fd086728fb97951eac251681@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove license warning from
 README.mbedtls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Max Fillinger <maximilian.fillinger@...2507...>

The licenses are compatible now, so we can remove the warning.

Change-Id: I1879c893ed19b165fd086728fb97951eac251681
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/561
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/README.mbedtls b/README.mbedtls
index 124eaa2..c4f3924 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -11,22 +11,6 @@
 
 *************************************************************************
 
-Warning:
-
-As of mbed TLS 2.17, it can be licensed *only* under the Apache v2.0 license.
-That license is incompatible with OpenVPN's GPLv2.
-
-We are currently in the process of resolving this problem, but for now, if you
-wish to distribute OpenVPN linked with mbed TLS, there are two options:
-
- * Ensure that your case falls under the system library exception in GPLv2, or
-
- * Use an earlier version of mbed TLS. Version 2.16.12 is the last release
-   that may be licensed under GPLv2. Unfortunately, this version is
-   unsupported and won't receive any more updates.
-
-*************************************************************************
-
 Due to limitations in the mbed TLS library, the following features are missing
 in the mbed TLS version of OpenVPN:
 

