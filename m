MIME-Version: 1.0
References: <20230111160848.22906-1-gert@...1296...>
 <3991c027-442a-b869-196e-ceebf3eca1d9@...2181...>
In-Reply-To: <3991c027-442a-b869-196e-ceebf3eca1d9@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 12 Jan 2023 02:50:27 -0500
Message-ID: <CAKuzo_iZO9WW8xUJS1Qc-DNF5A2+UhK_0v8bzt21A7z9KG8PHg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c03f0005f20c5f32"
Subject: Re: [Openvpn-devel] [PATCH] Repair special-casing of EEXIST for
 Linux/SITNL route install
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--000000000000c03f0005f20c5f32
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 11, 2023 at 7:30 PM Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> for the netlink/sitnl bits: this makes sense to me.
> I agree with Selva that the v6 variant could benefit from the same
> treatment.
>
> However, this patch can also be hacked on its own
>
> Acked-by: Antonio Quartulli <a@...2181...>
>

Not so fast.
As it stands the patch introduces a bug that was not there: existing v6
routes can cause CONENCTED,ROUTE_ERROR instead of CONNECTED,SUCCESS. That's
why I did not ACK it.

Not sure I understand "can also be hacked alone".

Selva

--000000000000c03f0005f20c5f32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 11, 2023 at 7:30 PM Anton=
io Quartulli &lt;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2707...=
1...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi,<br>
<br>
for the netlink/sitnl bits: this makes sense to me.<br>
I agree with Selva that the v6 variant could benefit from the same <br>
treatment.<br>
<br>
However, this patch can also be hacked on its own<br>
<br>
Acked-by: Antonio Quartulli &lt;<a href=3D"mailto:a@...2181..." target=3D"_=
blank">a@...2181...</a>&gt;<br></blockquote><div><br></div><div>Not so fast=
.=C2=A0</div><div>As it stands the patch introduces=C2=A0a bug that was not=
 there: existing v6 routes can cause CONENCTED,ROUTE_ERROR instead of CONNE=
CTED,SUCCESS. That&#39;s why I did not ACK it.</div><div><br></div><div>Not=
 sure I understand &quot;can also be hacked alone&quot;.</div><div><br></di=
v><div>Selva</div></div></div>

--000000000000c03f0005f20c5f32--

