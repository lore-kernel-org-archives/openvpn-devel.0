From: Gert Doering <gert@...1296...>
Date: Thu, 18 Jan 2024 14:55:30 +0100
Message-ID: <20240118135530.3911-1-gert@...1296...>
In-Reply-To: <gerrit.1705584340000.Ia9c5453dc08679ffb73a275ddd4f28095ff1c1f8@...2715...>
References: <gerrit.1705584340000.Ia9c5453dc08679ffb73a275ddd4f28095ff1c1f8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove conditional text for Apache2
 linking exception
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

From: Arne Schwabe <arne@...1227...>

With the reimplementation of the tls-export feature and removal/approval
or being trivial of the rest of the code, now all the code falls under
new license. Remove the conditional text of the license to be only valid
for parts of OpenVPN.

Change-Id: Ia9c5453dc08679ffb73a275ddd4f28095ff1c1f8
Acked-by: dazo <dazo@...2108...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/502
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
dazo <dazo@...2108...>

        
diff --git a/COPYING b/COPYING
index ab59cef..28525d7 100644
--- a/COPYING
+++ b/COPYING
@@ -33,11 +33,6 @@
 
 Apache2 linking exception:
 ---------------------------
-OpenVPN is currently undergoing a license change to add an exception for
-Apache 2 linking. The following exception is only valid for new contributions
-after 2023-05-03 and past contribution where the authors have already agreed
-to the exception.
-
   In addition, as a special exception, OpenVPN Inc and the
   contributors give permission to link the code of this program to
   libraries (the "Libraries") licensed under the Apache License

