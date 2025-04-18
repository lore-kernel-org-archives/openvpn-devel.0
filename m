From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 18 Apr 2025 11:47:33 +0000
In-Reply-To: <gerrit.1744973073000.I621d44ec6b0facc524875c15ddfd11ec47b06c15@...2715...>
References: <gerrit.1744973073000.I621d44ec6b0facc524875c15ddfd11ec47b06c15@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0ddd443bad3c9b53fe7887ff0127820ca67e70e7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L/Y8L7mRyco="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: create adapter
 on demand
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L/Y8L7mRyco=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail

to look at the new patch set (#2).


Change subject: win: create adapter on demand
......................................................................

win: create adapter on demand

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
---
M include/openvpn-msg.h
M src/openvpn/socket.c
M src/openvpn/tun.c
M src/openvpnserv/common.c
M src/openvpnserv/interactive.c
M src/openvpnserv/service.h
6 files changed, 169 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/943/2

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

         tt->backend_driver =3D DRIVER_DCO;
+        tt->options.msg_channel =3D c->options.msg_channel;

         const char *device_guid =3D NULL; /* not used */
         tun_open_device(tt, c->options.dev_node, &device_guid, &c->gc);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4f7de6c..281ed95 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -451,6 +451,71 @@
     argv_free(&argv);
 }

+/**
+ * Requests the interactive service to create a VPN adapter of the specifi=
ed type.
+ *
+ * @param msg_channel Handle to the interactive service communication pipe.
+ * @param driver_type Adapter type to create (e.g., TAP, Wintun, DCO).
+ *
+ * @return true on success, false on failure.
+ */
+static bool
+do_create_adapter_service(HANDLE msg_channel, enum tun_driver_type driver_=
type)
+{
+    bool ret =3D false;
+    ack_message_t ack;
+    struct gc_arena gc =3D gc_new();
+
+    adapter_type_t t;
+    switch (driver_type)
+    {
+        case WINDOWS_DRIVER_TAP_WINDOWS6:
+            t =3D ADAPTER_TYPE_TAP;
+            break;
+
+        case WINDOWS_DRIVER_WINTUN:
+            t =3D ADAPTER_TYPE_WINTUN;
+            break;
+
+        case DRIVER_DCO:
+            t =3D ADAPTER_TYPE_DCO;
+            break;
+
+        default:
+            msg(M_NONFATAL, "Invalid backend driver %s", print_tun_backend=
_driver(driver_type));
+            goto out;
+    }
+
+    create_adapter_message_t msg =3D {
+        .header =3D {
+            msg_create_adapter,
+            sizeof(create_adapter_message_t),
+            0
+        },
+        .adapter_type =3D t
+    };
+
+    if (!send_msg_iservice(msg_channel, &msg, sizeof(msg), &ack, "create_a=
dapter"))
+    {
+        goto out;
+    }
+
+    if (ack.error_number !=3D NO_ERROR)
+    {
+        msg(M_NONFATAL, "TUN: creating %s adapter using service failed: %s=
 [status=3D%u]",
+            print_tun_backend_driver(driver_type), strerror_win32(ack.erro=
r_number, &gc), ack.error_number);
+    }
+    else
+    {
+        msg(M_INFO, "%s adapter created using service", print_tun_backend_=
driver(driver_type));
+        ret =3D true;
+    }
+
+out:
+    gc_free(&gc);
+    return ret;
+}
+
 #endif /* ifdef _WIN32 */

 #ifdef TARGET_SOLARIS
@@ -3713,7 +3778,7 @@
     }
 }

-static const struct device_instance_id_interface *
+static struct device_instance_id_interface *
 get_device_instance_id_interface(struct gc_arena *gc)
 {
     HDEVINFO dev_info_set;
@@ -3841,7 +3906,7 @@
     return first;
 }

-static const struct tap_reg *
+static struct tap_reg *
 get_tap_reg(struct gc_arena *gc)
 {
     HKEY adapter_key;
@@ -3986,7 +4051,7 @@
     return first;
 }

-static const struct panel_reg *
+static struct panel_reg *
 get_panel_reg(struct gc_arena *gc)
 {
     LONG status;
@@ -6586,12 +6651,11 @@
 void
 tun_open_device(struct tuntap *tt, const char *dev_node, const char **devi=
ce_guid, struct gc_arena *gc)
 {
-    const struct tap_reg *tap_reg =3D get_tap_reg(gc);
-    const struct panel_reg *panel_reg =3D get_panel_reg(gc);
-    const struct device_instance_id_interface *device_instance_id_interfac=
e =3D get_device_instance_id_interface(gc);
-    uint8_t actual_buffer[256];
+    struct tap_reg *tap_reg =3D get_tap_reg(gc);
+    struct panel_reg *panel_reg =3D get_panel_reg(gc);
+    struct device_instance_id_interface *device_instance_id_interface =3D =
get_device_instance_id_interface(gc);

-    at_least_one_tap_win(tap_reg);
+    uint8_t actual_buffer[256];

     /*
      * Lookup the device name in the registry, using the --dev-node high l=
evel name.
@@ -6622,6 +6686,7 @@
     else
     {
         int device_number =3D 0;
+        bool adapter_created =3D false;

         /* Try opening all TAP devices until we find one available */
         while (true)
@@ -6637,7 +6702,25 @@

             if (!*device_guid)
             {
-                msg(M_FATAL, "All %s adapters on this system are currently=
 in use or disabled.", print_tun_backend_driver(tt->backend_driver));
+                HANDLE h =3D tt->options.msg_channel;
+                /* try to create an adapter once if we have a service pipe=
 handle */
+                if (adapter_created || (h && !do_create_adapter_service(h,=
 tt->backend_driver)))
+                {
+                    msg(M_FATAL, "All %s adapters on this system are curre=
ntly in use or disabled.", print_tun_backend_driver(tt->backend_driver));
+                }
+                else
+                {
+                    adapter_created =3D true;
+
+                    /* we have created a new adapter so we must reinitiali=
ze adapters structs */
+                    tap_reg =3D get_tap_reg(gc);
+                    panel_reg =3D get_panel_reg(gc);
+                    device_instance_id_interface =3D get_device_instance_i=
d_interface(gc);
+
+                    device_number =3D 0;
+
+                    continue;
+                }
             }

             if (tt->backend_driver !=3D windows_driver)
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 4a11e6c..198835e 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -96,6 +96,14 @@
         goto out;
     }

+    swprintf(default_value, _countof(default_value), L"%ls\\bin", install_=
path);
+    error =3D GetRegString(key, L"bin_dir", s->bin_dir, sizeof(s->bin_dir),
+                         default_value);
+    if (error !=3D ERROR_SUCCESS)
+    {
+        goto out;
+    }
+
     error =3D GetRegString(key, L"config_ext", s->ext_string, sizeof(s->ex=
t_string),
                          L".ovpn");
     if (error !=3D ERROR_SUCCESS)
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
+            hwid =3D L"ovpn-dco";
+            break;
+
+        case ADAPTER_TYPE_TAP:
+            hwid =3D L"root\\tap0901";
+            break;
+
+        case ADAPTER_TYPE_WINTUN:
+            hwid =3D L"wintun";
+            break;
+
+        default:
+            return ERROR_INVALID_PARAMETER;
+    }
+
+    WCHAR cmd[MAX_PATH];
+    WCHAR args[MAX_PATH];
+
+    if (swprintf_s(cmd, _countof(cmd), L"%s\\tapctl.exe", settings.bin_dir=
) < 0)
+    {
+        return ERROR_BUFFER_OVERFLOW;
+    }
+
+    if (swprintf_s(args, _countof(args), L"tapctl create --hwid %s", hwid)=
 < 0)
+    {
+        return ERROR_BUFFER_OVERFLOW;
+    }
+
+    return ExecCommand(cmd, args, 10000);
+}
+
 static VOID
 HandleMessage(HANDLE pipe, PPROCESS_INFORMATION proc_info,
               DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lis=
ts)
@@ -3206,6 +3253,13 @@
             }
             break;

+        case msg_create_adapter:
+            if (msg.header.size =3D=3D sizeof(msg.create_adapter))
+            {
+                ack.error_number =3D HandleCreateAdapterMessage(&msg.creat=
e_adapter);
+            }
+            break;
+
         default:
             ack.error_number =3D ERROR_MESSAGE_TYPE;
             MsgToEventLog(MSG_FLAGS_ERROR, L"Unknown message type %d", msg=
.header.type);
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I621d44ec6b0facc524875c15ddfd11ec47b06c15
Gerrit-Change-Number: 943
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--L/Y8L7mRyco=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">win: create adapter on demand<br><br>The installer currently creates one =
adapter per driver. When a user tries<br>to start a second VPN connection w=
hile another is active, the client<br>fails with an unclear error message:<=
br><br>  &quot;All ovpn-dco adapters on this system are currently in use or=
 disabled.&quot;<br><br>This message does not guide the user toward resolvi=
ng the issue, such as by<br>running the shortcut &quot;Add a new dco-win vi=
rtual network adapter.&quot;<br><br>To improve user experience, the client =
will now create an adapter on demand<br>when no available adapters exist. T=
he client sends a command specifying<br>the adapter type to the interactive=
 service, which then executes tapctl.exe<br>to create a new adapter.<br><br=
>This feature requires the interactive service, but this should not pose a<=
br>problem since even our automatic service has recently started relying on=
 the<br>interactive service.<br><br>GitHub: #728<br><br>Change-Id: I621d44e=
c6b0facc524875c15ddfd11ec47b06c15<br>Signed-off-by: Lev Stipakov &lt;lev@...1186...=
.515...&gt;<br>---<br>M include/openvpn-msg.h<br>M src/openvpn/socket.c<br>=
M src/openvpn/tun.c<br>M src/openvpnserv/common.c<br>M src/openvpnserv/inte=
ractive.c<br>M src/openvpnserv/service.h<br>6 files changed, 169 insertions=
(+), 10 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/43/943/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/include/openvpn-msg.h b/incl=
ude/openvpn-msg.h</span><br><span>index 8b48053..2cf8d40 100644</span><br><=
span>--- a/include/openvpn-msg.h</span><br><span>+++ b/include/openvpn-msg.=
h</span><br><span>@@ -47,7 +47,8 @@</span><br><span>     msg_register_ring_=
buffers,</span><br><span>     msg_set_mtu,</span><br><span>     msg_add_win=
s_cfg,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg_del_win=
s_cfg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_del_wi=
ns_cfg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_crea=
te_adapter</span><br><span> } message_type_t;</span><br><span> </span><br><=
span> typedef struct {</span><br><span>@@ -172,4 +173,15 @@</span><br><span=
>     int mtu;</span><br><span> } set_mtu_message_t;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ADAPTER_TYPE_DCO,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ADAPTER_TYPE_TAP,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ADAPTER_TYPE_WINTUN</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+} adapter_type_t;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+typedef struct {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    message_header_t header;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    adapter_type_t adapter_type;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+} create_adapter_messa=
ge_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> #endif /* ifndef OPENVPN_MSG_H_ */</span><br><span>diff --git a/src/ope=
nvpn/socket.c b/src/openvpn/socket.c</span><br><span>index a0c22b1..34a049e=
 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/sr=
c/openvpn/socket.c</span><br><span>@@ -2231,6 +2231,7 @@</span><br><span>  =
       ALLOC_OBJ_CLEAR(tt, struct tuntap);</span><br><span> </span><br><spa=
n>         tt-&gt;backend_driver =3D DRIVER_DCO;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        tt-&gt;options.msg_channel =3D c-&gt;o=
ptions.msg_channel;</span><br><span> </span><br><span>         const char *=
device_guid =3D NULL; /* not used */</span><br><span>         tun_open_devi=
ce(tt, c-&gt;options.dev_node, &amp;device_guid, &amp;c-&gt;gc);</span><br>=
<span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>in=
dex 4f7de6c..281ed95 100644</span><br><span>--- a/src/openvpn/tun.c</span><=
br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -451,6 +451,71 @@</span=
><br><span>     argv_free(&amp;argv);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Requests the interactive service =
to create a VPN adapter of the specified type.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param msg_channel Handle to the interactive service communica=
tion pipe.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 driver_type Adapter type to create (e.g., TAP, Wintun, DCO).</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return true on success, false on failure.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+do_create_adapter_service(HANDLE msg_channel, en=
um tun_driver_type driver_type)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ack_message_t ack;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   adapter_type_t t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    switch (driver_type)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
case WINDOWS_DRIVER_TAP_WINDOWS6:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            t =3D ADAPTER_TYPE_TAP;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case WINDOWS_DRIVER_WINTUN:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            t =3D ADAPTER_TYPE_WINTUN;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        case DRIVER_DCO:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            t =3D ADAPTER_TYPE_DCO;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            msg(M_NONFATAL, &quot;Invalid backend dr=
iver %s&quot;, print_tun_backend_driver(driver_type));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto out;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    create_adapter_message_t msg =3D {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        .header =3D {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg_create_adapter,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            sizeof(create_adapter_mess=
age_t),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        .adapter_type =3D t=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!send_msg_iservice(msg_channel, &amp;msg, s=
izeof(msg), &amp;ack, &quot;create_adapter&quot;))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ack.error_=
number !=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_NONFATAL, &quot;TUN: creating %s adapter using service failed: %s [status=
=3D%u]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      print_tun_backend_driver(driver_type), strerror_win32(ack.error_numbe=
r, &amp;gc), ack.error_number);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;%=
s adapter created using service&quot;, print_tun_backend_driver(driver_type=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> #endif /* ifdef _WIN32 */</span><br><span> </span><br><span> #if=
def TARGET_SOLARIS</span><br><span>@@ -3713,7 +3778,7 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static const struct device_instance_id_interface *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct device_ins=
tance_id_interface *</span><br><span> get_device_instance_id_interface(stru=
ct gc_arena *gc)</span><br><span> {</span><br><span>     HDEVINFO dev_info_=
set;</span><br><span>@@ -3841,7 +3906,7 @@</span><br><span>     return firs=
t;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static const struct tap_reg *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static struct tap_reg *</span><br><span> get_ta=
p_reg(struct gc_arena *gc)</span><br><span> {</span><br><span>     HKEY ada=
pter_key;</span><br><span>@@ -3986,7 +4051,7 @@</span><br><span>     return=
 first;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static const struct panel_reg *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static struct panel_reg *</span><br><spa=
n> get_panel_reg(struct gc_arena *gc)</span><br><span> {</span><br><span>  =
   LONG status;</span><br><span>@@ -6586,12 +6651,11 @@</span><br><span> vo=
id</span><br><span> tun_open_device(struct tuntap *tt, const char *dev_node=
, const char **device_guid, struct gc_arena *gc)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct tap_reg *tap=
_reg =3D get_tap_reg(gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    const struct panel_reg *panel_reg =3D get_panel_reg(gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const struct device_instance=
_id_interface *device_instance_id_interface =3D get_device_instance_id_inte=
rface(gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t=
 actual_buffer[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct tap_reg *tap_reg =3D get_tap_reg(gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct panel_reg *panel_reg =3D get_panel=
_reg(gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 device_instance_id_interface *device_instance_id_interface =3D get_device_=
instance_id_interface(gc);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    at_least_one_tap_win(tap_reg);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint8_t actual_buffer[256];</span=
><br><span> </span><br><span>     /*</span><br><span>      * Lookup the dev=
ice name in the registry, using the --dev-node high level name.</span><br><=
span>@@ -6622,6 +6686,7 @@</span><br><span>     else</span><br><span>     {=
</span><br><span>         int device_number =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        bool adapter_created =3D false;</spa=
n><br><span> </span><br><span>         /* Try opening all TAP devices until=
 we find one available */</span><br><span>         while (true)</span><br><=
span>@@ -6637,7 +6702,25 @@</span><br><span> </span><br><span>             =
if (!*device_guid)</span><br><span>             {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                msg(M_FATAL, &quot;All %s adapt=
ers on this system are currently in use or disabled.&quot;, print_tun_backe=
nd_driver(tt-&gt;backend_driver));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                HANDLE h =3D tt-&gt;options.msg_channel;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* try =
to create an adapter once if we have a service pipe handle */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                if (adapter_creat=
ed || (h &amp;&amp; !do_create_adapter_service(h, tt-&gt;backend_driver)))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ms=
g(M_FATAL, &quot;All %s adapters on this system are currently in use or dis=
abled.&quot;, print_tun_backend_driver(tt-&gt;backend_driver));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    adapter_create=
d =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    /* we h=
ave created a new adapter so we must reinitialize adapters structs */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    tap_r=
eg =3D get_tap_reg(gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    panel_reg =3D get_panel_reg(gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    device_instance_id=
_interface =3D get_device_instance_id_interface(gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    device_number =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    continue;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                }</span><br><span>             }=
</span><br><span> </span><br><span>             if (tt-&gt;backend_driver !=
=3D windows_driver)</span><br><span>diff --git a/src/openvpnserv/common.c b=
/src/openvpnserv/common.c</span><br><span>index 4a11e6c..198835e 100644</sp=
an><br><span>--- a/src/openvpnserv/common.c</span><br><span>+++ b/src/openv=
pnserv/common.c</span><br><span>@@ -96,6 +96,14 @@</span><br><span>        =
 goto out;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    swprintf(default_value, _countof(defa=
ult_value), L&quot;%ls\\bin&quot;, install_path);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    error =3D GetRegString(key, L&quot;bin_di=
r&quot;, s-&gt;bin_dir, sizeof(s-&gt;bin_dir),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                         default_value);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error !=3D ERROR_SU=
CCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     error =3D GetRegStr=
ing(key, L&quot;config_ext&quot;, s-&gt;ext_string, sizeof(s-&gt;ext_string=
),</span><br><span>                          L&quot;.ovpn&quot;);</span><br=
><span>     if (error !=3D ERROR_SUCCESS)</span><br><span>diff --git a/src/=
openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>i=
ndex f06d386..8a7b50d 100644</span><br><span>--- a/src/openvpnserv/interact=
ive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@=
@ -125,6 +125,7 @@</span><br><span>     register_ring_buffers_message_t rrb=
;</span><br><span>     set_mtu_message_t mtu;</span><br><span>     wins_cfg=
_message_t wins;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 create_adapter_message_t create_adapter;</span><br><span> } pipe_message_t=
;</span><br><span> </span><br><span> typedef struct {</span><br><span>@@ -3=
107,6 +3108,52 @@</span><br><span>     return err;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Creates a VPN adapte=
r of the specified type by invoking tapctl.exe.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param msg Adapter creation request specifying the type.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return NO_ERROR on success, otherwise=
 a Windows error code.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static DWORD<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+HandleCreateAdapterM=
essage(const create_adapter_message_t *msg)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const WCHAR *hwid;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch=
 (msg-&gt;adapter_type)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
se ADAPTER_TYPE_DCO:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            hwid =3D L&quot;ovpn-dco&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        case ADAPTER_TYPE_TAP:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            hwid =3D L&quot;root\\tap0901&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        case ADAPTER_TYPE_WINTUN:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            hwid =3D L&quot;wintun&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return ERROR_INVALID_PARA=
METER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    WCHAR cmd[MAX_PATH];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    WCHAR args[MAX_PATH];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (swprintf_s(cmd, _countof(cmd), L&quot;%s\\tapc=
tl.exe&quot;, settings.bin_dir) &lt; 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return ERROR_BUFFER_OVERFLOW;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (s=
wprintf_s(args, _countof(args), L&quot;tapctl create --hwid %s&quot;, hwid)=
 &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return ERROR_BUFF=
ER_OVERFLOW;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return ExecCommand(cmd, args, 10000)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static VOID</span>=
<br><span> HandleMessage(HANDLE pipe, PPROCESS_INFORMATION proc_info,</span=
><br><span>               DWORD bytes, DWORD count, LPHANDLE events, undo_l=
ists_t *lists)</span><br><span>@@ -3206,6 +3253,13 @@</span><br><span>     =
        }</span><br><span>             break;</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        case msg_create_adapter=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (ms=
g.header.size =3D=3D sizeof(msg.create_adapter))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                ack.error_number =3D HandleCreateAda=
pterMessage(&amp;msg.create_adapter);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>         default:</span><br><span>             =
ack.error_number =3D ERROR_MESSAGE_TYPE;</span><br><span>             MsgTo=
EventLog(MSG_FLAGS_ERROR, L&quot;Unknown message type %d&quot;, msg.header.=
type);</span><br><span>diff --git a/src/openvpnserv/service.h b/src/openvpn=
serv/service.h</span><br><span>index cbe213b..cebc67f 100644</span><br><spa=
n>--- a/src/openvpnserv/service.h</span><br><span>+++ b/src/openvpnserv/ser=
vice.h</span><br><span>@@ -63,6 +63,7 @@</span><br><span> typedef struct {<=
/span><br><span>     WCHAR exe_path[MAX_PATH];</span><br><span>     WCHAR c=
onfig_dir[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    WCHAR bin_dir[MAX_PATH];</span><br><span>     WCHAR ext_string[16];</s=
pan><br><span>     WCHAR log_dir[MAX_PATH];</span><br><span>     WCHAR ovpn=
_admin_group[MAX_NAME];</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail">change 94=
3</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I621d44ec6b0facc524875c15ddf=
d11ec47b06c15 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 943 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--L/Y8L7mRyco=--

