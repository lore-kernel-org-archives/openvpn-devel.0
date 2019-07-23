MIME-Version: 1.0
References: <CAKuzo_jTwnNZ_5QtFo8YqUyWWhEJWBCYgnO_xAqEaNkumGPgrw@...278...>
 <1563873663-25785-1-git-send-email-lstipakov@...277...>
 <bb9ab727-ccab-b8e3-cde2-c7068e891b4a@...277...>
In-Reply-To: <bb9ab727-ccab-b8e3-cde2-c7068e891b4a@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 23 Jul 2019 15:17:01 +0300
Message-ID: <CAGyAFMUJur5bwmgNsTZUMR7oDO2AKidn9e-rXm4njPHwD97Q8g@...278...>
Content-Type: multipart/alternative; boundary="0000000000002dbbae058e582c36"
Subject: Re: [Openvpn-devel] [PATCH v6] openvpnserv: enable interactive
 service to open tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002dbbae058e582c36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This could be fixed by @cron2 when he will apply this patch :)

ti 23. hein=C3=A4k. 2019 klo 15.12 tincanteksup (tincanteksup@...277...)
kirjoitti:

> Looks like a typo below:
>
> On 23/07/2019 10:21, Lev Stipakov wrote:
> > From: Lev Stipakov <lev@...515...>
> >
> > This patch enables interactive service to open tun device.
> > This is mostly needed by Wintun, which could be opened
> > only by privileged process.
> >
> > When interactive service is used, instead of calling
> > CreateFile() directly by openvpn process we pass tun device path
> > into service process. There we open device, duplicate handle
> > and pass it back to openvpn process.
> >
> > Signed-off-by: Lev Stipakov <lev@...515...>
> > ---
> >   v6:
> >    - simplify and strengthen guid check with wcsspn()
> >    - fix doxygen comment
> >
> >   v5:
> >    - further strengthen security by passing only device guid from client
> process
> >    to service, validating guid and constructing device path on service
> side
> >
> >   v4:
> >    - strengthen security by adding basic validation to device path
> >    - reorder fields in msg_open_tun_device_result for backward
> compatibility
> >
> >   v3:
> >    - ensure that device path passed by client is null-terminated
> >    - support for multiple openvpn processes
> >    - return proper error code when device handle is invalid
> >
> >   v2:
> >    - introduce send_msg_iservice_ex() instead of changing
> >    signature of existing send_msg_iservice()
> >    - use wchar_t strings in interactive service code
> >
> >   include/openvpn-msg.h         | 12 +++++++
> >   src/openvpn/tun.c             | 83
> ++++++++++++++++++++++++++++++++++---------
> >   src/openvpn/win32.c           |  9 ++++-
> >   src/openvpn/win32.h           | 30 +++++++++++++---
> >   src/openvpnserv/interactive.c | 78
> ++++++++++++++++++++++++++++++++++++++--
> >   5 files changed, 188 insertions(+), 24 deletions(-)
> >
> > diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
> > index 66177a2..5dbdca5 100644
> > --- a/include/openvpn-msg.h
> > +++ b/include/openvpn-msg.h
> > @@ -39,6 +39,8 @@ typedef enum {
> >       msg_del_block_dns,
> >       msg_register_dns,
> >       msg_enable_dhcp,
> > +    msg_open_tun_device,
> > +    msg_open_tun_device_result,
> >   } message_type_t;
> >
> >   typedef struct {
> > @@ -117,4 +119,14 @@ typedef struct {
> >       interface_t iface;
> >   } enable_dhcp_message_t;
> >
> > +typedef struct {
> > +    message_header_t header;
> > +    char device_guid[36+2+1]; /* length of guid with dashes + braces +
> nul terminator */
> > +} open_tun_device_message_t;
> > +
> > +typedef struct {
> > +    message_header_t header;
> > +    int error_number;
> > +    HANDLE handle;
> > +} open_tun_device_result_message_t;
> >   #endif /* ifndef OPENVPN_MSG_H_ */
> > diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> > index 8f8f7c6..df26ccf 100644
> > --- a/src/openvpn/tun.c
> > +++ b/src/openvpn/tun.c
> > @@ -5248,6 +5248,43 @@ out:
> >       return ret;
> >   }
> >
> > +static HANDLE
> > +service_open_tun_device(const HANDLE pipe, const char* device_guid)
> > +{
> > +    open_tun_device_result_message_t result_msg;
> > +    struct gc_arena gc =3D gc_new();
> > +    open_tun_device_message_t open_tun_device =3D {
> > +        .header =3D {
> > +            msg_open_tun_device,
> > +            sizeof(open_tun_device_message_t),
> > +            0
> > +        }
> > +    };
> > +    result_msg.handle =3D INVALID_HANDLE_VALUE;
> > +
> > +    strncpynt(open_tun_device.device_guid, device_guid,
> sizeof(open_tun_device.device_guid));
> > +
> > +    if (!send_msg_iservice_ex(pipe, &open_tun_device,
> sizeof(open_tun_device),
> > +        &result_msg, sizeof(result_msg), "Open_tun_device"))
> > +    {
> > +        goto out;
> > +    }
> > +
> > +    if (result_msg.error_number !=3D NO_ERROR)
> > +    {
> > +        msg(D_TUNTAP_INFO, "TUN: opening tun handle using service
> failed: %s [status=3D%u device_path=3D%s]",
> > +            strerror_win32(result_msg.error_number, &gc),
> result_msg.error_number, device_guid);
> > +    }
> > +    else
> > +    {
> > +        msg(M_INFO, "Opened tun device %s using service", device_guid);
> > +    }
> > +
> > +out:
> > +    gc_free(&gc);
> > +    return result_msg.handle;
> > +}
> > +
> >   /*
> >    * Return a TAP name for netsh commands.
> >    */
> > @@ -5591,15 +5628,22 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
> >                                device_guid,
> >                                TAP_WIN_SUFFIX);
> >
> > -            tt->hand =3D CreateFile(
> > -                device_path,
> > -                GENERIC_READ | GENERIC_WRITE,
> > -                0,                /* was: FILE_SHARE_READ */
> > -                0,
> > -                OPEN_EXISTING,
> > -                FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
> > -                0
> > +            if (tt->options.msg_channel)
> > +            {
> > +                tt->hand =3D
> service_open_tun_device(tt->options.msg_channel, device_guid);
> > +            }
> > +            else
> > +            {
> > +                tt->hand =3D CreateFile(
> > +                    device_path,
> > +                    GENERIC_READ | GENERIC_WRITE,
> > +                    0,                /* was: FILE_SHARE_READ */
> > +                    0,
> > +                    OPEN_EXISTING,
> > +                    FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
> > +                    0
> >                   );
> > +            }
> >
> >               if (tt->hand =3D=3D INVALID_HANDLE_VALUE)
> >               {
> > @@ -5631,15 +5675,22 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
> >                                    device_guid,
> >                                    TAP_WIN_SUFFIX);
> >
> > -                tt->hand =3D CreateFile(
> > -                    device_path,
> > -                    GENERIC_READ | GENERIC_WRITE,
> > -                    0,                /* was: FILE_SHARE_READ */
> > -                    0,
> > -                    OPEN_EXISTING,
> > -                    FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
> > -                    0
> > +                if (tt->options.msg_channel)
> > +                {
> > +                    tt->hand =3D
> service_open_tun_device(tt->options.msg_channel, device_guid);
> > +                }
> > +                else
> > +                {
> > +                    tt->hand =3D CreateFile(
> > +                        device_path,
> > +                        GENERIC_READ | GENERIC_WRITE,
> > +                        0,                /* was: FILE_SHARE_READ */
> > +                        0,
> > +                        OPEN_EXISTING,
> > +                        FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
> > +                        0
> >                       );
> > +                }
> >
> >                   if (tt->hand =3D=3D INVALID_HANDLE_VALUE)
> >                   {
> > diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> > index eb4c030..039c1a4 100644
> > --- a/src/openvpn/win32.c
> > +++ b/src/openvpn/win32.c
> > @@ -1476,12 +1476,19 @@ bool
> >   send_msg_iservice(HANDLE pipe, const void *data, size_t size,
> >                     ack_message_t *ack, const char *context)
> >   {
> > +    return send_msg_iservice_ex(pipe, data, size, ack, sizeof(*ack),
> context);
> > +}
> > +
> > +bool
> > +send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,
> > +                     void *response, size_t response_size, const char
> *context)
> > +{
> >       struct gc_arena gc =3D gc_new();
> >       DWORD len;
> >       bool ret =3D true;
> >
> >       if (!WriteFile(pipe, data, size, &len, NULL)
> > -        || !ReadFile(pipe, ack, sizeof(*ack), &len, NULL))
> > +        || !ReadFile(pipe, response, response_size, &len, NULL))
> >       {
> >           msg(M_WARN, "%s: could not talk to service: %s [%lu]",
> >               context ? context : "Unknown",
> > diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> > index 4814bbc..eff4401 100644
> > --- a/src/openvpn/win32.h
> > +++ b/src/openvpn/win32.h
> > @@ -309,14 +309,36 @@ int win32_version_info(void);
> >    */
> >   const char *win32_version_string(struct gc_arena *gc, bool add_name);
> >
> > -/*
> > - * Send the |size| bytes in buffer |data| to the interactive service
> |pipe|
> > - * and read the result in |ack|. Returns false on communication error.
> > - * The string in |context| is used to prefix error messages.
> > +
> > +/**
> > + * Send data to interactive service and receive response of type
> ack_message_t.
> > + *
> > + * @param  pipe      The handle of communication pipe
> > + * @param  data      The data to send
> > + * @param  size      The size of data to send
> > + * @param  ack       The pointer to ack_message_t structure to where
> response is written
> > + * @param  context   The string used to prefix error messages
> > + *
> > + * @returns True on success, false on failure.
> >    */
> >   bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
> >                          ack_message_t *ack, const char *context);
> >
> > +/**
> > + * Send data to interactive service and receive response.
> > + *
> > + * @param  pipe           The handle of communication pipe
> > + * @param  data           The data to send
> > + * @param  size           The size of data to send
> > + * @param  response       The buffer to where response is written
> > + * @param  response_size  The size of response buffer
> > + * @param  context        The string used to prefix error messages
> > + *
> > + * @returns True on success, false on failure.
> > + */
> > +bool send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,
> > +                          void *response, size_t response_size, const
> char *context);
> > +
> >   /*
> >    * Attempt to simulate fork/execve on Windows
> >    */
> > diff --git a/src/openvpnserv/interactive.c
> b/src/openvpnserv/interactive.c
> > index 623c3ff..1b4a5e2 100644
> > --- a/src/openvpnserv/interactive.c
> > +++ b/src/openvpnserv/interactive.c
> > @@ -58,7 +58,6 @@ static settings_t settings;
> >   static HANDLE rdns_semaphore =3D NULL;
> >   #define RDNS_TIMEOUT 600  /* seconds to wait for the semaphore */
> >
> > -
> >   openvpn_service_t interactive_service =3D {
> >       interactive,
> >       TEXT(PACKAGE_NAME "ServiceInteractive"),
> > @@ -1198,8 +1197,62 @@ HandleEnableDHCPMessage(const
> enable_dhcp_message_t *dhcp)
> >       return err;
> >   }
> >
> > +static DWORD
> > +HandleOpenTunDeviceMessage(const open_tun_device_message_t *open_tun,
> HANDLE ovpn_proc, HANDLE *remote_handle)
> > +{
> > +    DWORD err =3D ERROR_SUCCESS;
> > +    HANDLE local_handle;
> > +    LPWSTR wguid =3D NULL;
> > +    WCHAR device_path[256] =3D {0};
> > +    const WCHAR prefix[] =3D L"\\\\.\\Global\\";
> > +    const WCHAR tap_suffix[] =3D L".tap";
> > +
> > +    *remote_handle =3D INVALID_HANDLE_VALUE;
> > +
> > +    wguid =3D utf8to16(open_tun->device_guid);
> > +    if (!wguid)
> > +    {
> > +        err =3D ERROR_OUTOFMEMORY;
> > +        goto out;
> > +    }
> > +
> > +    /* validate device guid */
> > +    const size_t guid_len =3D wcslen(wguid);
> > +    if (guid_len !=3D 38 || wcsspn(wguid, L"0123456789ABCDEFabcdef-{}")
> !=3D guid_len)
> > +    {
> > +        err =3D ERROR_MESSAGE_DATA;
> > +        MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Invalid device guild
> (%s)"), wguid);
>
> Invalid device "guild" ? I presume guid ..
>
>
> > +        goto out;
> > +    }
> > +
> > +    openvpn_swprintf(device_path, sizeof(device_path), L"%s%s%s",
> prefix, wguid, tap_suffix);
> > +
> > +    /* open tun device */
> > +    local_handle =3D CreateFileW(device_path, GENERIC_READ |
> GENERIC_WRITE, 0, 0,
> > +                               OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM |
> FILE_FLAG_OVERLAPPED, 0);
> > +    if (local_handle =3D=3D INVALID_HANDLE_VALUE)
> > +    {
> > +        err =3D GetLastError();
> > +        MsgToEventLog(M_SYSERR, TEXT("Error opening tun device (%s)"),
> device_path);
> > +        goto out;
> > +    }
> > +
> > +    /* duplicate tun device handle to openvpn process */
> > +    if (!DuplicateHandle(GetCurrentProcess(), local_handle, ovpn_proc,
> remote_handle, 0, FALSE,
> > +                         DUPLICATE_CLOSE_SOURCE |
> DUPLICATE_SAME_ACCESS))
> > +    {
> > +        err =3D GetLastError();
> > +        MsgToEventLog(M_SYSERR, TEXT("Error duplicating tun device
> handle"));
> > +    }
> > +
> > +out:
> > +    free(wguid);
> > +
> > +    return err;
> > +}
> > +
> >   static VOID
> > -HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events,
> undo_lists_t *lists)
> > +HandleMessage(HANDLE pipe, HANDLE ovpn_proc, DWORD bytes, DWORD count,
> LPHANDLE events, undo_lists_t *lists)
> >   {
> >       DWORD read;
> >       union {
> > @@ -1210,6 +1263,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD
> count, LPHANDLE events, undo_lists
> >           block_dns_message_t block_dns;
> >           dns_cfg_message_t dns;
> >           enable_dhcp_message_t dhcp;
> > +        open_tun_device_message_t open_tun;
> >       } msg;
> >       ack_message_t ack =3D {
> >           .header =3D {
> > @@ -1277,6 +1331,24 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD
> count, LPHANDLE events, undo_lists
> >               }
> >               break;
> >
> > +        case msg_open_tun_device:
> > +            if (msg.header.size =3D=3D sizeof(msg.open_tun))
> > +            {
> > +                open_tun_device_result_message_t res =3D {
> > +                    .header =3D {
> > +                        .type =3D msg_open_tun_device_result,
> > +                        .size =3D sizeof(res),
> > +                        .message_id =3D msg.header.message_id
> > +                    }
> > +                };
> > +                /* make sure that string passed from user process is
> null-terminated */
> > +
> msg.open_tun.device_guid[sizeof(msg.open_tun.device_guid) - 1] =3D '\0';
> > +                res.error_number =3D
> HandleOpenTunDeviceMessage(&msg.open_tun, ovpn_proc, &res.handle);
> > +                WritePipeAsync(pipe, &res, sizeof(res), count, events);
> > +                return;
> > +            }
> > +            break;
> > +
> >           default:
> >               ack.error_number =3D ERROR_MESSAGE_TYPE;
> >               MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type
> %d"), msg.header.type);
> > @@ -1611,7 +1683,7 @@ RunOpenvpn(LPVOID p)
> >               break;
> >           }
> >
> > -        HandleMessage(ovpn_pipe, bytes, 1, &exit_event, &undo_lists);
> > +        HandleMessage(ovpn_pipe, proc_info.hProcess, bytes, 1,
> &exit_event, &undo_lists);
> >       }
> >
> >       WaitForSingleObject(proc_info.hProcess, IO_TIMEOUT);
> >
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


--=20
-Lev

--0000000000002dbbae058e582c36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This could be fixed by @cron2 when he will apply this patc=
h :)</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">ti 23. hein=C3=A4k. 2019 klo 15.12 tincanteksup (<a href=3D"mailto:tinc=
anteksup@...277...">tincanteksup@...277...</a>) kirjoitti:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Looks like a typo below:<br>
<br>
On 23/07/2019 10:21, Lev Stipakov wrote:<br>
&gt; From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_bla=
nk">lev@...515...</a>&gt;<br>
&gt; <br>
&gt; This patch enables interactive service to open tun device.<br>
&gt; This is mostly needed by Wintun, which could be opened<br>
&gt; only by privileged process.<br>
&gt; <br>
&gt; When interactive service is used, instead of calling<br>
&gt; CreateFile() directly by openvpn process we pass tun device path<br>
&gt; into service process. There we open device, duplicate handle<br>
&gt; and pass it back to openvpn process.<br>
&gt; <br>
&gt; Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." targe=
t=3D"_blank">lev@...515...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0v6:<br>
&gt;=C2=A0 =C2=A0 - simplify and strengthen guid check with wcsspn()<br>
&gt;=C2=A0 =C2=A0 - fix doxygen comment<br>
&gt; <br>
&gt;=C2=A0 =C2=A0v5:<br>
&gt;=C2=A0 =C2=A0 - further strengthen security by passing only device guid=
 from client process<br>
&gt;=C2=A0 =C2=A0 to service, validating guid and constructing device path =
on service side<br>
&gt; <br>
&gt;=C2=A0 =C2=A0v4:<br>
&gt;=C2=A0 =C2=A0 - strengthen security by adding basic validation to devic=
e path<br>
&gt;=C2=A0 =C2=A0 - reorder fields in msg_open_tun_device_result for backwa=
rd compatibility<br>
&gt; <br>
&gt;=C2=A0 =C2=A0v3:<br>
&gt;=C2=A0 =C2=A0 - ensure that device path passed by client is null-termin=
ated<br>
&gt;=C2=A0 =C2=A0 - support for multiple openvpn processes<br>
&gt;=C2=A0 =C2=A0 - return proper error code when device handle is invalid<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0v2:<br>
&gt;=C2=A0 =C2=A0 - introduce send_msg_iservice_ex() instead of changing<br>
&gt;=C2=A0 =C2=A0 signature of existing send_msg_iservice()<br>
&gt;=C2=A0 =C2=A0 - use wchar_t strings in interactive service code<br>
&gt; <br>
&gt;=C2=A0 =C2=A0include/openvpn-msg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
2 +++++++<br>
&gt;=C2=A0 =C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 83 ++++++++++++++++++++++++++++++++++---------<br>
&gt;=C2=A0 =C2=A0src/openvpn/win32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 9 ++++-<br>
&gt;=C2=A0 =C2=A0src/openvpn/win32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 30 +++++++++++++---<br>
&gt;=C2=A0 =C2=A0src/openvpnserv/interactive.c | 78 +++++++++++++++++++++++=
+++++++++++++++--<br>
&gt;=C2=A0 =C2=A05 files changed, 188 insertions(+), 24 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h<br>
&gt; index 66177a2..5dbdca5 100644<br>
&gt; --- a/include/openvpn-msg.h<br>
&gt; +++ b/include/openvpn-msg.h<br>
&gt; @@ -39,6 +39,8 @@ typedef enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0msg_del_block_dns,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0msg_register_dns,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0msg_enable_dhcp,<br>
&gt; +=C2=A0 =C2=A0 msg_open_tun_device,<br>
&gt; +=C2=A0 =C2=A0 msg_open_tun_device_result,<br>
&gt;=C2=A0 =C2=A0} message_type_t;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0typedef struct {<br>
&gt; @@ -117,4 +119,14 @@ typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0interface_t iface;<br>
&gt;=C2=A0 =C2=A0} enable_dhcp_message_t;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 message_header_t header;<br>
&gt; +=C2=A0 =C2=A0 char device_guid[36+2+1]; /* length of guid with dashes=
 + braces + nul terminator */<br>
&gt; +} open_tun_device_message_t;<br>
&gt; +<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 message_header_t header;<br>
&gt; +=C2=A0 =C2=A0 int error_number;<br>
&gt; +=C2=A0 =C2=A0 HANDLE handle;<br>
&gt; +} open_tun_device_result_message_t;<br>
&gt;=C2=A0 =C2=A0#endif /* ifndef OPENVPN_MSG_H_ */<br>
&gt; diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
&gt; index 8f8f7c6..df26ccf 100644<br>
&gt; --- a/src/openvpn/tun.c<br>
&gt; +++ b/src/openvpn/tun.c<br>
&gt; @@ -5248,6 +5248,43 @@ out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static HANDLE<br>
&gt; +service_open_tun_device(const HANDLE pipe, const char* device_guid)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 open_tun_device_result_message_t result_msg;<br>
&gt; +=C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
&gt; +=C2=A0 =C2=A0 open_tun_device_message_t open_tun_device =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .header =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_open_tun_device,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(open_tun_device_mess=
age_t),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 result_msg.handle =3D INVALID_HANDLE_VALUE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 strncpynt(open_tun_device.device_guid, device_guid, siz=
eof(open_tun_device.device_guid));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!send_msg_iservice_ex(pipe, &amp;open_tun_device, s=
izeof(open_tun_device),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;result_msg, sizeof(result_msg), &quo=
t;Open_tun_device&quot;))<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (result_msg.error_number !=3D NO_ERROR)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_TUNTAP_INFO, &quot;TUN: opening tun=
 handle using service failed: %s [status=3D%u device_path=3D%s]&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror_win32(result_msg.e=
rror_number, &amp;gc), result_msg.error_number, device_guid);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;Opened tun device %s us=
ing service&quot;, device_guid);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 gc_free(&amp;gc);<br>
&gt; +=C2=A0 =C2=A0 return result_msg.handle;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 * Return a TAP name for netsh commands.<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt; @@ -5591,15 +5628,22 @@ open_tun(const char *dev, const char *dev_type=
, const char *dev_node, struct tun<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_guid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TAP_WIN_SUFFIX);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;hand =3D CreateFile(=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_path,<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GENERIC_READ =
| GENERIC_WRITE,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was: FILE_SHARE_READ */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPEN_EXISTING=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE_ATTRIBUT=
E_SYSTEM | FILE_FLAG_OVERLAPPED,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;options.msg_chan=
nel)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;hand =
=3D service_open_tun_device(tt-&gt;options.msg_channel, device_guid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;hand =
=3D CreateFile(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 device_path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 GENERIC_READ | GENERIC_WRITE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was: FILE_SHA=
RE_READ */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 OPEN_EXISTING,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tt-&gt;hand =
=3D=3D INVALID_HANDLE_VALUE)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; @@ -5631,15 +5675,22 @@ open_tun(const char *dev, const char *dev_type=
, const char *dev_node, struct tun<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_guid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TAP_WIN_SUFFIX);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;hand =
=3D CreateFile(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 device_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 GENERIC_READ | GENERIC_WRITE,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was: FILE_SHA=
RE_READ */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 OPEN_EXISTING,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;op=
tions.msg_channel)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 tt-&gt;hand =3D service_open_tun_device(tt-&gt;options.msg_channel, device=
_guid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 tt-&gt;hand =3D CreateFile(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 device_path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 GENERIC_READ | GENERIC_WRITE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 was: FILE_SHARE_READ */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 OPEN_EXISTING,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (tt-&gt;hand =3D=3D INVALID_HANDLE_VALUE)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<=
br>
&gt; diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c<br>
&gt; index eb4c030..039c1a4 100644<br>
&gt; --- a/src/openvpn/win32.c<br>
&gt; +++ b/src/openvpn/win32.c<br>
&gt; @@ -1476,12 +1476,19 @@ bool<br>
&gt;=C2=A0 =C2=A0send_msg_iservice(HANDLE pipe, const void *data, size_t si=
ze,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ack_message_t *ack, const char *context)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 return send_msg_iservice_ex(pipe, data, size, ack, size=
of(*ack), context);<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool<br>
&gt; +send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0void *response, size_t response_size, const char *context)<br>
&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DWORD len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool ret =3D true;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!WriteFile(pipe, data, size, &amp;len, N=
ULL)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, ack, sizeof(*ack), &am=
p;len, NULL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ReadFile(pipe, response, response_siz=
e, &amp;len, NULL))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_WARN, &quot;%s: could no=
t talk to service: %s [%lu]&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context ? contex=
t : &quot;Unknown&quot;,<br>
&gt; diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h<br>
&gt; index 4814bbc..eff4401 100644<br>
&gt; --- a/src/openvpn/win32.h<br>
&gt; +++ b/src/openvpn/win32.h<br>
&gt; @@ -309,14 +309,36 @@ int win32_version_info(void);<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0const char *win32_version_string(struct gc_arena *gc, bool=
 add_name);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/*<br>
&gt; - * Send the |size| bytes in buffer |data| to the interactive service =
|pipe|<br>
&gt; - * and read the result in |ack|. Returns false on communication error=
.<br>
&gt; - * The string in |context| is used to prefix error messages.<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Send data to interactive service and receive response of type ack_=
message_t.<br>
&gt; + *<br>
&gt; + * @param=C2=A0 pipe=C2=A0 =C2=A0 =C2=A0 The handle of communication =
pipe<br>
&gt; + * @param=C2=A0 data=C2=A0 =C2=A0 =C2=A0 The data to send<br>
&gt; + * @param=C2=A0 size=C2=A0 =C2=A0 =C2=A0 The size of data to send<br>
&gt; + * @param=C2=A0 ack=C2=A0 =C2=A0 =C2=A0 =C2=A0The pointer to ack_mess=
age_t structure to where response is written<br>
&gt; + * @param=C2=A0 context=C2=A0 =C2=A0The string used to prefix error m=
essages<br>
&gt; + *<br>
&gt; + * @returns True on success, false on failure.<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0bool send_msg_iservice(HANDLE pipe, const void *data, size=
_t size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ack_message_t *ack, const char *context);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * Send data to interactive service and receive response.<br>
&gt; + *<br>
&gt; + * @param=C2=A0 pipe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The hand=
le of communication pipe<br>
&gt; + * @param=C2=A0 data=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The data=
 to send<br>
&gt; + * @param=C2=A0 size=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The size=
 of data to send<br>
&gt; + * @param=C2=A0 response=C2=A0 =C2=A0 =C2=A0 =C2=A0The buffer to wher=
e response is written<br>
&gt; + * @param=C2=A0 response_size=C2=A0 The size of response buffer<br>
&gt; + * @param=C2=A0 context=C2=A0 =C2=A0 =C2=A0 =C2=A0 The string used to=
 prefix error messages<br>
&gt; + *<br>
&gt; + * @returns True on success, false on failure.<br>
&gt; + */<br>
&gt; +bool send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 void *response, size_t response_size, const char *con=
text);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 * Attempt to simulate fork/execve on Windows<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt; diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interacti=
ve.c<br>
&gt; index 623c3ff..1b4a5e2 100644<br>
&gt; --- a/src/openvpnserv/interactive.c<br>
&gt; +++ b/src/openvpnserv/interactive.c<br>
&gt; @@ -58,7 +58,6 @@ static settings_t settings;<br>
&gt;=C2=A0 =C2=A0static HANDLE rdns_semaphore =3D NULL;<br>
&gt;=C2=A0 =C2=A0#define RDNS_TIMEOUT 600=C2=A0 /* seconds to wait for the =
semaphore */<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0openvpn_service_t interactive_service =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0interactive,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0TEXT(PACKAGE_NAME &quot;ServiceInteractive&q=
uot;),<br>
&gt; @@ -1198,8 +1197,62 @@ HandleEnableDHCPMessage(const enable_dhcp_messa=
ge_t *dhcp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static DWORD<br>
&gt; +HandleOpenTunDeviceMessage(const open_tun_device_message_t *open_tun,=
 HANDLE ovpn_proc, HANDLE *remote_handle)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DWORD err =3D ERROR_SUCCESS;<br>
&gt; +=C2=A0 =C2=A0 HANDLE local_handle;<br>
&gt; +=C2=A0 =C2=A0 LPWSTR wguid =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 WCHAR device_path[256] =3D {0};<br>
&gt; +=C2=A0 =C2=A0 const WCHAR prefix[] =3D L&quot;\\\\.\\Global\\&quot;;<=
br>
&gt; +=C2=A0 =C2=A0 const WCHAR tap_suffix[] =3D L&quot;.tap&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *remote_handle =3D INVALID_HANDLE_VALUE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 wguid =3D utf8to16(open_tun-&gt;device_guid);<br>
&gt; +=C2=A0 =C2=A0 if (!wguid)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D ERROR_OUTOFMEMORY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* validate device guid */<br>
&gt; +=C2=A0 =C2=A0 const size_t guid_len =3D wcslen(wguid);<br>
&gt; +=C2=A0 =C2=A0 if (guid_len !=3D 38 || wcsspn(wguid, L&quot;0123456789=
ABCDEFabcdef-{}&quot;) !=3D guid_len)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D ERROR_MESSAGE_DATA;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MsgToEventLog(MSG_FLAGS_ERROR, TEXT(&quot=
;Invalid device guild (%s)&quot;), wguid);<br>
<br>
Invalid device &quot;guild&quot; ? I presume guid ..<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 openvpn_swprintf(device_path, sizeof(device_path), L&qu=
ot;%s%s%s&quot;, prefix, wguid, tap_suffix);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* open tun device */<br>
&gt; +=C2=A0 =C2=A0 local_handle =3D CreateFileW(device_path, GENERIC_READ =
| GENERIC_WRITE, 0, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPEN_EXISTING, FILE_ATTRIBUTE_SYS=
TEM | FILE_FLAG_OVERLAPPED, 0);<br>
&gt; +=C2=A0 =C2=A0 if (local_handle =3D=3D INVALID_HANDLE_VALUE)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D GetLastError();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MsgToEventLog(M_SYSERR, TEXT(&quot;Error =
opening tun device (%s)&quot;), device_path);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* duplicate tun device handle to openvpn process */<br>
&gt; +=C2=A0 =C2=A0 if (!DuplicateHandle(GetCurrentProcess(), local_handle,=
 ovpn_proc, remote_handle, 0, FALSE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0DUPLICATE_CLOSE_SOURCE | DUPLICATE_SAME_ACCESS))<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D GetLastError();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MsgToEventLog(M_SYSERR, TEXT(&quot;Error =
duplicating tun device handle&quot;));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 free(wguid);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return err;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static VOID<br>
&gt; -HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events,=
 undo_lists_t *lists)<br>
&gt; +HandleMessage(HANDLE pipe, HANDLE ovpn_proc, DWORD bytes, DWORD count=
, LPHANDLE events, undo_lists_t *lists)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DWORD read;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0union {<br>
&gt; @@ -1210,6 +1263,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD co=
unt, LPHANDLE events, undo_lists<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block_dns_message_t block_dns;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dns_cfg_message_t dns;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_dhcp_message_t dhcp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 open_tun_device_message_t open_tun;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} msg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ack_message_t ack =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.header =3D {<br>
&gt; @@ -1277,6 +1331,24 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD c=
ount, LPHANDLE events, undo_lists<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case msg_open_tun_device:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg.header.size =3D=3D =
sizeof(msg.open_tun))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open_tun_devi=
ce_result_message_t res =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 .header =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .type =3D msg_open_tun_device_result,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .size =3D sizeof(res),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .message_id =3D msg.header.message_id<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* make sure =
that string passed from user process is null-terminated */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg.open_tun.=
device_guid[sizeof(msg.open_tun.device_guid) - 1] =3D &#39;\0&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res.error_num=
ber =3D HandleOpenTunDeviceMessage(&amp;msg.open_tun, ovpn_proc, &amp;res.h=
andle);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WritePipeAsyn=
c(pipe, &amp;res, sizeof(res), count, events);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ack.error_number=
 =3D ERROR_MESSAGE_TYPE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MsgToEventLog(MS=
G_FLAGS_ERROR, TEXT(&quot;Unknown message type %d&quot;), msg.header.type);=
<br>
&gt; @@ -1611,7 +1683,7 @@ RunOpenvpn(LPVOID p)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 HandleMessage(ovpn_pipe, bytes, 1, &amp;e=
xit_event, &amp;undo_lists);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 HandleMessage(ovpn_pipe, proc_info.hProce=
ss, bytes, 1, &amp;exit_event, &amp;undo_lists);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0WaitForSingleObject(proc_info.hProcess, IO_T=
IMEOUT);<br>
&gt; <br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--0000000000002dbbae058e582c36--

