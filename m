From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 24 Jan 2023 16:23:16 +0200
Message-Id: <20230124142316.441-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] openvpnmsica: fix adapters discovery logic
 for DCO
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Custom action "FindSystemInfo" finds adapters with certain hwid and
assigns found adapters' guids to a certain property. Later another custom
action "EvaluateTUNTAPAdapters" schedules adapter creation if the
abovementioned property is not set - which means no adapters exist
with given hwid.

I think this logic is needed to prevent duplicate adapter creation
if adapter was renamed and then new version is installed.

As one can see, there is a typo in property name ("OVPNDCOAPTERS"). As
a result of this typo, installer will always try to create DCO adapter
no matter if there are existing adapters. It however won't do anything
if adapter with the name "OpenVPN Data Channel Offload" already exists,
this is handled in schedule_adapter_create() function.

Because of that typo, following scenario works fine:

 1) Upcoming release of OpenVPN Connect is installed, which creates
adapter named "OpenVPN Connect DCO Adapter"

 2) OpenVPN-GUI is installed. Because of typo, it ignores adapter created
by Connect and creates own "OpenVPN Data Channel Offload" adapter

 3) OpenVPN Connect is uninstalled and it removes
"OpenVPN Connect DCO Adapter".

 4) OpenVPN-GUI still has its "OpenVPN Data Channel Offload" adapter

If we just fix a typo, OpenVPN-GUI won't create a adapter on step 2 and
after Connect removal on step 3 there won't be DCO adapters anymore
for OpenVPN-GUI to use.

The ultimate solution to this would be moving adapter creation to MSM,
a shared component which adds/removes the DCO driver. However this change
is not trivial and requires a lot of work. For the time being we apply
this band-aid by excluding Connect-created adapters from enumerations in
"FindSystemInfo" custom action. This makes sure that OpenVPN-GUI won't
rely on adapter created by Connnect (which is deleted on Connect uninstall)
and ensures that additional DCO adapters won't be created on upgrade
if user decides to rename adapter.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnmsica/openvpnmsica.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index af12b2c4..06c9789d 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -65,6 +65,8 @@
 
 #define FILE_NEED_REBOOT        L".ovpn_need_reboot"
 
+#define OPENVPN_CONNECT_ADAPTER_SUBSTR L"OpenVPN Connect"
+
 /**
  * Joins an argument sequence and sets it to the MSI property.
  *
@@ -224,6 +226,13 @@ find_adapters(
 
     for (struct tap_adapter_node *pAdapter = pAdapterList; pAdapter; pAdapter = pAdapter->pNext)
     {
+        /* exclude adapters created by OpenVPN Connect, since they're removed on Connect uninstallation */
+        if (_tcsstr(pAdapter->szName, OPENVPN_CONNECT_ADAPTER_SUBSTR))
+        {
+            msg(M_WARN, "%s: skip OpenVPN Connect adapter '%ls'", __FUNCTION__, pAdapter->szName);
+            continue;
+        }
+
         /* Convert adapter GUID to UTF-16 string. (LPOLESTR defaults to LPWSTR) */
         LPOLESTR szAdapterId = NULL;
         StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
@@ -316,7 +325,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
     find_adapters(
         hInstall,
         TEXT("ovpn-dco") TEXT("\0"),
-        TEXT("OVPNDCOAPTERS"),
+        TEXT("OVPNDCOADAPTERS"),
         TEXT("ACTIVEOVPNDCOADAPTERS"));
 
     if (bIsCoInitialized)
-- 
2.38.1.windows.1


