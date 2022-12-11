MIME-Version: 1.0
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
 <20221211192124.1126-1-marc.becker@...2704...>
In-Reply-To: <20221211192124.1126-1-marc.becker@...2704...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 11 Dec 2022 14:38:46 -0500
Message-ID: <CAKuzo_iFLmH3R=K6LKcbii+vzyCvU8c6hxKRCtHuRd8gt75z0A@...278...>
Content-Type: multipart/alternative; boundary="000000000000f09dd605ef928967"
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] special handling for PKCS11
 providers on win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marc Becker <marc.becker@...2704...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000f09dd605ef928967
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Dec 11, 2022 at 2:22 PM Marc Becker via Openvpn-devel <
openvpn-devel@lists.sourceforge.net> wrote:

> Change win32 dynamic loader behavior when supplying an absolute path.
> The DLL location is considered/preferred to resolve dependencies.
> Support in pkcs11-helper for loader flag is detected at compile time.
>
> 3rd party DLLs and additional dependencies do not need to be moved to
> the OpenVPN directory or require changes to %PATH% configuration.
>
> The included changes to pkcs11-helper are pending and can be removed as
> soon as a compatible a version is released/referenced.
>
> Signed-off-by: Marc Becker <marc.becker@...2704...>
> ---
> v2: compress code change an add transitional pkcs11-helper patch
>

Please split this into separate patches for
#1 changes to pkcs11.c which will be required even after
upstream pkcs11-helper library is updated
#2 Patching pkcs11-helper in vcpkg-ports

Rationale:
(1) #2 can be independently reverted when longer required
(2) IMO, carrying around patches to external libraries is an undue burden
and not justified in this case --- my personal preference would be to NAK
it but still keep #1 as it will automatically get enabled when upstream
pkcs11-helper accepts your changes, which look imminent.

Selva

--000000000000f09dd605ef928967
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div>Hi,<div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 11, 2022 at 2:22 PM M=
arc Becker via Openvpn-devel &lt;<a href=3D"mailto:openvpn-devel@...1439...=
ceforge.net" target=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Change wi=
n32 dynamic loader behavior when supplying an absolute path.<br>
The DLL location is considered/preferred to resolve dependencies.<br>
Support in pkcs11-helper for loader flag is detected at compile time.<br>
<br>
3rd party DLLs and additional dependencies do not need to be moved to<br>
the OpenVPN directory or require changes to %PATH% configuration.<br>
<br>
The included changes to pkcs11-helper are pending and can be removed as<br>
soon as a compatible a version is released/referenced.<br>
<br>
Signed-off-by: Marc Becker &lt;<a href=3D"mailto:marc.becker@...2704..." ta=
rget=3D"_blank">marc.becker@...2704...</a>&gt;<br>
---<br>
v2: compress code change an add transitional pkcs11-helper patch<br></block=
quote><div><br></div><div>Please split this into separate patches for=C2=A0=
</div><div>#1 changes to pkcs11.c which will be required even after upstrea=
m=C2=A0pkcs11-helper library is updated</div><div>#2 Patching pkcs11-helper=
 in vcpkg-ports</div><div><br></div><div>Rationale:</div><div>(1) #2 can be=
 independently reverted when longer required</div><div>(2) IMO, carrying ar=
ound patches to external=C2=A0libraries is an undue burden and not justifie=
d=C2=A0in this case --- my personal preference would be to NAK it but still=
 keep #1 as it will automatically get enabled when upstream pkcs11-helper a=
ccepts your changes, which look imminent.</div><div><br></div><div>Selva</d=
iv></div></div></div>

--000000000000f09dd605ef928967--

