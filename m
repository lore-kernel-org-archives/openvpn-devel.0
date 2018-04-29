References: <DM5PR21MB0185FC110A99E76426A1603FB08D0@...2394...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <9fb8c0a0-b1d1-2834-dd42-d0abece8529e@...515...>
Date: Sun, 29 Apr 2018 15:26:37 +0300
MIME-Version: 1.0
In-Reply-To: <DM5PR21MB0185FC110A99E76426A1603FB08D0@...2394...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] OpenVPN on ARM64 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Jon Kunkee <jkunkee@...2393...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Marc Sweetgall <marcs@...2393...>

Hi and welcome!

Il 28/04/2018 02:26, Jon Kunkee via Openvpn-devel ha scritto:
> Hi,
>=20
> As a few of you have heard on IRC, I'm a Microsoft engineer working on th=
e ARM64 version of Windows desktop, mostly on the x86 usermode emulation la=
yers. One of the challenges usermode-only emulation poses is that applicati=
ons relying on drivers don't run unless the driver is ported. There has bee=
n quite some interest in OpenVPN on my team and my proof of concept went we=
ll, so I am taking a shot at porting tap-windows6 to ARM64 and contributing=
 the port back to the community.
>=20
> (I'll have patches to share soon! Please bear with me.)

Patches to tap-windows6 driver are very, very welcome! As the driver
itself changes very rarely, we have not spent much effort in the support
code (e.g. build system) either.

> My proof of concept was pretty simple: Copy the source files into a VS201=
7 driver project, tweak the project properties to reflect the SOURCES file,=
 lie about the NDIS version, and suddenly I had a working ARM64 tap0901.sys=
 through which I could ping an OpenVPN server's VPN-side IP. Not bad!
>=20
> Needless to say, a lot more work is required to ship this. I've already d=
one a lot of it, and I'm planning to do the rest--but I'd love help, even i=
f just advice and historical perspective.=20
>=20
>=20
> The work splits into a few different buckets; I'm interested in your thou=
ghts about my approach:
>=20
> The Windows Driver Kit only supports ARM64 drivers from Windows 10 1709 f=
orward, so tap-windows6's build system needed to migrate to the newer SDK, =
complete with new folder names and build engine semantics. Just switching S=
DKs required no driver code changes and I expect it should still run downle=
vel to Win7, if not Vista (but I haven't yet tested anything but Win10!). B=
uildTap.py needed a moderate number of straightforward changes.

I'm very interested in seeing and testing these changes. I think porting
the buildsystem to a newer SDK would be a good candidate for a PR.

> Appveyor will need to be updated to handle the environment and output cha=
nges; I'm happy to explain what's needed, but I have no previous experience=
 with the service.

Ilya may be able to help you with that: he has written all our AppVeyor
integrations so far.

> Along with the SDK changes, the build script needed many changes to add a=
 third architecture (ARM64).
>
These changes would make another PR.

> The installer also needed changes to support ARM64. I've written an NSIS =
header to replace x64.nsh to make this easy. (Complex NSIS scripting...um..=
.ouch. Just...ouch. :)

We intend to switch away from NSIS to MSI packages. I believe Simon
already did some work in there but he was rather busy for an extended
period of time. But now he is back, so migrating away from NSIS might
make sense at this point. Thoughts Simon?

> The driver does technically need code changes, though: ARM64 Windows only=
 supports NDIS >=3D6.30, while Windows 7 only supports NDIS <=3D 6.20. If I=
 find that these changes are small enough, I'll simply base them on the NDI=
S version supported by the OS. If they're bigger, supporting two (or many) =
NDIS versions gets messy. I'm just starting on this now, but the NDIS maint=
ainers made it sound somewhat simple for a driver that doesn't interact wit=
h hardware.
>=20
> I cracked open the devcon.exe sample from the Win7 DDK and the only chang=
e I had to make was renaming the binary to tapinstall.exe. For the new buil=
d system, I pulled the latest devcon sources from
>     https://github.com/Microsoft/Windows-driver-samples/tree/master/setup=
/devcon
> and built it with the new WDK, then renamed it to tapinstall.exe in build=
tap.py. This might break the current signing pattern. I did make one change=
 to support ARM64 as a build target, and it's under review:>     https://gi=
thub.com/Microsoft/Windows-driver-samples/pull/238
> As for whether or not the Microsoft code can now be redistributed, I thin=
k the 'clone the Microsoft repo' is a fairly easy way forward. On the other=
 hand, the MS-PL isn't nearly as heavy as anything that the DDK came with:
>     https://raw.githubusercontent.com/Microsoft/Windows-driver-samples/ma=
ster/LICENSE

MS-PL is an Open Source Initiative-approved license:

https://opensource.org/licenses/alphabetical

I think we're safe on the licensing front.

> As for signing, I get similar errors before and after my changes. I'm not=
 quite sure what the goal is for which script section, but it does appear t=
hat the new build system invokes Inf2Cat itself using the test certs provid=
ed with the SDK. Since that doesn't cover tapinstall.exe or the installer E=
XE nor does it cover the official attestation case, it's insufficient. (I'l=
l keep my ear to the ground about making this signing stuff more palatable =
in general.)

The tap-windows6 buildsystem signs, by default, files (tap0901.cat
files, tapinstall.exe, NSIS package) using a certificate with OpenVPN in
the (subject) name in the user's certificate store. It is also possible
to use a certificate file (pfx) and pass the password in the command-line.

Due to lack of proper refactoring the buildsystem is rather clunky and
could use some work. So any patches are most welcome! The clunkiness is,
however, quite well documented. In addition to README.md we have a quite
thorough Wiki page on how to sign the thing:

https://community.openvpn.net/openvpn/wiki/BuildingTapWindows6

I do have access the the Windows developer portal and can submit drivers
for official MS "blessing". But I have not yet even tried going through
the process.

> The x86 usermode daemon and UI work beautifully with the ARM64 driver, so=
 bundling the properly-tri-arch tap-windows6 installer with the x86 usermod=
e should be fine for now for the user experience. As pointed out on IRC, th=
is is a big potential bottleneck since this is where the cryptography and r=
outing are done, but it just works for now and I don't have the resources t=
o add the ARM64 Windows ABI to GCC+mingw nor do I feel a pressing need to r=
esuscitate the old MSVC openvpn-build paths and then hope the community is =
happy supporting that in the future, seeing as how it's currently unsupport=
ed.=20

Yes, MSVC buildsystem has not been maintained in years. Occasionally
somebody tries to use it and notices it does not work and notifies us.
But nobody has stepped up to do the maintenance required.

> Going forward I'll be happy to smoke-test new versions of OpenVPN on an A=
RM64 device, as long as I have one available.=20
>=20
>=20
> Overall, I think ARM64 support only requires changes to tap-windows6 and =
the build environment, but there are a lot of little changes. I'd love to h=
ear your feedback, and I'm sure I missed explaining something.
>=20
> Thanks,
> Jon Kunkee
> =20
> (Shout out to kitsune1, cron2, mattock, pekster, and others who have give=
n me feedback on IRC to get me this far!)

One final note on PRs/patches: keep them as small and atomic as possible
and they will be easy to review and marge. Just like you did with your
first PR :).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

