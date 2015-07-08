MIME-Version: 1.0
In-Reply-To: <559D4F39.5000603@...1147...>
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
	<559672D0.1030904@...1147...> <20150703115639.GC57772@...2041...>
	<20150703131545.GZ382@...1296...> <5596980F.6010600@...1147...>
	<559D4F39.5000603@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Jul 2015 14:22:36 -0400
Message-ID: <CAKuzo_g91GRKGN=5vsztpifmhWDsOhy0UYGfesxEzPZowDJuMg@...278...>
Content-Type: multipart/alternative; boundary=001a11404440533f48051a613abc
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11404440533f48051a613abc
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 8, 2015 at 12:26 PM, Jan Just Keijser <janjust@...1147...> wrote:

>
> FWIW: I've patched openvpn to set routes using DHCP on Windows and yes,
> it works: I can add any route to the system routing tables, including
> 0.0.0.0/1 and 128.0.0.1/1 ; this could be used as an alternative to
> requiring elevated privileges.
>
>
This is excellent news. Is routing the only function that needs admin
privileges on windows while starting openvpn?

I have been using a management-interface based client and the openvpn
service to support Windows users without needing admin privileges. Given
the unreliability of the windows service it would be great if non-admin
users can run openvpn.exe.

I am looking forward to testing this. Is there a binary available?

Thanks,

Selva

--001a11404440533f48051a613abc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jul 8, 2015 at 12:26 PM, Jan Just Keijser <span dir=3D"ltr">&lt;<a =
href=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
FWIW: I&#39;ve patched openvpn to set routes using DHCP on Windows and yes,=
<br>
it works: I can add any route to the system routing tables, including<br>
<a href=3D"http://0.0.0.0/1" rel=3D"noreferrer" target=3D"_blank">0.0.0.0/1=
</a> and <a href=3D"http://128.0.0.1/1" rel=3D"noreferrer" target=3D"_blank=
">128.0.0.1/1</a> ; this could be used as an alternative to<br>
requiring elevated privileges.<br>
<br></blockquote><div><br></div><div>This is excellent news. Is routing the=
 only function that needs admin privileges on windows while starting openvp=
n?<br><br>I have been using a management-interface based client and the ope=
nvpn service to support Windows users without needing admin privileges. Giv=
en the unreliability of the windows service it would be great if non-admin =
users can run openvpn.exe.<br><br></div><div>I am looking forward to testin=
g this. Is there a binary available?<br><br></div><div>Thanks,<br><br></div=
><div>Selva<br></div></div><br><br></div></div>

--001a11404440533f48051a613abc--

