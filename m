MIME-Version: 1.0
References: <20230210133159.1336-1-lstipakov@...277...>
 <a080d07f-c772-4dc4-de40-1807d2f74a6a@...2181...>
In-Reply-To: <a080d07f-c772-4dc4-de40-1807d2f74a6a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 10 Feb 2023 14:54:05 -0500
Message-ID: <CAKuzo_hkFXh=m3VYvxKCzGePzMau92Af8cBmUy23vd8XcrBpmQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000000ace8705f45dddad"
Subject: Re: [Openvpn-devel] [PATCH] Improve format specifier for socket
 handle in Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--0000000000000ace8705f45dddad
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Feb 10, 2023 at 2:21 PM Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 10/02/2023 14:31, Lev Stipakov wrote:
> > From: Lev Stipakov <lev@...515...>
> >
> > Socket is a handle on Windows, which is usually logged in hex.
> > Also an interesting value is INVALID_SOCKET, which is ~0.
> >
> > PRIuPTR prints decimals, and for INVALID_SOCKET it prints something like
> >
> >    2023-02-10 14:45:21 us=906000 write to TUN/TAP : Jrjestelmkutsulle
> > annettu data-alue on liian pieni.   (fd=18446744073709551615,code=122)
> >
> > PRIxPTR prints hex, and INVALID_SOCKET looks a bit nicer:
> >
> >    2023-02-10 15:17:11 us=828000 write to TUN/TAP : Jrjestelmkutsulle
> > annettu data-alue on liian pieni.   (fd=ffffffffffffffff,code=122)
> >
> > Reported-by: Selva Nair <selva.nair@...277...>
> > Signed-off-by: Lev Stipakov <lev@...515...>
>
> I also discussed this with Lev and, despite this being different from
> what we do in the *nix world (where decimal representations make sense
> for file descriptors), it seems to be the right hting to do on Windows
> when using HANDLEs (shrug).
>

Windows kernel handles are very much "like" fds though the handle table
also covers processes, threads,  semaphores etc. They are not pointers, are
generally smallish numbers or ~0 (== -1). But not as small as fds in the
Unix/Linux world --- mainly because several objects share the name space
and they have to be multiples of 4 for some arcane reason.

The problem here was not printing as "decimal" but as "unsigned decimal".
Use of the latter would have caused the same issue on Linux too.

Using hex is a compromise here as handles are defined as "unsigned ints" of
the same size as pointers. So PRIdPTR somehow looks improper though I would
have chosen that.

Selva

--0000000000000ace8705f45dddad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Feb 10, 2023 at 2:21 PM Antonio Quartulli &=
lt;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 10/02/2023 14:31, Lev Stipakov wrote:<br>
&gt; From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_bla=
nk">lev@...515...</a>&gt;<br>
&gt; <br>
&gt; Socket is a handle on Windows, which is usually logged in hex.<br>
&gt; Also an interesting value is INVALID_SOCKET, which is ~0.<br>
&gt; <br>
&gt; PRIuPTR prints decimals, and for INVALID_SOCKET it prints something li=
ke<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 2023-02-10 14:45:21 us=3D906000 write to TUN/TAP : Jrjest=
elmkutsulle<br>
&gt; annettu data-alue on liian pieni.=C2=A0 =C2=A0(fd=3D184467440737095516=
15,code=3D122)<br>
&gt; <br>
&gt; PRIxPTR prints hex, and INVALID_SOCKET looks a bit nicer:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 2023-02-10 15:17:11 us=3D828000 write to TUN/TAP : Jrjest=
elmkutsulle<br>
&gt; annettu data-alue on liian pieni.=C2=A0 =C2=A0(fd=3Dffffffffffffffff,c=
ode=3D122)<br>
&gt; <br>
&gt; Reported-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." ta=
rget=3D"_blank">selva.nair@...277...</a>&gt;<br>
&gt; Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." targe=
t=3D"_blank">lev@...515...</a>&gt;<br>
<br>
I also discussed this with Lev and, despite this being different from <br>
what we do in the *nix world (where decimal representations make sense <br>
for file descriptors), it seems to be the right hting to do on Windows<br>
when using HANDLEs (shrug).<br></blockquote><div><br></div><div>Windows ker=
nel handles are very much &quot;like&quot; fds though the handle table also=
 covers processes, threads,=C2=A0 semaphores etc. They are not pointers, ar=
e generally smallish numbers or ~0 (=3D=3D -1). But not as small as fds in =
the Unix/Linux world --- mainly because several objects share the name spac=
e and they have to be multiples of 4 for some arcane reason.=C2=A0</div><di=
v><br></div><div>The problem here was not printing as &quot;decimal&quot; b=
ut as &quot;unsigned decimal&quot;. Use of the latter would have caused the=
 same issue on Linux too.</div><div><br></div><div>Using hex is a compromis=
e here as handles are defined as &quot;unsigned ints&quot; of the same size=
 as pointers. So PRIdPTR somehow looks improper though I would have chosen =
that.</div><div><br></div><div>Selva</div></div></div>

--0000000000000ace8705f45dddad--

