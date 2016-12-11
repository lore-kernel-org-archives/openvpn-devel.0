MIME-Version: 1.0
In-Reply-To: <ad8c62af-5534-79d7-11ff-56cf51888615@...277...>
References: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
	<08d5f483-cc64-b708-a54c-29cfb2c7880e@...277...>
	<CAKuzo_jFHw1k0M0WfU8WsiTaZDYNE9+K=2=41g_oHqLikydo1w@...278...>
	<ad8c62af-5534-79d7-11ff-56cf51888615@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 11 Dec 2016 12:52:39 -0500
Message-ID: <CAKuzo_iBnazFOMGaCDO-ga_ONCN=wb6818syt+S66S_OKZDoCw@...278...>
Content-Type: multipart/alternative; boundary=001a114c8946658f81054365a8b0
Subject: Re: [Openvpn-devel] On saving passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114c8946658f81054365a8b0
Content-Type: text/plain; charset=UTF-8

On Sun, Dec 11, 2016 at 12:00 PM, debbie10t <debbie10t@...277...> wrote:

> What happens if a remote user, who has admin access to their own computer,
> connects to a work VPN but they decide to change said config ?
>

A user who has admin access to their own computer can do anything to it:
including saving VPN passwords. Why would openvpn stop them doing that? The
question was about a sysadmin of an office not allowing their users to save
their openvpn passwords in an automated way. There is no way of ensuring
that if the user has admin access on their devices. Note that password is
saved on the client, not the server.


>
> I think the essence of my question is: does openvpn feel that there is a
> valid need for total server control of such an option ?
>

This is not something that the server can enforce, its about the user
interface on the client.  Server can make it easier for  the admin to apply
some options to all users (by pushing them), but that doesn't enforce user
behaviour.

Selva

--001a114c8946658f81054365a8b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Dec 11, 2016 at 12:00 PM, debbie10t <span dir=3D"ltr">&lt;<a href=
=3D"mailto:debbie10t@...277..." target=3D"_blank">debbie10t@...277...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D"m_28694548003=
30992424:3n6" class=3D"m_2869454800330992424a3s m_2869454800330992424aXjCH =
m_2869454800330992424m158eed469f8fd167">What happens if a remote user, who =
has admin access to their own computer, connects to a work VPN but they dec=
ide to change said config ?<br></div></blockquote><div><br></div><div>A use=
r who has admin access to their own computer can do anything to it: includi=
ng saving VPN passwords. Why would openvpn stop them doing that? The questi=
on was about a sysadmin of an office not allowing their users to save their=
 openvpn passwords in an automated way. There is no way of ensuring that if=
 the user has admin access on their devices. Note that password is saved on=
 the client, not the server.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div id=3D"m_2869454800330992424:3n6" class=3D"m_2869454800330992424=
a3s m_2869454800330992424aXjCH m_2869454800330992424m158eed469f8fd167">
<br>
I think the essence of my question is: does openvpn feel that there is a va=
lid need for total server control of such an option ?<br></div></blockquote=
><div><br></div><div>This is not something that the server can enforce, its=
 about the user interface on the client.=C2=A0 Server can make it easier fo=
r =C2=A0the admin to apply some options to all users (by pushing them), but=
 that doesn&#39;t enforce user behaviour.=C2=A0</div></div><br></div><div c=
lass=3D"gmail_extra">Selva</div></div>

--001a114c8946658f81054365a8b0--

