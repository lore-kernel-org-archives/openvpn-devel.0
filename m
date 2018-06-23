MIME-Version: 1.0
In-Reply-To: <20180623173104.GT57262@...1296...>
References: <201806231209.w5NC9AhF028415@...2054...>
 <20180623121503.4080-1-gert@...1296...>
 <20180623173104.GT57262@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 23 Jun 2018 14:08:19 -0400
Message-ID: <CAKuzo_iE0zU_6+19+V0QSSbU0sBpSYtJU48uLaS_ireoj81n8Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000b587cd056f5309ee"
Subject: Re: [Openvpn-devel] [PATCH] Add %d,
 %u and %lu tests to test_argv unit tests.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b587cd056f5309ee
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, Jun 23, 2018 at 1:31 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sat, Jun 23, 2018 at 02:15:03PM +0200, Gert Doering wrote:
> > Some basic integer tests to verify signed, unsigned and
> > long unsigned (2^33) printing.
>
> Ditch that patch... this only works on 64bit systems.
>

Most 64 bit systems (excluding Windows)


>
> What I wanted to see is "yes, it really does long math", but on systems
> where sizeof(int) = sizeof(long) = 4, this will just not do the right
> thing.
>
> Do we care?
>
> Or shall I just have it print "1", so we know "%lu works and prints its
> argument nicely"?
>

That should be enough, but we could get fancy and use -1L and compare
the result against sprintf(str, "%lu", -1L)

Selva

--000000000000b587cd056f5309ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Sat, Jun 23, 2018 at 1:31 PM, Gert Doering <span dir=3D"ltr">&lt;=
<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Sat, Jun 23, 2018 at 02:15:03PM +0200, Gert Doering wrote:<br>
&gt; Some basic integer tests to verify signed, unsigned and<br>
&gt; long unsigned (2^33) printing.<br>
<br>
</span>Ditch that patch... this only works on 64bit systems.<br></blockquot=
e><div><br></div><div>Most 64 bit systems (excluding Windows)</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
What I wanted to see is &quot;yes, it really does long math&quot;, but on s=
ystems<br>
where sizeof(int) =3D sizeof(long) =3D 4, this will just not do the right<b=
r>
thing.<br>
<br>
Do we care?=C2=A0 <br>
<br>
Or shall I just have it print &quot;1&quot;, so we know &quot;%lu works and=
 prints its <br>
argument nicely&quot;?<br></blockquote><div><br></div><div>That should be e=
nough, but we could get fancy and use -1L and compare</div><div>the result =
against sprintf(str, &quot;%lu&quot;, -1L)</div><div><br></div><div>Selva</=
div><div><br></div></div></div></div>

--000000000000b587cd056f5309ee--

