MIME-Version: 1.0
References: <Yt+QllThprcm+Vu6@...1296...>
In-Reply-To: <Yt+QllThprcm+Vu6@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 26 Jul 2022 07:45:32 -0400
Message-ID: <CAKuzo_hQ=-keb2nWmz4b=tsQNQtj6rUCpv1=D0m0MFqHFp+cvQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000007bd8db05e4b3d8c2"
Subject: Re: [Openvpn-devel] OpenSSL 3.0 builds with --disable-management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000007bd8db05e4b3d8c2
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Jul 26, 2022 at 2:59 AM Gert Doering <gert@...1296...> wrote:

>
> I'm just relaying what buildbot found, not suggesting a particular fix
> - not very familiar with these new code paths (do we need xkey at all
> if management is disabled?).
>

xkey handles all external keys including pkcs11 and cryptoapicert, so we
need it even when management is disabled.

Selva

--0000000000007bd8db05e4b3d8c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Jul 26, 2022 at 2:59 AM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><br>
I&#39;m just relaying what buildbot found, not suggesting a particular fix<=
br>
- not very familiar with these new code paths (do we need xkey at all<br>
if management is disabled?).<br></blockquote><div><br></div><div>xkey handl=
es all external keys including pkcs11 and cryptoapicert, so we need it even=
 when management is disabled.</div><div><br></div><div>Selva</div></div></d=
iv>

--0000000000007bd8db05e4b3d8c2--

