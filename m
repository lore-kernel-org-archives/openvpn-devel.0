MIME-Version: 1.0
References: <1544210258-8754-1-git-send-email-selva.nair@...277...>
 <1544210258-8754-2-git-send-email-selva.nair@...277...>
 <c66e66a4-f43d-3c75-0ab5-20b90cdd1f2b@...1227...>
In-Reply-To: <c66e66a4-f43d-3c75-0ab5-20b90cdd1f2b@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 23 Jan 2019 12:51:11 -0500
Message-ID: <CAKuzo_iJQwRShiV2pVMSFWGXWMAtwJi8dvghj_stG_kjfxCvSQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000048db54058023be40"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Handle PSS padding in cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--00000000000048db54058023be40
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Jan 23, 2019 at 7:55 AM Arne Schwabe <arne@...1227...> wrote:

>
>
> Overall the code looks good. The overriding of the global RSA method is
> a bit of a hack but I also do not have any better solution for this. It
> might break using OpenSSL engines but that is a corner case that I would
> not worry about here.
>
> Apart from the minor issues this gets an ACK from me.
>

Thanks for taking time to review this. All good comments and v2 is in the
next mail.

Selva

--00000000000048db54058023be40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi<br></div></div><br><div><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 23, 2019 at 7:55 AM=
 Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Overall the code looks good. The overriding of the global RSA method is<br>
a bit of a hack but I also do not have any better solution for this. It<br>
might break using OpenSSL engines but that is a corner case that I would<br>
not worry about here.<br>
<br>
Apart from the minor issues this gets an ACK from me.<br></blockquote><div>=
=C2=A0</div><div>Thanks for taking time to review this. All good comments a=
nd v2 is in the next mail.<br><br></div><div>Selva<br></div></div></div></d=
iv>

--00000000000048db54058023be40--

