MIME-Version: 1.0
References: <tencent_634348984485969552F3189D5284B3FD7C08@...1414...>
 <CAAUX2SVnf4dr8FNsgNXbFiRMK1VWQQJWE-JUmDPs4VgzcPsDaA@...278...>
 <fdf4b3e6-6130-04c4-7f4e-7f249d5db3ea@...1227...>
In-Reply-To: <fdf4b3e6-6130-04c4-7f4e-7f249d5db3ea@...1227...>
From: Tony He <huangya90@...277...>
Date: Tue, 1 Dec 2020 09:50:01 +0800
Message-ID: <CAAUX2SVMaOXeKrkck4CUXVdMdtP5WBGS0rvfzQm9s5NFYECXqA@...278...>
Content-Type: multipart/alternative; boundary="000000000000fcd95d05b55d58f1"
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Antonio Quartulli <a@...2181...>, lev@...515..., openvpn-devel@lists.sourceforge.net

--000000000000fcd95d05b55d58f1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arne,

openssl speed -evp aes-128-cbc
type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-cbc
20035.60k 123261.54k 267081.60k 1094764.09k 9181370.18k
openssl speed -evp aes-128-gcm
type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-gcm
18738.76k 19284.91k 19524.44k 19606.87k 19685.46k
openssl speed -evp aes-128-ccm
type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes aes-128-ccm
53859.07k 215581.12k 862070.02k 3460786.43k 27566347.61k
openssl speed -evp sha1
type 16 bytes 64 bytes 256 bytes 1024 bytes 8192 bytes sha1 3108.57k
12177.79k 57325.18k 181610.34k 1207364.27k
openssl speed -evp chacha20-poly1305
chacha20-poly1305 is an unknown cipher or digest
Using old openssl, so chacha20-poly1305 is not supported.

Tony

Arne Schwabe <arne@...1227...> =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:40=E5=86=99=E9=81=93=EF=BC=9A

> Am 26.11.20 um 10:41 schrieb Tony He:
> > Hi Arne,
> >
> >>Since the original thread was not on the mailing list I am missing your
> >>goal but if your crypto acelator already works with OpenSSL, then it
> >>will also work with the "normal" OpenVPN
> >
> > Yes, it wokrs with "normal" OpenVPN(OpenVPN2), but according to the test
> > result, it's still not fast(about 60Mbps).
> > The bottleneck is not encryption operation any more. It comes from the
> > switch of user space and kernel space in the OpenVPN2,
> > which makes the poor CPU of  embedded device very busy. That's why we
> > need OpenVPN3 running in the kernel space.
>
>
> What numbers are we are talking in crypto speed? Could you provide from
> your "poor" device:
>
>
> openssl speed -evp aes-128-cbc
> openssl speed -evp aes-128-gcm
> openssl speed -evp aes-128-ccm
> openssl speed -evp sha1
> openssl speed -evp chacha20-poly1305
>
> I want to what difference/gain in terms of raw crypto speed we are
> talking here.
>
> Arne
>
>
>

--000000000000fcd95d05b55d58f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arne,<div><br></div><div>openssl speed -evp aes-128-cbc=
</div><div><div style=3D"white-space:pre-wrap">          type             1=
6 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
aes-128-cbc      20035.60k   123261.54k   267081.60k  1094764.09k  9181370.=
18k
              </div>openssl speed -evp aes-128-gcm</div><div><div style=3D"=
white-space:pre-wrap">                type             16 bytes     64 byte=
s    256 bytes   1024 bytes   8192 bytes
aes-128-gcm      18738.76k    19284.91k    19524.44k    19606.87k    19685.=
46k
              </div>openssl speed -evp aes-128-ccm</div><div><div style=3D"=
white-space:pre-wrap">                type             16 bytes     64 byte=
s    256 bytes   1024 bytes   8192 bytes
aes-128-ccm      53859.07k   215581.12k   862070.02k  3460786.43k 27566347.=
61k
              </div>openssl speed -evp sha1</div><div><div style=3D"white-s=
pace:pre-wrap">   type             16 bytes     64 bytes    256 bytes   102=
4 bytes   8192 bytes
sha1              3108.57k    12177.79k    57325.18k   181610.34k  1207364.=
27k
              </div>openssl speed -evp chacha20-poly1305<br></div><div><div=
 style=3D"white-space:pre-wrap">chacha20-poly1305 is an unknown cipher or d=
igest</div><div style=3D"white-space:pre-wrap">Using old openssl, so chacha=
20-poly1305 is not supported.</div><div style=3D"white-space:pre-wrap"><br>=
</div><div style=3D"white-space:pre-wrap">Tony</div><div style=3D"white-spa=
ce:pre-wrap">              </div></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">Arne Schwabe &lt;<a href=3D"mailto:a=
rne@...1227...">arne@...1227...</a>&gt; =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:40=E5=86=99=E9=81=93=EF=BC=
=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 26.11.20 =
um 10:41 schrieb Tony He:<br>
&gt; Hi Arne,<br>
&gt; <br>
&gt;&gt;Since the original thread was not on the mailing list I am missing =
your<br>
&gt;&gt;goal but if your crypto acelator already works with OpenSSL, then i=
t<br>
&gt;&gt;will also work with the &quot;normal&quot; OpenVPN<br>
&gt; <br>
&gt; Yes, it wokrs with &quot;normal&quot; OpenVPN(OpenVPN2), but according=
 to the test<br>
&gt; result, it&#39;s still not fast(about 60Mbps).<br>
&gt; The bottleneck is not encryption operation any more. It comes from the=
<br>
&gt; switch of user space and kernel space in the OpenVPN2,<br>
&gt; which makes the poor CPU of=C2=A0 embedded device=C2=A0very busy.=C2=
=A0That&#39;s why we<br>
&gt; need OpenVPN3 running in the kernel space.<br>
<br>
<br>
What numbers are we are talking in crypto speed? Could you provide from<br>
your &quot;poor&quot; device:<br>
<br>
<br>
openssl speed -evp aes-128-cbc<br>
openssl speed -evp aes-128-gcm<br>
openssl speed -evp aes-128-ccm<br>
openssl speed -evp sha1<br>
openssl speed -evp chacha20-poly1305<br>
<br>
I want to what difference/gain in terms of raw crypto speed we are<br>
talking here.<br>
<br>
Arne<br>
<br>
<br>
</blockquote></div>

--000000000000fcd95d05b55d58f1--

