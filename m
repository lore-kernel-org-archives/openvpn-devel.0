MIME-Version: 1.0
References: <20230203191440.136050-4-frank@...2641...>
 <20230207134333.52221-1-frank@...2641...>
 <CAKuzo_ikVsfTZctuS0=_KpzyJ4xLAdpPeRdG2Fyk5qcgP1tR5g@...278...>
In-Reply-To: <CAKuzo_ikVsfTZctuS0=_KpzyJ4xLAdpPeRdG2Fyk5qcgP1tR5g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 9 Feb 2023 17:24:59 -0500
Message-ID: <CAKuzo_i8UoKZkV84pesfa_YxYvTn9qZiagYymAtfdBgWxMZGEg@...278...>
Content-Type: multipart/alternative; boundary="000000000000dc17ac05f44bda69"
Subject: [Openvpn-devel] Fwd: [PATCH v2 3/5] Windows: fix wrong printf
 format in x_check_status
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000dc17ac05f44bda69
Content-Type: text/plain; charset="UTF-8"

CC: list

---------- Forwarded message ---------
From: Selva Nair <selva.nair@...277...>
Date: Tue, Feb 7, 2023 at 11:57 AM
Subject: Re: [Openvpn-devel] [PATCH v2 3/5] Windows: fix wrong printf
format in x_check_status
To: Frank Lichtenheld <frank@...2641...>


Nitpicking:


>  - use PRIuPTR as discussed on IRC (added relevant defines to
>    commit message)
>

The most interesting value to log for SOCKET on Windows is  INVALID_SOCKET
= ~0 (i.e, -1). It will print with PRIuPTR as 18446744073709551615. PRIdPTR
which will give -1 or PRIxPTR (ffff....ffff) may be better in this case?
Though socket is a handle on Windows, I think it never gets too large to be
-ve except for this special value.

I'm fine with this too as unsigned decimals for -1 in both 32 bit and 64
bit are not hard to spot.

Selva

--000000000000dc17ac05f44bda69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">CC: list<br><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">---------- Forwarded message ---------<br>From: <str=
ong class=3D"gmail_sendername" dir=3D"auto">Selva Nair</strong> <span dir=
=3D"auto">&lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...<=
/a>&gt;</span><br>Date: Tue, Feb 7, 2023 at 11:57 AM<br>Subject: Re: [Openv=
pn-devel] [PATCH v2 3/5] Windows: fix wrong printf format in x_check_status=
<br>To: Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641...">frank@...493...=
2641...</a>&gt;<br></div><br><br><div dir=3D"ltr"><div class=3D"gmail_quote=
"><div>Nitpicking:</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">=C2=A0- use PRIuPTR as discussed on IRC (added relevant def=
ines to<br>
=C2=A0 =C2=A0commit message)<br></blockquote><div><br></div><div>The most i=
nteresting value to log for SOCKET on Windows is=C2=A0 INVALID_SOCKET =3D ~=
0 (i.e, -1). It will print with PRIuPTR as=C2=A0<span style=3D"color:rgb(77=
,81,86);font-family:arial,sans-serif;font-size:14px">18446744073709551615. =
PRIdPTR which will give -1 or PRIxPTR (ffff....ffff) may be better in this =
case? Though socket is a handle on Windows, I think it never gets too large=
 to be -ve except for this special value.</span></div><div><br></div><div>I=
&#39;m fine with this too as unsigned decimals for -1 in both 32 bit and 64=
 bit are not hard to spot.</div><div><br></div><div>Selva</div></div></div>
</div></div>

--000000000000dc17ac05f44bda69--

