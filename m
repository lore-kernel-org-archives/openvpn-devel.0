From: Simon Rozman <simon@...2293...>
Date: Tue, 17 Dec 2019 13:17:37 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10D05C945E@...2294...>
References: <20191120145952.303-1-lstipakov@...277...>
 <20191217125041.207-1-lstipakov@...277...>
In-Reply-To: <20191217125041.207-1-lstipakov@...277...>
Content-Language: en-US
Content-Type: multipart/signed; micalg=2.16.840.1.101.3.4.2.1;
 protocol="application/x-pkcs7-signature";
 boundary="----=_NextPart_000_0025_01D5B4E4.BAF88510"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v5 5/7] wintun: interactive service
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

------=_NextPart_000_0025_01D5B4E4.BAF88510
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Definitely an ack. We need this for Wintun and to drop that SYSTEM token
hack.

Acked-by: Simon Rozman <simon@...2293...> 

Best regards,
Simon

> -----Original Message-----
> From: Lev Stipakov <lstipakov@...277...>
> Sent: Tuesday, December 17, 2019 1:51 PM
> To: openvpn-devel@lists.sourceforge.net
> Cc: Lev Stipakov <lev@...515...>
> Subject: [Openvpn-devel] [PATCH v5 5/7] wintun: interactive service
> support
> 
> From: Lev Stipakov <lev@...515...>
> 
> Wintun requires ring buffers registration to be performed by privileged
> process. In order to use openvpn with wintun by non-Administrator, we
> need to use interactive service and shared memory to register buffers.
> 
> Openvpn process creates memory mapping object and event for send and
> receive ring and passes handles to interactive service. There handles
> are duplicated and memory mapped object is mapped into the address space
> of service process.
> Then address of mapped view and event handle is passed to wintun kernel
> driver.
> 
> After interactive service preformed registration, openvpn process maps
> memory mapped object into own address space. Thus mapped views in
> openvpn and service process represent the same memory region.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> 
>  While v2 has been ACKed, it had to be rebased on  top of previous patch
> in series, which required some  manual work.
> 
>  v5:
>   - rebased on top of [PATCH v8 4/7] wintun: ring buffers based I/O
>     (fixed struct tun_ring layout and made DeviceIoControl result check
> more robust)
> 
>  v4:
>   - rebased on top of [PATCH v5 4/7] "wintun: ring buffers based I/O"
> 
>  v3:
>   - rebased on top of [PATCH v4 4/7] "wintun: ring buffers based I/O"
>   - added doxygen comments to ring_buffer.h
> 
>  v2:
>   - rebased on top of master
> 
>  include/openvpn-msg.h                       |  10 ++
>  src/openvpn/Makefile.am                     |   2 +-
>  src/openvpn/openvpn.vcxproj                 |   2 +
>  src/openvpn/openvpn.vcxproj.filters         |   8 +-
>  src/openvpn/ring_buffer.c                   |  56 ++++++++
>  src/openvpn/ring_buffer.h                   | 104 +++++++++++++++
>  src/openvpn/tun.c                           |  82 ++++++++++--
>  src/openvpn/tun.h                           |   3 +
>  src/openvpn/win32.c                         |  27 ----
>  src/openvpn/win32.h                         |  46 -------
>  src/openvpnserv/Makefile.am                 |   3 +-
>  src/openvpnserv/interactive.c               | 141 +++++++++++++++++++-
>  src/openvpnserv/openvpnserv.vcxproj         |   2 +
>  src/openvpnserv/openvpnserv.vcxproj.filters |   6 +
>  14 files changed, 399 insertions(+), 93 deletions(-)  create mode
> 100644 src/openvpn/ring_buffer.c  create mode 100644
> src/openvpn/ring_buffer.h
> 
> diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h index
> 66177a21..3ed62069 100644
> --- a/include/openvpn-msg.h
> +++ b/include/openvpn-msg.h
> @@ -39,6 +39,7 @@ typedef enum {
>      msg_del_block_dns,
>      msg_register_dns,
>      msg_enable_dhcp,
> +    msg_register_ring_buffers
>  } message_type_t;
> 
>  typedef struct {
> @@ -117,4 +118,13 @@ typedef struct {
>      interface_t iface;
>  } enable_dhcp_message_t;
> 
> +typedef struct {
> +    message_header_t header;
> +    HANDLE device;
> +    HANDLE send_ring_handle;
> +    HANDLE receive_ring_handle;
> +    HANDLE send_tail_moved;
> +    HANDLE receive_tail_moved;
> +} register_ring_buffers_message_t;
> +
>  #endif /* ifndef OPENVPN_MSG_H_ */
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am index
> a091ffc2..d1bb99c2 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -138,6 +138,6 @@ openvpn_LDADD = \
>  	$(OPTIONAL_SYSTEMD_LIBS) \
>  	$(OPTIONAL_DL_LIBS)
>  if WIN32
> -openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h
> +openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h
> +ring_buffer.c ring_buffer.h
>  openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -
> lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi  endif diff --git
> a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj index
> 7446d97d..614d720a 100644
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -181,6 +181,7 @@
>      <ClCompile Include="ps.c" />
>      <ClCompile Include="push.c" />
>      <ClCompile Include="reliable.c" />
> +    <ClCompile Include="ring_buffer.c" />
>      <ClCompile Include="route.c" />
>      <ClCompile Include="run_command.c" />
>      <ClCompile Include="schedule.c" />
> @@ -265,6 +266,7 @@
>      <ClInclude Include="push.h" />
>      <ClInclude Include="pushlist.h" />
>      <ClInclude Include="reliable.h" />
> +    <ClInclude Include="ring_buffer.h" />
>      <ClInclude Include="route.h" />
>      <ClInclude Include="run_command.h" />
>      <ClInclude Include="schedule.h" />
> diff --git a/src/openvpn/openvpn.vcxproj.filters
> b/src/openvpn/openvpn.vcxproj.filters
> index 653e892c..41e62d14 100644
> --- a/src/openvpn/openvpn.vcxproj.filters
> +++ b/src/openvpn/openvpn.vcxproj.filters
> @@ -240,6 +240,9 @@
>      <ClCompile Include="vlan.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
> +    <ClCompile Include="ring_buffer.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
>    </ItemGroup>
>    <ItemGroup>
>      <ClInclude Include="base64.h">
> @@ -500,10 +503,13 @@
>      <ClInclude Include="vlan.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> +    <ClInclude Include="ring_buffer.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
>    </ItemGroup>
>    <ItemGroup>
>      <ResourceCompile Include="openvpn_win32_resources.rc">
>        <Filter>Resource Files</Filter>
>      </ResourceCompile>
>    </ItemGroup>
> -</Project>
> \ No newline at end of file
> +</Project>
> diff --git a/src/openvpn/ring_buffer.c b/src/openvpn/ring_buffer.c new
> file mode 100644 index 00000000..8c81dc46
> --- /dev/null
> +++ b/src/openvpn/ring_buffer.c
> @@ -0,0 +1,56 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
> + *                2019 Lev Stipakov <lev@...515...>
> + *
> + *  This program is free software; you can redistribute it and/or
> +modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> +along
> + *  with this program; if not, write to the Free Software Foundation,
> +Inc.,
> + *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include "ring_buffer.h"
> +
> +#ifdef _WIN32
> +
> +bool
> +register_ring_buffers(HANDLE device,
> +                      struct tun_ring *send_ring,
> +                      struct tun_ring *receive_ring,
> +                      HANDLE send_tail_moved,
> +                      HANDLE receive_tail_moved) {
> +    struct tun_register_rings rr;
> +    BOOL res;
> +    DWORD bytes_returned;
> +
> +    ZeroMemory(&rr, sizeof(rr));
> +
> +    rr.send.ring = send_ring;
> +    rr.send.ring_size = sizeof(struct tun_ring);
> +    rr.send.tail_moved = send_tail_moved;
> +
> +    rr.receive.ring = receive_ring;
> +    rr.receive.ring_size = sizeof(struct tun_ring);
> +    rr.receive.tail_moved = receive_tail_moved;
> +
> +    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr,
> sizeof(rr),
> +                          NULL, 0, &bytes_returned, NULL);
> +
> +    return res != FALSE;
> +}
> +
> +#endif /* ifdef _WIN32 */
> \ No newline at end of file
> diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h new
> file mode 100644 index 00000000..3522c984
> --- /dev/null
> +++ b/src/openvpn/ring_buffer.h
> @@ -0,0 +1,104 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2002-2019 OpenVPN Inc <sales@...515...>
> + *                2019 Lev Stipakov <lev@...515...>
> + *
> + *  This program is free software; you can redistribute it and/or
> +modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> +along
> + *  with this program; if not, write to the Free Software Foundation,
> +Inc.,
> + *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifdef _WIN32
> +#ifndef OPENVPN_RING_BUFFER_H
> +#define OPENVPN_RING_BUFFER_H
> +
> +#include <windows.h>
> +#include <winioctl.h>
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +
> +/*
> + * Values below are taken from Wireguard Windows client
> + *
> +https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/ring_w
> +indows.go#L14
> + */
> +#define WINTUN_RING_CAPACITY        0x800000
> +#define WINTUN_RING_TRAILING_BYTES  0x10000
> +#define WINTUN_MAX_PACKET_SIZE      0xffff
> +#define WINTUN_PACKET_ALIGN         4
> +
> +#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U,
> +METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
> +
> +/**
> + * Wintun ring buffer
> + * See https://github.com/WireGuard/wintun#ring-layout
> + */
> +struct tun_ring
> +{
> +    volatile ULONG head;
> +    volatile ULONG tail;
> +    volatile LONG alertable;
> +    UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES]; };
> +
> +/**
> + * Struct for ring buffers registration
> + * See https://github.com/WireGuard/wintun#registering-rings
> + */
> +struct tun_register_rings
> +{
> +    struct
> +    {
> +        ULONG ring_size;
> +        struct tun_ring *ring;
> +        HANDLE tail_moved;
> +    } send, receive;
> +};
> +
> +struct TUN_PACKET_HEADER
> +{
> +    uint32_t size;
> +};
> +
> +struct TUN_PACKET
> +{
> +    uint32_t size;
> +    UCHAR data[WINTUN_MAX_PACKET_SIZE]; };
> +
> +/**
> + * Registers ring buffers used to exchange data between
> + * userspace openvpn process and wintun kernel driver,
> + * see https://github.com/WireGuard/wintun#registering-rings
> + *
> + * @param device              handle to opened wintun device
> + * @param send_ring           pointer to send ring
> + * @param receive_ring        pointer to receive ring
> + * @param send_tail_moved     event set by wintun to signal openvpn
> + *                            that data is available for reading in
> send ring
> + * @param receive_tail_moved  event set by openvpn to signal wintun
> + *                            that data has been written to receive
> ring
> + * @return                    true if registration is successful, false
> otherwise
> + */
> +bool register_ring_buffers(HANDLE device,
> +                           struct tun_ring *send_ring,
> +                           struct tun_ring *receive_ring,
> +                           HANDLE send_tail_moved,
> +                           HANDLE receive_tail_moved);
> +
> +#endif /* ifndef OPENVPN_RING_BUFFER_H */ #endif /* ifdef _WIN32 */
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c index
> 3f66b216..77d84fb2 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -779,17 +779,29 @@ init_tun_post(struct tuntap *tt,
> 
>      if (tt->wintun)
>      {
> -        tt->wintun_send_ring = malloc(sizeof(struct tun_ring));
> -        tt->wintun_receive_ring = malloc(sizeof(struct tun_ring));
> -        if ((tt->wintun_send_ring == NULL) || (tt->wintun_receive_ring
> == NULL))
> +        tt->wintun_send_ring_handle =
> CreateFileMapping(INVALID_HANDLE_VALUE, NULL,
> +                                                        PAGE_READWRITE,
> +                                                        0,
> +                                                        sizeof(struct
> tun_ring),
> +                                                        NULL);
> +        tt->wintun_receive_ring_handle =
> CreateFileMapping(INVALID_HANDLE_VALUE,
> +                                                           NULL,
> +
> PAGE_READWRITE,
> +                                                           0,
> +
> sizeof(struct tun_ring),
> +                                                           NULL);
> +        if ((tt->wintun_send_ring_handle == NULL) ||
> + (tt->wintun_receive_ring_handle == NULL))
>          {
>              msg(M_FATAL, "Cannot allocate memory for ring buffer");
>          }
> -        ZeroMemory(tt->wintun_send_ring, sizeof(struct tun_ring));
> -        ZeroMemory(tt->wintun_receive_ring, sizeof(struct tun_ring));
> 
>          tt->rw_handle.read = CreateEvent(NULL, FALSE, FALSE, NULL);
>          tt->rw_handle.write = CreateEvent(NULL, FALSE, FALSE, NULL);
> +
> +        if ((tt->rw_handle.read == NULL) || (tt->rw_handle.write ==
> NULL))
> +        {
> +            msg(M_FATAL, "Cannot create events for ring buffer");
> +        }
>      }
>      else
>      {
> @@ -5604,6 +5616,44 @@ register_dns_service(const struct tuntap *tt)
>      gc_free(&gc);
>  }
> 
> +static void
> +service_register_ring_buffers(const struct tuntap *tt) {
> +    HANDLE msg_channel = tt->options.msg_channel;
> +    ack_message_t ack;
> +    struct gc_arena gc = gc_new();
> +
> +    register_ring_buffers_message_t msg = {
> +        .header = {
> +            msg_register_ring_buffers,
> +            sizeof(register_ring_buffers_message_t),
> +            0
> +        },
> +        .device = tt->hand,
> +        .send_ring_handle = tt->wintun_send_ring_handle,
> +        .receive_ring_handle = tt->wintun_receive_ring_handle,
> +        .send_tail_moved = tt->rw_handle.read,
> +        .receive_tail_moved = tt->rw_handle.write
> +    };
> +
> +    if (!send_msg_iservice(msg_channel, &msg, sizeof(msg), &ack,
> "Register ring buffers"))
> +    {
> +        gc_free(&gc);
> +        return;
> +    }
> +    else if (ack.error_number != NO_ERROR)
> +    {
> +        msg(M_FATAL, "Register ring buffers failed using service: %s
> [status=0x%x]",
> +            strerror_win32(ack.error_number, &gc), ack.error_number);
> +    }
> +    else
> +    {
> +        msg(M_INFO, "Ring buffers registered via service");
> +    }
> +
> +    gc_free(&gc);
> +}
> +
>  void
>  fork_register_dns_action(struct tuntap *tt)  { @@ -6198,9 +6248,20 @@
> open_tun(const char *dev, const char *dev_type, const char *dev_node,
> struct tun
> 
>      if (tt->wintun)
>      {
> +        tt->wintun_send_ring = (struct tun_ring *)MapViewOfFile(tt-
> >wintun_send_ring_handle,
> +
> FILE_MAP_ALL_ACCESS,
> +                                                                0,
> +                                                                0,
> +
> sizeof(struct tun_ring));
> +        tt->wintun_receive_ring = (struct tun_ring *)MapViewOfFile(tt-
> >wintun_receive_ring_handle,
> +
> FILE_MAP_ALL_ACCESS,
> +                                                                   0,
> +                                                                   0,
> +
> + sizeof(struct tun_ring));
> +
>          if (tt->options.msg_channel)
>          {
> -            /* TODO */
> +            service_register_ring_buffers(tt);
>          }
>          else
>          {
> @@ -6365,13 +6426,12 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t
> *ctx)
>      {
>          CloseHandle(tt->rw_handle.read);
>          CloseHandle(tt->rw_handle.write);
> +        UnmapViewOfFile(tt->wintun_send_ring);
> +        UnmapViewOfFile(tt->wintun_receive_ring);
> +        CloseHandle(tt->wintun_send_ring_handle);
> +        CloseHandle(tt->wintun_receive_ring_handle);
>      }
> 
> -    free(tt->wintun_receive_ring);
> -    free(tt->wintun_send_ring);
> -
> -    tt->wintun_receive_ring = NULL;
> -    tt->wintun_send_ring = NULL;
> 
>      clear_tuntap(tt);
>      free(tt);
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h index
> 10f687c5..b0b80d1a 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -39,6 +39,7 @@
>  #include "proto.h"
>  #include "misc.h"
>  #include "networking.h"
> +#include "ring_buffer.h"
> 
>  #ifdef _WIN32
>  #define WINTUN_COMPONENT_ID "wintun"
> @@ -183,6 +184,8 @@ struct tuntap
>      bool wintun; /* true if wintun is used instead of tap-windows6 */
>      int standby_iter;
> 
> +    HANDLE wintun_send_ring_handle;
> +    HANDLE wintun_receive_ring_handle;
>      struct tun_ring *wintun_send_ring;
>      struct tun_ring *wintun_receive_ring;  #else  /* ifdef _WIN32 */
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c index
> 24dae7d6..b2f2a19f 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -1588,31 +1588,4 @@ impersonate_as_system()
>      return true;
>  }
> 
> -bool
> -register_ring_buffers(HANDLE device,
> -                      struct tun_ring* send_ring,
> -                      struct tun_ring* receive_ring,
> -                      HANDLE send_tail_moved,
> -                      HANDLE receive_tail_moved)
> -{
> -    struct tun_register_rings rr;
> -    BOOL res;
> -    DWORD bytes_returned;
> -
> -    ZeroMemory(&rr, sizeof(rr));
> -
> -    rr.send.ring = send_ring;
> -    rr.send.ring_size = sizeof(struct tun_ring);
> -    rr.send.tail_moved = send_tail_moved;
> -
> -    rr.receive.ring = receive_ring;
> -    rr.receive.ring_size = sizeof(struct tun_ring);
> -    rr.receive.tail_moved = receive_tail_moved;
> -
> -    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr,
> sizeof(rr),
> -                          NULL, 0, &bytes_returned, NULL);
> -
> -    return res != FALSE;
> -}
> -
>  #endif /* ifdef _WIN32 */
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h index
> 5fe95f47..4b508c56 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -325,53 +325,7 @@ bool send_msg_iservice(HANDLE pipe, const void
> *data, size_t size,  int  openvpn_execve(const struct argv *a, const
> struct env_set *es, const unsigned int flags);
> 
> -/*
> - * Values below are taken from Wireguard Windows client
> - * https://github.com/WireGuard/wireguard-
> go/blob/master/tun/wintun/ring_windows.go#L14
> - */
> -#define WINTUN_RING_CAPACITY 0x800000
> -#define WINTUN_RING_TRAILING_BYTES 0x10000 -#define
> WINTUN_MAX_PACKET_SIZE 0xffff -#define WINTUN_PACKET_ALIGN 4
> -
> -struct tun_ring
> -{
> -    volatile ULONG head;
> -    volatile ULONG tail;
> -    volatile LONG alertable;
> -    UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES];
> -};
> -
> -struct tun_register_rings
> -{
> -    struct
> -    {
> -        ULONG ring_size;
> -        struct tun_ring *ring;
> -        HANDLE tail_moved;
> -    } send, receive;
> -};
> -
> -struct TUN_PACKET_HEADER
> -{
> -    uint32_t size;
> -};
> -
> -struct TUN_PACKET
> -{
> -    uint32_t size;
> -    UCHAR data[WINTUN_MAX_PACKET_SIZE];
> -};
> -
> -#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U,
> METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
> -
>  bool impersonate_as_system();
> 
> -bool register_ring_buffers(HANDLE device,
> -                           struct tun_ring *send_ring,
> -                           struct tun_ring *receive_ring,
> -                           HANDLE send_tail_moved,
> -                           HANDLE receive_tail_moved);
> -
>  #endif /* ifndef OPENVPN_WIN32_H */
>  #endif /* ifdef _WIN32 */
> diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
> index bc65070b..f8d3319c 100644
> --- a/src/openvpnserv/Makefile.am
> +++ b/src/openvpnserv/Makefile.am
> @@ -36,4 +36,5 @@ openvpnserv_SOURCES = \
>  	service.c service.h \
>  	validate.c validate.h \
>  	$(top_srcdir)/src/openvpn/block_dns.c
> $(top_srcdir)/src/openvpn/block_dns.h \
> -	openvpnserv_resources.rc
> +	openvpnserv_resources.rc \
> +	$(top_srcdir)/src/openvpn/ring_buffer.c
> +$(top_srcdir)/src/openvpn/ring_buffer.h
> diff --git a/src/openvpnserv/interactive.c
> b/src/openvpnserv/interactive.c index 623c3ff7..6e72a141 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -43,13 +43,15 @@
>  #include "openvpn-msg.h"
>  #include "validate.h"
>  #include "block_dns.h"
> +#include "ring_buffer.h"
> 
>  #define IO_TIMEOUT  2000 /*ms*/
> 
> -#define ERROR_OPENVPN_STARTUP  0x20000000
> -#define ERROR_STARTUP_DATA     0x20000001
> -#define ERROR_MESSAGE_DATA     0x20000002
> -#define ERROR_MESSAGE_TYPE     0x20000003
> +#define ERROR_OPENVPN_STARTUP        0x20000000
> +#define ERROR_STARTUP_DATA           0x20000001
> +#define ERROR_MESSAGE_DATA           0x20000002
> +#define ERROR_MESSAGE_TYPE           0x20000003
> +#define ERROR_REGISTER_RING_BUFFERS  0x20000004
> 
>  static SERVICE_STATUS_HANDLE service;
>  static SERVICE_STATUS status = { .dwServiceType =
> SERVICE_WIN32_SHARE_PROCESS }; @@ -58,6 +60,7 @@ static settings_t
> settings;  static HANDLE rdns_semaphore = NULL;  #define RDNS_TIMEOUT
> 600  /* seconds to wait for the semaphore */
> 
> +#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U,
> +METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
> 
>  openvpn_service_t interactive_service = {
>      interactive,
> @@ -100,6 +103,14 @@ typedef struct {
>      int metric_v6;
>  } block_dns_data_t;
> 
> +typedef struct {
> +    HANDLE send_ring_handle;
> +    HANDLE receive_ring_handle;
> +    HANDLE send_tail_moved;
> +    HANDLE receive_tail_moved;
> +    HANDLE device;
> +} ring_buffer_handles_t;
> +
> 
>  static DWORD
>  AddListItem(list_item_t **pfirst, LPVOID data) @@ -154,6 +165,26 @@
> CloseHandleEx(LPHANDLE handle)
>      return INVALID_HANDLE_VALUE;
>  }
> 
> +static HANDLE
> +OvpnUnmapViewOfFile(LPHANDLE handle)
> +{
> +    if (handle && *handle && *handle != INVALID_HANDLE_VALUE)
> +    {
> +        UnmapViewOfFile(*handle);
> +        *handle = INVALID_HANDLE_VALUE;
> +    }
> +    return INVALID_HANDLE_VALUE;
> +}
> +
> +static void
> +CloseRingBufferHandles(ring_buffer_handles_t *ring_buffer_handles) {
> +    CloseHandleEx(&ring_buffer_handles->device);
> +    CloseHandleEx(&ring_buffer_handles->receive_tail_moved);
> +    CloseHandleEx(&ring_buffer_handles->send_tail_moved);
> +    OvpnUnmapViewOfFile(&ring_buffer_handles->send_ring_handle);
> +    OvpnUnmapViewOfFile(&ring_buffer_handles->receive_ring_handle);
> +}
> 
>  static HANDLE
>  InitOverlapped(LPOVERLAPPED overlapped) @@ -1198,8 +1229,95 @@
> HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
>      return err;
>  }
> 
> +static DWORD
> +OvpnDuplicateHandle(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE*
> +new_handle) {
> +    DWORD err = ERROR_SUCCESS;
> +
> +    if (!DuplicateHandle(ovpn_proc, orig_handle, GetCurrentProcess(),
> new_handle, 0, FALSE, DUPLICATE_SAME_ACCESS))
> +    {
> +        err = GetLastError();
> +        MsgToEventLog(M_SYSERR, TEXT("Could not duplicate handle"));
> +        return err;
> +    }
> +
> +    return err;
> +}
> +
> +static DWORD
> +DuplicateAndMapRing(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE
> +*new_handle, struct tun_ring **ring) {
> +    DWORD err = ERROR_SUCCESS;
> +
> +    err = OvpnDuplicateHandle(ovpn_proc, orig_handle, new_handle);
> +    if (err != ERROR_SUCCESS)
> +    {
> +        return err;
> +    }
> +    *ring = (struct tun_ring *)MapViewOfFile(*new_handle,
> FILE_MAP_ALL_ACCESS, 0, 0, sizeof(struct tun_ring));
> +    if (*ring == NULL)
> +    {
> +        err = GetLastError();
> +        MsgToEventLog(M_SYSERR, TEXT("Could not map shared memory"));
> +        return err;
> +    }
> +
> +    return err;
> +}
> +
> +static DWORD
> +HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb,
> HANDLE ovpn_proc,
> +                          ring_buffer_handles_t *ring_buffer_handles) {
> +    DWORD err = 0;
> +    struct tun_ring *send_ring;
> +    struct tun_ring *receive_ring;
> +
> +    CloseRingBufferHandles(ring_buffer_handles);
> +
> +    err = OvpnDuplicateHandle(ovpn_proc, rrb->device,
> &ring_buffer_handles->device);
> +    if (err != ERROR_SUCCESS)
> +    {
> +        return err;
> +    }
> +
> +    err = DuplicateAndMapRing(ovpn_proc, rrb->send_ring_handle,
> &ring_buffer_handles->send_ring_handle, &send_ring);
> +    if (err != ERROR_SUCCESS)
> +    {
> +        return err;
> +    }
> +
> +    err = DuplicateAndMapRing(ovpn_proc, rrb->receive_ring_handle,
> &ring_buffer_handles->receive_ring_handle, &receive_ring);
> +    if (err != ERROR_SUCCESS)
> +    {
> +        return err;
> +    }
> +
> +    err = OvpnDuplicateHandle(ovpn_proc, rrb->send_tail_moved,
> &ring_buffer_handles->send_tail_moved);
> +    if (err != ERROR_SUCCESS)
> +    {
> +        return err;
> +    }
> +
> +    err = OvpnDuplicateHandle(ovpn_proc, rrb->receive_tail_moved,
> &ring_buffer_handles->receive_tail_moved);
> +    if (err != ERROR_SUCCESS)
> +    {
> +        return err;
> +    }
> +
> +    if (!register_ring_buffers(ring_buffer_handles->device, send_ring,
> receive_ring,
> +                               ring_buffer_handles->send_tail_moved,
> ring_buffer_handles->receive_tail_moved))
> +    {
> +        MsgToEventLog(M_SYSERR, TEXT("Could not register ring
> buffers"));
> +        err = ERROR_REGISTER_RING_BUFFERS;
> +    }
> +
> +    return err;
> +}
> +
>  static VOID
> -HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events,
> undo_lists_t *lists)
> +HandleMessage(HANDLE pipe, HANDLE ovpn_proc, ring_buffer_handles_t
> *ring_buffer_handles,
> +              DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t
> +*lists)
>  {
>      DWORD read;
>      union {
> @@ -1210,6 +1328,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD
> count, LPHANDLE events, undo_lists
>          block_dns_message_t block_dns;
>          dns_cfg_message_t dns;
>          enable_dhcp_message_t dhcp;
> +        register_ring_buffers_message_t rrb;
>      } msg;
>      ack_message_t ack = {
>          .header = {
> @@ -1277,6 +1396,13 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD
> count, LPHANDLE events, undo_lists
>              }
>              break;
> 
> +        case msg_register_ring_buffers:
> +            if (msg.header.size == sizeof(msg.rrb))
> +            {
> +                ack.error_number = HandleRegisterRingBuffers(&msg.rrb,
> ovpn_proc, ring_buffer_handles);
> +            }
> +            break;
> +
>          default:
>              ack.error_number = ERROR_MESSAGE_TYPE;
>              MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type
> %d"), msg.header.type); @@ -1360,6 +1486,7 @@ RunOpenvpn(LPVOID p)
>      WCHAR *cmdline = NULL;
>      size_t cmdline_size;
>      undo_lists_t undo_lists;
> +    ring_buffer_handles_t ring_buffer_handles;
> 
>      SECURITY_ATTRIBUTES inheritable = {
>          .nLength = sizeof(inheritable), @@ -1380,6 +1507,7 @@
> RunOpenvpn(LPVOID p)
>      ZeroMemory(&startup_info, sizeof(startup_info));
>      ZeroMemory(&undo_lists, sizeof(undo_lists));
>      ZeroMemory(&proc_info, sizeof(proc_info));
> +    ZeroMemory(&ring_buffer_handles, sizeof(ring_buffer_handles));
> 
>      if (!GetStartupData(pipe, &sud))
>      {
> @@ -1611,7 +1739,7 @@ RunOpenvpn(LPVOID p)
>              break;
>          }
> 
> -        HandleMessage(ovpn_pipe, bytes, 1, &exit_event, &undo_lists);
> +        HandleMessage(ovpn_pipe, proc_info.hProcess,
> + &ring_buffer_handles, bytes, 1, &exit_event, &undo_lists);
>      }
> 
>      WaitForSingleObject(proc_info.hProcess, IO_TIMEOUT); @@ -1638,6
> +1766,7 @@ out:
>      free(cmdline);
>      DestroyEnvironmentBlock(user_env);
>      FreeStartupData(&sud);
> +    CloseRingBufferHandles(&ring_buffer_handles);
>      CloseHandleEx(&proc_info.hProcess);
>      CloseHandleEx(&proc_info.hThread);
>      CloseHandleEx(&stdin_read);
> diff --git a/src/openvpnserv/openvpnserv.vcxproj
> b/src/openvpnserv/openvpnserv.vcxproj
> index 7061b7b1..c5a34b87 100644
> --- a/src/openvpnserv/openvpnserv.vcxproj
> +++ b/src/openvpnserv/openvpnserv.vcxproj
> @@ -115,6 +115,7 @@
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemGroup>
> +    <ClCompile Include="..\openvpn\ring_buffer.c" />
>      <ClCompile Include="automatic.c" />
>      <ClCompile Include="common.c" />
>      <ClCompile Include="interactive.c" /> @@ -123,6 +124,7 @@
>      <ClCompile Include="..\openvpn\block_dns.c" />
>    </ItemGroup>
>    <ItemGroup>
> +    <ClInclude Include="..\openvpn\ring_buffer.h" />
>      <ClInclude Include="service.h" />
>      <ClInclude Include="validate.h" />
>      <ClInclude Include="..\openvpn\block_dns.h" /> diff --git
> a/src/openvpnserv/openvpnserv.vcxproj.filters
> b/src/openvpnserv/openvpnserv.vcxproj.filters
> index 3ce9bb24..3cb14ef6 100644
> --- a/src/openvpnserv/openvpnserv.vcxproj.filters
> +++ b/src/openvpnserv/openvpnserv.vcxproj.filters
> @@ -33,6 +33,9 @@
>      <ClCompile Include="..\openvpn\block_dns.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
> +    <ClCompile Include="..\openvpn\ring_buffer.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
>    </ItemGroup>
>    <ItemGroup>
>      <ClInclude Include="service.h">
> @@ -44,6 +47,9 @@
>      <ClInclude Include="..\openvpn\block_dns.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> +    <ClInclude Include="..\openvpn\ring_buffer.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
>    </ItemGroup>
>    <ItemGroup>
>      <ResourceCompile Include="openvpnserv_resources.rc">
> --
> 2.17.1
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

------=_NextPart_000_0025_01D5B4E4.BAF88510
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AwMwJzAlBggrBgEFBQcCARYZaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3BzLzAIBgYEAIswAQIwGAYI
KwYBBQUHAQMEDDAKMAgGBgQAjkYBATAaBgNVHREEEzARgQ9zaW1vbkByb3ptYW4uc2kwge4GA1Ud
HwSB5jCB4zBWoFSgUqRQME4xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJzdGF0ZS1pbnN0aXR1dGlv
bnMxETAPBgNVBAsTCHNpZ2VuLWNhMQ8wDQYDVQQDEwZDUkw0NTUwgYiggYWggYKGV2xkYXA6Ly94
NTAwLmdvdi5zaS9vdT1zaWdlbi1jYSxvPXN0YXRlLWluc3RpdHV0aW9ucyxjPXNpP2NlcnRpZmlj
YXRlUmV2b2NhdGlvbkxpc3Q/YmFzZYYnaHR0cDovL3d3dy5zaWdlbi1jYS5zaS9jcmwvc2lnZW4t
Y2EuY3JsMCsGA1UdEAQkMCKADzIwMTYwMjE5MTc1NDQxWoEPMjAyMTAyMTkyMTM4MTVaMB8GA1Ud
IwQYMBaAFHF7igYfMQVVq2ASd0cgHgOIGOyJMB0GA1UdDgQWBBS7/7AHyQYI0e8GOPmwTc1ZTNw5
lzAJBgNVHRMEAjAAMBkGCSqGSIb2fQdBAAQMMAobBFY4LjEDAgOoMA0GCSqGSIb3DQEBBQUAA4IB
AQBBUL4KG1Z1oBIIdKIZs9yJxnJg/LfEPVvzNH8+CCqegq0D6k48Doo72oVEiskjqggdbUGj30uA
H8PjCD5kLGVoDwh5a2atQ3qQzaYA/lj2Js2f4fdXNn60vRp7XzbGsQdwYYecIrKzO5x6XVAIRb+T
HZNjXL3VX6vOozwBQv/+dx1P9H/rMUn7d8ci7v4PeqShbWbWwi6ez19cZvSKSkz/lWf4tj8QbA0n
WeUBlk3Bx6/TRda7kwXzcFExt+ROGt0YJjbZCN3kd7swcRvRT6gEi9L6n1XLghwPSYhzZjaL5fXv
I11JuSoQCy13XWBkq35Moo4iY19wanS1W6UM8Yq0MIIF5TCCBE2gAwIBAgINAKZovVEAAAAAVx3Q
6DANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJTSTEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3Zl
bmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAUBgNVBAMTDVNJLVRSVVNUIFJvb3QwHhcN
MTYwNTI0MTE1ODI3WhcNMjEwNjI3MjIwMDAwWjA9MQswCQYDVQQGEwJzaTEbMBkGA1UEChMSc3Rh
dGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALDlZbLArGSW8ogbs+2e5ALGTyuIzi6KUYB1rxBb8ss4ZpuiDm00R5alkhGv9jVH
onciDM4WiGKq00luGLwuRNi+xp7CGhmsQY78MAcC8sZq1FsjAO9BNNikc2PfIpIzhAGljfODXPq4
1Ho13+z4bQ/gTO2tnDp9htalCJS+fXoRH/6FP1RaiGOHnKWxp07Nt0Rzr8+KSWsf483XSU1aKxfm
XHazu3K5byfSm4kViN8QX3YhAWrHFTEK0ZxY+CgWBW3ZTtmh1wcgy0smiU2Ssqe6lujjWI8inAGW
WsT3MU0LSbXheGHiVBgGu55UNH4MPuvutYAf3RaEHWg4Zmdz+JECAwEAAaOCAkMwggI/MBIGA1Ud
EwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDoGA1UdIAQzMDEwLwYEVR0gADAnMCUGCCsG
AQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9jcHMvMGkGCCsGAQUFBwEBBF0wWzA2BggrBgEF
BQcwAoYqaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3J0L3NpLXRydXN0LXJvb3QuY3J0MCEGCCsGAQUF
BzABhhVodHRwOi8vb2NzcC5jYS5nb3Yuc2kwHQYDVR0OBBYEFHF7igYfMQVVq2ASd0cgHgOIGOyJ
MIIBPAYDVR0fBIIBMzCCAS8wgbeggbSggbGGKmh0dHA6Ly93d3cuY2EuZ292LnNpL2NybC9zaS10
cnVzdC1yb290LmNybIaBgmxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSS1UUlVTVCUyMFJvb3Qsb3Jn
YW5pemF0aW9uSWRlbnRpZmllcj1WQVRTSS0xNzY1OTk1NyxvPVJlcHVibGlrYSUyMFNsb3Zlbmlq
YSxjPVNJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Qwc6BxoG+kbTBrMQswCQYDVQQGEwJTSTEc
MBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAU
BgNVBAMTDVNJLVRSVVNUIFJvb3QxDTALBgNVBAMTBENSTDEwEwYDVR0jBAwwCoAITKPDaF4IAmMw
DQYJKoZIhvcNAQELBQADggGBAHuvNSPhY4qcirWJkTwkqaOPqOSV06J/ZepFQfUEJ87TlrGjp4XR
5FLktTAEY/7R4Sgeb2K8OWEl/Koc1BbH6+uyZYvfa+WnnJEWeWOmyPy/vooO7eZyOVvaORxurWOL
CCVDW2wBkbtUoKZaUyzgP+ZPPGRV8GFlbZLCzGmArMGXJXe8t/XNiJDLehGqSWT49NYjyYQdIgI+
qi9W+A6BSUQ9jsMdYJqKhXQcosfH51sc6gZVxTKMr3PsItsa8XFiNazECAAFr0ms7HB6zb8QvHRF
eBGk/CLrW4VkZEBN/JtuyhvgktQ2BvuGtauEvHZQAYpMSh35D7pwtavRMpmhaAsQb4yPqhIMcztw
RqsKPBhWoaFEVZ+Vn3wxap5h/oAhocifNzkWJTNWjxnoPM2eNz2uWFJsgsNhlwteUvnq7+bKTNte
SKWKr6pI+GUsZhmCh5URpUnqUanp0Uie0MD9f3tiOLOp711sNb0xwi+VdDuDB37IddOIsfhPBood
wpoFrTGCAyEwggMdAgEBMEUwPTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0
aW9uczERMA8GA1UECxMIc2lnZW4tY2ECBDtKDS4wDQYJYIZIAWUDBAIBBQCgggGtMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MTIxNzEzMTczNVowLwYJKoZIhvcN
AQkEMSIEIOpOiM3aKYpcJJz0zRvReUaRz3GHpwnzN8sNC8uDbokfMFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAcGBSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBACbZzwcM5NgRcewFClTrEEPx
dW5VJSmK6WToSGTeR9+r1olsbfL3lplmCL/lor0R5b3FnAdyt3HJAkNdpljxMKa+obAjGCN3OhuS
FxjAkF5G3c6yUvApxd4yEalti4SKCubapkD3uJcVG0oUBS6IcY7bkTov5Ku5nlYDv93dC7VMVBbZ
DKUoMyQS0pQvyhwf3e8l40YsWS9dpb3BSbmhZbqa+He8+gUYwUIaB+C62qOr5pQ3TByiNH6setXA
J4fIs9SVjW7a2bLsfzLF2c7yYQY31mB1nlB4atcuNjmv9kFJLjiaK0UKRQTiVNs4aRdoiibPcz1A
IgoGXnJCx2ytym0AAAAAAAA=

------=_NextPart_000_0025_01D5B4E4.BAF88510--

