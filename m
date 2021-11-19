MIME-Version: 1.0
References: <CAKuzo_gHxUQfam=J8uKtMAL2ma_Vu0zZcOBMgGHy4BtcQ5panw@...278...>
 <CAGyAFMXvP0iwEiE-G4-d6P4ANSRpr9w-tF++VDL-amgrmPmGuQ@...278...>
 <CAKuzo_gOVrTYqK7s3ZryCSxJmbXE1ogquTDyQfMfZ6GUy4coGA@...278...>
 <CAGyAFMXfhmN+79joNEgcGR9E-+3EMgWyWDCUcC7JAD5bWFvzAA@...278...>
 <CAKuzo_gY+U1KKwLZXiMM=t_2QvJkN3nKxYYhtwzSi2CMrNc9Pg@...278...>
 <CAGyAFMUXsMwaL=wrxrQBh0s+D0RrK=GYbGC1y+HNhXbgvCQq=A@...278...>
In-Reply-To: <CAGyAFMUXsMwaL=wrxrQBh0s+D0RrK=GYbGC1y+HNhXbgvCQq=A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 Nov 2021 11:57:02 -0500
Message-ID: <CAKuzo_hcZYjPDVj=PyEB_K7VfTC6r_pDhZs9=_PbKiZnAKYqUg@...278...>
Content-Type: multipart/alternative; boundary="000000000000f11f9105d1272aa5"
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

--000000000000f11f9105d1272aa5
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Nov 19, 2021 at 11:16 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> Here is what output of openssl.exe built with abovementioned patch on
> my machine:
>
>
> c:\Users\lev\Projects\vcpkg\packages\openssl_x64-windows-ovpn\tools\openssl>openssl.exe
> version -a
> OpenSSL 1.1.1l  24 Aug 2021
> built on: Fri Nov 19 09:43:38 2021 UTC
> platform: VC-WIN64A
> options:  bn(64,64) rc4(16x,int) des(long) idea(int) blowfish(ptr)
> compiler: cl /Zi /Fdossl_static.pdb /Gs0 /GF /Gy /MD /W3 /wd4090
> /nologo /O2 -utf-8 -FS -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ
> -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5
> -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM
> -DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM
> -DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM
> OPENSSLDIR: "C:\Program Files\OpenVPN\ssl"
> ENGINESDIR:
> "C:\Users\lev\Projects\vcpkg\packages\openssl_x64-windows-ovpn\lib\engines-1_1"
>

That seems to indicate that the prefix is not set properly. See NOTES.WIN
or NOTES.WINDOWS in OpenSSL source tree for default locations chosen in
MSVC build which are safe. I do not have Windows packaging experience, so
I'm not sure why vcpkg folks are using the working directory for setting
these paths and not following OpenSSL installation docs.


> Seeding source: os-specific
>
> ENGINESDIR looks good, no? Is it something we use?
>

I think that's where engine dlls will get loaded from when specified as a
relative path or name. We  allow loading of engines via the "--engine"
option.

Also I guess MODULESDIR in 3.0 build will point to C:\Users\.... which is
not acceptable. Provider names or dlls that the user specifies using our
new "--providers" option will get loaded from there. Also we have to
distribute the dll for the legacy provider which will go into the
MODULESDIR.

Users can override these using env vars but the built-in values should
point to read-only locations.

Selva

--000000000000f11f9105d1272aa5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div></div><div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 19, 2021 at 11:16 AM Le=
v Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi=
,<br>
<br>
Here is what output of openssl.exe built with abovementioned patch on<br>
my machine:<br>
<br>
c:\Users\lev\Projects\vcpkg\packages\openssl_x64-windows-ovpn\tools\openssl=
&gt;openssl.exe<br>
version -a<br>
OpenSSL 1.1.1l=C2=A0 24 Aug 2021<br>
built on: Fri Nov 19 09:43:38 2021 UTC<br>
platform: VC-WIN64A<br>
options:=C2=A0 bn(64,64) rc4(16x,int) des(long) idea(int) blowfish(ptr)<br>
compiler: cl /Zi /Fdossl_static.pdb /Gs0 /GF /Gy /MD /W3 /wd4090<br>
/nologo /O2 -utf-8 -FS -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ<br>
-DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5<br>
-DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM<br>
-DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM<br>
-DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM<br>
OPENSSLDIR: &quot;C:\Program Files\OpenVPN\ssl&quot;<br>
ENGINESDIR: &quot;C:\Users\lev\Projects\vcpkg\packages\openssl_x64-windows-=
ovpn\lib\engines-1_1&quot;<br></blockquote><div><br></div><div>That seems t=
o indicate that the prefix is not set properly. See NOTES.WIN or NOTES.WIND=
OWS in OpenSSL source tree for default locations chosen in MSVC build which=
 are safe. I do not=C2=A0have=C2=A0Windows packaging experience, so I&#39;m=
 not sure why vcpkg folks are using the working directory for setting these=
 paths and not following OpenSSL installation docs.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
Seeding source: os-specific<br>
<br>
ENGINESDIR looks good, no? Is it something we use?<br></blockquote><div><br=
></div><div>I think that&#39;s where engine dlls will get loaded from when =
specified as a relative path or name. We=C2=A0 allow loading of engines via=
 the &quot;--engine&quot; option.</div><div><br></div><div>Also I guess MOD=
ULESDIR in 3.0 build will point to C:\Users\.... which is not acceptable. P=
rovider names or dlls that the user specifies using our new &quot;--provide=
rs&quot; option will get loaded from there. Also we have to distribute the =
dll for the legacy provider which will=C2=A0go into the MODULESDIR.</div><d=
iv><br></div><div>Users can override these using env vars but the built-in =
values should point to read-only locations.</div><div><br></div><div>Selva<=
/div></div></div></div>

--000000000000f11f9105d1272aa5--

