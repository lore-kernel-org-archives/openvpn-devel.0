Message-ID: <4F420D7D.5020006@...515...>
Date: Mon, 20 Feb 2012 11:08:13 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz3S2GAFu+TN0s7482ovQBdWJYUxALVfOEiF6UGHR0oW0Q@...278...>
In-Reply-To: <CAOazyz3S2GAFu+TN0s7482ovQBdWJYUxALVfOEiF6UGHR0oW0Q@...278...>
Subject: Re: [Openvpn-devel] [DEVELOPER REQUESTED] Repackage TAP-Win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi Alon,
> Hello,
>
> We have a go to rewrite the OpenvPN build system.
> I started to work at core product [1].
>
> As part of the re-write we split out the TAP-Win32 out of OpenVPN code ba=
se.
>
> To make things go faster we may try to parallelize the effort.
>
> Here are the tasks to perform:
> 1. Create a GIT repository of the master TAP-Win32 sources with all
> history, to ease our work, please use github.
Any thoughts of this anyone? Personally, I don't care where the source
code lives. It seems[1] that GitHub can send commit notifications to
Buildbot directly, which would be nice. At the moment I have to poll the
SF.net Git repo, which causes some delays.

[1] <http://buildbot.net/buildbot/docs/0.8.4/Choosing-a-Change-Source.html>
> 2. Detach the TAP-Win32 build from the OpenVPN build. It should be a
> simpler build as it now only use the DDK.
This sounds like a job for me. I'll get on to it after the 2.3-alpha1
release and buildbot connection test integration; expect first patches
in 2-3 weeks. This should be fairly trivial to do, as the Python build
system is split into separate steps stored in separate modules already.
> 3. Rename the TAP-Win32 to TAP-Windows as we do not need the legacy
> "Win32" any more.
> 4. Rename the TAP common.h into tap-windows.h.
> 5. Sync tap-windows.h symbols per [2], I added prefix and removed the
> "32", add another header for version information.
> 6. Create tap nsis installation (based on current openvpn nsis), the
> msi must be silent installation mode enabled.
This (6) is something I can do also. Will get on to this after my other
stuff ^^^.
> 7. Within installation, add a group "SDK" or similar to nsis to
> install the tap-windows.h as well.
> 8. Create build script to build and optionally sign the driver and the ms=
i.
This (8) is already being done for the driver. However, the Python glue
for signtool.exe is missing, so signing won't work at the moment. James
uses his own tricks to sign the TAP-driver - I don't any of the details.

That said, rewriting the functionality should be trivial. Anyone
interested? I got tons of stuff on my plate already.

> 9. Output of build system would be [at least] (msi, tarball) for
> (win32, win64). Why tarball? To enable people to fetch files without
> hacking the msi (example: cross compile).
As I responsed to Karl, this is trivial to do; essentially it's just
packaging the "dist" directory into a tarball after the Windows build.
I'll do this for future releases, including 2.3-alpha1.
> Anyone interested?
> Need someone experienced with courage!
>
> Alon.
>
> [1] https://github.com/alonbl/openvpn branch build.
> [2] https://github.com/alonbl/openvpn/blob/build/include/tap-windows.h
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing=20
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


