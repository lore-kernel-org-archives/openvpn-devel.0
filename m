MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
 <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
 <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
 <CAGyAFMWeN-G7qf=MJfuuZK5M72VJ_03ahdAFsi6aLDcUT_me6g@...278...>
In-Reply-To: <CAGyAFMWeN-G7qf=MJfuuZK5M72VJ_03ahdAFsi6aLDcUT_me6g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 19 Nov 2019 13:03:26 -0500
Message-ID: <CAKuzo_h4hbQmaQrPHdDTkPjGOdGS55tsGDKm4RfHY0vWuqF5Fw@...278...>
Content-Type: multipart/alternative; boundary="000000000000714a030597b6e22a"
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

--000000000000714a030597b6e22a
Content-Type: text/plain; charset="UTF-8"

Hi Lev,

On Tue, Nov 19, 2019 at 12:23 PM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> Apart from the error message, there is a larger issue especially when we
>> use iservice. In that case, we have to preserve privilege separation and
>> allowing a user to open a device handle in use by another has to be avoided.
>>
>
> Do you see it as a security issue when handle can be opened by another
> process?
>

I don't know the internals of wintun to know that for sure.


>
> To read / write to tunnel one needs to register ring buffers, and this
> call will fail for any other process. Am I missing something here?
>

Hopefully, Simon can confirm whether that provides a sufficient safety net.

Selva

--000000000000714a030597b6e22a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Lev,<br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 19, 2019 at 12:23 PM Lev Stipa=
kov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@=
...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"auto"><div dir=3D"ltr"><div>Hi,</div><div><br></div>=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>Apart from the error mes=
sage, there is a larger issue especially when we use iservice. In that case=
, we have to preserve privilege separation and allowing a user to open a de=
vice handle in use by another has to be avoided.</div></div></div></blockqu=
ote><div><br></div><div>Do you see it as a security issue when handle can b=
e opened by another process?</div></div></div></div></blockquote><div><br><=
/div><div>I don&#39;t know the internals of wintun to know that for sure. <=
br></div><div>=C2=A0 <br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"auto"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><b=
r></div><div>To read / write to tunnel one needs to register ring buffers, =
and this call will fail for any other process. Am I missing=C2=A0something =
here?</div></div></div></div></blockquote><div><br></div><div>Hopefully, Si=
mon can confirm whether that provides a sufficient safety net.<br></div></d=
iv><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Selva<br=
></div></div>

--000000000000714a030597b6e22a--

