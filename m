MIME-Version: 1.0
References: <CAKuzo_gHxUQfam=J8uKtMAL2ma_Vu0zZcOBMgGHy4BtcQ5panw@...278...>
 <CAGyAFMXvP0iwEiE-G4-d6P4ANSRpr9w-tF++VDL-amgrmPmGuQ@...278...>
In-Reply-To: <CAGyAFMXvP0iwEiE-G4-d6P4ANSRpr9w-tF++VDL-amgrmPmGuQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Nov 2021 13:08:42 -0500
Message-ID: <CAKuzo_gOVrTYqK7s3ZryCSxJmbXE1ogquTDyQfMfZ6GUy4coGA@...278...>
Content-Type: multipart/alternative; boundary="000000000000acebe305d0731e2a"
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000acebe305d0731e2a
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Nov 7, 2021 at 9:14 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> We agreed during the hackathon that we are going to ship a 2.6 Windows
> client with OpenSSL 3.0. Apart from merging relevant patches, there
> are few (small) blocks:
>
>  - vcpkg hasn't yet added OpenSSL 3.0 to official repo, but there is a
> PR https://github.com/microsoft/vcpkg/pull/20428 This shouldn't be a
> problem for us, since we could just have this port in openvpn repo,
> like we do with pkcs11-helper.
>
>  - The latest release of pkcs11-helper doesn't build with openssl3,
> but things are progressing -
> https://github.com/OpenSC/pkcs11-helper/issues/42. We would also have
> to make sure that our vcpkg port for pkcs11-helper builds with
> openssl3.
>
> Once OpenSSL 3.0 support is somewhat settled, we could look into
> configuration file loading. I haven't checked vcpkg scripts, but in
> the best case scenario we won't have to do anything and just rely on
> readonly values you've mentioned.
>

While this sounds good for 2.6, can we fix this in 2.5 as well?  In mingw
cross builds our mistake was using "--openssl-dir /etc/ssl" with OpenSSL
"Configure". Not sure what we do now for MSVC builds. The default
locations are pretty decent as per NOTES.WIN in OpenSSL 1.1.1 tree.

Selva

--000000000000acebe305d0731e2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Sun, Nov 7, 2021 at 9:14 AM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i,<br>
<br>
We agreed during the hackathon that we are going to ship a 2.6 Windows<br>
client with OpenSSL 3.0. Apart from merging relevant patches, there<br>
are few (small) blocks:<br>
<br>
=C2=A0- vcpkg hasn&#39;t yet added OpenSSL 3.0 to official repo, but there =
is a<br>
PR <a href=3D"https://github.com/microsoft/vcpkg/pull/20428" rel=3D"norefer=
rer" target=3D"_blank">https://github.com/microsoft/vcpkg/pull/20428</a> Th=
is shouldn&#39;t be a<br>
problem for us, since we could just have this port in openvpn repo,<br>
like we do with pkcs11-helper.<br>
<br>
=C2=A0- The latest release of pkcs11-helper doesn&#39;t build with openssl3=
,<br>
but things are progressing -<br>
<a href=3D"https://github.com/OpenSC/pkcs11-helper/issues/42" rel=3D"norefe=
rrer" target=3D"_blank">https://github.com/OpenSC/pkcs11-helper/issues/42</=
a>. We would also have<br>
to make sure that our vcpkg port for pkcs11-helper builds with<br>
openssl3.<br>
<br>
Once OpenSSL 3.0 support is somewhat settled, we could look into<br>
configuration file loading. I haven&#39;t checked vcpkg scripts, but in<br>
the best case scenario we won&#39;t have to do anything and just rely on<br>
readonly values you&#39;ve mentioned.<br></blockquote><div><br></div><div>W=
hile this sounds good for 2.6, can we fix this in 2.5 as well?=C2=A0 In min=
gw cross builds our mistake was using &quot;--openssl-dir /etc/ssl&quot; wi=
th OpenSSL &quot;Configure&quot;. Not sure what we do now for MSVC builds. =
The default locations=C2=A0are pretty decent as per NOTES.WIN in OpenSSL 1.=
1.1 tree.</div><div><br></div><div>Selva</div></div></div>

--000000000000acebe305d0731e2a--

