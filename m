MIME-Version: 1.0
References: <CAGyAFMX0MMWHC3GTpfoP1VOvvenNkzdrpZj_5N5RMNa8LphGYw@...278...>
 <20200213135047.9020-1-arne@...1227...>
In-Reply-To: <20200213135047.9020-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 14 Feb 2020 14:23:55 +0200
Message-ID: <CAGyAFMWK6cHc-eiigxrp8cVj4Vyz5NN-59MOOr-zGr_s9-16Gw@...278...>
Content-Type: multipart/alternative; boundary="0000000000002f0775059e884878"
Subject: Re: [Openvpn-devel] [PATCH v2 2/5] Implement dynamic NCP negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002f0775059e884878
Content-Type: text/plain; charset="UTF-8"

Hi,

to 13. helmik. 2020 klo 15.51 Arne Schwabe (arne@...1227...) kirjoitti:
>
> Our current NCP version is flawed in the way that it can only indicate
support for

Built and tested on Ubuntu 18 and MSVC. Works as advertised.

Out of curiosity - you picked strsep because strtok which we have used so
far
relies on evil global state?

Acked-by: Lev Stipakov <lstipakov@...277...>

--0000000000002f0775059e884878
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>to 13. helmik. 2020 klo 15.51 Arne Schwabe (<a =
href=3D"mailto:arne@...1227...">arne@...1227...</a>) kirjoitti:<br>&gt;<br>=
&gt; Our current NCP version is flawed in the way that it can only indicate=
 support for<br><br>Built and tested on Ubuntu 18 and MSVC. Works as advert=
ised.<br><div><br></div><div>Out of curiosity - you picked strsep because s=
trtok which we have used so far</div><div>relies on evil global state?</div=
><div><br></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov=
@...277...">lstipakov@...277...</a>&gt;</div></div>

--0000000000002f0775059e884878--

