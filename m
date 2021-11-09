MIME-Version: 1.0
From: Pete Nelson <petiepooo@...277...>
Date: Tue, 9 Nov 2021 19:47:25 +0000
Message-ID: <CAAYFXLmcybkvkw0RJ5gPVhkxrYKRr4XkdPUJwB4Cm--jQjdXKQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000008f63f305d060616f"
Subject: [Openvpn-devel] [PATCH] boolean short-circuit auth upon failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000008f63f305d060616f
Content-Type: text/plain; charset="UTF-8"

When evaluating authentication plugins, stop further evaluation
once the first failure is detected.



Implementation notes: Refactoring from a switch-case to an
if-else block allows the break statement to break out of the
outer for loop without additional control variables.  Also,
moving the pr->n setting to within the loop keeps the value
correct if one does break out early.

First email patch submission and first patch submitted to this
list; be gentle please... -- Pete
---
 src/openvpn/plugin.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index d5704e07..c6c9a63f 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -818,24 +818,19 @@ plugin_call_ssl(const struct plugin_list *pl,
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
-                    break;
+                pr->n = i + 1;
+            }
+            if (status == OPENVPN_PLUGIN_FUNC_DEFERRED)
+            {
+                deferred = true;
+            }
+            else if (status != OPENVPN_PLUGIN_FUNC_SUCCESS)
+            {
+                error = true;
+                break;
             }
-        }
-
-        if (pr)
-        {
-            pr->n = i;
         }

         gc_free(&gc);
-- 
2.17.1

--0000000000008f63f305d060616f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+V2hlbiBldmFsdWF0aW5nIGF1dGhlbnRpY2F0aW9uIHBsdWdpbnMsIHN0
b3AgZnVydGhlciBldmFsdWF0aW9uPGJyPm9uY2UgdGhlIGZpcnN0IGZhaWx1cmUgaXMgZGV0ZWN0
ZWQuPGJyPjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PkltcGxl
bWVudGF0aW9uIG5vdGVzOiBSZWZhY3RvcmluZyBmcm9tIGEgc3dpdGNoLWNhc2UgdG8gYW48YnI+
aWYtZWxzZSBibG9jayBhbGxvd3MgdGhlIGJyZWFrIHN0YXRlbWVudCB0byBicmVhayBvdXQgb2Yg
dGhlPGJyPjxkaXY+b3V0ZXIgZm9yIGxvb3Agd2l0aG91dCBhZGRpdGlvbmFsIGNvbnRyb2wgdmFy
aWFibGVzLsKgIEFsc28sPC9kaXY+PGRpdj5tb3ZpbmcgdGhlIHByLSZndDtuIHNldHRpbmcgdG8g
d2l0aGluIHRoZSBsb29wIGtlZXBzIHRoZSB2YWx1ZTwvZGl2PjxkaXY+Y29ycmVjdCBpZiBvbmUg
ZG9lcyBicmVhayBvdXQgZWFybHkuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5GaXJzdCBlbWFp
bCBwYXRjaCBzdWJtaXNzaW9uIGFuZCBmaXJzdCBwYXRjaCBzdWJtaXR0ZWQgdG8gdGhpczwvZGl2
PjxkaXY+bGlzdDsgYmUgZ2VudGxlIHBsZWFzZS4uLiAtLSBQZXRlPGJyPjwvZGl2Pi0tLTxicj7C
oHNyYy9vcGVudnBuL3BsdWdpbi5jIHwgMjcgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tPGJy
PsKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKTxicj48
YnI+ZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3BsdWdpbi5jIGIvc3JjL29wZW52cG4vcGx1Z2lu
LmM8YnI+aW5kZXggZDU3MDRlMDcuLmM2YzlhNjNmIDEwMDY0NDxicj4tLS0gYS9zcmMvb3BlbnZw
bi9wbHVnaW4uYzxicj4rKysgYi9zcmMvb3BlbnZwbi9wbHVnaW4uYzxicj5AQCAtODE4LDI0ICs4
MTgsMTkgQEAgcGx1Z2luX2NhbGxfc3NsKGNvbnN0IHN0cnVjdCBwbHVnaW5fbGlzdCAqcGwsPGJy
PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgY2VydGRlcHRoLDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGN1cnJlbnRf
Y2VydDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCk7PGJyPi0gwqAgwqAgwqAgwqAgwqAgwqBzd2l0Y2gg
KHN0YXR1cyk8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoGlmIChwcik8YnI+wqAgwqAgwqAgwqAgwqAg
wqAgwqB7PGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIE9QRU5WUE5fUExVR0lOX0ZV
TkNfU1VDQ0VTUzo8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4t
PGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIE9QRU5WUE5fUExVR0lOX0ZVTkNfREVG
RVJSRUQ6PGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZlcnJlZCA9IHRydWU7
PGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+LTxicj4tIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZGVmYXVsdDo8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGVycm9yID0gdHJ1ZTs8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFr
Ozxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHItJmd0O24gPSBpICsgMTs8YnI+KyDCoCDC
oCDCoCDCoCDCoCDCoH08YnI+KyDCoCDCoCDCoCDCoCDCoCDCoGlmIChzdGF0dXMgPT0gT1BFTlZQ
Tl9QTFVHSU5fRlVOQ19ERUZFUlJFRCk8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoHs8YnI+KyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGRlZmVycmVkID0gdHJ1ZTs8YnI+KyDCoCDCoCDCoCDCoCDCoCDC
oH08YnI+KyDCoCDCoCDCoCDCoCDCoCDCoGVsc2UgaWYgKHN0YXR1cyAhPSBPUEVOVlBOX1BMVUdJ
Tl9GVU5DX1NVQ0NFU1MpPGJyPisgwqAgwqAgwqAgwqAgwqAgwqB7PGJyPisgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBlcnJvciA9IHRydWU7PGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVh
azs8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPi0gwqAgwqAgwqAgwqB9PGJyPi08YnI+LSDC
oCDCoCDCoCDCoGlmIChwcik8YnI+LSDCoCDCoCDCoCDCoHs8YnI+LSDCoCDCoCDCoCDCoCDCoCDC
oHByLSZndDtuID0gaTs8YnI+wqAgwqAgwqAgwqAgwqB9PGJyPsKgPGJyPsKgIMKgIMKgIMKgIMKg
Z2NfZnJlZSgmYW1wO2djKTs8YnI+LS0gPGJyPjIuMTcuMTwvZGl2Pg0K

--0000000000008f63f305d060616f--

