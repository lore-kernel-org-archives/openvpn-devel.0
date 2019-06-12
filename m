MIME-Version: 1.0
References: <CAGyAFMWpLKixwrmOqLy-OZ86h-zXwgPMyJQ3HqV8O3GQRGE1UA@...278...>
 <193E6898-A1C8-4319-8847-866E3CEB3E97@...2293...>
 <CAKuzo_ihkXkr_-2+VQ5bSaoi-MrEM+u051_WNoMtdhVdubOhAw@...278...>
 <20190612052402.GL1097@...1296...>
 <CAGyAFMX9ZxkArOT+A9f14cHYE37vwEiuTGBvgmvXPe6xy=bA9Q@...278...>
In-Reply-To: <CAGyAFMX9ZxkArOT+A9f14cHYE37vwEiuTGBvgmvXPe6xy=bA9Q@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 12 Jun 2019 19:43:22 +0300
Message-ID: <CAGyAFMVqsD1Jqwebu5haknoFCi6s3ju8769tCu5no+5H9uaeHg@...278...>
Content-Type: multipart/alternative; boundary="00000000000040945b058b231dac"
Subject: Re: [Openvpn-devel] Preliminary Wintun support in OpenVPN2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000040945b058b231dac
Content-Type: text/plain; charset="UTF-8"

> WSASend / WSASendTo methods, which we use to write to link on Windows,
> already support multiple buffers (but we do not use that feature):
>

Argh, turns out that WSASend combines multiple buffers (openvpn packets)
into single UDP packet,
which doesn't work for openvpn - we expect UDP packet to contain single
openvpn packet.

-- 
-Lev

--00000000000040945b058b231dac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_quote"><div>WSASend / WSASendTo methods, which we use to write to=
 link on Windows,</div><div>already support multiple buffers (but we do not=
 use that feature):</div></div></div></blockquote><div><br></div><div>Argh,=
 turns out that WSASend combines multiple buffers (openvpn packets) into si=
ngle UDP packet,</div><div>which doesn&#39;t work for openvpn - we expect U=
DP packet to contain single openvpn packet.</div></div><div><br></div>-- <b=
r><div dir=3D"ltr" class=3D"gmail_signature">-Lev</div></div>

--00000000000040945b058b231dac--

