MIME-Version: 1.0
References: <20211015175330.15760-1-selva.nair@...277...>
In-Reply-To: <20211015175330.15760-1-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 15 Oct 2021 14:50:26 -0400
Message-ID: <CAKuzo_h51X2SvZLOy2ZS5wjw8h2qZuQcc9tJN3M85XOXp4A5rg@...278...>
Content-Type: multipart/alternative; boundary="0000000000002116c105ce68acfd"
Subject: Re: [Openvpn-devel] [PATCH] Fix some more wrong defines in
 config-msvc.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002116c105ce68acfd
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 15, 2021 at 1:53 PM <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> Not sure where these came from, but here goes:
>
> S_IRUSR = 0 --> _S_IREAD
> S_IWUSR = 0 --> _S_IWRITE
>
> ENABLE_DEBUG is on, but I do not think we want it in production build.
> Changed to ENABLE_DEBUG 0
>
> S_IRGRP is not defined but seems to be used. I have added it, remove if
> not required.
> This define is based on mingw and matches MS docs on <filesystem>
> (
> https://docs.microsoft.com/en-us/cpp/standard-library/filesystem-enumerations?view=msvc-160
> )
>
> Should fix Trac #1430 but untested (I do not have a setup at hand for msvc
> build).
>

The patch for master doesn't apply cleantly to 2.5. Please use the next one
marked "for 2.5" on the release branch.

Selva

--0000000000002116c105ce68acfd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 15, 2021 at 1:53 PM &lt;<a hr=
ef=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">From: Selva Nair &lt=
;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1664...=
7...</a>&gt;<br>
<br>
Not sure where these came from, but here goes:<br>
<br>
S_IRUSR =3D 0 --&gt; _S_IREAD<br>
S_IWUSR =3D 0 --&gt; _S_IWRITE<br>
<br>
ENABLE_DEBUG is on, but I do not think we want it in production build.<br>
Changed to ENABLE_DEBUG 0<br>
<br>
S_IRGRP is not defined but seems to be used. I have added it, remove if<br>
not required.<br>
This define is based on mingw and matches MS docs on &lt;filesystem&gt;<br>
(<a href=3D"https://docs.microsoft.com/en-us/cpp/standard-library/filesyste=
m-enumerations?view=3Dmsvc-160" rel=3D"noreferrer" target=3D"_blank">https:=
//docs.microsoft.com/en-us/cpp/standard-library/filesystem-enumerations?vie=
w=3Dmsvc-160</a>)<br>
<br>
Should fix Trac #1430 but untested (I do not have a setup at hand for msvc =
build).<br></blockquote><div><br></div><div>The patch for master doesn&#39;=
t apply cleantly to 2.5. Please use the next one marked &quot;for 2.5&quot;=
 on the release branch.<div><br></div><div>Selva</div></div></div></div>

--0000000000002116c105ce68acfd--

