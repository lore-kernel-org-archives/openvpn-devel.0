MIME-Version: 1.0
References: <Z36ERnxqcn21Mxkb@...2685...>
In-Reply-To: <Z36ERnxqcn21Mxkb@...2685...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Jan 2025 15:52:12 -0500
Message-ID: <CAKuzo_h7E_xk9bXJsXu1X179pu0f+NOzbUWo=fLtUjpZKPeQ9A@...278...>
Content-Type: multipart/alternative; boundary="000000000000237c04062b380a4e"
Subject: Re: [Openvpn-devel] RFC: tchar removal patch series
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net, Heiko Hund <heiko@...2662...>, Lev Stipakov <lev@...515...>

--000000000000237c04062b380a4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I think the use of tchar is outdated and I'm all for purging it.

best,

Selva

On Wed, Jan 8, 2025 at 8:57=E2=80=AFAM Frank Lichtenheld <frank@...2641...>
wrote:

> Hi.
>
> Today I submitted a patch series that removes all usages of
> tchar.h from the OpenVPN 2 code base. You can see the full
> series here: https://gerrit.openvpn.net/q/topic:%22tchar-removal%22
>
> This series came about when I looked into the Windows code
> for a potential clang-format reformat and for reviewing
> Heiko's DNS series. I learned about TEXT() and about how it
> is basically useless in our case (since we never build
> non-unicode builds anymore). I came to the conclusion that
> this is somewhat inconsistently used, useless clutter, and
> potential source for confusion.
>
> So I propose to remove the use of tchar.h and and associated
> functions and just use wchar directly. The actual conversion
> step is fully automated. See
> https://gerrit.openvpn.net/c/openvpn/+/852 for the script.
> So it can easily be rebased on any ongoing Windows work.
>
> Let me know what you guys think about it. CCing our Windows
> experts.
>
> Regards,
> --
>   Frank Lichtenheld
>

--000000000000237c04062b380a4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I think the use of tchar is outdate=
d and I&#39;m all for purging it.</div><div><br></div><div>best,</div><div>=
<br></div><div>Selva</div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Wed, Jan 8, 2025 at 8:57=E2=80=AFAM Frank Lich=
tenheld &lt;<a href=3D"mailto:frank@...2641..." target=3D"_blank">frank@...493...=
2641...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hi.<br>
<br>
Today I submitted a patch series that removes all usages of<br>
tchar.h from the OpenVPN 2 code base. You can see the full<br>
series here: <a href=3D"https://gerrit.openvpn.net/q/topic:%22tchar-removal=
%22" rel=3D"noreferrer" target=3D"_blank">https://gerrit.openvpn.net/q/topi=
c:%22tchar-removal%22</a><br>
<br>
This series came about when I looked into the Windows code<br>
for a potential clang-format reformat and for reviewing<br>
Heiko&#39;s DNS series. I learned about TEXT() and about how it<br>
is basically useless in our case (since we never build<br>
non-unicode builds anymore). I came to the conclusion that<br>
this is somewhat inconsistently used, useless clutter, and<br>
potential source for confusion.<br>
<br>
So I propose to remove the use of tchar.h and and associated<br>
functions and just use wchar directly. The actual conversion<br>
step is fully automated. See<br>
<a href=3D"https://gerrit.openvpn.net/c/openvpn/+/852" rel=3D"noreferrer" t=
arget=3D"_blank">https://gerrit.openvpn.net/c/openvpn/+/852</a> for the scr=
ipt.<br>
So it can easily be rebased on any ongoing Windows work.<br>
<br>
Let me know what you guys think about it. CCing our Windows<br>
experts.<br>
<br>
Regards,<br>
-- <br>
=C2=A0 Frank Lichtenheld<br>
</blockquote></div>

--000000000000237c04062b380a4e--

