MIME-Version: 1.0
In-Reply-To: <CAFHpkQHbufM9=+_SwgesYzV=vPR3_dT_EMxakkGdOk2HmjvTKA@...278...>
References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
	<57A72DA2.1090003@...277...>
	<CAFHpkQHbufM9=+_SwgesYzV=vPR3_dT_EMxakkGdOk2HmjvTKA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 7 Aug 2016 11:16:16 -0400
Message-ID: <CAKuzo_iPncck2Ds2R2Z1ZfcnPMoqUkFBkt0iZex51RAYv4OQMQ@...278...>
Content-Type: multipart/alternative; boundary=001a114a6a2224fbe905397cc91d
Subject: Re: [Openvpn-devel] Win10 Tun Server +Standard W10 User +OVPN
 Interactive Service +OVPN GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114a6a2224fbe905397cc91d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 7, 2016 at 8:55 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> I also noticed, that "openvpn administrators" membership is required.
>
> Should we modify installer to make it adf current user to that group?
>
With multiple users on a system, the installer will have to choose which
users are to be added etc. Also for newly created users the membership will
not be automatic.

For simple setups with one or two users who have access to the admin
password, I think, the current setup where the GUI provides a way to add
themselves to the group looks good enough. In a vast majority of cases
where users are also administrators everything is automatic: UAC will
ensure that the GUI runs with limited rights and thus use the interactive
service, and the service will permit config from any location because of
user's membership in the "Administrators" group.

For more complex setups, I suppose the sysadm would want to fine-tune
membership in the "OpenVPN Administrtaors" group as needed.

Selva

--001a114a6a2224fbe905397cc91d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Aug 7, 2016 at 8:55 AM, =D0=
=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=
=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chip=
itsine@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p=
 dir=3D"ltr">I also noticed, that &quot;openvpn administrators&quot; member=
ship is required.<br></p>
<p dir=3D"ltr">Should we modify installer to make it adf current user to th=
at group?</p></blockquote></div>With multiple users on a system, the instal=
ler will have to choose which users are to be added etc. Also for newly cre=
ated users the membership will not be automatic. <br><br>For simple setups =
with one or two users who have access to the admin password, I think, the c=
urrent setup where the GUI provides a way to add themselves to the group lo=
oks good enough. In a vast majority of cases where users are also administr=
ators everything is automatic: UAC will ensure that the GUI runs with limit=
ed rights and thus use the interactive service, and the service will permit=
 config from any location because of user&#39;s membership in the &quot;Adm=
inistrators&quot; group.<br><br>For more complex setups, I suppose the sysa=
dm would want to fine-tune membership in the &quot;OpenVPN Administrtaors&q=
uot; group as needed. <br><br></div><div class=3D"gmail_extra">Selva<br></d=
iv></div>

--001a114a6a2224fbe905397cc91d--

