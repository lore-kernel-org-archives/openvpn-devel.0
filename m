From: Gert Doering <gert@...1296...>
Date: Sat, 10 May 2025 20:19:30 +0200
Message-ID: <20250510181937.2993-1-gert@...1296...>
In-Reply-To: <gerrit.1744973073000.I621d44ec6b0facc524875c15ddfd11ec47b06c15@...2715...>
References: <gerrit.1744973073000.I621d44ec6b0facc524875c15ddfd11ec47b06c15@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] win: create adapter on demand
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

From: Lev Stipakov <lev@...515...>

The installer currently creates one adapter per driver. When a user tries
to start a second VPN connection while another is active, the client
fails with an unclear error message:

  "All ovpn-dco adapters on this system are currently in use or disabled."

This message does not guide the user toward resolving the issue, such as by
running the shortcut "Add a new dco-win virtual network adapter."

To improve user experience, the client will now create an adapter on demand
when no available adapters exist. The client sends a command specifying
the adapter type to the interactive service, which then executes tapctl.exe
to create a new adapter.

This feature requires the interactive service, but this should not pose a
problem since even our automatic service has recently started relying on the
interactive service.

GitHub: #728

Change-Id: I621d44ec6b0facc524875c15ddfd11ec47b06c15
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Selva Nair <selva.nair@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/943
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Selva Nair <selva.nair@...277...>

        
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 8b48053..2cf8d40 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -47,7 +47,8 @@
     msg_register_ring_buffers,
     msg_set_mtu,
     msg_add_wins_cfg,
-    msg_del_wins_cfg
+    msg_del_wins_cfg,
+    msg_create_adapter
 } message_type_t;
 
 typedef struct {
@@ -172,4 +173,15 @@
     int mtu;
 } set_mtu_message_t;
 
+typedef enum {
+    ADAPTER_TYPE_DCO,
+    ADAPTER_TYPE_TAP,
+    ADAPTER_TYPE_WINTUN
+} adapter_type_t;
+
+typedef struct {
+    message_header_t header;
+    adapter_type_t adapter_type;
+} create_adapter_message_t;
+
 #endif /* ifndef OPENVPN_MSG_H_ */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a0c22b1..34a049e 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2231,6 +2231,7 @@
         ALLOC_OBJ_CLEAR(tt, struct tuntap);
 
         tt->backend_driver = DRIVER_DCO;
+        tt->options.msg_channel = c->options.msg_channel;
 
         const char *device_guid = NULL; /* not used */
         tun_open_device(tt, c->options.dev_node, &device_guid, &c->gc);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4f7de6c..0bde6ef 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -451,6 +451,71 @@
     argv_free(&argv);
 }
 
+/**
+ * Requests the interactive service to create a VPN adapter of the specified type.
+ *
+ * @param msg_channel Handle to the interactive service communication pipe.
+ * @param driver_type Adapter type to create (e.g., TAP, Wintun, DCO).
+ *
+ * @return true on success, false on failure.
+ */
+static bool
+do_create_adapter_service(HANDLE msg_channel, enum tun_driver_type driver_type)
+{
+    bool ret = false;
+    ack_message_t ack;
+    struct gc_arena gc = gc_new();
+
+    adapter_type_t t;
+    switch (driver_type)
+    {
+        case WINDOWS_DRIVER_TAP_WINDOWS6:
+            t = ADAPTER_TYPE_TAP;
+            break;
+
+        case WINDOWS_DRIVER_WINTUN:
+            t = ADAPTER_TYPE_WINTUN;
+            break;
+
+        case DRIVER_DCO:
+            t = ADAPTER_TYPE_DCO;
+            break;
+
+        default:
+            msg(M_NONFATAL, "Invalid backend driver %s", print_tun_backend_driver(driver_type));
+            goto out;
+    }
+
+    create_adapter_message_t msg = {
+        .header = {
+            msg_create_adapter,
+            sizeof(create_adapter_message_t),
+            0
+        },
+        .adapter_type = t
+    };
+
+    if (!send_msg_iservice(msg_channel, &msg, sizeof(msg), &ack, "create_adapter"))
+    {
+        goto out;
+    }
+
+    if (ack.error_number != NO_ERROR)
+    {
+        msg(M_NONFATAL, "TUN: creating %s adapter using service failed: %s [status=%u]",
+            print_tun_backend_driver(driver_type), strerror_win32(ack.error_number, &gc), ack.error_number);
+    }
+    else
+    {
+        msg(M_INFO, "%s adapter created using service", print_tun_backend_driver(driver_type));
+        ret = true;
+    }
+
+out:
+    gc_free(&gc);
+    return ret;
+}
+
 #endif /* ifdef _WIN32 */
 
 #ifdef TARGET_SOLARIS
@@ -6589,9 +6654,8 @@
     const struct tap_reg *tap_reg = get_tap_reg(gc);
     const struct panel_reg *panel_reg = get_panel_reg(gc);
     const struct device_instance_id_interface *device_instance_id_interface = get_device_instance_id_interface(gc);
-    uint8_t actual_buffer[256];
 
-    at_least_one_tap_win(tap_reg);
+    uint8_t actual_buffer[256];
 
     /*
      * Lookup the device name in the registry, using the --dev-node high level name.
@@ -6622,6 +6686,7 @@
     else
     {
         int device_number = 0;
+        int adapters_created = 0;
 
         /* Try opening all TAP devices until we find one available */
         while (true)
@@ -6637,7 +6702,22 @@
 
             if (!*device_guid)
             {
-                msg(M_FATAL, "All %s adapters on this system are currently in use or disabled.", print_tun_backend_driver(tt->backend_driver));
+                /* try to create an adapter a few times if we have a service pipe handle */
+                if ((++adapters_created > 10) || !do_create_adapter_service(tt->options.msg_channel, tt->backend_driver))
+                {
+                    msg(M_FATAL, "All %s adapters on this system are currently in use or disabled.", print_tun_backend_driver(tt->backend_driver));
+                }
+                else
+                {
+                    /* we have created a new adapter so we must reinitialize adapters structs */
+                    tap_reg = get_tap_reg(gc);
+                    panel_reg = get_panel_reg(gc);
+                    device_instance_id_interface = get_device_instance_id_interface(gc);
+
+                    device_number = 0;
+
+                    continue;
+                }
             }
 
             if (tt->backend_driver != windows_driver)
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 4a11e6c..198835e 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -96,6 +96,14 @@
         goto out;
     }
 
+    swprintf(default_value, _countof(default_value), L"%ls\\bin", install_path);
+    error = GetRegString(key, L"bin_dir", s->bin_dir, sizeof(s->bin_dir),
+                         default_value);
+    if (error != ERROR_SUCCESS)
+    {
+        goto out;
+    }
+
     error = GetRegString(key, L"config_ext", s->ext_string, sizeof(s->ext_string),
                          L".ovpn");
     if (error != ERROR_SUCCESS)
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index f06d386..8a7b50d 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -125,6 +125,7 @@
     register_ring_buffers_message_t rrb;
     set_mtu_message_t mtu;
     wins_cfg_message_t wins;
+    create_adapter_message_t create_adapter;
 } pipe_message_t;
 
 typedef struct {
@@ -3107,6 +3108,52 @@
     return err;
 }
 
+/**
+ * Creates a VPN adapter of the specified type by invoking tapctl.exe.
+ *
+ * @param msg Adapter creation request specifying the type.
+ *
+ * @return NO_ERROR on success, otherwise a Windows error code.
+ */
+static DWORD
+HandleCreateAdapterMessage(const create_adapter_message_t *msg)
+{
+    const WCHAR *hwid;
+
+    switch (msg->adapter_type)
+    {
+        case ADAPTER_TYPE_DCO:
+            hwid = L"ovpn-dco";
+            break;
+
+        case ADAPTER_TYPE_TAP:
+            hwid = L"root\\tap0901";
+            break;
+
+        case ADAPTER_TYPE_WINTUN:
+            hwid = L"wintun";
+            break;
+
+        default:
+            return ERROR_INVALID_PARAMETER;
+    }
+
+    WCHAR cmd[MAX_PATH];
+    WCHAR args[MAX_PATH];
+
+    if (swprintf_s(cmd, _countof(cmd), L"%s\\tapctl.exe", settings.bin_dir) < 0)
+    {
+        return ERROR_BUFFER_OVERFLOW;
+    }
+
+    if (swprintf_s(args, _countof(args), L"tapctl create --hwid %s", hwid) < 0)
+    {
+        return ERROR_BUFFER_OVERFLOW;
+    }
+
+    return ExecCommand(cmd, args, 10000);
+}
+
 static VOID
 HandleMessage(HANDLE pipe, PPROCESS_INFORMATION proc_info,
               DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
@@ -3206,6 +3253,13 @@
             }
             break;
 
+        case msg_create_adapter:
+            if (msg.header.size == sizeof(msg.create_adapter))
+            {
+                ack.error_number = HandleCreateAdapterMessage(&msg.create_adapter);
+            }
+            break;
+
         default:
             ack.error_number = ERROR_MESSAGE_TYPE;
             MsgToEventLog(MSG_FLAGS_ERROR, L"Unknown message type %d", msg.header.type);
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index cbe213b..cebc67f 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -63,6 +63,7 @@
 typedef struct {
     WCHAR exe_path[MAX_PATH];
     WCHAR config_dir[MAX_PATH];
+    WCHAR bin_dir[MAX_PATH];
     WCHAR ext_string[16];
     WCHAR log_dir[MAX_PATH];
     WCHAR ovpn_admin_group[MAX_NAME];

