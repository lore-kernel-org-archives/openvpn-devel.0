MIME-Version: 1.0
In-Reply-To: <5669DE06.70509@...2070...>
References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...> <20151210162651.GI24952@...1296...>
	<5669AD21.4000301@...2070...>
	<CAKuzo_jhYhGT7y_+O1Z73RLW51RuHB702MxxmHbVS5XG2jg0dw@...278...>
	<5669DE06.70509@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Dec 2015 15:33:53 -0500
Message-ID: <CAKuzo_i6Q_13D3pV5QW58MQ-5ybC9JU7qCTLKybpQ0yZvNzghw@...278...>
Content-Type: multipart/alternative; boundary=001a11453cf4347045052691213a
Subject: Re: [Openvpn-devel] [PATCH v8-master] Add Windows DNS Leak fix
	using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11453cf4347045052691213a
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Dec 10, 2015 at 3:18 PM, ValdikSS <iam@...2070...> wrote:

> Use dynamic sessions.
>
> Many applications add filtering policy objects at start, and then delete
> these objects at stop. By using a dynamic session, you guarantee that these
> objects are deleted even if the application crashes. Furthermore, simply
> closing the engine handle at stop is more efficient than making individual
> calls to delete each object.
>
> Going by that just closing the engine appears good enough. I never tested
really changing the tapluid between a SIGHUP restart (how to trigger that)
to know whether any old filters hang around after a  _uninit. Anyway, those
are very unlikely cases and we cant guarad against everything up front.

I would say go for v9 with a simple closing of the engine.

Thanks,

Selva

--001a11453cf4347045052691213a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Thu, Dec 10, 2015 at 3:18 PM, Va=
ldikSS <span dir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_b=
lank">iam@...2070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><blockquote type=3D"cite">Use dynamic sessions.
      <p>Many applications add filtering policy objects at start, and
        then delete these objects at stop. By using a dynamic session,
        you guarantee that these objects are deleted even if the
        application crashes. Furthermore, simply closing the engine
        handle at stop is more efficient than making individual calls to
        delete each object.</p></blockquote></blockquote></div>Going by tha=
t just closing the engine appears good enough. I never tested really changi=
ng the tapluid between a SIGHUP restart (how to trigger that) to know wheth=
er any old filters hang around after a=C2=A0 _uninit. Anyway, those are ver=
y unlikely cases and we cant guarad against everything up front.<br><br></d=
iv><div class=3D"gmail_extra">I would say go for v9 with a simple closing o=
f the engine.<br></div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">Thanks,<br><br></div><div class=3D"gmail_extra">Selva<br></div>=
<div class=3D"gmail_extra"><br></div></div>

--001a11453cf4347045052691213a--

