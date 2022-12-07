MIME-Version: 1.0
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
In-Reply-To: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 7 Dec 2022 14:48:59 -0500
Message-ID: <CAKuzo_jBYgxsZhN4nzZky+uQHndnZx9MZweYRs0E7xDQu0X48A@...278...>
Content-Type: multipart/alternative; boundary="00000000000025134505ef423791"
Subject: Re: [Openvpn-devel] [PATCH] support PKCS11 lib dependencies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marc Becker <marc.becker@...2704...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000025134505ef423791
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Dec 6, 2022 at 8:19 PM Marc Becker via Openvpn-devel <
openvpn-devel@lists.sourceforge.net> wrote:

> Modify the Win32-PE search path to find dependencies
> in shared object origin location.
>
> Needs https://github.com/OpenSC/pkcs11-helper/pull/59 to work.



> Would be nice if this could still be included for v2.6,

an additional pkcs11-helper patch may be added to preempt the PR.


At first glance it looks like the proposed change will build cleany even
without the upstream although the feature to set loader_flags will get
bypassed (as PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS will evaluate as
undefined)

I think we should leave it at that instead of carrying around another local
patch for pkcs11-helper. If/when it gets merged upstream we'll have this
feature. Until then Windows users can still set the PATH and have their
providers loaded from arbitrary source directories.

In other words, the option to set load_flags is just a convenience, not a
necessity, isn't it? Correct me if I'm wrong.

As for the patches, I couldn't apply them -- tried from email and
patchwork. Corrupt lines due to line breaks?

> ---
> 2.38.1.windows.1

Possibly that explains it :)

Unless it's only me, a v2 will be required to fix the patch. At that point,
it would be nice to have Signed-off lines and better commit messages that
are clear and descriptive.

Selva

--00000000000025134505ef423791
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Dec 6, 2022 at 8:19 PM Marc Becker via Ope=
nvpn-devel &lt;<a href=3D"mailto:openvpn-devel@lists.sourceforge.net" targe=
t=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Modify the Win32-PE search =
path to find dependencies<br>
in shared object origin location.<br>
<br>
Needs <a href=3D"https://github.com/OpenSC/pkcs11-helper/pull/59" rel=3D"no=
referrer" target=3D"_blank">https://github.com/OpenSC/pkcs11-helper/pull/59=
</a> to work.</blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Would be nice if this could still be included for v2.6,=
=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">an add=
itional pkcs11-helper patch may be added to preempt the PR.=C2=A0</blockquo=
te><div><br></div><div>At first glance it looks like the proposed change=C2=
=A0will build cleany even without the upstream although the feature to set =
loader_flags will get bypassed (as=C2=A0PKCS11H_PROVIDER_PROPERTY_LOADER_FL=
AGS will evaluate as undefined)</div><div><br></div><div>I think we should =
leave it at that instead of carrying around another local patch for pkcs11-=
helper. If/when it gets merged upstream we&#39;ll have this feature. Until =
then Windows users can still set the PATH and have their providers=C2=A0loa=
ded from arbitrary source directories.</div><div><br></div><div>In other wo=
rds, the option to set load_flags is just a convenience, not a necessity, i=
sn&#39;t it? Correct=C2=A0me if I&#39;m wrong.</div><div><br></div><div>As =
for the patches, I couldn&#39;t=C2=A0apply them -- tried from email and pat=
chwork. Corrupt lines due to line breaks?</div><div><br></div><div>&gt; ---=
</div><div><span style=3D"color:rgb(97,97,97);font-size:14px;white-space:pr=
e-wrap">&gt; 2.38.1.windows.1</span></div><div class=3D"gmail_quote"><br></=
div>Possibly that explains it :)</div><div class=3D"gmail_quote"><br><div>U=
nless it&#39;s=C2=A0only me, a v2=C2=A0will be required to fix the patch. A=
t that=C2=A0point, it=C2=A0would be nice to have Signed-off lines and bette=
r commit messages that are clear and descriptive.</div><div><br></div><div>=
Selva</div></div></div>

--00000000000025134505ef423791--

