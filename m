MIME-Version: 1.0
From: Pete Nelson <petiepooo@...277...>
Date: Thu, 11 Nov 2021 15:00:19 +0000
Message-ID: <CAAYFXLmG9AGFUwyCaY2=pNZgV2X_kjG7Ba=8=OfQwayZP2wGpQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000085942a05d0849a1d"
Subject: [Openvpn-devel] [PATCH v2] boolean short-circuit plugins upon
 failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--00000000000085942a05d0849a1d
Content-Type: text/plain; charset="UTF-8"

When evaluating authentication plugins, stop further evaluation
once the first failure is detected.

implementation notes: refactoring from a switch-case to an
if-else block allows the break statement to break out of the
outer for loop without additional control variables.  Also,
moving the pr->n setting to within the loop keeps the value
correct if one does break out early.

v2: add check for auth plugin before breaking loop

Signed-off-by: Peter Nelson <petiepooo@...277...>
---
 src/openvpn/plugin.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index d5704e07..02b17378 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -818,26 +818,24 @@ plugin_call_ssl(const struct plugin_list *pl,
                                                 certdepth,
                                                 current_cert
                                                 );
-            switch (status)
+            if (pr)
             {
-                case OPENVPN_PLUGIN_FUNC_SUCCESS:
-                    break;
-
-                case OPENVPN_PLUGIN_FUNC_DEFERRED:
-                    deferred = true;
-                    break;
-
-                default:
-                    error = true;
+                pr->n = i + 1;
+            }
+            if (status == OPENVPN_PLUGIN_FUNC_DEFERRED)
+            {
+                deferred = true;
+            }
+            else if (status != OPENVPN_PLUGIN_FUNC_SUCCESS)
+            {
+                error = true;
+                if (type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
+                {
                     break;
+                }
             }
         }

-        if (pr)
-        {
-            pr->n = i;
-        }
-
         gc_free(&gc);

         if (error)
-- 
2.17.1

--00000000000085942a05d0849a1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+V2hlbiBldmFsdWF0aW5nIGF1dGhlbnRpY2F0aW9uIHBsdWdpbnMsIHN0
b3AgZnVydGhlciBldmFsdWF0aW9uPGJyPm9uY2UgdGhlIGZpcnN0IGZhaWx1cmUgaXMgZGV0ZWN0
ZWQuPGJyPjxicj5pbXBsZW1lbnRhdGlvbiBub3RlczogcmVmYWN0b3JpbmcgZnJvbSBhIHN3aXRj
aC1jYXNlIHRvIGFuPGJyPmlmLWVsc2UgYmxvY2sgYWxsb3dzIHRoZSBicmVhayBzdGF0ZW1lbnQg
dG8gYnJlYWsgb3V0IG9mIHRoZTxicj48ZGl2Pm91dGVyIGZvciBsb29wIHdpdGhvdXQgYWRkaXRp
b25hbCBjb250cm9sIHZhcmlhYmxlcy7CoCBBbHNvLDwvZGl2PjxkaXY+bW92aW5nIHRoZSBwci0m
Z3Q7biBzZXR0aW5nIHRvIHdpdGhpbiB0aGUgbG9vcCBrZWVwcyB0aGUgdmFsdWU8L2Rpdj48ZGl2
PmNvcnJlY3QgaWYgb25lIGRvZXMgYnJlYWsgb3V0IGVhcmx5Ljxicj48L2Rpdj48YnI+djI6IGFk
ZCBjaGVjayBmb3IgYXV0aCBwbHVnaW4gYmVmb3JlIGJyZWFraW5nIGxvb3A8YnI+PGJyPlNpZ25l
ZC1vZmYtYnk6IFBldGVyIE5lbHNvbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOnBldGllcG9vb0AuLi4y
NzcuLi4iPnBldGllcG9vb0AuLi4yNzcuLi48L2E+Jmd0Ozxicj4tLS08YnI+wqBzcmMvb3BlbnZw
bi9wbHVnaW4uYyB8IDI4ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS08YnI+wqAxIGZpbGUg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pPGJyPjxicj5kaWZmIC0t
Z2l0IGEvc3JjL29wZW52cG4vcGx1Z2luLmMgYi9zcmMvb3BlbnZwbi9wbHVnaW4uYzxicj5pbmRl
eCBkNTcwNGUwNy4uMDJiMTczNzggMTAwNjQ0PGJyPi0tLSBhL3NyYy9vcGVudnBuL3BsdWdpbi5j
PGJyPisrKyBiL3NyYy9vcGVudnBuL3BsdWdpbi5jPGJyPkBAIC04MTgsMjYgKzgxOCwyNCBAQCBw
bHVnaW5fY2FsbF9zc2woY29uc3Qgc3RydWN0IHBsdWdpbl9saXN0ICpwbCw8YnI+wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjZXJ0ZGVwdGgsPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY3VycmVudF9jZXJ0PGJyPsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgKTs8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoHN3aXRjaCAoc3RhdHVzKTxi
cj4rIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHByKTxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoHs8YnI+
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgT1BFTlZQTl9QTFVHSU5fRlVOQ19TVUNDRVNT
Ojxicj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPi08YnI+LSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgT1BFTlZQTl9QTFVHSU5fRlVOQ19ERUZFUlJFRDo8YnI+
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlZmVycmVkID0gdHJ1ZTs8YnI+LSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4tPGJyPi0gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBkZWZhdWx0Ojxicj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJyb3Ig
PSB0cnVlOzxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHItJmd0O24gPSBpICsgMTs8YnI+
KyDCoCDCoCDCoCDCoCDCoCDCoH08YnI+KyDCoCDCoCDCoCDCoCDCoCDCoGlmIChzdGF0dXMgPT0g
T1BFTlZQTl9QTFVHSU5fRlVOQ19ERUZFUlJFRCk8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoHs8YnI+
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlZmVycmVkID0gdHJ1ZTs8YnI+KyDCoCDCoCDCoCDC
oCDCoCDCoH08YnI+KyDCoCDCoCDCoCDCoCDCoCDCoGVsc2UgaWYgKHN0YXR1cyAhPSBPUEVOVlBO
X1BMVUdJTl9GVU5DX1NVQ0NFU1MpPGJyPisgwqAgwqAgwqAgwqAgwqAgwqB7PGJyPisgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBlcnJvciA9IHRydWU7PGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAodHlwZSA9PSBPUEVOVlBOX1BMVUdJTl9BVVRIX1VTRVJfUEFTU19WRVJJRlkpPGJyPisg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgYnJlYWs7PGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPsKgIMKgIMKgIMKgIMKg
IMKgIMKgfTxicj7CoCDCoCDCoCDCoCDCoH08YnI+wqA8YnI+LSDCoCDCoCDCoCDCoGlmIChwcik8
YnI+LSDCoCDCoCDCoCDCoHs8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoHByLSZndDtuID0gaTs8YnI+
LSDCoCDCoCDCoCDCoH08YnI+LTxicj7CoCDCoCDCoCDCoCDCoGdjX2ZyZWUoJmFtcDtnYyk7PGJy
PsKgPGJyPsKgIMKgIMKgIMKgIMKgaWYgKGVycm9yKTxicj4tLSA8YnI+Mi4xNy4xPC9kaXY+DQo=

--00000000000085942a05d0849a1d--

