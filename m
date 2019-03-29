References: <20190328122701.7396-1-cschenk@...2502...>
 <1363f761-21e4-f5e6-8c49-234e1339bc3d@...1227...>
 <CAKuzo_gmJSuz0vYx+YugB4qcz3M8MRWNEVw3FuHXsL2KKRSH2Q@...278...>
From: Christopher Schenk <cschenk@...2502...>
Message-ID: <2c639a7a-0cf6-4648-44d2-d6b876959eb7@...2502...>
Date: Fri, 29 Mar 2019 11:25:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gmJSuz0vYx+YugB4qcz3M8MRWNEVw3FuHXsL2KKRSH2Q@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Setting adapter mtu on windows systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 28/03/2019 16:00, Selva Nair wrote:
> I would go a step further to say we should not add new features that
> do not work when started using the interactive service.
>
> Secondly, we should avoid the old style use of netsh and instead use the
> iphelper API as far as possible. It should be possible to
> set MTU using the SetIfEntry() or SetIpInterfaceEnrty() function -- I 
> haven't
> checked which one is appropriate here.

I agree on the point that we should add this functionality to the 
interactive service as well. So i modified the patch accordingly.
I also modified my patch so that it uses the SetIpInterfaceEnrty 
function instead of netsh.

---
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 66177a21..f59c5a21 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -39,6 +39,7 @@ typedef enum {
      msg_del_block_dns,
      msg_register_dns,
      msg_enable_dhcp,
+    msg_set_mtu,
  } message_type_t;

  typedef struct {
@@ -117,4 +118,11 @@ typedef struct {
      interface_t iface;
  } enable_dhcp_message_t;

+typedef struct {
+    message_header_t header;
+    interface_t iface;
+    short family;
+    int mtu;
+} set_mtu_message_t;
+
  #endif /* ifndef OPENVPN_MSG_H_ */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 48a8fdf7..9fe8444f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -69,6 +69,10 @@ static void netsh_ifconfig(const struct 
tuntap_options *to,
                             const in_addr_t netmask,
                             const unsigned int flags);

+static void windows_set_mtu(const int iface_indey,
+                                short family,
+                               const int mtu);
+
  static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
                                     const int addr_len,
                                     const char *flex_name);
@@ -201,6 +205,63 @@ out:
      return ret;
  }

+static bool
+do_set_mtu_service(const struct tuntap *tt, const short family, const 
int mtu)
+{
+    DWORD len;
+    bool ret = false;
+    ack_message_t ack;
+    struct gc_arena gc = gc_new();
+    HANDLE pipe = tt->options.msg_channel;
+
+    set_mtu_message_t mtu_msg = {
+        .header = {
+            msg_set_mtu,
+            sizeof(set_mtu_message_t),
+            0
+        },
+        .iface = {.index = tt->adapter_index,.name = tt->actual_name },
+        .mtu = mtu,
+        .family = family
+    };
+
+    if (!send_msg_iservice(pipe, &mtu_msg, sizeof(mtu_msg), &ack, 
"Set_mtu"))
+    {
+        goto out;
+    }
+
+    if (family == AF_INET)
+    {
+        if (ack.error_number != NO_ERROR)
+        {
+            msg(M_NONFATAL, "TUN: setting IPv4 mtu using service 
failed: %s [status=%u if_index=%d]",
+                strerror_win32(ack.error_number, &gc), 
ack.error_number, mtu_msg.iface.index);
+        }
+        else
+        {
+            msg(M_INFO, "IPv4 MTU set to %d on interface %d using 
service", mtu, mtu_msg.iface.index);
+            ret = true;
+        }
+    }
+    else if (family == AF_INET6)
+    {
+        if (ack.error_number != NO_ERROR)
+        {
+            msg(M_NONFATAL, "TUN: setting IPv6 mtu using service 
failed: %s [status=%u if_index=%d]",
+                strerror_win32(ack.error_number, &gc), 
ack.error_number, mtu_msg.iface.index);
+        }
+        else
+        {
+            msg(M_INFO, "IPv6 MTU set to %d on interface %d using 
service", mtu, mtu_msg.iface.index);
+            ret = true;
+        }
+    }
+
+out:
+    gc_free(&gc);
+    return ret;
+}
+
  #endif /* ifdef _WIN32 */

  #ifdef TARGET_SOLARIS
@@ -984,6 +1045,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char 
*ifname, int tun_mtu,
      {
          do_address_service(true, AF_INET6, tt);
          do_dns6_service(true, tt);
+        do_set_mtu_service(tt, AF_INET6, tun_mtu);
      }
      else
      {
@@ -1000,6 +1062,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char 
*ifname, int tun_mtu,
          netsh_command(&argv, 4, M_FATAL);
          /* set ipv6 dns servers if any are specified */
          netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, 
ifname);
+        windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
      }

      /* explicit route needed */
@@ -1391,9 +1454,16 @@ do_ifconfig_ipv4(struct tuntap *tt, const char 
*ifname, int tun_mtu,
              case IPW32_SET_NETSH:
                  netsh_ifconfig(&tt->options, ifname, tt->local,
                                 tt->adapter_netmask, 
NI_IP_NETMASK|NI_OPTIONS);
-
                  break;
          }
+        if (tt->options.msg_channel)
+        {
+            do_set_mtu_service(tt, AF_INET, tun_mtu);
+        }
+        else
+        {
+            windows_set_mtu(tt->adapter_index, AF_INET, tun_mtu);
+        }
      }

  #else  /* if defined(TARGET_LINUX) */
@@ -5236,6 +5306,46 @@ out:
      return ret;
  }

+static void
+windows_set_mtu(const int iface_index, const short family,
+    const int mtu)
+{
+    DWORD err = 0;
+    struct gc_arena gc = gc_new();
+    MIB_IPINTERFACE_ROW row;
+    InitializeIpInterfaceEntry(&row);
+    row.Family = family;
+    row.InterfaceIndex = iface_index;
+    row.NlMtu = mtu;
+
+    err = SetIpInterfaceEntry(&row);
+    if (family == AF_INET)
+    {
+        if (err != NO_ERROR)
+        {
+            msg(M_WARN, "TUN: Setting IPv4 mtu failed: %s [status=%u 
if_index=%d]",
+                strerror_win32(err, &gc), err, iface_index);
+        }
+        else
+        {
+            msg(M_INFO, "Successfully set IPv4 mtu on interface %d", 
iface_index);
+        }
+    }
+    else if (family == AF_INET6)
+    {
+        if (err != NO_ERROR)
+        {
+            msg(M_WARN, "TUN: Setting IPv6 mtu failed: %s [status=%u 
if_index=%d]",
+                strerror_win32(err, &gc), err, iface_index);
+        }
+        else
+        {
+            msg(M_INFO, "Successfully set IPv6 mtu on interface %d", 
iface_index);
+        }
+    }
+}
+
+
  /*
   * Return a TAP name for netsh commands.
   */
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 623c3ff7..6e6a63fe 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -33,6 +33,7 @@
  #include <sddl.h>
  #include <shellapi.h>
  #include <mstcpip.h>
+#include <netioapi.h>

  #ifdef HAVE_VERSIONHELPERS_H
  #include <versionhelpers.h>
@@ -1198,6 +1199,20 @@ HandleEnableDHCPMessage(const 
enable_dhcp_message_t *dhcp)
      return err;
  }

+static DWORD
+HandleMTUMessage(const set_mtu_message_t *mtu)
+{
+    DWORD err = 0;
+    MIB_IPINTERFACE_ROW row;
+    InitializeIpInterfaceEntry(&row);
+    row.Family = mtu->family;
+    row.InterfaceIndex = mtu->iface.index;
+    row.NlMtu = mtu->mtu;
+
+    err = SetIpInterfaceEntry(&row);
+    return err;
+}
+
  static VOID
  HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, 
undo_lists_t *lists)
  {
@@ -1210,6 +1225,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD 
count, LPHANDLE events, undo_lists
          block_dns_message_t block_dns;
          dns_cfg_message_t dns;
          enable_dhcp_message_t dhcp;
+        set_mtu_message_t mtu;
      } msg;
      ack_message_t ack = {
          .header = {
@@ -1276,6 +1292,12 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD 
count, LPHANDLE events, undo_lists
                  ack.error_number = HandleEnableDHCPMessage(&msg.dhcp);
              }
              break;
+        case msg_set_mtu:
+            if (msg.header.size == sizeof(msg.mtu))
+            {
+                ack.error_number = HandleMTUMessage(&msg.mtu);
+            }
+            break;

          default:
              ack.error_number = ERROR_MESSAGE_TYPE;


