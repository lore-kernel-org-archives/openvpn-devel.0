MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
 <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
In-Reply-To: <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 19 Nov 2019 10:27:06 -0500
Message-ID: <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000008a151c0597b4b3cb"
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000008a151c0597b4b3cb
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Nov 19, 2019 at 3:50 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> Doesn't this mean that  if --dev-node is specified, we'll open  tapwindows
>> adapter
>> with that name even if "--window-driver wintun" is specified? The open
>> may succeed
>> but subsequent wintun-specific processing will fail.
>>
>
> --dev-node is not (yet) supported and open will fail (just re-tested).
>

I did a quick test and found the open to succeed with a misleading message
that Wintun device opened (though it opened the tap device) and then fails
on register ring buffers. I haven't applied all patches as yet, so not sure
whether this is changed in later patches.

If I'm not mistaken wintun device can be opened multiple times, so we'll
>> never get the
>> "All wintun adapters on this system...." error.
>>
>
Well, we get it if wintun driver is not installed :) but yep, open will
> succeed.
>

Instead, open will succeed here and something else may fail later.
>>
>
> Right after opening we register ring buffers, and that will fail (with a
> friendly message):
>
> ERROR:  Failed to register ring buffers: 1247
>
> We should probably make it even more user friendly and write something
> like "make sure wintun adapter is not in use".
>

Apart from the error message, there is a larger issue especially when we
use iservice. In that case, we have to preserve privilege separation and
allowing a user to open a device handle in use by another has to be
avoided. The service could keep a lock on devices it manages, but I have no
idea how we are going to lock out devices opened by other means (say
instances started by automatic service, or wireguard or some other third
party product).

Can we get the wintun folks to support exclusive open (say FILE_SHARE_READ
= 0) or expose the internal count of number of open handles? That would
also make it easier to fix this and provide better error messages.


> Wireguard creates wintun adapter on demand (on connect) and openvpn during
> installation and then
> picks the first one found on connect. Maybe that logic could be more
> clever to not to pick adapter which
> is currently used by wireguard.
>
> I haven't looked yet into running wireguard and openvpn side by side (or
> multiple openvpn instances
> with wintun), just tested that wg and openvpn could co-exist without
> problems on the same machine.
>

Hmm.. if multiple openvpn instances are not tested this is not ready for
review yet, is it?

Again, a quick test shows that, with multiple openvpn instances, it does
open an already opened device and then fails while registering ring buffers.

Selva

--0000000000008a151c0597b4b3cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Nov 19, 2019 at 3:50 AM Lev Stipakov =
&lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_quote"><div>Doesn&#39;t this mean that=C2=A0 if --dev-=
node is specified, we&#39;ll open=C2=A0 tapwindows adapter</div><div>with t=
hat name even if &quot;--window-driver wintun&quot; is specified? The open =
may succeed</div><div>but subsequent wintun-specific processing will fail.<=
/div></div></div></blockquote><div><br></div><div>--dev-node is not (yet) s=
upported and open will fail (just re-tested).</div></div></div></blockquote=
><div><br></div><div class=3D"gmail_quote">I did a quick test and found the=
 open to succeed with a misleading message that Wintun device opened (thoug=
h it opened the tap device) and then fails on register ring buffers. I have=
n&#39;t applied all patches as yet, so not sure whether this is changed in =
later patches.<br></div><div class=3D"gmail_quote"><br><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>If I&#39;m not mistak=
en wintun device can be opened multiple times, so we&#39;ll never get the<b=
r>&quot;All wintun adapters on this system....&quot; error.</div></div></di=
v></blockquote></blockquote><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div>Well, we get it if wintun driver is not installed :)=
 but yep, open will succeed.</div></blockquote><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div>Instead, open will succeed here and something else may fai=
l later.</div></blockquote></blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div><br></div><div>Right after opening we register ring buf=
fers, and that will fail (with a friendly message):</div><div><br></div><di=
v>ERROR: =C2=A0Failed to register ring buffers: 1247</div><div><br></div><d=
iv>We should probably make it even more user friendly and write something l=
ike &quot;make sure wintun adapter is not in use&quot;.</div></blockquote><=
/div><div><br></div><div>Apart from the error message, there is a larger is=
sue especially when we use iservice. In that case, we have to preserve priv=
ilege separation and allowing a user to open a device handle in use by anot=
her has to be avoided. The service could keep a lock on devices it manages,=
 but I have no idea how we are going to lock out devices opened by other me=
ans (say instances started by automatic service, or wireguard or some other=
 third party product).<br></div><div><br></div><div>Can we get the wintun f=
olks to support exclusive open (say FILE_SHARE_READ =3D 0) or expose the in=
ternal count of number of open handles? That would also make it easier to f=
ix this and provide better error messages.<br></div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gm=
ail_quote"><div><br></div><div>Wireguard creates wintun adapter on demand (=
on connect) and openvpn during installation and then</div><div>picks the fi=
rst=C2=A0one found on connect. Maybe that logic could be more clever to not=
 to pick adapter which</div><div>is currently used by wireguard.</div><div>=
<br></div><div>I haven&#39;t looked yet into running wireguard and openvpn =
side by side (or multiple openvpn instances</div><div>with wintun), just te=
sted that wg and openvpn could co-exist without problems on the same machin=
e.</div></div></div></blockquote><div><br></div><div>Hmm.. if multiple open=
vpn instances are not tested this is not ready for review yet, is it?<br></=
div><div><br></div><div>Again, a quick test shows that, with multiple openv=
pn instances, it does open an already opened device and then fails while re=
gistering ring buffers.</div><div><br></div><div>Selva<br></div></div></div>

--0000000000008a151c0597b4b3cb--

