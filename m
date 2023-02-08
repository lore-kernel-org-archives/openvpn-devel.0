MIME-Version: 1.0
References: <20230208001819.244694-1-arne@...1227...>
 <20230208001819.244694-2-arne@...1227...>
In-Reply-To: <20230208001819.244694-2-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Feb 2023 19:40:00 -0500
Message-ID: <CAKuzo_gqTixNXNbTG+PfYOm2i7WcUtzKZjbL4vTQvh_x_5gCRw@...278...>
Content-Type: multipart/alternative; boundary="0000000000000db88905f4258278"
Subject: Re: [Openvpn-devel] [PATCH 1/5] Conditionally add subdir-objects
 option to automake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000000db88905f4258278
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 7, 2023 at 7:18 PM Arne Schwabe <arne@...1227...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> - Eliminates repeated warnings such as
>   warning: source file '$(openvpn_srcdir)/env_set.c' is in a subdirectory,
>   but option 'subdir-objects' is disabled
> - Enabled only for automake >= 1.16 as older versions have a buggy
> implementation
>   of this option
>
> Main side effect of this option is that object files like
> openvpnserv-blockdns.o
> are now created in src/openvpn where block-dns.c resides instead of in
> src/openvpnserv. Same for object files for sources from $(openvpn_srcdir)
> compiled
> into test executables.
>
> See also past discussion on this topic:
>
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg00013.html
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> Signed-off-by: Arne Schwabe <arne@...1227...>
>

I'm a bit confused here -- it seems you have made some edits to my patch
(signed-off), but not clear what has changed.

As for my original 3/3, I will add your fix for engine-test and submit as
v3 -- thanks for working on this.

I've no idea why libtool adds that wrong line break in its wrapper script
on OSX.

Selva

--0000000000000db88905f4258278
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 7, 2023 at 7:18 PM Arne S=
chwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Selva Na=
ir &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair=
@...277...</a>&gt;<br>
<br>
- Eliminates repeated warnings such as<br>
=C2=A0 warning: source file &#39;$(openvpn_srcdir)/env_set.c&#39; is in a s=
ubdirectory,<br>
=C2=A0 but option &#39;subdir-objects&#39; is disabled<br>
- Enabled only for automake &gt;=3D 1.16 as older versions have a buggy imp=
lementation<br>
=C2=A0 of this option<br>
<br>
Main side effect of this option is that object files like openvpnserv-block=
dns.o<br>
are now created in src/openvpn where block-dns.c resides instead of in<br>
src/openvpnserv. Same for object files for sources from $(openvpn_srcdir) c=
ompiled<br>
into test executables.<br>
<br>
See also past discussion on this topic:<br>
=C2=A0 <a href=3D"https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg00013.html" rel=3D"noreferrer" target=3D"_blank">https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg00013.html</a><br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a>&gt;<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br></blockquote><div><br></div><div>I&#=
39;m a bit confused here -- it seems you have made some edits to my patch (=
signed-off), but not clear what has changed.</div><div><br></div><div>As fo=
r my original 3/3, I will add your fix for engine-test and submit as v3 -- =
thanks for working=C2=A0on this.=C2=A0</div><div><br></div><div>I&#39;ve no=
 idea why libtool adds that wrong line break in its wrapper script on OSX.<=
/div><div><br></div><div>Selva</div></div></div>

--0000000000000db88905f4258278--

