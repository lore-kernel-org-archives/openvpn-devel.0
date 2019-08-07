MIME-Version: 1.0
References: <CAKuzo_jTwnNZ_5QtFo8YqUyWWhEJWBCYgnO_xAqEaNkumGPgrw@...278...>
 <1563873663-25785-1-git-send-email-lstipakov@...277...>
 <CAKuzo_j7SxL_6Aerh9vnBDOgU20VteOCvH=da1yxK73Y1a-xLg@...278...>
In-Reply-To: <CAKuzo_j7SxL_6Aerh9vnBDOgU20VteOCvH=da1yxK73Y1a-xLg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 7 Aug 2019 14:12:01 +0300
Message-ID: <CAGyAFMV2k0OWM6G9tH=CcMt9-yQ0hu-vLT7HP7o90mPZXkwG6A@...278...>
Content-Type: multipart/alternative; boundary="0000000000004cbfd5058f8503d9"
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000004cbfd5058f8503d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let's not merge it yet.

The reason why this patch was done is to prepare for Wintun support,
since Wintun device must be opened by privileged process. There is no need
to use privileged process to open tap-windows6 device.

Recently Wintun API has been changed and previous Wintun device path
(\\.\Global\WINTUNxxx) does not work anymore. In order to get a new path
one needs to use SetupAPI (such as SetupDiCreateDeviceInfo), which
must be called by privileged process.

So instead of having IPC call "open_tun_device(path)" it is probably better
to have something like "open_wintun_device()", which both figures out
device path
and opens device.

ke 24. hein=C3=A4k. 2019 klo 17.44 Selva Nair (selva.nair@...277...) kirjoi=
tti:

> Hi,
>
> Looks good now and works as expected.
>
> On Tue, Jul 23, 2019 at 5:22 AM Lev Stipakov <lstipakov@...277...> wrote:
> >
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
> >  v6:
> >   - simplify and strengthen guid check with wcsspn()
> >   - fix doxygen comment
> >
> >  v5:
> >   - further strengthen security by passing only device guid from client
> process
> >   to service, validating guid and constructing device path on service
> side
> >
> >  v4:
> >   - strengthen security by adding basic validation to device path
> >   - reorder fields in msg_open_tun_device_result for backward
> compatibility
> >
> >  v3:
> >   - ensure that device path passed by client is null-terminated
> >   - support for multiple openvpn processes
> >   - return proper error code when device handle is invalid
> >
> >  v2:
> >   - introduce send_msg_iservice_ex() instead of changing
> >   signature of existing send_msg_iservice()
> >   - use wchar_t strings in interactive service code
> >
> >  include/openvpn-msg.h         | 12 +++++++
> >  src/openvpn/tun.c             | 83
> ++++++++++++++++++++++++++++++++++---------
> >  src/openvpn/win32.c           |  9 ++++-
> >  src/openvpn/win32.h           | 30 +++++++++++++---
> >  src/openvpnserv/interactive.c | 78
> ++++++++++++++++++++++++++++++++++++++--
> >  5 files changed, 188 insertions(+), 24 deletions(-)
>
> ...
>
> > diff --git a/src/openvpnserv/interactive.c
> b/src/openvpnserv/interactive.c
> > index 623c3ff..1b4a5e2 100644
> > --- a/src/openvpnserv/interactive.c
> > +++ b/src/openvpnserv/interactive.c
> > @@ -58,7 +58,6 @@ static settings_t settings;
> >  static HANDLE rdns_semaphore =3D NULL;
> >  #define RDNS_TIMEOUT 600  /* seconds to wait for the semaphore */
> >
> > -
> >  openvpn_service_t interactive_service =3D {
> >      interactive,
> >      TEXT(PACKAGE_NAME "ServiceInteractive"),
> > @@ -1198,8 +1197,62 @@ HandleEnableDHCPMessage(const
> enable_dhcp_message_t *dhcp)
> >      return err;
> >  }
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
> guild -> guid  (as pointed out by tincanteksup)
>
> > +        goto out;
> > +    }
> > +
>
> whitespace in line above.
>
> These could be fixed at commit time.
>
> Acked-by: Selva Nair <selva.nair@...277...>
>
> Selva
>
>
>
>
> Selva
>


--=20
-Lev

--0000000000004cbfd5058f8503d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Let&#39;s not merge it yet.<div><br></div><div>The reason =
why this patch was done is to prepare for Wintun support,</div><div>since W=
intun device must be opened by privileged process. There is no need</div><d=
iv>to use privileged process to open tap-windows6 device.</div><div><br></d=
iv><div>Recently Wintun API has been changed and previous Wintun device pat=
h=C2=A0</div>(\\.\Global\WINTUNxxx) does not work anymore. In order to get =
a new path<div>one needs to use SetupAPI (such as=C2=A0SetupDiCreateDeviceI=
nfo), which</div><div>must be called by privileged process.</div><div><br><=
/div><div>So instead of having IPC call &quot;open_tun_device(path)&quot; i=
t is probably better</div><div>to have something like &quot;open_wintun_dev=
ice()&quot;, which both figures out device path</div><div>and opens device.=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">ke 24. hein=C3=A4k. 2019 klo 17.44 Selva Nair (<a href=3D"mailto:selv=
a.nair@...277...">selva.nair@...277...</a>) kirjoitti:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
Looks good now and works as expected.<br>
<br>
On Tue, Jul 23, 2019 at 5:22 AM Lev Stipakov &lt;<a href=3D"mailto:lstipako=
v@...277..." target=3D"_blank">lstipakov@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_bla=
nk">lev@...515...</a>&gt;<br>
&gt;<br>
&gt; This patch enables interactive service to open tun device.<br>
&gt; This is mostly needed by Wintun, which could be opened<br>
&gt; only by privileged process.<br>
&gt;<br>
&gt; When interactive service is used, instead of calling<br>
&gt; CreateFile() directly by openvpn process we pass tun device path<br>
&gt; into service process. There we open device, duplicate handle<br>
&gt; and pass it back to openvpn process.<br>
&gt;<br>
&gt; Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." targe=
t=3D"_blank">lev@...515...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 v6:<br>
&gt;=C2=A0 =C2=A0- simplify and strengthen guid check with wcsspn()<br>
&gt;=C2=A0 =C2=A0- fix doxygen comment<br>
&gt;<br>
&gt;=C2=A0 v5:<br>
&gt;=C2=A0 =C2=A0- further strengthen security by passing only device guid =
from client process<br>
&gt;=C2=A0 =C2=A0to service, validating guid and constructing device path o=
n service side<br>
&gt;<br>
&gt;=C2=A0 v4:<br>
&gt;=C2=A0 =C2=A0- strengthen security by adding basic validation to device=
 path<br>
&gt;=C2=A0 =C2=A0- reorder fields in msg_open_tun_device_result for backwar=
d compatibility<br>
&gt;<br>
&gt;=C2=A0 v3:<br>
&gt;=C2=A0 =C2=A0- ensure that device path passed by client is null-termina=
ted<br>
&gt;=C2=A0 =C2=A0- support for multiple openvpn processes<br>
&gt;=C2=A0 =C2=A0- return proper error code when device handle is invalid<b=
r>
&gt;<br>
&gt;=C2=A0 v2:<br>
&gt;=C2=A0 =C2=A0- introduce send_msg_iservice_ex() instead of changing<br>
&gt;=C2=A0 =C2=A0signature of existing send_msg_iservice()<br>
&gt;=C2=A0 =C2=A0- use wchar_t strings in interactive service code<br>
&gt;<br>
&gt;=C2=A0 include/openvpn-msg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 ++++=
+++<br>
&gt;=C2=A0 src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 83 ++++++++++++++++++++++++++++++++++---------<br>
&gt;=C2=A0 src/openvpn/win32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 9 ++++-<br>
&gt;=C2=A0 src/openvpn/win32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30=
 +++++++++++++---<br>
&gt;=C2=A0 src/openvpnserv/interactive.c | 78 +++++++++++++++++++++++++++++=
+++++++++--<br>
&gt;=C2=A0 5 files changed, 188 insertions(+), 24 deletions(-)<br>
<br>
...<br>
<br>
&gt; diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interacti=
ve.c<br>
&gt; index 623c3ff..1b4a5e2 100644<br>
&gt; --- a/src/openvpnserv/interactive.c<br>
&gt; +++ b/src/openvpnserv/interactive.c<br>
&gt; @@ -58,7 +58,6 @@ static settings_t settings;<br>
&gt;=C2=A0 static HANDLE rdns_semaphore =3D NULL;<br>
&gt;=C2=A0 #define RDNS_TIMEOUT 600=C2=A0 /* seconds to wait for the semaph=
ore */<br>
&gt;<br>
&gt; -<br>
&gt;=C2=A0 openvpn_service_t interactive_service =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 interactive,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TEXT(PACKAGE_NAME &quot;ServiceInteractive&quot;),=
<br>
&gt; @@ -1198,8 +1197,62 @@ HandleEnableDHCPMessage(const enable_dhcp_messa=
ge_t *dhcp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt;=C2=A0 }<br>
&gt;<br>
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
guild -&gt; guid=C2=A0 (as pointed out by tincanteksup)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
whitespace in line above.<br>
<br>
These could be fixed at commit time.<br>
<br>
Acked-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"=
_blank">selva.nair@...277...</a>&gt;<br>
<br>
Selva<br>
<br>
<br>
<br>
<br>
Selva<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--0000000000004cbfd5058f8503d9--

