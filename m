From: Jon Kunkee <jkunkee@...2393...>
Date: Fri, 27 Apr 2018 23:26:20 +0000
Message-ID: <DM5PR21MB0185FC110A99E76426A1603FB08D0@...2394...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN on ARM64 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Marc Sweetgall <marcs@...2393...>

Hi,

As a few of you have heard on IRC, I'm a Microsoft engineer working on the =
ARM64 version of Windows desktop, mostly on the x86 usermode emulation laye=
rs. One of the challenges usermode-only emulation poses is that application=
s relying on drivers don't run unless the driver is ported. There has been =
quite some interest in OpenVPN on my team and my proof of concept went well=
, so I am taking a shot at porting tap-windows6 to ARM64 and contributing t=
he port back to the community.

(I'll have patches to share soon! Please bear with me.)

My proof of concept was pretty simple: Copy the source files into a VS2017 =
driver project, tweak the project properties to reflect the SOURCES file, l=
ie about the NDIS version, and suddenly I had a working ARM64 tap0901.sys t=
hrough which I could ping an OpenVPN server's VPN-side IP. Not bad!

Needless to say, a lot more work is required to ship this. I've already don=
e a lot of it, and I'm planning to do the rest--but I'd love help, even if =
just advice and historical perspective.=20


The work splits into a few different buckets; I'm interested in your though=
ts about my approach:

The Windows Driver Kit only supports ARM64 drivers from Windows 10 1709 for=
ward, so tap-windows6's build system needed to migrate to the newer SDK, co=
mplete with new folder names and build engine semantics. Just switching SDK=
s required no driver code changes and I expect it should still run downleve=
l to Win7, if not Vista (but I haven't yet tested anything but Win10!). Bui=
ldTap.py needed a moderate number of straightforward changes.

Appveyor will need to be updated to handle the environment and output chang=
es; I'm happy to explain what's needed, but I have no previous experience w=
ith the service.

Along with the SDK changes, the build script needed many changes to add a t=
hird architecture (ARM64).

The installer also needed changes to support ARM64. I've written an NSIS he=
ader to replace x64.nsh to make this easy. (Complex NSIS scripting...um...o=
uch. Just...ouch. :)

The driver does technically need code changes, though: ARM64 Windows only s=
upports NDIS >=3D6.30, while Windows 7 only supports NDIS <=3D 6.20. If I f=
ind that these changes are small enough, I'll simply base them on the NDIS =
version supported by the OS. If they're bigger, supporting two (or many) ND=
IS versions gets messy. I'm just starting on this now, but the NDIS maintai=
ners made it sound somewhat simple for a driver that doesn't interact with =
hardware.

I cracked open the devcon.exe sample from the Win7 DDK and the only change =
I had to make was renaming the binary to tapinstall.exe. For the new build =
system, I pulled the latest devcon sources from
    https://github.com/Microsoft/Windows-driver-samples/tree/master/setup/d=
evcon
and built it with the new WDK, then renamed it to tapinstall.exe in buildta=
p.py. This might break the current signing pattern. I did make one change t=
o support ARM64 as a build target, and it's under review:
    https://github.com/Microsoft/Windows-driver-samples/pull/238
As for whether or not the Microsoft code can now be redistributed, I think =
the 'clone the Microsoft repo' is a fairly easy way forward. On the other h=
and, the MS-PL isn't nearly as heavy as anything that the DDK came with:
    https://raw.githubusercontent.com/Microsoft/Windows-driver-samples/mast=
er/LICENSE

As for signing, I get similar errors before and after my changes. I'm not q=
uite sure what the goal is for which script section, but it does appear tha=
t the new build system invokes Inf2Cat itself using the test certs provided=
 with the SDK. Since that doesn't cover tapinstall.exe or the installer EXE=
 nor does it cover the official attestation case, it's insufficient. (I'll =
keep my ear to the ground about making this signing stuff more palatable in=
 general.)

The x86 usermode daemon and UI work beautifully with the ARM64 driver, so b=
undling the properly-tri-arch tap-windows6 installer with the x86 usermode =
should be fine for now for the user experience. As pointed out on IRC, this=
 is a big potential bottleneck since this is where the cryptography and rou=
ting are done, but it just works for now and I don't have the resources to =
add the ARM64 Windows ABI to GCC+mingw nor do I feel a pressing need to res=
uscitate the old MSVC openvpn-build paths and then hope the community is ha=
ppy supporting that in the future, seeing as how it's currently unsupported=
.=20

Going forward I'll be happy to smoke-test new versions of OpenVPN on an ARM=
64 device, as long as I have one available.=20


Overall, I think ARM64 support only requires changes to tap-windows6 and th=
e build environment, but there are a lot of little changes. I'd love to hea=
r your feedback, and I'm sure I missed explaining something.

Thanks,
Jon Kunkee
=20
(Shout out to kitsune1, cron2, mattock, pekster, and others who have given =
me feedback on IRC to get me this far!)


