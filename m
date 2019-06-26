MIME-Version: 1.0
References: <CAKuzo_jvYaihBobd14U45epDOB43Dd_Kmhyug7py_+hmFjnCBg@...278...>
 <1561542690-17559-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1561542690-17559-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 26 Jun 2019 12:57:46 -0400
Message-ID: <CAKuzo_iGLb=hVgFeJ9JcwdnQoTrp3f6QZr=D4GvhKgcW7At0yQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnserv: enable interactive
 service to open tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I haven't compiled or run tested, but there are few issues that need
to be addressed before that:

On Wed, Jun 26, 2019 at 5:52 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> This patch enables interactive service to open tun device.
> This is mostly needed by Wintun, which could be opened
> only by privileged process.
>
> When interactive service is used, instead of calling
> CreateFile() directly by openvpn process we pass tun device path
> into service process. There we open device, duplicate handle
> and pass it back to openvpn process.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v2:
>   - introduce send_msg_iservice_ex() instead of changing
>   signature of existing send_msg_iservice()
>   - use wchar_t strings in interactive service code
>
>  include/openvpn-msg.h         | 12 +++++++++
>  src/openvpn/tun.c             | 60 +++++++++++++++++++++++++++++++++++++------
>  src/openvpn/win32.c           |  9 ++++++-
>  src/openvpn/win32.h           | 30 +++++++++++++++++++---
>  src/openvpnserv/interactive.c | 57 +++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 154 insertions(+), 14 deletions(-)
>
> diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
> index 66177a2..273d9a6 100644
> --- a/include/openvpn-msg.h
> +++ b/include/openvpn-msg.h
> @@ -39,6 +39,8 @@ typedef enum {
>      msg_del_block_dns,
>      msg_register_dns,
>      msg_enable_dhcp,
> +    msg_open_tun_device,
> +    msg_open_tun_device_result,
>  } message_type_t;
>
>  typedef struct {
> @@ -117,4 +119,14 @@ typedef struct {
>      interface_t iface;
>  } enable_dhcp_message_t;
>
> +typedef struct {
> +    message_header_t header;
> +    char device_path[512];
> +} open_tun_device_message_t;
> +
> +typedef struct {
> +    message_header_t header;
> +    HANDLE handle;
> +    int error_number;
> +} open_tun_device_result_message_t;
>  #endif /* ifndef OPENVPN_MSG_H_ */
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 8f8f7c6..6caba50 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5248,6 +5248,43 @@ out:
>      return ret;
>  }
>
> +static HANDLE
> +service_open_tun_device(const HANDLE pipe, const char* device_path)
> +{
> +    open_tun_device_result_message_t result_msg;
> +    struct gc_arena gc = gc_new();
> +    open_tun_device_message_t open_tun_device = {
> +        .header = {
> +            msg_open_tun_device,
> +            sizeof(open_tun_device_message_t),
> +            0
> +        }
> +    };
> +    result_msg.handle = INVALID_HANDLE_VALUE;
> +
> +    strncpynt(open_tun_device.device_path, device_path, sizeof(open_tun_device.device_path));
> +
> +    if (!send_msg_iservice_ex(pipe, &open_tun_device, sizeof(open_tun_device),
> +        &result_msg, sizeof(result_msg), "Open_tun_device"))
> +    {
> +        goto out;
> +    }
> +
> +    if (result_msg.error_number != NO_ERROR)
> +    {
> +        msg(D_TUNTAP_INFO, "TUN: opening tun handle using service failed: %s [status=%u device_path=%s]",
> +            strerror_win32(result_msg.error_number, &gc), result_msg.error_number, device_path);
> +    }
> +    else
> +    {
> +        msg(M_INFO, "Opened tun device %s using service", device_path);
> +    }
> +
> +out:
> +    gc_free(&gc);
> +    return result_msg.handle;
> +}
> +
>  /*
>   * Return a TAP name for netsh commands.
>   */
> @@ -5631,15 +5668,22 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>                                   device_guid,
>                                   TAP_WIN_SUFFIX);
>
> -                tt->hand = CreateFile(
> -                    device_path,
> -                    GENERIC_READ | GENERIC_WRITE,
> -                    0,                /* was: FILE_SHARE_READ */
> -                    0,
> -                    OPEN_EXISTING,
> -                    FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
> -                    0
> +                if (tt->options.msg_channel)
> +                {
> +                    tt->hand = service_open_tun_device(tt->options.msg_channel, device_path);
> +                }
> +                else
> +                {
> +                    tt->hand = CreateFile(
> +                        device_path,
> +                        GENERIC_READ | GENERIC_WRITE,
> +                        0,                /* was: FILE_SHARE_READ */
> +                        0,
> +                        OPEN_EXISTING,
> +                        FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
> +                        0
>                      );
> +                }
>
>                  if (tt->hand == INVALID_HANDLE_VALUE)
>                  {

This only handles dev-node is unspecified. We need the same for
the case where dev-node specified above this.

> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index eb4c030..039c1a4 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -1476,12 +1476,19 @@ bool
>  send_msg_iservice(HANDLE pipe, const void *data, size_t size,
>                    ack_message_t *ack, const char *context)
>  {
> +    return send_msg_iservice_ex(pipe, data, size, ack, sizeof(*ack), context);
> +}
> +
> +bool
> +send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,
> +                     void *response, size_t response_size, const char *context)
> +{
>      struct gc_arena gc = gc_new();
>      DWORD len;
>      bool ret = true;
>
>      if (!WriteFile(pipe, data, size, &len, NULL)
> -        || !ReadFile(pipe, ack, sizeof(*ack), &len, NULL))
> +        || !ReadFile(pipe, response, response_size, &len, NULL))
>      {
>          msg(M_WARN, "%s: could not talk to service: %s [%lu]",
>              context ? context : "Unknown",
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index 4814bbc..8ccddc0 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -309,14 +309,36 @@ int win32_version_info(void);
>   */
>  const char *win32_version_string(struct gc_arena *gc, bool add_name);
>
> -/*
> - * Send the |size| bytes in buffer |data| to the interactive service |pipe|
> - * and read the result in |ack|. Returns false on communication error.
> - * The string in |context| is used to prefix error messages.
> +
> +/**
> + * Send data to interactive service and receive response of type ack_message_t.
> + *
> + * @param  pipe      The handle of communication pipe
> + * @param  data      The data to send
> + * @param  size      The size of data to send
> + * @param  response  The pointer to ack_message_t structure to where response is written

response --> ack

> + * @param  context   The string used to prefix error messages
> + *
> + * @returns True on success, false on failure.
>   */
>  bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
>                         ack_message_t *ack, const char *context);
>
> +/**
> + * Send data to interactive service and receive response.
> + *
> + * @param  pipe           The handle of communication pipe
> + * @param  data           The data to send
> + * @param  size           The size of data to send
> + * @param  response       The buffer to where response is written
> + * @param  response_size  The size of response buffer
> + * @param  context        The string used to prefix error messages
> + *
> + * @returns True on success, false on failure.
> + */
> +bool send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,
> +                          void *response, size_t response_size, const char *context);
> +
>  /*
>   * Attempt to simulate fork/execve on Windows
>   */
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 623c3ff..81d556b 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -57,7 +57,7 @@ static HANDLE exit_event = NULL;
>  static settings_t settings;
>  static HANDLE rdns_semaphore = NULL;
>  #define RDNS_TIMEOUT 600  /* seconds to wait for the semaphore */
> -
> +static HANDLE ovpn_process = NULL; /* used by DuplicateHandle() when passing tun device handle to openvpn process */

We service multiple OpenVPN processes, so a global variable is no good.

Some alternatives:
(i) Use GetNamedPipeClientProcessId() each time
(ii) save the processId in undo_lists (this list is local to the service thread)

>
>  openvpn_service_t interactive_service = {
>      interactive,
> @@ -1198,6 +1198,42 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
>      return err;
>  }
>
> +static DWORD
> +HandleOpenTunDeviceMessage(const open_tun_device_message_t *open_tun, HANDLE *remote_handle)
> +{
> +    DWORD err = 0;
> +
> +    *remote_handle = INVALID_HANDLE_VALUE;
> +
> +    LPWSTR device_path = utf8to16(open_tun->device_path);

I think we must ensure device_path is null terminated as its received
over the pipe from a user process. Our utf8to16() just assumes it is.
There are a few other places where we've this defect but that has to
be handled in a separate patch.

> +    if (!device_path)
> +    {
> +        err = ERROR_OUTOFMEMORY;
> +        goto out;
> +    }
> +
> +    HANDLE local_handle = CreateFileW(device_path, GENERIC_READ | GENERIC_WRITE, 0, 0,
> +                                      OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, 0);

As wintun allows the device to be opened multiple times, we'll
eventually need some protection against that. Saying this as the real
purpose of this patch is to enable the use of wintun. But this is fine
for tapwindows.

> +
> +    if (local_handle == INVALID_HANDLE_VALUE)
> +    {

Need err = GetLastError(); here. Otherwise we're returning success as
the error code with an invalid handle.

> +        MsgToEventLog(M_SYSERR, TEXT("Error opening tun device (%s)"), device_path);
> +        goto out;
> +    }
> +
> +    if (!DuplicateHandle(GetCurrentProcess(), local_handle, ovpn_process, remote_handle, 0, FALSE,
> +            DUPLICATE_CLOSE_SOURCE | DUPLICATE_SAME_ACCESS))
> +    {
> +        err = GetLastError();
> +        MsgToEventLog(M_SYSERR, TEXT("Error duplicating tun device handle"));
> +    }
> +
> +out:
> +    free(device_path);
> +
> +    return err;
> +}
> +
>  static VOID
>  HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
>  {
> @@ -1210,6 +1246,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
>          block_dns_message_t block_dns;
>          dns_cfg_message_t dns;
>          enable_dhcp_message_t dhcp;
> +        open_tun_device_message_t open_tun;
>      } msg;
>      ack_message_t ack = {
>          .header = {
> @@ -1277,6 +1314,22 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
>              }
>              break;
>
> +        case msg_open_tun_device:
> +            if (msg.header.size == sizeof(msg.open_tun))
> +            {
> +                open_tun_device_result_message_t res = {
> +                    .header = {
> +                        .type = msg_open_tun_device_result,
> +                        .size = sizeof(res),
> +                        .message_id = msg.header.message_id
> +                    }
> +                };
> +                res.error_number = HandleOpenTunDeviceMessage(&msg.open_tun, &res.handle);
> +                WritePipeAsync(pipe, &res, sizeof(res), count, events);
> +                return;
> +            }
> +            break;
> +
>          default:
>              ack.error_number = ERROR_MESSAGE_TYPE;
>              MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
> @@ -1603,6 +1656,8 @@ RunOpenvpn(LPVOID p)
>          free(input);
>      }
>
> +    ovpn_process = proc_info.hProcess;

See above.

Selva


Selva


> +
>      while (TRUE)
>      {
>          DWORD bytes = PeekNamedPipeAsync(ovpn_pipe, 1, &exit_event);
> --
> 2.7.4

