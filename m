MIME-Version: 1.0
References: <99203e85-fc9e-906e-61e2-0ab250371f1f@...2663...>
 <CAKuzo_ioneE7-WX68GNgVE_dSK1LqoxtEOZwyoafEb7596-s+g@...278...>
 <YipsQB6QHjkjC4/I@...1296...>
 <CAKuzo_g3x6PDMeiDvxM303XdVLpF68xfw6AcEWgBKk6sw1ighQ@...278...>
 <eaeb2183-ad8f-b047-51a2-22a7f188ad9e@...2663...>
In-Reply-To: <eaeb2183-ad8f-b047-51a2-22a7f188ad9e@...2663...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 11 Mar 2022 08:50:43 -0500
Message-ID: <CAKuzo_jroHsu6B3zWawgHP_XObD9mfXyGnZBkGhinwr=1m0qTA@...278...>
Content-Type: multipart/alternative; boundary="000000000000db1e1a05d9f19ee2"
Subject: Re: [Openvpn-devel] OpenVPN Client 2FA problem with Backslash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jakob Curdes <jc@...2663...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000db1e1a05d9f19ee2
Content-Type: text/plain; charset="UTF-8"

Hi Jacob,

On Fri, Mar 11, 2022 at 3:52 AM Jakob Curdes <jc@...2663...> wrote:

> Hello Selva, hello all,
>
> I have tested the executable in the circumstances described earlier. I
> confirm the problem described (username/password auth succeeds, but second
> auth with 2FA data fails as the backslash in the username is not escaped
> this time) is solved using the binary provided. I also confirmed this in
> issue #483  .
>
> Thank you all for your quick work. This will help us rolling out 2FA to a
> bunch of users!
>
Thanks for testing.

Selva

>

--000000000000db1e1a05d9f19ee2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Jacob,</div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 11, 2022 at 3:52 AM =
Jakob Curdes &lt;<a href=3D"mailto:jc@...2663..." target=3D"_blank">jc@...1665...=
663...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
=20=20
=20=20=20=20
=20=20
  <div>
    <p>Hello Selva, hello all,<br></p>
    <p>I have tested the executable in the circumstances described
      earlier. I confirm the problem described (username/password auth
      succeeds, but second auth with 2FA data fails as the backslash in
      the username is not escaped this time) is solved using the binary
      provided. I also confirmed this in issue #483=C2=A0 . <br>
    </p>
    <p>Thank you all for your quick work. This will help us rolling out
      2FA to a bunch of users!</p></div></blockquote><div>Thanks for testin=
g.</div><div><br></div><div>Selva</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div>
    <div></div>
  </div>

</blockquote></div></div>

--000000000000db1e1a05d9f19ee2--

