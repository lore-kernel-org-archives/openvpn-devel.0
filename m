MIME-Version: 1.0
References: <1561491241-16380-1-git-send-email-lstipakov@...277...>
 <20190625194905.GM1097@...1296...>
In-Reply-To: <20190625194905.GM1097@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 Jun 2019 15:57:18 -0400
Message-ID: <CAKuzo_g200Ck8fBTMmTe93R5A_+FjGoK0zKNQr49i01RmHfHkw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: enable interactive service
 to open tun
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
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Tue, Jun 25, 2019 at 3:49 PM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Tue, Jun 25, 2019 at 10:34:01PM +0300, Lev Stipakov wrote:
> >      ack_message_t ack;
> >      struct gc_arena gc = gc_new();
> >
> > -    if (!send_msg_iservice(pipe, rt, size, &ack, "ROUTE"))
> > +    if (!send_msg_iservice(pipe, rt, size, &ack, sizeof(ack), "ROUTE"))
>
> I do not like this.  Please find another way to send the request message
> "with length" than to add an extra parameter to every single caller of
> send_msg_iservice().

Gert beat me to it :) Anyway, me too!

The way interactive service structures are coded should not require
this at all, does it? The size and message type are already in the
header, so why do we need to pass it? The result here is a new kind of
ack message with a different size and type and that could be checked
by accessing the header element. Unless I'm missing something.

>
> +    HANDLE local_handle = CreateFileA(open_tun->device_path, GENERIC_READ | GENERIC_WRITE, 0, 0,
> +                                      OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, 0);
> +
> +    if (local_handle == INVALID_HANDLE_VALUE)
> +    {
> +        WCHAR *device_path_wchar = NULL;
> +        int size = sizeof(open_tun->device_path);
> +        err = GetLastError();
> +
> +        device_path_wchar = malloc(size * sizeof(WCHAR));
> +        if (device_path_wchar)
> +        {
> +            MultiByteToWideChar(CP_UTF8, 0, open_tun->device_path, size, device_path_wchar, size);
> +            device_path_wchar[size - 1] = 0;
> +        }
> +        MsgToEventLog(M_SYSERR, TEXT("Error opening tun device (%s)"), device_path_wchar);
> +        free(device_path_wchar);
> +        return err;
> +    }
>

Also this one -- I think we should just use the wide version of
CreateFile  -- all strings in OpenVPN.exe are supposed to be in utf8,
so convert to widechar and call CreateFileW.

Selva

