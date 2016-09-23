MIME-Version: 1.0
In-Reply-To: <CAFHpkQHCqHSDe6ujC1ZEi5bvD_qQL-ng7JmkuYP_vWvByO-6ww@...278...>
References: <CAFHpkQHCqHSDe6ujC1ZEi5bvD_qQL-ng7JmkuYP_vWvByO-6ww@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 23 Sep 2016 10:47:26 -0400
Message-ID: <CAKuzo_j3VQktbmkhnQbTee5oUNR48KjWXqd7SZfWBMgpdMOdsA@...278...>
Content-Type: multipart/alternative; boundary=001a114c8960901d8f053d2ddc7e
Subject: Re: [Openvpn-devel] extended error messages ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114c8960901d8f053d2ddc7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 10:14 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

>
> login/password are correct, but ...
>
> 1) password is expired
> 2) acount is disabled
> 3) access is not permitted



If you use management-client-auth on the server side, you can return a
reason for failure. Dynamic challenege works that way by returning a
specially formatted reason with challenge so that the client can display
the message and prompt if a response is required.

Selva

--001a114c8960901d8f053d2ddc7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Sep 23, 2016 at 10:14 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipits=
ine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div><div><div><div><br></div>login/pass=
word are correct, but ...<br><br></div>1) password is expired<br></div>2) a=
count is disabled<br></div>3) access is not permitted</blockquote></div><br=
><br></div><div class=3D"gmail_extra">If you use management-client-auth on =
the server side, you can return a reason for failure. Dynamic challenege wo=
rks that way by returning a specially formatted reason with challenge so th=
at the client can display the message and prompt if a response is required.=
<br><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--001a114c8960901d8f053d2ddc7e--

