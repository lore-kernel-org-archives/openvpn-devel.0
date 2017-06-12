MIME-Version: 1.0
In-Reply-To: <f73269d2-ba02-5360-9498-378f1e221a56@...277...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f73269d2-ba02-5360-9498-378f1e221a56@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 12 Jun 2017 15:23:43 -0400
Message-ID: <CAKuzo_jkyATwPyQkg4mZRAYbUFqc198+yKE-4kyK_--KbRtU=g@...278...>
Content-Type: multipart/alternative; boundary="001a114178f60dd5e90551c843c3"
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114178f60dd5e90551c843c3
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 7, 2017 at 12:41 PM, debbie10t <debbie10t@...277...> wrote:

> Hi,
>
> I have a basic setup and discovered that my W10 client was assigning a
> second IPv6 address to TAP even though it is *not* being pushed by the
> server.  The second address is an old address from a server that I
> sometimes connect to.  The server is still running but the client is not
> connected to it.
>
> The most significant information here is that this *only* happens when
> using the openvpn-GUI + interactive-service.


On Mon, Jun 12, 2017 at 10:28 AM, debbie10t <debbie10t@...277...> wrote:

> Is there no explanation ?


The service should delete the address when openvpn terminates so can't
think of any reason why an old address would linger even if the same tap
adapter was used for the previous connection.

Does this happen only on Win 10?

Wed Jun 07 16:33:53 2017 us=125353 ROUTE: route addition failed using
> service: The object already exists.   [status=5010 if_index=17]


This is a known issue (route not deleted on termination so fails to
recreate later) and is not a critical. FWIW, there is a patch on the ML to
fix it.

Selva

--001a114178f60dd5e90551c843c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_extra">On W=
ed, Jun 7, 2017 at 12:41 PM, debbie10t=C2=A0<span dir=3D"ltr">&lt;<a href=
=3D"mailto:debbie10t@...277..." target=3D"_blank">debbie10t@...277...</a>&g=
t;</span>=C2=A0wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);=
border-left-style:solid;padding-left:1ex">Hi,<br><br>I have a basic setup a=
nd discovered that my W10 client was assigning a second IPv6 address to TAP=
 even though it is *not* being pushed by the server.=C2=A0 The second addre=
ss is an old address from a server that I sometimes connect to.=C2=A0 The s=
erver is still running but the client is not connected to it.<br><br>The mo=
st significant information here is that this *only* happens when using the =
openvpn-GUI + interactive-service.</blockquote><div>=C2=A0</div></div><div =
class=3D"gmail_quote">On Mon, Jun 12, 2017 at 10:28 AM, debbie10t <span dir=
=3D"ltr">&lt;<a href=3D"mailto:debbie10t@...277..." target=3D"_blank">debbi=
e10t@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rg=
b(204,204,204);border-left-style:solid;padding-left:1ex">Is there no explan=
ation ?</blockquote><div><br></div></div>The service should delete the addr=
ess when openvpn terminates so can&#39;t think of any reason why an old add=
ress would linger even if the same tap adapter was used for the previous co=
nnection.</div><div class=3D"gmail_extra">=C2=A0<br>Does this happen only o=
n Win 10?</div><div class=3D"gmail_extra"><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">Wed Ju=
n 07 16:33:53 2017 us=3D125353 ROUTE: route addition failed using service: =
The object already exists. =C2=A0 [status=3D5010 if_index=3D17]</blockquote=
><div><br></div><div>This is a known issue (route not deleted on terminatio=
n so fails to recreate later) and is not a critical. FWIW, there is a patch=
 on the ML to fix it.</div><div>=C2=A0</div><div class=3D"gmail_extra">Selv=
a</div><div class=3D"gmail_extra"><br></div></div>

--001a114178f60dd5e90551c843c3--

