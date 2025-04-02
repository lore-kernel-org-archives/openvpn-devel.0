From: Gert Doering <gert@...1296...>
Date: Wed,  2 Apr 2025 17:36:55 +0200
Message-ID: <20250402153701.7560-1-gert@...1296...>
In-Reply-To: <gerrit.1743591174000.I3434c35da75ede90a1b479b152142142ecc2fd40@...2715...>
References: <gerrit.1743591174000.I3434c35da75ede90a1b479b152142142ecc2fd40@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Make sure renovate notifies us
 about AWS LC releases
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

Change-Id: I3434c35da75ede90a1b479b152142142ecc2fd40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/932
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5e8e15d..2df495c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -469,6 +469,7 @@
         uses: actions/checkout@...2844... # v4.2.2
         with:
           path: aws-lc
+          # versioning=semver-coerced
           repository: aws/aws-lc
           ref: v1.42.0
       - uses: lukka/get-cmake@...2870... # v3.31.6

