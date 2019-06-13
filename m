MIME-Version: 1.0
References: <CAGyAFMWpLKixwrmOqLy-OZ86h-zXwgPMyJQ3HqV8O3GQRGE1UA@...278...>
 <193E6898-A1C8-4319-8847-866E3CEB3E97@...2293...>
 <CAKuzo_ihkXkr_-2+VQ5bSaoi-MrEM+u051_WNoMtdhVdubOhAw@...278...>
 <20190612052402.GL1097@...1296...>
 <CAGyAFMX9ZxkArOT+A9f14cHYE37vwEiuTGBvgmvXPe6xy=bA9Q@...278...>
 <CAGyAFMVqsD1Jqwebu5haknoFCi6s3ju8769tCu5no+5H9uaeHg@...278...>
In-Reply-To: <CAGyAFMVqsD1Jqwebu5haknoFCi6s3ju8769tCu5no+5H9uaeHg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 13 Jun 2019 14:39:36 +0300
Message-ID: <CAGyAFMU-u3KHETH9YS8Ouv4iP32qW-Xd9_AeWXob2B3gc8ZKYA@...278...>
Content-Type: multipart/alternative; boundary="000000000000bf9751058b32fc0c"
Subject: Re: [Openvpn-devel] Preliminary Wintun support in OpenVPN2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000bf9751058b32fc0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the record - it seems that TransmitPackets is a Windows equivalent of
sendmmsg which sends each passed buffer in its own UDP datagram,

I have created a test project to understand better how it works,
https://github.com/lstipakov/TransmitPackets/blob/master/TransmitPackets.cp=
p ,
will try at some point with OpenVPN.



ke 12. kes=C3=A4k. 2019 klo 19.43 Lev Stipakov (lstipakov@...277...) kirjoi=
tti:

>
> WSASend / WSASendTo methods, which we use to write to link on Windows,
>> already support multiple buffers (but we do not use that feature):
>>
>
> Argh, turns out that WSASend combines multiple buffers (openvpn packets)
> into single UDP packet,
> which doesn't work for openvpn - we expect UDP packet to contain single
> openvpn packet.
>
> --
> -Lev
>


--=20
-Lev

--000000000000bf9751058b32fc0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">For the record - it seems that TransmitPackets is a Window=
s equivalent of sendmmsg which sends each passed buffer in its own UDP data=
gram,<div><br></div><div>I have created a test project to understand better=
 how it works,=C2=A0

<a href=3D"https://github.com/lstipakov/TransmitPackets/blob/master/Transmi=
tPackets.cpp">https://github.com/lstipakov/TransmitPackets/blob/master/Tran=
smitPackets.cpp</a>=C2=A0, will try at some point with OpenVPN.=C2=A0<br><d=
iv><br></div><div><br></div></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">ke 12. kes=C3=A4k. 2019 klo 19.43 Lev Sti=
pakov (<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>) kirj=
oitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_=
quote"><div>WSASend / WSASendTo methods, which we use to write to link on W=
indows,</div><div>already support multiple buffers (but we do not use that =
feature):</div></div></div></blockquote><div><br></div><div>Argh, turns out=
 that WSASend combines multiple buffers (openvpn packets) into single UDP p=
acket,</div><div>which doesn&#39;t work for openvpn - we expect UDP packet =
to contain single openvpn packet.</div></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail-m_6600182085144398004gmail_signature">-Lev</div></d=
iv>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000bf9751058b32fc0c--

