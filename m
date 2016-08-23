MIME-Version: 1.0
In-Reply-To: <3642cff2-6233-0a28-2a39-36513f008ab4@...277...>
References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
	<f9d8f147-e3d1-b80b-5646-faba6b853bc2@...277...>
	<76eb908d-b7b3-7425-5340-e4cd5726fbd1@...2080...>
	<3642cff2-6233-0a28-2a39-36513f008ab4@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Aug 2016 22:00:42 -0400
Message-ID: <CAKuzo_gdJFSOG-_g2v0FHnAjcq-cv9=8YJQCre5OQoxTbzNzyw@...278...>
Content-Type: multipart/alternative; boundary=001a1141f534681c32053ab3891d
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
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1141f534681c32053ab3891d
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Aug 22, 2016 at 8:55 PM, debbie10t <debbie10t@...277...> wrote:

>
> I need to use --up/--down/--client-connect/disconnect et al ..
>
> How does one run openvpn on *windows* without these "considered"
> security flaws ? or are we all just "lambs to the slaughter"
> from here on in ?


I wouldn't call it a security flaw. Its just that using interactive service
is more secure as openvpn and all scripts it calls run with limited
privileges. It has its limitations but may meet the needs of vast majority
of installations. So, going forward,  using interactive service would be
the recommended way.

But, some users do need to run scripts as admin and the only option is to
go ahead and run openvpn as admin -- either through the automatic service,
or directly from command line or whatever way is convenient. We should just
call that advanced usage, less secure and should be used only if absolutely
necessary.

Interestingly, running scripts as user has advantages in some use cases --
often scripts just do things like mapping a drive and has to be done as
user and not as admin for it to work on modern versions of windows. This is
the case with most client installations I have. Interactive service made it
easier/automatic to run scripts as the logged in user and not as admin.

If there are widely used tasks requiring admin privilege, we could add
support for that to the interactive service. Reducing the need for running
scripts as admin would be a good goal. This has to be done carefully
though, to keep the service code running as admin to a minimum.

Selva

--001a1141f534681c32053ab3891d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Mon, Aug 22, 2016 at 8:55 PM, de=
bbie10t <span dir=3D"ltr">&lt;<a href=3D"mailto:debbie10t@...277..." target=
=3D"_blank">debbie10t@...277...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br>
I need to use --up/--down/--client-connect/d<wbr>isconnect et al ..<br>
<br>
How does one run openvpn on *windows* without these &quot;considered&quot;<=
br>
security flaws ? or are we all just &quot;lambs to the slaughter&quot;<br>
from here on in ?</blockquote></div><br></div><div class=3D"gmail_extra">I =
wouldn&#39;t call it a security flaw. Its just that using interactive servi=
ce is more secure as <span tabindex=3D"-1" id=3D":7bj.1" style=3D"" class=
=3D"">openvpn</span> and all scripts it calls run with limited privileges. =
It has its limitations but may meet the needs of vast majority of installat=
ions. So, going forward,=C2=A0 using interactive service would be the recom=
mended way. <br><br>But, some users do need to run scripts as admin and the=
 only option is to go ahead and run <span tabindex=3D"-1" id=3D":7bj.2" sty=
le=3D"" class=3D"">openvpn</span> as admin -- either through the automatic =
service, or directly from command line or whatever way is convenient. We sh=
ould just call that advanced usage, less secure and should be used only if =
absolutely necessary.<br><br></div><div class=3D"gmail_extra">Interestingly=
, running scripts as user has advantages in some use cases -- often scripts=
 just do things like mapping a drive and has to be done as user and not as =
admin for it to work on modern versions of windows. This is the case with m=
ost client installations I have. Interactive service made it easier/automat=
ic to run scripts as the logged in user and not as admin.<br></div><div cla=
ss=3D"gmail_extra"><br></div><div class=3D"gmail_extra">If there are widely=
 used tasks requiring admin privilege, we could add support for that to the=
 interactive service. Reducing the need for running scripts as admin would =
be a good goal. This has to be done carefully though, to keep the service c=
ode running as admin to a minimum.</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra"><span tabindex=3D"-1" id=3D":7bj.3" style=3D""=
 class=3D"">Selva</span><br></div></div>

--001a1141f534681c32053ab3891d--

