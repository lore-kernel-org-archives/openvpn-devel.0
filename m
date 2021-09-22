MIME-Version: 1.0
References: <20210922211254.7570-1-selva.nair@...277...>
 <20210922211254.7570-4-selva.nair@...277...>
In-Reply-To: <20210922211254.7570-4-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 22 Sep 2021 17:23:04 -0400
Message-ID: <CAKuzo_j=_PHMgm1q7v+jQZaSRopt3kduQP8y_YOVhrNaiMXkWw@...278...>
Content-Type: multipart/alternative; boundary="000000000000dd8a1805cc9c2983"
Subject: Re: [Openvpn-devel] [PATCH 3/9] Implement keymgmt in the xkey
 provider
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000dd8a1805cc9c2983
Content-Type: text/plain; charset="UTF-8"

Hi,

hmm.. there is some cruft in the commit message referring to a non-existent
function, in case anyone reads it. The code itself is fine.

On Wed, Sep 22, 2021 at 5:13 PM <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> A minimal set of functions for keymgmt are implemented.
> No support for external key import as yet, only native
> keys. Support for native keys is required as all public
> key ops will get delegated to us once SSL_CTX is initialized
> in our context. This will include digest-verify using
> peer's public key.
>
> To test key import, use the normal --key operation,
> change use_xkey_provider() to return true. The key
>

There is no use_xkey_provider() in the submitted version.

Just use --cert and --key to test and exercise the code path.


> will import correctly but signing will fail as there
> is no signature interface in the provider yet.
> (use enable-debug for the dmsg() chatter).
>

Selva

--000000000000dd8a1805cc9c2983
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>hmm.. there is some cruf=
t in the commit message referring to a non-existent function, in case anyon=
e reads it. The code itself is fine.</div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 22, 2021 at 5:13 PM &lt;<a =
href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_bla=
nk">selva.nair@...277...</a>&gt;<br>
<br>
A minimal set of functions for keymgmt are implemented.<br>
No support for external key import as yet, only native<br>
keys. Support for native keys is required as all public<br>
key ops will get delegated to us once SSL_CTX is initialized<br>
in our context. This will include digest-verify using<br>
peer&#39;s public key.<br>
<br>
To test key import, use the normal --key operation,<br>
change use_xkey_provider() to return true. The key<br></blockquote><div><br=
></div><div>There is no use_xkey_provider() in the submitted version.</div>=
<div><br></div><div>Just use --cert and --key to test and exercise the code=
 path.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
will import correctly but signing will fail as there<br>
is no signature interface in the provider yet.<br>
(use enable-debug for the dmsg() chatter).<br></blockquote><div><br></div><=
div>Selva=C2=A0</div></div></div>

--000000000000dd8a1805cc9c2983--

