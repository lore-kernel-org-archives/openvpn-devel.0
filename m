MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
 <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
 <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
In-Reply-To: <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 19 Nov 2019 19:23:16 +0200
Message-ID: <CAGyAFMWeN-G7qf=MJfuuZK5M72VJ_03ahdAFsi6aLDcUT_me6g@...278...>
Content-Type: multipart/alternative; boundary="000000000000787b880597b65294"
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
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000787b880597b65294
Content-Type: text/plain; charset="UTF-8"

Hi,

Apart from the error message, there is a larger issue especially when we
> use iservice. In that case, we have to preserve privilege separation and
> allowing a user to open a device handle in use by another has to be avoided.
>

Do you see it as a security issue when handle can be opened by another
process?

To read / write to tunnel one needs to register ring buffers, and this call
will fail for any other process. Am I missing something here?


> Can we get the wintun folks to support exclusive open (say FILE_SHARE_READ
> = 0) or expose the internal count of number of open handles? That would
> also make it easier to fix this and provide better error messages.
>

We could maybe submit a patch for that.

I agree it would be nice to have.


> Hmm.. if multiple openvpn instances are not tested this is not ready for
> review yet, is it?
>

I don't think so. I would not expect new tun driver (or code around it) to
support all features of old driver right from the beginning.

Wintun doesn't replace tap-windows6, so if someone requires functionality
which wintun doesn't yet support, one could always switch to previous
driver.

Again, a quick test shows that, with multiple openvpn instances, it does
> open an already opened device and then fails while registering ring buffers.
>

Yeah, it would be nice to eventual support multiple tunnels, but I don't
think that this is "must have" in the first version.

--000000000000787b880597b65294
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"ltr"><div>Hi,</div><div><br></div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_quote"><div>Apart from the error message, ther=
e is a larger issue especially when we use iservice. In that case, we have =
to preserve privilege separation and allowing a user to open a device handl=
e in use by another has to be avoided.</div></div></div></blockquote><div><=
br></div><div>Do you see it as a security issue when handle can be opened b=
y another process?</div><div><br></div><div>To read / write to tunnel one n=
eeds to register ring buffers, and this call will fail for any other proces=
s. Am I missing=C2=A0something here?</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quot=
e"><div>Can we get the wintun folks to support exclusive open (say FILE_SHA=
RE_READ =3D 0) or expose the internal count of number of open handles? That=
 would also make it easier to fix this and provide better error messages.</=
div></div></div></blockquote><div><br></div><div>We could maybe submit a pa=
tch for that.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I agree it=
 would be nice to have.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hmm..=
 if multiple openvpn instances are not tested this is not ready for review =
yet, is it?<br></div></div></div></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">I don&#39;t think so. I would not expect new t=
un driver (or code around it) to support all features of old driver right f=
rom the beginning.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Wintun doesn&#39;t replace tap-windows6, so if someone requires functional=
ity which wintun doesn&#39;t yet support, one could always switch to previo=
us driver.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"ltr"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div d=
ir=3D"ltr"><div class=3D"gmail_quote"><div>Again, a quick test shows that, =
with multiple openvpn instances, it does open an already opened device and =
then fails while registering ring buffers.</div></div></div></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah, it would be n=
ice to eventual support multiple tunnels, but I don&#39;t think that this i=
s &quot;must have&quot; in the first version.=C2=A0</div></div>

--000000000000787b880597b65294--

