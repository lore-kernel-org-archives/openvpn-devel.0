MIME-Version: 1.0
In-Reply-To: <CAEsd45Q9S_V137M5Db5jNT2ZFGju8XKMAUYqBeDYifjC5y=-MQ@...278...>
References: <CAEsd45Q9S_V137M5Db5jNT2ZFGju8XKMAUYqBeDYifjC5y=-MQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 12 Dec 2015 17:43:15 -0500
Message-ID: <CAKuzo_it8Y25Z0Bw4i-X+FiY80K2cT9X5Q7oQ4wxN-Ds_SPAOA@...278...>
Content-Type: multipart/alternative; boundary=001a1145b958916f160526bb2b34
Subject: Re: [Openvpn-devel] Options that are "safe" for users to modify?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1145b958916f160526bb2b34
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat, Dec 12, 2015 at 4:47 PM, Jonathan K. Bullard <jkbullard@...277...>
wrote:

>
> My tentative plan is to allow users to update without authorization
> any files that are the "targets" of the following options:
>

I suppose, not just adding but also removing options will be allowed. There
could be more options that are ok (i.e not unsafe) to remove but not change.


> --askpass
> --auth-user-pass
> --ca
> --cert
> --dh
> --extra-certs
> --key
> --pkcs1
> --static
> --ta
> --tls-auth


--ta ?

As remote cant change, several more options may be safe, though note
necessarily very useful. Here are a couple of options that could help when
the server is updated, for example

--topology  t  (mainly to remove from client so that a new setting at the
server can take effect through push -- say moving from net30 to subnet)
--comp-lzo
--secret  (for non-tls)
--auth
--cipher

Selva

--001a1145b958916f160526bb2b34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sat, Dec 12, 2015 at 4:47 PM, Jo=
nathan K. Bullard <span dir=3D"ltr">&lt;<a href=3D"mailto:jkbullard@...1354...=
.." target=3D"_blank">jkbullard@...277...</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><br>
My tentative plan is to allow users to update without authorization<br>
any files that are the &quot;targets&quot; of the following options:<br></b=
lockquote><div><br>I suppose, not just adding but also removing options wil=
l be allowed. There could be more options that are ok (i.e not unsafe) to r=
emove but not change.<br><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
--askpass<br>
--auth-user-pass<br>
--ca<br>
--cert<br>
--dh<br>
--extra-certs<br>
--key<br>
--pkcs1<br>
--static<br>
--ta<br>
--tls-auth</blockquote></div><br></div><div class=3D"gmail_extra">--ta ? <b=
r></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">As =
remote cant change, several more options may be safe, though note necessari=
ly very useful. Here are a couple of options that could help when the serve=
r is updated, for example<br><br></div><div class=3D"gmail_extra">--topolog=
y=C2=A0 t=C2=A0 (mainly to remove from client so that a new setting at the =
server can take effect through push -- say moving from net30 to subnet)<br>=
</div><div class=3D"gmail_extra">--comp-lzo <br></div><div class=3D"gmail_e=
xtra">--secret=C2=A0 (for non-tls)<br></div><div class=3D"gmail_extra">--au=
th<br></div><div class=3D"gmail_extra">--cipher<br><br></div><div class=3D"=
gmail_extra">Selva<br></div></div>

--001a1145b958916f160526bb2b34--

