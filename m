From: Simon Rozman <simon@...2293...>
Date: Thu, 3 May 2018 10:13:21 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10862E0F5C@...2294...>
References: <DM5PR21MB0185FC110A99E76426A1603FB08D0@...2394...>
 <9fb8c0a0-b1d1-2834-dd42-d0abece8529e@...515...>
 <99D61A626FDA8A4B90A270669121BE10862E0950@...2294...>
 <DM5PR21MB0185BFF553A864FE338B6EC9B0800@...2394...>
In-Reply-To: <DM5PR21MB0185BFF553A864FE338B6EC9B0800@...2394...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN on ARM64 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
To: Jon Kunkee <jkunkee@...2393...>, =?iso-8859-2?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Marc Sweetgall <marcs@...2393...>

Hi Jon,

> What system are you using to generate MSIs? Marc (CC'd) has a patch for W=
IX
> that adds support for generating ARM64 MSIs.

I am using a WiX to make two separate MSI files (x86 and x64). This is the =
easy part - I had the WiX MSI package ready back at Hackatlon in an hour or=
 so. However, those MSI files do not create a TAP interface on install -- w=
hich is a regression.

The TAP interface will be created on install using a custom action (DLL). I=
 want to support MSI custom action deferred/commit/rollback functionality i=
n full.

An additional EXE command line utility will be included in the install to a=
llow later TAP interface management completely replacing the tapinstall.exe=
/devcon.exe.

> Are you wrapping two arch-specific MSIs in an EXE, or doing one mixed MSI?
> Two MSIs will be very simple to add ARM64 to, while one mixed MSI will be
> harder.

I see no drawbacks compiling the custom action DLL and EXE command line uti=
lity for ARM64 platform and providing a third MSI file for ARM64 platform a=
s you suggest. This is the best way to go in my opinion too.

Finally, the plan is to offer TAP driver binaries for download as separate =
platform-specific MSI files (for IT admins) and a simple self-extractable x=
86 EXE containing all the MSI files and a "detect-platform-and-launch-appro=
priate-MSI" bootstrapper (for end-users). For this EXE bundle WiX, 7-Zip or=
 some other easy to implement and maintain framework is to be used.

> As for tapinstall, a standalone tapinstall under VS2017 will work perfect=
ly with
> what I'm building since the EWDK consumes the vcxproj and sln files direc=
tly.=20

The new MSI custom action and EXE utility I am working on it are built usin=
g vcxproj. If we get a green light to port the driver building itself to a =
vcxproj as well, the TAP driver build environment could move from Python to=
 VS2017.

However, while we can potentially renew the TAP driver build process (being=
 Windows-only), we are limited with options when packaging OpenVPN for Wind=
ows. For OpenVPN Windows packaging, the requirement to prepare MSI files wi=
thin the Linux environment remains. After a discussion msitools package was=
 chosen for the job.

Yes, I must kick myself and start working on this seriously!?

Best regards,
Simon

