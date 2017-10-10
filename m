From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:28 +0200
Message-Id: <20171010231130.6832-11-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 11/13] openvpn.vcxproj temporarily disabled
 from building in openvpn.sln until we re-establish MSVC building for it
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

From: Simon Rozman <simon@...2293...>

---
 openvpn.sln | 2 --
 1 file changed, 2 deletions(-)

diff --git a/openvpn.sln b/openvpn.sln
index 9f50f11..ac865bb 100644
--- a/openvpn.sln
+++ b/openvpn.sln
@@ -22,9 +22,7 @@ Global
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.ActiveCfg = Release|Win32
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Build.0 = Release|Win32
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.ActiveCfg = Debug|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Build.0 = Debug|Win32
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.ActiveCfg = Release|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Build.0 = Release|Win32
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.ActiveCfg = Debug|Win32
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.0 = Debug|Win32
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.ActiveCfg = Release|Win32
-- 
2.9.0.windows.1


