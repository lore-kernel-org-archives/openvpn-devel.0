MIME-Version: 1.0
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
In-Reply-To: <E1iaLck-0000Aj-5c@...2508...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 28 Nov 2019 11:56:34 -0500
Message-ID: <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
Content-Type: multipart/alternative; boundary="00000000000000526705986b009a"
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000000526705986b009a
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Nov 28, 2019 at 10:23 AM Steffan Karger <
steffan.karger@...2507...> wrote:

> On 28-11-2019 09:06, Lev Stipakov wrote:
> > A struct with subobjects should be initialized
> > with double braces.
>
> This is not true. {0} is a valid initializer for structs in C. Both
> clang and gcc used to have a bug where they incorrectly warned about
> this. GCC fixed this a while ago[0]. I thought clang had fixed it too
> recently, but apparently not?
>

Pretty much same as my thoughts.

I think the correct fix here is to remove -Werror from travis build.
I have tried and failed to lobby for this earlier, but one more try
can't hurt, I suppose :)

That said, it seems clang has fixed this some time after clang-7.
I don't get this warning anymore after upgrading to clang-9.

Selva

--00000000000000526705986b009a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Nov 28, 2019 at 10:23 AM Steffan Karg=
er &lt;<a href=3D"mailto:steffan.karger@...2507..." target=3D"_blank">steff=
an.karger@...2507...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On 28-11-2019 09:06, Lev Stipakov wrote:<br>
&gt; A struct with subobjects should be initialized<br>
&gt; with double braces.<br>
<br>
This is not true. {0} is a valid initializer for structs in C. Both<br>
clang and gcc used to have a bug where they incorrectly warned about<br>
this. GCC fixed this a while ago[0]. I thought clang had fixed it too<br>
recently, but apparently not?<br></blockquote></div><div class=3D"gmail_quo=
te"><br></div><div class=3D"gmail_quote">Pretty much same as my thoughts.<b=
r></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><di=
v>I think the correct fix here is to remove -Werror from travis build.</div=
><div>I have tried and failed to lobby for this earlier, but one more try</=
div><div>can&#39;t hurt, I suppose :)</div><div><br></div><div>That said, i=
t seems clang has fixed this some time after clang-7.</div><div>I don&#39;t=
 get this warning anymore after upgrading to clang-9.<br></div><div><br></d=
iv><div>Selva<br></div></div></div>

--00000000000000526705986b009a--

