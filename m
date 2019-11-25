MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
 <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
 <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
 <CAGyAFMWeN-G7qf=MJfuuZK5M72VJ_03ahdAFsi6aLDcUT_me6g@...278...>
 <CAKuzo_h4hbQmaQrPHdDTkPjGOdGS55tsGDKm4RfHY0vWuqF5Fw@...278...>
 <99D61A626FDA8A4B90A270669121BE10C9AF9896@...2294...>
 <CAGyAFMWEc0c_GRiphD+=zikh2BkMckxD4rjZXrmQfmLUejAkgA@...278...>
 <CAKuzo_howdUtX86vj9kTYga=r8Ce0rbnrSiciqfCNtVVVeFwbw@...278...>
In-Reply-To: <CAKuzo_howdUtX86vj9kTYga=r8Ce0rbnrSiciqfCNtVVVeFwbw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 25 Nov 2019 11:03:35 +0200
Message-ID: <CAGyAFMWc=A=D_HRUpHJTXcPZSqxWKK44Hvd1ykAyb8JgQZD_2Q@...278...>
Content-Type: multipart/alternative; boundary="00000000000006564b0598280bd7"
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000006564b0598280bd7
Content-Type: text/plain; charset="UTF-8"

Hi,

(cc:ed to -devel)


> I would vote for B and not the combination.
>
> With wintun there is no backwards compatibility requirements, so we could
> use a cleaner, consistent and simpler approach (i.e B). Do not create any
> adapter during installation and dynamically create a temporary adapter at
> connection time.
>

My main concern with creating tun adapter on demand is that it is far from
instant:

$ time ./tapctl.exe create --hwid wintun
{D9F56B7A-3054-4ADC-9457-61030F0B469D}

real    0m2,090s

I don't think we want to add it to connection time.

Creating one persistent adapter per profile (as viscosity does for
> tapwindows and wireguard seems to do for wintun)
>

If I remember right, wireguard doesn't create persistent adapter, instead
it adds/removes it on demand.

If --dev-node is specified, we open the named adapter which the user is
> supposed to have created as we do for tapwindows.
>

Yes, I plan to add support for --dev-node for wintun.

-- 
-Lev

--00000000000006564b0598280bd7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi,</div><div><br></div><d=
iv>(cc:ed to -devel)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>I would =
vote for B and not the combination.<br></div><div><br></div><div>With wintu=
n there is no backwards compatibility requirements, so we could use a clean=
er, consistent and simpler approach (i.e B). Do not create any adapter duri=
ng installation and dynamically create a temporary adapter at connection ti=
me.</div></div></div></blockquote><div><br></div><div>My main concern with =
creating tun adapter on demand is that it is far from instant:</div><div><b=
r></div><div>$ time ./tapctl.exe create --hwid wintun<br>{D9F56B7A-3054-4AD=
C-9457-61030F0B469D}<br><br>real =C2=A0 =C2=A00m2,090s<br></div><div><br></=
div><div>I don&#39;t think we want to add it to connection time.</div><div>=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr=
"><div class=3D"gmail_quote"><div>Creating one persistent adapter per profi=
le (as viscosity does for tapwindows and wireguard seems to do for wintun)<=
/div></div></div></blockquote><div><br></div><div>If I remember right, wire=
guard doesn&#39;t create persistent adapter, instead it adds/removes it on =
demand.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>If --dev-node is specif=
ied, we open the named adapter which the user is supposed to have created a=
s we do for tapwindows.</div></div></div></blockquote><div><br></div><div>Y=
es, I plan to add support for --dev-node for wintun.=C2=A0<br></div></div><=
div><br></div>-- <br><div dir=3D"ltr">-Lev</div></div>

--00000000000006564b0598280bd7--

