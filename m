MIME-Version: 1.0
In-Reply-To: <d925da2c-5715-6452-1c38-097a123c0de1@...277...>
References: <d925da2c-5715-6452-1c38-097a123c0de1@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 28 May 2017 11:20:04 -0400
Message-ID: <CAKuzo_hWtk=vpR1P4T7O6e6udL8o+yySciD7VveTYdt25c7DRA@...278...>
Content-Type: multipart/alternative; boundary="001a113d77cc0cf1460550971c9c"
Subject: Re: [Openvpn-devel] block-outside-dns and persist-tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <valdikss@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d77cc0cf1460550971c9c
Content-Type: text/plain; charset="UTF-8"

Hi,

Copying the -devel list:

On Sun, May 28, 2017 at 10:16 AM, ValdikSS <valdikss@...277...> wrote:

> Pavel, a friend of mine, made a service to circumvent Ukrainian blocks of
> Russian websites. He configured OpenVPN TCP without persist-tun on the
> client side and pushes block-outside-dns from server.
>
> When he restarts OpenVPN server, DNS no longer works on the clients.
> Neither with or without VPN. Users say this can be fixed only with
> rebooting, I believe restarting service would help too.
>

Is this only with 2.4.2 or is 2.4.1 also affected?  As you imply, the
filters won't persist after the process ends (in this case the service),
restarting service should be enough to clear them. Further, even if the
openvpn client process terminates without removing the filters, the service
should clean up all filters added in that session during the undo()
processing. However, that wont happen if the openvpn.exe process fails to
exit. Verify that a stale client process is not hanging around.


>
> I tried to do exactly what he did with Windows 7 and OpenVPN 2.4.2 and I
> can't reproduce this bug. I think service in some cases loses TAP adapter
> index before unblocking DNS.
>

The tap adapter index is used to allow dns traffic through it, not block
it, so I would think the failure is in unblocking dns through non-tap
adapters. If that is the case, dns should start working again through the
tunnel when the client reconnects.

Anyway, we need to see the client logs and any error event logged by the
service when this happens. Can you get the user to open a ticket with logs?


>
> Works fine with persist-tun on client side.
>

Selva

--001a113d77cc0cf1460550971c9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Copying the -devel list:</div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun, May 28, 2017=
 at 10:16 AM, ValdikSS <span dir=3D"ltr">&lt;<a href=3D"mailto:valdikss@...493...=
277..." target=3D"_blank">valdikss@...277...</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div id=3D"m_3882217382509307866:3jm" class=3D"m_=
3882217382509307866a3s m_3882217382509307866aXjCH m_3882217382509307866m15c=
4f6a0f2bce42b">Pavel, a friend of mine, made a service to circumvent Ukrain=
ian blocks of Russian websites. He configured OpenVPN TCP without persist-t=
un on the client side and pushes block-outside-dns from server.<br>
<br>
When he restarts OpenVPN server, DNS no longer works on the clients. Neithe=
r with or without VPN. Users say this can be fixed only with rebooting, I b=
elieve restarting service would help too.<br></div></blockquote><div><br></=
div><div>Is this only with 2.4.2 or is 2.4.1 also affected?=C2=A0 As you im=
ply, the filters won&#39;t persist after the process ends (in this case the=
 service), restarting service should be enough to clear them. Further, even=
 if the openvpn client process terminates without removing the filters, the=
 service should clean up all filters added in that session during the undo(=
) processing. However, that wont happen if the openvpn.exe process fails to=
 exit. Verify that a stale client process is not hanging around.=C2=A0</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D"m_3882217382509=
307866:3jm" class=3D"m_3882217382509307866a3s m_3882217382509307866aXjCH m_=
3882217382509307866m15c4f6a0f2bce42b">
<br>
I tried to do exactly what he did with Windows 7 and OpenVPN 2.4.2 and I ca=
n&#39;t reproduce this bug. I think service in some cases loses TAP adapter=
 index before unblocking DNS.<br></div></blockquote><div><br></div><div>The=
 tap adapter index is used to allow dns traffic through it, not block it, s=
o I would think the failure is in unblocking dns through non-tap adapters. =
If that is the case, dns should start working again through the tunnel when=
 the client reconnects.</div><div><br></div><div>Anyway, we need to see the=
 client logs and any error event logged by the service when this happens. C=
an you get the user to open a ticket with logs?</div><div>=C2=A0=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div id=3D"m_3882217382509307866:3jm" class=
=3D"m_3882217382509307866a3s m_3882217382509307866aXjCH m_38822173825093078=
66m15c4f6a0f2bce42b">
<br>
Works fine with persist-tun on client side.</div></blockquote></div><div cl=
ass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div><=
/div>

--001a113d77cc0cf1460550971c9c--

