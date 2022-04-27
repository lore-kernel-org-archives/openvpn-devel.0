MIME-Version: 1.0
References: <20220427074828.6283-1-kprovost@...2661...>
 <20220427074828.6283-2-kprovost@...2661...>
 <761e5640-6d43-d25b-4845-25698d2e0688@...2181...>
 <CAGyAFMXA0YdQtOFUJ0ShANVJeZ9gLv1Y4DB0_xN7E6-_d4Va3A@...278...>
In-Reply-To: <CAGyAFMXA0YdQtOFUJ0ShANVJeZ9gLv1Y4DB0_xN7E6-_d4Va3A@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 27 Apr 2022 16:18:22 +0300
Message-ID: <CAGyAFMV7=m0kJ7kG3NKEp4oBEHTdYdGWCRUAJs9hZ8dh+2Wbeg@...278...>
Content-Type: multipart/alternative; boundary="00000000000072f58205dda2a565"
Subject: Re: [Openvpn-devel] [PATCH] Handle (DCO) timeouts in client mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--00000000000072f58205dda2a565
Content-Type: text/plain; charset="UTF-8"

How about we'll add dco_check_timeout(int, context) to dco.h with platform
specific implementations?

Here is what I just did for Windows (Linux part is no-nop):
https://github.com/lstipakov/openvpn/commit/ce242896c621273578a446c5194d5ca6aee04237

ke 27. huhtik. 2022 klo 15.32 Lev Stipakov (lstipakov@...277...) kirjoitti:

> Hi,
>
> @Lev, just a heads up: does dco-win deal with this case? It would be
>> good to have a look on your side too.
>>
>
> Good point - this functionality (dco keepalive timeout) works in openvpn3
> but not in openvpn2.
>
> dco-win notifies userspace about keepalive timeout by returning certain
> error code (STATUS_CONNECTION_DISCONNECTED in kernel
> which translates to GetLastError 64 ERROR_NETNAME_DELETED, don't ask me
> why) in response to read request, so we should catch it
> inside read_incoming_link() after link_socket_read() call. Will do.
>
> --
> -Lev
>


-- 
-Lev

--00000000000072f58205dda2a565
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">How about we&#39;ll add dco_check_timeout(int, context) to=
 dco.h with platform specific implementations?<div><br></div><div>Here is w=
hat=C2=A0I just did for Windows (Linux part is no-nop):=C2=A0<a href=3D"htt=
ps://github.com/lstipakov/openvpn/commit/ce242896c621273578a446c5194d5ca6ae=
e04237">https://github.com/lstipakov/openvpn/commit/ce242896c621273578a446c=
5194d5ca6aee04237</a></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">ke 27. huhtik. 2022 klo 15.32 Lev Stipakov (<a h=
ref=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...</a=
>) kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
@Lev, just a heads up: does dco-win deal with this case? It would be <br>
good to have a look on your side too.<br></blockquote><div><br></div><div>G=
ood point - this functionality (dco keepalive timeout) works in openvpn3 bu=
t not in openvpn2.</div><div><br></div><div>dco-win notifies userspace abou=
t keepalive timeout by returning certain error code (STATUS_CONNECTION_DISC=
ONNECTED in kernel</div><div>which translates to GetLastError 64 ERROR_NETN=
AME_DELETED, don&#39;t ask me why) in response to read request, so we shoul=
d catch it</div><div>inside read_incoming_link() after link_socket_read() c=
all. Will do.</div><div><br></div></div>-- <br><div dir=3D"ltr">-Lev</div><=
/div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>-Lev</div>

--00000000000072f58205dda2a565--

