From: Gert Doering <gert@...1296...>
Date: Tue, 15 Apr 2025 17:56:50 +0200
Message-ID: <20250415155656.12963-1-gert@...1296...>
In-Reply-To: <gerrit.1744202768000.Ia7186b528773c0549748f1051c1c8d1db39a7e11@...2715...>
References: <gerrit.1744202768000.Ia7186b528773c0549748f1051c1c8d1db39a7e11@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Doxygen: Remove useless Python
 information
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

From: Frank Lichtenheld <frank@...2641...>

Do not include information for the trivial Python
scripts we have. Completely eliminates the "Namespaces"
page as well.

Change-Id: Ia7186b528773c0549748f1051c1c8d1db39a7e11
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/939
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfile.in
index 573b7c2..edecc54 100644
--- a/doc/doxygen/openvpn.doxyfile.in
+++ b/doc/doxygen/openvpn.doxyfile.in
@@ -894,36 +894,7 @@
 # *.ucf, *.qsf and *.ice.
 
 FILE_PATTERNS          = *.c \
-                         *.cc \
-                         *.cxx \
-                         *.cpp \
-                         *.c++ \
-                         *.d \
-                         *.java \
-                         *.ii \
-                         *.ixx \
-                         *.ipp \
-                         *.i++ \
-                         *.inl \
-                         *.h \
-                         *.hh \
-                         *.hxx \
-                         *.hpp \
-                         *.h++ \
-                         *.idl \
-                         *.odl \
-                         *.cs \
-                         *.php \
-                         *.php3 \
-                         *.inc \
-                         *.m \
-                         *.mm \
-                         *.dox \
-                         *.py \
-                         *.f90 \
-                         *.f \
-                         *.vhd \
-                         *.vhdl
+                         *.h
 
 # The RECURSIVE tag can be used to specify whether or not subdirectories should
 # be searched for input files as well.

