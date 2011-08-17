From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 17 Aug 2011 16:49:33 +0200
References: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz0gdd6+367C94OnsWPfmaAKtBXO0-OAttXSna2mAVX6OQ@...278...>
	<AC0D1768260B41DB9B09FFBD4A66B5EC@...139...>
In-Reply-To: <AC0D1768260B41DB9B09FFBD4A66B5EC@...139...>
MIME-Version: 1.0
Message-Id: <201108171649.33802.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel]
 =?iso-8859-1?q?=5BPATCH_1/3=5D_add_MinGW_WinHTTP_?=
 =?iso-8859-1?q?compatibility=09layer?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gisle Vanem <gvanem@...139...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

On Wednesday 17 August 2011 16:28:42 Gisle Vanem wrote:
> "Alon Bar-Lev" <alon.barlev@...277...> wrote:
> > These macros are soooooooo ugly!
>=20
> I tend to agree; had to read the code closely.=20

I tend to disagree. =3D)

Using macros here makes the code more readable. And managable. Imaging if=20
there'll be another 20 functions to wrap. The result without macros would b=
e a=20
plain mess. I agree however that this whole construct is weird, but I guess=
=20
that's what you get when you used unsupported APIs.

The way the library is loaded in cryptoapi.c opens a dll hijacking security=
=20
hole, btw. See http://www.microsoft.com/technet/security/advisory/2269637.m=
spx=20
and now imagine this being done in many different places many different way=
s.=20
I know some people are generally allergic to macros, but reconsider for thi=
s=20
situation please.

Besides that if the hack in cryptoapi.c would have been done right it would=
=20
not pose a threat anymore as MinGW knows CryptAcquireCertificatePrivateKey =
by=20
now. I'll post a patch that removes that hunk later.

> But this hack was cool:
>=20
>  union {
>   FUNC ## _fn *type;
>   FARPROC *ptr;
>   } u =3D { .type =3D &(LIB ## _ ## FUNC) };
> ...
>  *(u.ptr) =3D GetProcAddress (lib, (#FUNC));
>=20
> Where did you get that Heiko?
