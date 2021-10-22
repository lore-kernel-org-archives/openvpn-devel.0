MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-13-arne@...1227...>
 <CAKuzo_h6zwNySb7iu=bFGduxH7jB2OT_2TopZ0gYdYPmpRTO=g@...278...>
 <5554b1a1-02ec-a0af-c045-58aa999ed66f@...1227...>
 <CAKuzo_i+eN4Juj70S3v25wHwJepW69MGPEONHN=D1pQbSBK7PA@...278...>
 <5aaca5a3-2087-6e1c-2284-5919111456a8@...1227...>
In-Reply-To: <5aaca5a3-2087-6e1c-2284-5919111456a8@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Oct 2021 16:38:35 -0400
Message-ID: <CAKuzo_iHebV3tY_JcMVei9vtQthD5SOJ_CMXTG_PEQ1HWmLwGQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000c6468e05cef6ff7b"
Subject: Re: [Openvpn-devel] [PATCH v3 12/21] [OSSL 3.0] Allow loading of
 non default providers
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

--000000000000c6468e05cef6ff7b
Content-Type: text/plain; charset="UTF-8"

Hi

No. I am actually against loading legacy on demand or loading the
> default provider if --provider is not specified. Often there are system
> wide security defaults in place and I don't think OpenVPN should
> override them unless explicitly instructed to do so.
>

Okay, that adds some clarity :)

In that case let the system default + explicit options take control. If
that breaks anything or causes an error, we can try our best to print a
helpful error message.

Selva

--000000000000c6468e05cef6ff7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
No. I am actually against loading legacy on demand or loading the<br>
default provider if --provider is not specified. Often there are system<br>
wide security defaults in place and I don&#39;t think OpenVPN should<br>
override them unless explicitly instructed to do so.<br></blockquote><div><=
br></div><div>Okay, that adds some clarity :)=C2=A0</div><div><br></div><di=
v>In that case let the system default + explicit=C2=A0options take control.=
 If that breaks anything or causes an error, we can try our best to print a=
 helpful error message.</div><div><br></div><div>Selva</div></div></div>

--000000000000c6468e05cef6ff7b--

