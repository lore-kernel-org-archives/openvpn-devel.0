MIME-Version: 1.0
In-Reply-To: <403b6c99-f62f-6d7e-f3b7-ec207505ca3d@...277...>
References: <1483152307-15687-1-git-send-email-selva.nair@...277...>
	<403b6c99-f62f-6d7e-f3b7-ec207505ca3d@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 1 Jan 2017 13:15:54 -0500
Message-ID: <CAKuzo_iQPcDbZVbfMgnouj5XGLfVp=RniKeg==_N1UV0aWQU9A@...278...>
Content-Type: multipart/alternative; boundary=001a114d8ca4379a7f05450c6e8d
Subject: Re: [Openvpn-devel] [PATCH] Always release dhcp address in
	close_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114d8ca4379a7f05450c6e8d
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Jan 1, 2017 at 10:49 AM, debbie10t <debbie10t@...277...> wrote:

> Hi,
>
> I applied this to 2.5 and used the build system to build windows
> installer using windows-nsis/build-snapshot
>
> I tested the windows client against Linux 2.4
>
> The test was:
>
> Connect to first server, receive DHCP 10.*8*.0.6 (net30)
> Idle 10 mins / Transfer some data / disconnect
>
> Edit the config file to connect to a new server
> (This was an exact copy of first server on a new --port
> and with a new --server subnet / PKI identical)
>
> Connect to second server, receive DHCP 10.*9*.0.6 (net30)
> Idle 10 mins / Transfer some data / disconnect
>
> No problems encountered.
>

> Note: I *was* able to replicate the original bug using
> windows 10 / openvpn 2.4.0 and the same procedure as above.
>
>

I am curious about this as I could not reproduce "the bug" with only one
adapter except in a special case (see below)  -- the issue I described in
Trac #807 was related to assigning a VPN ip to one adapter, disconnect and
then try to assign the same to another adapter.

However, some reports in the user list and Trac #665 appears to have
problems when changing the remote with one adapter. I can see dhcp failure
in such a case only if the media status on the adapter is set to always
connected. Is that the case in your tests?

Thanks,

Selva

--001a114d8ca4379a7f05450c6e8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Jan 1, 2017 at 10:49 AM, de=
bbie10t <span dir=3D"ltr">&lt;<a href=3D"mailto:debbie10t@...277..." target=
=3D"_blank">debbie10t@...277...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<br>
I applied this to 2.5 and used the build system to build windows<br>
installer using windows-nsis/build-snapshot<br>
<br>
I tested the windows client against Linux 2.4<br>
<br>
The test was:<br>
<br>
Connect to first server, receive DHCP 10.*8*.0.6 (net30)<br>
Idle 10 mins / Transfer some data / disconnect<br>
<br>
Edit the config file to connect to a new server<br>
(This was an exact copy of first server on a new --port<br>
and with a new --server subnet / PKI identical)<br>
<br>
Connect to second server, receive DHCP 10.*9*.0.6 (net30)<br>
Idle 10 mins / Transfer some data / disconnect<br>
<br>
No problems encountered.=C2=A0<br></blockquote><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
Note: I *was* able to replicate the original bug using<br>
windows 10 / openvpn 2.4.0 and the same procedure as above.<br>
<span class=3D"im HOEnZb"></span>=C2=A0<br></blockquote><div><br></div><div=
>I am curious about this as I could not reproduce &quot;the bug&quot; with =
only one adapter except in a special case (see below)=C2=A0 -- the issue I =
described in Trac #807 was related to assigning a VPN ip to one adapter, di=
sconnect and then try to assign the same to another adapter. <br><br>Howeve=
r, some reports in the user list and Trac #665 appears to have problems whe=
n changing the remote with one adapter. I can see dhcp failure in such a ca=
se only if the media status on the adapter is set to always connected. Is t=
hat the case in your tests?<br><br></div><div>Thanks,<br><br></div><div>Sel=
va<br></div><div>=C2=A0<br></div></div></div></div>

--001a114d8ca4379a7f05450c6e8d--

