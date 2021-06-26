MIME-Version: 1.0
References: <CAFHpkQEoWAMOzBP9Ra1ygp-8HpRxhB3kmQEvZYuRrBqrYV05qw@...278...>
In-Reply-To: <CAFHpkQEoWAMOzBP9Ra1ygp-8HpRxhB3kmQEvZYuRrBqrYV05qw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 26 Jun 2021 12:37:44 +0500
Message-ID: <CAFHpkQEOCAu9BvwJpN-DhiJPa+F5v7NrJM_aYtRZX0GgoXhdGQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000b99b0405c5a6553f"
Subject: Re: [Openvpn-devel] is this expected when using "--dev null" ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b99b0405c5a6553f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried 2.4.7:

Sat Jun 26 07:36:39 2021 /sbin/ip link set dev null up mtu 1500
Cannot find device "null"
Sat Jun 26 07:36:39 2021 Linux ip link set failed: external program exited
with error status: 1


=D1=81=D0=B1, 26 =D0=B8=D1=8E=D0=BD. 2021 =D0=B3. =D0=B2 12:34, =D0=98=D0=
=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...1665...=
77...>:

> Hello,
>
> I'm using "null" for testing (to avoid modifiyng routes and interfaces).
> current master tells me
>
> 2021-06-26 07:27:03 net_iface_mtu_set: rtnl: cannot get ifindex for null:
> No such device (errno=3D19)
> 2021-06-26 07:27:03 Linux can't set mtu (1500) on null
> 2021-06-26 07:27:03 Exiting due to fatal error
>
>
> is this considered as a feature or bug ?
>
>
>
> cheers,
> Ilya
>
>

--000000000000b99b0405c5a6553f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I tried 2.4.7:<div><br></div><div><div>Sa=
t Jun 26 07:36:39 2021 /sbin/ip link set dev null up mtu 1500</div><div>Can=
not find device &quot;null&quot;</div><div>Sat Jun 26 07:36:39 2021 Linux i=
p link set failed: external program exited with error status: 1</div></div>=
<div><br></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">=D1=81=D0=B1, 26 =D0=B8=D1=8E=D0=BD. 2021 =D0=B3. =D0=
=B2 12:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=
=BD &lt;<a href=3D"mailto:chipitsine@...277...">chipitsine@...277...</a>&gt=
;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div dir=3D"ltr">Hello,<div><br></div><div>I&#39;m using &quot;null&quo=
t; for testing (to avoid modifiyng=C2=A0routes and interfaces). current mas=
ter tells me</div><div>=C2=A0</div><div><div>2021-06-26 07:27:03 net_iface_=
mtu_set: rtnl: cannot get ifindex for null: No such device (errno=3D19)</di=
v><div>2021-06-26 07:27:03 Linux can&#39;t set mtu (1500) on null</div><div=
>2021-06-26 07:27:03 Exiting due to fatal error</div></div><div><br></div><=
div><br></div><div>is this considered as a feature or bug ?</div><div><br><=
/div><div><br></div><div><br></div><div>cheers,</div><div>Ilya</div><div><b=
r></div></div></div>
</blockquote></div>

--000000000000b99b0405c5a6553f--

