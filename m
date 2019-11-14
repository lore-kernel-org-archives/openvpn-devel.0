MIME-Version: 1.0
References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
 <CAFHpkQF+5iwq-J60RwdDj2PhD4GEjJsxLZ2SfZ5qKrERVVfQOg@...278...>
In-Reply-To: <CAFHpkQF+5iwq-J60RwdDj2PhD4GEjJsxLZ2SfZ5qKrERVVfQOg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 14 Nov 2019 17:32:34 -0500
Message-ID: <CAKuzo_iMJ-0gPyq0EEqKPvzTs=o6OJPbYgk1GwL03HCUCXj5NA@...278...>
Content-Type: multipart/alternative; boundary="000000000000ca3a850597560f72"
Subject: Re: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ca3a850597560f72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 14, 2019 at 3:16 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> Thank you for your efforts.
> As you are touching this, can you try "dist: bionic" ? It might bring
> newer compilers
>

I don't expect newer compilers on bionic break this patch. But fwiw, I've
started a travis build with dist: bionic. For results see
https://travis-ci.org/selvanair/openvpn/jobs/612099524

Selva

--000000000000ca3a850597560f72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Nov 14, 2019 at 3:16 PM =D0=98=D0=BB=
=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mail=
to:chipitsine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
auto">Thank you for your efforts.<div dir=3D"auto">As you are touching this=
, can you try &quot;dist: bionic&quot; ? It might bring newer compilers</di=
v></div></blockquote><div><br></div><div>I don&#39;t expect newer compilers=
 on bionic break this patch. But fwiw, I&#39;ve started a travis build with=
 dist: bionic. For results see <a href=3D"https://travis-ci.org/selvanair/o=
penvpn/jobs/612099524" target=3D"_blank">https://travis-ci.org/selvanair/op=
envpn/jobs/612099524<br></a></div><div><br></div><div>Selva<br></div></div>=
</div>

--000000000000ca3a850597560f72--

