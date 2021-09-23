MIME-Version: 1.0
References: <20210922211254.7570-1-selva.nair@...277...>
 <ed918ec7-2301-0e66-4bbe-f9141c97b406@...1227...>
In-Reply-To: <ed918ec7-2301-0e66-4bbe-f9141c97b406@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Sep 2021 10:02:12 -0400
Message-ID: <CAKuzo_iC46yGz+hjyZvmxyh=PeNw_UPMMyxKEXm6Yxb0dSao5w@...278...>
Content-Type: multipart/alternative; boundary="0000000000001ad96805ccaa1f6b"
Subject: Re: [Openvpn-devel] [PATCH 0/9] A built-in OpenSSL3.0 provider for
 external-keys
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

--0000000000001ad96805ccaa1f6b
Content-Type: text/plain; charset="UTF-8"

Hi Arne,


> So I have two options here:
>
> a) I finish my own implementation of the provider for OpenVPN3 to not be
> influenced by this implementation and review this implementation after that
>
> b) you agree that I can take parts of your code for the OpenVPN3
> implementation, then I go directly into review and then base my OpenVPN3
> implementation on your xkey provider implementation.
>

(b) is fine with me and preferred. I do not want to release it under BSD,
but can agree to  a CLA. I wrote it consulting OpenSSL sources (though no
copy paste) which is not GPL2, so not even sure what license is most
appropriate. But BSD isi not my thing.

If there is a specific wording required, I can add that to the
xkey_provider.c file which contains the implementation. Or make a separate
copy for you to pick for OpenVPN3 The rest is generic interfacing with
OpenVPN.

Thanks,

Selva



> Arne
>

--0000000000001ad96805ccaa1f6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div class=3D"gmail_quote"><div>Hi Arne,</d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
So I have two options here:<br>
<br>
a) I finish my own implementation of the provider for OpenVPN3 to not be<br>
influenced by this implementation and review this implementation after that=
<br>
<br>
b) you agree that I can take parts of your code for the OpenVPN3<br>
implementation, then I go directly into review and then base my OpenVPN3<br>
implementation on your xkey provider implementation.<br></blockquote><div><=
br></div><div>(b) is fine with me and preferred. I do not want to release i=
t under BSD, but can agree to=C2=A0 a CLA. I wrote=C2=A0it consulting OpenS=
SL sources (though no copy paste) which is not GPL2, so not even sure what =
license is most appropriate. But BSD isi not my thing.=C2=A0</div><div><br>=
</div><div>If there is a specific=C2=A0wording required, I can add that to =
the xkey_provider.c file which contains the implementation. Or make a separ=
ate copy for you to pick for OpenVPN3 The rest is generic interfacing with =
OpenVPN.</div><div><br></div><div>Thanks,</div><div><br></div><div>Selva</d=
iv><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
Arne<br>
</blockquote></div></div>

--0000000000001ad96805ccaa1f6b--

