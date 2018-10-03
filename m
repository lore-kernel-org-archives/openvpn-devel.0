MIME-Version: 1.0
References: <1538576212-2363-1-git-send-email-lstipakov@...277...>
 <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
 <8ddfa02f-4003-4a20-5cce-6bb5d8e70e89@...2080...>
 <CAKuzo_iNhAf1yVG2qP0mfZpKWDukhJdcH6nGsJnHQ7=Rz60QuQ@...278...>
In-Reply-To: <CAKuzo_iNhAf1yVG2qP0mfZpKWDukhJdcH6nGsJnHQ7=Rz60QuQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 3 Oct 2018 19:41:44 +0300
Message-ID: <CAGyAFMWb0+kpevvu2-UqOvU32HbPK5A=y10WHhThYde74nbKAA@...278...>
Content-Type: multipart/alternative; boundary="00000000000066b957057755b7a3"
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: clarify return values type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000066b957057755b7a3
Content-Type: text/plain; charset="UTF-8"

Hi,


> In case of the service code, which is Windows only, there are about 30
> uses of
> BOOL but only a few cases of bool (typdef to int) all of which are in the
> deprecated
> automatic service code.
>

I agree, it probably not worth to introduce a "new" type (stdbool) to
interactive
service code.

The point of this patch is to make a few methods return boolean value and
BOOL
fits well for this purpose.

-- 
-Lev

--00000000000066b957057755b7a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi,</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote">=
<div>In case of the service code, which is Windows only, there are about 30=
 uses of<br>BOOL but only a few cases of bool (typdef to int) all of which =
are in the deprecated<br>automatic service code.=C2=A0</div></div></div></b=
lockquote><div><br></div><div>I agree, it probably not worth to introduce a=
 &quot;new&quot; type (stdbool) to interactive</div><div>service code.</div=
><div><br></div><div>The point of this patch is to make a few methods retur=
n boolean value and BOOL</div><div>fits well for this purpose.</div><div>=
=C2=A0</div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-sm=
artmail=3D"gmail_signature">-Lev</div></div>

--00000000000066b957057755b7a3--

