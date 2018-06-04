MIME-Version: 1.0
In-Reply-To: <1528136599.2661838.1396063928.5934C084@...2307...>
References: <1527819161.492538.1392521184.3CB7A30B@...2307...>
 <CAKuzo_iGmzY-D1Bn07fD89uWVuVDq-s622vtd21Tnn3oyuHF8A@...278...>
 <1527828655.645316.1392609712.3E887A89@...2307...>
 <CAKuzo_ifdaAb-nGgc2Z51-505j+J+kb_FbkQoVNodjVQD-qJjQ@...278...>
 <1528136599.2661838.1396063928.5934C084@...2307...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 4 Jun 2018 15:08:18 -0400
Message-ID: <CAKuzo_h9OPPSgYcBkNPczd8AuK883t=2Dka2W5YHE=2O0W0k-A@...278...>
Content-Type: multipart/alternative; boundary="0000000000004245a4056dd5a9f0"
Subject: Re: [Openvpn-devel] OpenVPN 2.5_git fails to build linked to
 OpenSSL v1.1.0 Works great linked to OpenSSL v1.0.2 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: aclion@...2404...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000004245a4056dd5a9f0
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Jun 4, 2018 at 2:23 PM, <aclion@...2404...> wrote:

> On 5/31/18 10:33 PM, Selva Nair wrote:
> > OpenVPN still supports openssl 1.0 and you can't build with api
> > restricted to 1.1. At least not yet. So it will build only if you use
> > the "default build" of OpenSSL 1.1. And should build with 1.1
> > lib/headers in major distributions -- if not, there is a problem.
>
> The "default build" does NOT include the deprecated functions:
>
> https://wiki.openssl.org/index.php/OpenSSL_1.1.0_Changes


Quoting from that page (emphasis mine).

"Various functions get deprecated as other interfaces get added, but *are
still available in a default build*. The include files support setting the
OPENSSL_API_COMPAT define that will hide functions that are deprecated in
the selected version. To select the 1.1.0 version use
-DOPENSSL_API_COMPAT=0x10100000L. "

And that's what I mean by default build. In other words, if you configure
openssl as "./Configure" leaving all options at their defaults what you get
is the default build. AFAIK OpenVPN compiles and links against such a
build. Use of -DOPENSSL_API_COMPAT=0x10100000L is not yet supported.

Selva

--0000000000004245a4056dd5a9f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Mon, Jun 4, 2018 at 2:23 PM,  <span dir=3D"ltr">&lt;<a href=
=3D"mailto:aclion@...2404..." target=3D"_blank">aclion@...2404...</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">On 5/31/18 10:33 PM, Selva N=
air wrote:<br>
&gt; OpenVPN still supports openssl 1.0 and you can&#39;t build with api<br>
&gt; restricted to 1.1. At least not yet. So it will build only if you use<=
br>
&gt; the &quot;default build&quot; of OpenSSL 1.1. And should build with 1.=
1<br>
&gt; lib/headers in major distributions -- if not, there is a problem.<br>
<br>
The &quot;default build&quot; does NOT include the deprecated functions:<br>
<br>
<a href=3D"https://wiki.openssl.org/index.php/OpenSSL_1.1.0_Changes" rel=3D=
"noreferrer" target=3D"_blank">https://wiki.openssl.org/<wbr>index.php/Open=
SSL_1.1.0_<wbr>Changes</a></blockquote><div><br></div><div>Quoting from tha=
t page (emphasis mine).<br><br>&quot;Various functions get deprecated as ot=
her interfaces get added, but <b>are=20
still available in a default build</b>.
The include files support setting the OPENSSL_API_COMPAT define that=20
will hide functions that are deprecated in the selected version.
To select the 1.1.0 version use -DOPENSSL_API_COMPAT=3D0x10100000L.
&quot;<br><br></div><div>And that&#39;s what I mean by default build. In ot=
her words, if you configure openssl as &quot;./Configure&quot; leaving all =
options at their defaults what you get is the default build. AFAIK OpenVPN =
compiles and links against such a build. Use of -DOPENSSL_API_COMPAT=3D0x10=
100000L is not yet supported.<br></div><div><br></div><div>Selva<br></div><=
/div></div></div></div>

--0000000000004245a4056dd5a9f0--

