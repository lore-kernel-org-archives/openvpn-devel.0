MIME-Version: 1.0
References: <20230323143140.76949-1-frank@...2641...>
 <CAKuzo_i+EEaThhmtOHjJGwprtnRgQGxDSNMpeJ+aHHH1FPGNOw@...278...>
 <ZCFYsIhSsTdQDDk8@...2685...>
In-Reply-To: <ZCFYsIhSsTdQDDk8@...2685...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 27 Mar 2023 07:44:50 -0400
Message-ID: <CAKuzo_hK0wjsvqttP1v7gKty6pk99jFTjB222tWZ33ROj-GAuQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000035cc0105f7e04611"
Subject: Re: [Openvpn-devel] [PATCH] unit_tests: make cert_data.h compile
 with MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000035cc0105f7e04611
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 4:49=E2=80=AFAM Frank Lichtenheld <frank@...2641...>
wrote:

> On Fri, Mar 24, 2023 at 01:13:22PM -0400, Selva Nair wrote:
> > Would the attached small patch be acceptable instead? It covers only
> > test_cryptoapi --- if this will do, I can incorporate similar changes f=
or
> > test_pkcs11 into a v2 of the relevant patch as those have not been
> > ACK-ed yet.
>
> Actually, I acked that whole series. However there was a problem with
> my mail configuration on that day and so Gmail rejected them. They
> are on the list however.


> But feel free to integrate this and I can re-ack the patch.
>

In that case I'll send this as a single patch covering both cryptoapi and
pkcs11 tests.

Thanks,

Selva

--00000000000035cc0105f7e04611
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 27, 2023 at 4:49=E2=80=AF=
AM Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641...">frank@...2724...=
..</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Fri, Mar 24, 2023 at 01:13:22PM -0400, Selva Nair wrote:<br>
&gt; Would the attached small patch be acceptable instead? It covers only<b=
r>
&gt; test_cryptoapi --- if this will do, I can incorporate similar changes =
for<br>
&gt; test_pkcs11 into a v2 of the relevant patch as those have not been<br>
&gt; ACK-ed yet.<br>
<br>
Actually, I acked that whole series. However there was a problem with<br>
my mail configuration on that day and so Gmail rejected them. They<br>
are on the list however.=C2=A0</blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
But feel free to integrate this and I can re-ack the patch.<br></blockquote=
><div><br></div><div>In that case I&#39;ll send this as a single patch cove=
ring both cryptoapi and</div><div>pkcs11 tests.=C2=A0</div><div><br></div><=
div>Thanks,</div><div><br></div><div>Selva</div></div></div>

--00000000000035cc0105f7e04611--

