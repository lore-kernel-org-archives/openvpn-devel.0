MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Wed, 27 Oct 2021 23:38:19 -0400
Message-ID: <CAKuzo_gHxUQfam=J8uKtMAL2ma_Vu0zZcOBMgGHy4BtcQ5panw@...278...>
Content-Type: multipart/alternative; boundary="0000000000000ecd9605cf6172d1"
Subject: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000ecd9605cf6172d1
Content-Type: text/plain; charset="UTF-8"

Hi,

By commit abd5ee9b7dc4ba85438da5d16bb7dfb31714dac7 we disabled loading of
OpenSSL configuration file on Windows due to OPENSSLDIR pointing to a
writable location in our builds.

I think we have to fix this. Considering that we distribute Windows
executable with our own OpenSSL build, this is totally under our control
and not an upstream issue.

For OpenSSL 3.0, loading of legacy provider for example will require us to
include legacy.so and MODULESDIR to point to the folder where it's
installed. While doing that we could also arrange to have OPENSSLDIR and
--prefix point to safe locations.

As per NOTES-WINDOWS.md in OpenSSL 3.0, the default values of these
locations are read-only:

<quote>
For VC-WIN32, the following defaults are use:

    PREFIX:      %ProgramFiles(x86)%\OpenSSL
    OPENSSLDIR:  %CommonProgramFiles(x86)%\SSL

For VC-WIN64, the following defaults are use:

    PREFIX:      %ProgramW6432%\OpenSSL
    OPENSSLDIR:  %CommonProgramW6432%\SSL

Should those environment variables not exist (on a pure Win32
installation for examples), these fallbacks are used:

    PREFIX:      %ProgramFiles%\OpenSSL
    OPENSSLDIR:  %CommonProgramFiles%\SSL
</quote>

Does this apply to our current build process? Or do we have to do something
in the MSVC build-setup? If it's the latter, can we also fix OPENSSLDIR so
that config loading can be re-enabled for OpenSSL 1.1.1 as well?

Not having the ability to load modules probably affects a small number of
users, but the number is not zero.

Selva

--0000000000000ecd9605cf6172d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>By commit abd5ee9b7dc4ba85438da5d16=
bb7dfb31714dac7 we disabled loading of OpenSSL configuration file on Window=
s due to OPENSSLDIR pointing to a writable=C2=A0location in our builds.</di=
v><div><br></div><div>I think we have to fix this. Considering that we dist=
ribute Windows executable with our own OpenSSL build, this is=C2=A0totally =
under our control and not an upstream issue.</div><div><br></div><div>For O=
penSSL 3.0, loading of legacy provider for example will require us to inclu=
de legacy.so and=C2=A0MODULESDIR to point to the folder where it&#39;s inst=
alled. While doing that we could also arrange to have OPENSSLDIR and --pref=
ix point to safe locations.</div><div><br></div><div>As per NOTES-WINDOWS.m=
d in OpenSSL 3.0, the default values of these locations are read-only:</div=
><div><br></div><div>&lt;quote&gt;</div><div>For VC-WIN32, the following de=
faults are use:<br><br>=C2=A0 =C2=A0 PREFIX: =C2=A0 =C2=A0 =C2=A0%ProgramFi=
les(x86)%\OpenSSL<br>=C2=A0 =C2=A0 OPENSSLDIR: =C2=A0%CommonProgramFiles(x8=
6)%\SSL<br><br>For VC-WIN64, the following defaults are use:<br><br>=C2=A0 =
=C2=A0 PREFIX: =C2=A0 =C2=A0 =C2=A0%ProgramW6432%\OpenSSL<br>=C2=A0 =C2=A0 =
OPENSSLDIR: =C2=A0%CommonProgramW6432%\SSL<br><br>Should those environment =
variables not exist (on a pure Win32<br>installation for examples), these f=
allbacks are used:<br><br>=C2=A0 =C2=A0 PREFIX: =C2=A0 =C2=A0 =C2=A0%Progra=
mFiles%\OpenSSL<br>=C2=A0 =C2=A0 OPENSSLDIR: =C2=A0%CommonProgramFiles%\SSL=
</div><div>&lt;/quote&gt;</div><div><br></div><div>Does this apply to our c=
urrent build process? Or do we have to do something in the MSVC build-setup=
? If it&#39;s the latter, can we also fix OPENSSLDIR=C2=A0so that config lo=
ading can be re-enabled for OpenSSL 1.1.1 as well?</div><div><br></div><div=
>Not having the ability to load modules probably affects a small number of =
users, but the number is not zero.</div><div><br></div><div>Selva=C2=A0</di=
v></div>

--0000000000000ecd9605cf6172d1--

