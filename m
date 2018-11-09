From: Jon Kunkee <jkunkee@...2393...>
Date: Fri, 9 Nov 2018 23:02:05 +0000
Message-ID: <DM5PR2101MB111297C51D45061C1CDC9563B0C60@...2412...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-4-simon@...2293...>
 <DM5PR2101MB1112DB68D163884AD7ACDA80B0C50@...2412...>
 <99D61A626FDA8A4B90A270669121BE109936403D@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE109936403D@...2294...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 4/5] Add MSI custom action for reliable
 Windows 10 detection
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
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

>> From what I gather, the OS version should be checked in the
>> CustomAction's MSI execution conditions instead of in the CustomAction
>> itself. The appropriate information can then be passed in based on that:
>>=20
>> https://blogs.msdn.microsoft.com/cjacks/2009/05/06/why-custom-actions-
>> get-a-windows-vista-version-lie-on-windows-7/

> The post on this link is true for Windows 7 (May 6, 2009). It's 2018 now =
and
> MSI's property VersionNT got stuck on Windows 8 (602 if I recall correctl=
y).

Quite right. I just talked to someone familiar with this here, and, as I un=
derstand=20
it, MSI will never offer a way to do this Right on Windows 10. I'm not sure=
 what=20
the general messaging is from Microsoft around MSI, but my personal=20
perception is that it is not moving forward anymore.

> I am open to suggestions, how to make a "regular/attestation signed/WHQL"
> selection logic in the MSI. MSI packages have up to three driver flavours
> packed and only one must be installed:
> - x86 MSI has regular+attestation signed
> - x64 has regular+attestation+WHQL
> - ARM64 will have attestation signed only

Fortunately, I *do* have a suggestion here...I think.

First, though, let's make sure I'm thinking straight: In your new system, t=
here=20
is an EXE that runs, detects the architecture, unpacks the right MSI, and r=
uns=20
the right MSI, right?

*If* I have that right, the EXE could be manifested as Windows-10-aware:

Manifest contents:
https://docs.microsoft.com/en-us/windows/desktop/SysInfo/targeting-your-app=
lication-at-windows-8-1
VS workflow:
https://docs.microsoft.com/en-us/cpp/build/how-to-embed-a-manifest-inside-a=
-c-cpp-application

Basically, you write an XML file and pack it in the EXE as a resource. Visu=
al=20
Studio will do this for you if the file is in your VS project source file l=
ist. I'm=20
not sure how you'd do this with mingw_w64, but you'd probably invoke the=20
equivalent of mt.exe:

https://stackoverflow.com/questions/1423492/how-do-i-add-a-manifest-to-an-e=
xecutable-using-mt-exe

The parent installer could then call GetVersionEx without being lied to and=
=20
pass it in to your CustomAction DLL through msiexec:

https://www.codeproject.com/articles/16767/how-to-pass-command-line-argumen=
ts-to-msi-installe

Let me know if that doesn't make sense or won't work for what you're doing.

Thanks,
Jon


