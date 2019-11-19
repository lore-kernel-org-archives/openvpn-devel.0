MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
In-Reply-To: <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 19 Nov 2019 10:50:18 +0200
Message-ID: <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
Content-Type: multipart/alternative; boundary="0000000000000437e90597af280e"
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] wintun: implement opening wintun
 device
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000000437e90597af280e
Content-Type: text/plain; charset="UTF-8"

Hi,

Doesn't this mean that  if --dev-node is specified, we'll open  tapwindows
> adapter
> with that name even if "--window-driver wintun" is specified? The open may
> succeed
> but subsequent wintun-specific processing will fail.
>

--dev-node is not (yet) supported and open will fail (just re-tested).


> If I'm not mistaken wintun device can be opened multiple times, so we'll
> never get the
> "All wintun adapters on this system...." error.
>

Well, we get it if wintun driver is not installed :) but yep, open will
succeed.

Instead, open will succeed here and something else may fail later.
>

Right after opening we register ring buffers, and that will fail (with a
friendly message):

ERROR:  Failed to register ring buffers: 1247

We should probably make it even more user friendly and write something like
"make sure wintun adapter is not in use".

Wireguard creates wintun adapter on demand (on connect) and openvpn during
installation and then
picks the first one found on connect. Maybe that logic could be more clever
to not to pick adapter which
is currently used by wireguard.

I haven't looked yet into running wireguard and openvpn side by side (or
multiple openvpn instances
with wintun), just tested that wg and openvpn could co-exist without
problems on the same machine.

-- 
-Lev

--0000000000000437e90597af280e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div class=3D"gmail_quote"><div>Doesn&#39;t this mean that=C2=
=A0 if --dev-node is specified, we&#39;ll open=C2=A0 tapwindows adapter</di=
v><div>with that name even if &quot;--window-driver wintun&quot; is specifi=
ed? The open may succeed</div><div>but subsequent wintun-specific processin=
g will fail.</div></div></div></blockquote><div><br></div><div>--dev-node i=
s not (yet) supported and open will fail (just re-tested).</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv class=3D"gmail_quote"><div>If I&#39;m not mistaken wintun device can be =
opened multiple times, so we&#39;ll never get the<br>&quot;All wintun adapt=
ers on this system....&quot; error.</div></div></div></blockquote><div><br>=
</div><div>Well, we get it if wintun driver is not installed :) but yep, op=
en will succeed.</div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>Instead, open =
will succeed here and something else may fail later.</div></div></div></blo=
ckquote><div><br></div><div>Right after opening we register ring buffers, a=
nd that will fail (with a friendly message):</div><div><br></div><div>ERROR=
: =C2=A0Failed to register ring buffers: 1247</div><div><br></div><div>We s=
hould probably make it even more user friendly and write something like &qu=
ot;make sure wintun adapter is not in use&quot;.</div><div><br></div><div>W=
ireguard creates wintun adapter on demand (on connect) and openvpn during i=
nstallation and then</div><div>picks the first=C2=A0one found on connect. M=
aybe that logic could be more clever to not to pick adapter which</div><div=
>is currently used by wireguard.</div><div><br></div><div>I haven&#39;t loo=
ked yet into running wireguard and openvpn side by side (or multiple openvp=
n instances</div><div>with wintun), just tested that wg and openvpn could c=
o-exist without problems on the same machine.</div></div><div><br></div>-- =
<br><div dir=3D"ltr" class=3D"gmail_signature">-Lev</div></div>

--0000000000000437e90597af280e--

