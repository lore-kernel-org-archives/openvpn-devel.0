MIME-Version: 1.0
In-Reply-To: <da790cbb-c93d-cd00-0f78-96cf868115f9@...2080...>
References: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
	<CAKuzo_jXCPDbsn24i4LcsqovVXGNaQuc-PtwwucnVDvwpMQgYg@...278...>
	<09fc522c-b33f-1c9b-9def-854ae3c07c62@...2080...>
	<CAKuzo_iC+gmgck4uY69k37tSMe-HAzn0uXJu7LwqxuMXP-Byxg@...278...>
	<da790cbb-c93d-cd00-0f78-96cf868115f9@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Aug 2016 15:40:03 -0400
Message-ID: <CAKuzo_jD7_qZEC+GpqVTxD1QXo5GdxjF5rm9KiupqM61z8=WQw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c06623abc01860539e50d1f
Subject: Re: [Openvpn-devel] autoconf/automake warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c06623abc01860539e50d1f
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 12, 2016 at 2:38 PM, David Sommerseth <
openvpn@...2080...> wrote:

> > I would say ignore the subdir-objects warning for now and we can
> > conditionally enable it when a version of automake that supports
> > it without breaking use of variables in foo_SOURCES becomes widely
> > available. In the mean time keep testing subdir-objects using a
> > patched automake may be all that we can do.
>
> I can live with that for now.  But it would be good to have a solution
> before we get complaints from more bleeding edge distros (Fedora,
> Arch, Ubuntu, openSUSE etc) that 'automake doesn't work any more' due
> to our setup isn't modern enough.


When that happens we add a version check to define subdir_objects =
"subdir-objects" and add that as we do for serial-objects. Its a bit
premature to do that until next version of automake is out.

Selva

--94eb2c06623abc01860539e50d1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Aug 12, 2016 at 2:38 PM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&gt; =
I would say ignore the subdir-objects warning for now and we can<br>
&gt; conditionally enable it when a version of automake that supports<br>
&gt; it without breaking use of variables in foo_SOURCES becomes widely<br>
&gt; available. In the mean time keep testing subdir-objects using a<br>
&gt; patched automake may be all that we can do.<br>
<br>
</span>I can live with that for now.=C2=A0 But it would be good to have a s=
olution<br>
before we get complaints from more bleeding edge distros (Fedora,<br>
Arch, Ubuntu, openSUSE etc) that &#39;automake doesn&#39;t work any more&#3=
9; due<br>
to our setup isn&#39;t modern enough.</blockquote></div><br>When that happe=
ns we add a version check to define subdir_objects =3D &quot;subdir-objects=
&quot; and add that as we do for serial-objects. Its a bit premature to do =
that until next version of automake is out.</div><div class=3D"gmail_extra"=
><br></div><div class=3D"gmail_extra">Selva</div></div>

--94eb2c06623abc01860539e50d1f--

