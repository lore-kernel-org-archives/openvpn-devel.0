MIME-Version: 1.0
References: <20180527190057.3488-1-chipitsine@...277...>
 <77f85744-4ae0-e8e5-148e-e327130adcc3@...2181...>
In-Reply-To: <77f85744-4ae0-e8e5-148e-e327130adcc3@...2181...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 24 Jun 2018 09:03:00 +0500
Message-ID: <CAFHpkQHVxZir86GQ0qCTiUqVDPqLX1jZp8uP8MH3TmdZfbD6+A@...278...>
Content-Type: multipart/alternative; boundary="0000000000002e5f1e056f5ba5e2"
Subject: Re: [Openvpn-devel] [PATCH v2] travis-ci: cleanup, refactor,
 upgrade ssl libraries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002e5f1e056f5ba5e2
Content-Type: text/plain; charset="UTF-8"

Someone who has admin rights, can purge the cache

On Sun, Jun 24, 2018, 8:28 AM Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 28/05/18 03:00, Ilya Shipitsin wrote:
> > -    - MBEDTLS_VERSION="2.5.1"
> > +    - MBEDTLS_VERSION="2.8.0"
>
> I know travis-ci currently is caching both the downloaded tarball and
> the built library, therefore my question: what will happen to
> mbedtls-2.5.1-*? Will that be wiped after some time? Or do we need to
> wipe the cache manually?
>
> Cheers,
>
> --
> Antonio Quartulli
>
>

--0000000000002e5f1e056f5ba5e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Someone who has admin rights, can purge the cache</div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr">On Sun, Jun 24, 2018, 8:28 AM=
 Antonio Quartulli &lt;a@...2181...&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<br>
On 28/05/18 03:00, Ilya Shipitsin wrote:<br>
&gt; -=C2=A0 =C2=A0 - MBEDTLS_VERSION=3D&quot;2.5.1&quot;<br>
&gt; +=C2=A0 =C2=A0 - MBEDTLS_VERSION=3D&quot;2.8.0&quot;<br>
<br>
I know travis-ci currently is caching both the downloaded tarball and<br>
the built library, therefore my question: what will happen to<br>
mbedtls-2.5.1-*? Will that be wiped after some time? Or do we need to<br>
wipe the cache manually?<br>
<br>
Cheers,<br>
<br>
-- <br>
Antonio Quartulli<br>
<br>
</blockquote></div>

--0000000000002e5f1e056f5ba5e2--

