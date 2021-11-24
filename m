MIME-Version: 1.0
References: <20211119015548.687-1-lstipakov@...277...>
 <202111241005.1AOA5Os7011522@...2054...>
In-Reply-To: <202111241005.1AOA5Os7011522@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Nov 2021 09:31:53 -0500
Message-ID: <CAKuzo_g8h+EKVD2npraqD0LmiTWWPg4+oMxZ10U9TLNV+u32qQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000001223a005d189b98b"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Load OpenSSL config on
 Windows from trusted location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001223a005d189b98b
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Nov 24, 2021 at 5:06 AM Gert Doering <gert@...1296...> wrote:

> Your patch has been applied to the master and release/2.5 branch
> (I consider this a bugfix since the "do not load config!" CVE patch
> unintendedly broke functionality for people)
>

What would be a good location in the man page where we can document this.
These are not env vars we natively support so putting it under a section
named "ENVIRONMENT VARIABLES" does not seem right. Also we already have a
section with that name which refer to env vars we export to scripts.

Selva

--0000000000001223a005d189b98b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Nov 24, 2021 at 5:06 AM Gert Doering &lt;<a=
 href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Your patc=
h has been applied to the master and release/2.5 branch<br>
(I consider this a bugfix since the &quot;do not load config!&quot; CVE pat=
ch<br>
unintendedly broke functionality for people)<br></blockquote><div><br></div=
><div>What would be a good location in the man page where we can document t=
his. These are not env vars we natively support so putting it under a secti=
on named &quot;ENVIRONMENT VARIABLES&quot; does not seem right. Also we alr=
eady have a section with that name which refer to env vars we export to scr=
ipts.</div><div><br></div><div>Selva</div></div></div>

--0000000000001223a005d189b98b--

