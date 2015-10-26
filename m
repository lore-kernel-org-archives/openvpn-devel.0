MIME-Version: 1.0
In-Reply-To: <071C5EF6-E94A-422D-9456-0E6015C10F8D@...277...>
References: <562DF8BA.1090406@...515...>
	<071C5EF6-E94A-422D-9456-0E6015C10F8D@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 26 Oct 2015 11:41:10 -0400
Message-ID: <CAKuzo_if_4L81xNZKDPJhek_FicxM-c2ZvWkYcZq1tMjGpXXvw@...278...>
Content-Type: multipart/alternative; boundary=001a11c243ae7fadf9052303cbf7
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 26th Oct 2015) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gmail <volleynbike@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c243ae7fadf9052303cbf7
Content-Type: text/plain; charset=UTF-8

On Mon, Oct 26, 2015 at 11:17 AM, Gmail <volleynbike@...277...> wrote:

> Regarding the instability of connection in the windows version:  I
> overcame this long ago (and works well to this date) by building a tiny
> script that periodically pings the the ovpn gateway (server). If no ping
> reply then restart the service. Very simple. Perhaps this could be built
> into the code as an option?


Oh, please, no... If the TAP driver has stability woes it needs to be
fixed. True loss of network connectivity is already handled by internal
pings and ping-restarts. It would be a grave mistake to add such options to
hide any stability issues.

Cheers,

Selva

--001a11c243ae7fadf9052303cbf7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Oct 26, 2015 at 11:17 AM, Gmail <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:volleynbike@...277..." target=3D"_blank">volleynbike@...277...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Regarding the instability =
of connection in the windows version:=C2=A0 I overcame this long ago (and w=
orks well to this date) by building a tiny script that periodically pings t=
he the ovpn gateway (server). If no ping reply then restart the service. Ve=
ry simple. Perhaps this could be built into the code as an option?</blockqu=
ote></div><div class=3D"gmail_extra"><br></div>Oh, please, no... If the TAP=
 driver has stability woes it needs to be fixed. True loss of network conne=
ctivity is already handled by internal pings and ping-restarts. It would be=
 a grave mistake to add such options to hide any stability issues.=C2=A0</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Cheers,<=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva<=
br><br></div></div>

--001a11c243ae7fadf9052303cbf7--

