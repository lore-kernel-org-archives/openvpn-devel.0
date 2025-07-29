From: Kristof Provost <kprovost@...2661...>
Date: Tue, 29 Jul 2025 13:30:50 +0200
Message-ID: <CBE17A18-1AAB-4891-88DA-14852A628D24@...2661...>
In-Reply-To: <aIireKdz0MHz2Iio@...1296...>
References: <20250729093857.37832-1-kprovost@...2661...>
 <E5429ADC-B338-4BC3-BA6B-F1D23B103D32@...2661...>
 <aIireKdz0MHz2Iio@...1296...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_0351E54B-0C07-43E9-AB3F-9A27BB03E041_="
Content-Transfer-Encoding: 8bit
Subject: Re: [Openvpn-devel] [PATCH 1/2] dco-freebsd: pass address scope to
 the kernel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--=_MailMate_0351E54B-0C07-43E9-AB3F-9A27BB03E041_=
Content-Type: text/plain; charset="utf-8"; format="flowed"; markup="markdown"
Content-Transfer-Encoding: 8bit

On 29 Jul 2025, at 13:07, Gert Doering wrote:
> On Tue, Jul 29, 2025 at 12:55:29PM +0200, Kristof Provost via 
> Openvpn-devel wrote:
>> This requires kernel side support: 
>> [https://reviews.freebsd.org/D51596](https://reviews.freebsd.org/D51596)
>
> I did not yet test it, but I assume that including scope-id in the
> message to an older kernel will not break anything for non-LLA peers?
>
Correct. That’s why we’re using nvlists in the ioctl path. We can 
add fields without confusing either kernel or userspace. They’ll just 
be ignored.

—
Kristof
--=_MailMate_0351E54B-0C07-43E9-AB3F-9A27BB03E041_=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8">
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" style=
=3D"white-space: normal;">
<p dir=3D"auto">On 29 Jul 2025, at 13:07, Gert Doering wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px s=
olid #136BCE; color: #136BCE;">
<p dir=3D"auto">On Tue, Jul 29, 2025 at 12:55:29PM +0200, Kristof Provost v=
ia Openvpn-devel wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px s=
olid #136BCE; border-left-color: #4B89CF; color: #4B89CF;">
<p dir=3D"auto">This requires kernel side support: <a href=3D"https://revie=
ws.freebsd.org/D51596">https://reviews.freebsd.org/D51596</a></p>
</blockquote>
<p dir=3D"auto">I did not yet test it, but I assume that including scope-id=
 in the<br>
message to an older kernel will not break anything for non-LLA peers?</p>
</blockquote>
<p dir=3D"auto">Correct. That=E2=80=99s why we=E2=80=99re using nvlists in =
the ioctl path. We can add fields without confusing either kernel or usersp=
ace. They=E2=80=99ll just be ignored.</p>
<p dir=3D"auto">=E2=80=94<br>
Kristof</p>

</div>
</div>
</body>

</html>

--=_MailMate_0351E54B-0C07-43E9-AB3F-9A27BB03E041_=--

