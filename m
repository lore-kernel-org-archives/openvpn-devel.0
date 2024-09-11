MIME-Version: 1.0
References: <20240906103734.36633-1-frank@...2641...>
 <202409082041.488KfLeN094702@...2054...>
 <7e2afe85-6129-4813-b5b3-a4a82f685528@...1227...>
In-Reply-To: <7e2afe85-6129-4813-b5b3-a4a82f685528@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 10 Sep 2024 22:56:25 -0400
Message-ID: <CAKuzo_iBB_oEY2R6oeMNFMmFWqeMazr75x1TpvMWrsgjH7NJSw@...278...>
Content-Type: multipart/alternative; boundary="000000000000bee1330621cf236d"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Interpret --key and --cert
 option argument as URI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--000000000000bee1330621cf236d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 5:48=E2=80=AFPM Arne Schwabe <arne@...1227...> wrot=
e:

>
> >
> > Your patch has been applied to the master branch.
> >
> > commit 3512e8d3ada4fa7d04925a89fd9f3669655c7887 (master)
> > Author: Selva Nair
> > Date:   Fri Sep 6 12:37:34 2024 +0200
> >
> >       Interpret --key and --cert option argument as URI
> >
> There is something wonky going on. On my local macOS build I am getting
> errors with this on master now:
>
> openvpn --cert /Users/arne/ovpn/styx-secp.pem --key
> /Users/arne/ovpn/styx-secp.pem
>
> 2024-09-10 23:25:00 us=3D689075 OpenSSL: error:1608010C:STORE
> routines::unsupported:
> 2024-09-10 23:25:00 us=3D689082 Cannot load certificate from URI
> </Users/arne/ovpn/styx-secp.pem>


>
> styx-secp.pem is a file that contains both cert and key:
>

Such composite PEM files should work both as file name and
URI.

It seems I have overlooked the fact that OPENSSL_STORE_load()
can error out and return NULL and still have more readable objects
present.

I'm working on a patch.

Selva

--000000000000bee1330621cf236d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Sep 10, 2024 at 5:48=E2=80=AFPM Arne Schwa=
be &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<br>
&gt; <br>
&gt; Your patch has been applied to the master branch.<br>
&gt; <br>
&gt; commit 3512e8d3ada4fa7d04925a89fd9f3669655c7887 (master)<br>
&gt; Author: Selva Nair<br>
&gt; Date:=C2=A0 =C2=A0Fri Sep 6 12:37:34 2024 +0200<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Interpret --key and --cert option argument a=
s URI<br>
&gt; <br>
There is something wonky going on. On my local macOS build I am getting <br>
errors with this on master now:<br>
<br>
openvpn --cert /Users/arne/ovpn/styx-secp.pem --key <br>
/Users/arne/ovpn/styx-secp.pem<br>
<br>
2024-09-10 23:25:00 us=3D689075 OpenSSL: error:1608010C:STORE <br>
routines::unsupported:<br>
2024-09-10 23:25:00 us=3D689082 Cannot load certificate from URI <br>
&lt;/Users/arne/ovpn/styx-secp.pem&gt;=C2=A0=C2=A0</blockquote><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
<br>
styx-secp.pem is a file that contains both cert and key:<br></blockquote><d=
iv><br></div><div>Such composite PEM files should work both as file name an=
d</div><div>URI.</div><div><br></div><div>It seems I have overlooked the fa=
ct that OPENSSL_STORE_load()</div><div>can error out and return NULL and st=
ill have more readable objects</div><div>present.</div><div><br></div><div>=
I&#39;m working on a patch.</div><div><br></div><div>Selva</div><div><br></=
div></div></div>

--000000000000bee1330621cf236d--

