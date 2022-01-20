MIME-Version: 1.0
References: <20211214165928.30676-8-selva.nair@...277...>
 <202201201518.20KFI6r4000355@...2054...>
In-Reply-To: <202201201518.20KFI6r4000355@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 20 Jan 2022 11:32:40 -0500
Message-ID: <CAKuzo_jX7aL3WG91JRk4_+27m=0G4JRvUrVTRzHd6=jqAf3bpg@...278...>
Content-Type: multipart/alternative; boundary="000000000000fcc80d05d6060dbe"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Enable signing via provider
 for management-external-key
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

--000000000000fcc80d05d6060dbe
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Jan 20, 2022 at 10:18 AM Gert Doering <gert@...1296...> wrote:

> Compile and client tested on 1.1.1 and 3.0.1.
>
> Glancing at the code related to management_external_key() does
> not make me very happy... too many build time variants.


"Happiness" is never a word that comes to mind while reading OpenVPN code :)
...

Even at our snail's pace, 2.7 may be out before we can break free of
OpenSSL 1, LibreSSL xyz etc. An option may be to require OpenSSL 3+ or
similar for external keys, or at least for management-external-key.

That feature is really used by only a few platforms (only Android for
now?). Although it's a nifty option that could potentially be leveraged to
remove pkcs11-helper, CNG etc out of OpenVPN core.

Selva

--000000000000fcc80d05d6060dbe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Jan 20, 2022 at 10:18 AM Gert Doering &lt;=
<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Compile=
 and client tested on 1.1.1 and 3.0.1.<br>
<br>
Glancing at the code related to management_external_key() does<br>
not make me very happy... too many build time variants.=C2=A0</blockquote><=
div><br></div><div>&quot;Happiness&quot; is never a word that comes to mind=
 while reading OpenVPN code :)</div><div>...<br></div><div><br></div><div>E=
ven at our snail&#39;s pace, 2.7 may be out before we can break free of Ope=
nSSL 1, LibreSSL xyz etc. An option may be to require OpenSSL 3+ or similar=
 for external keys, or at least for management-external-key.=C2=A0</div><di=
v><br></div><div>That feature is really used by only a few platforms (only =
Android for now?). Although it&#39;s a nifty option that could potentially =
be leveraged=C2=A0to remove pkcs11-helper, CNG etc out of OpenVPN core.</di=
v><div><br></div><div>Selva</div></div></div>

--000000000000fcc80d05d6060dbe--

