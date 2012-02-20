MIME-Version: 1.0
In-Reply-To: <4F420D7D.5020006@...515...>
References: <CAOazyz3S2GAFu+TN0s7482ovQBdWJYUxALVfOEiF6UGHR0oW0Q@...278...>
	<4F420D7D.5020006@...515...>
Date: Mon, 20 Feb 2012 13:02:58 +0200
Message-ID: <CAOazyz2PCAL7JPGZKG82bmF+OqbN7O6hnHZBxTL+PQkuy9+SPg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [DEVELOPER REQUESTED] Repackage TAP-Win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/2/20 Samuli Sepp=C3=A4nen <samuli@...515...>
> > Here are the tasks to perform:
> > 1. Create a GIT repository of the master TAP-Win32 sources with all
> > history, to ease our work, please use github.
> Any thoughts of this anyone? Personally, I don't care where the source
> code lives. It seems[1] that GitHub can send commit notifications to
> Buildbot directly, which would be nice. At the moment I have to poll the
> SF.net Git repo, which causes some delays.

github is much more comfortable than source forge, as you can do the
merge process and review process within its interface.
It supports a complete workflow which can be used in parallel to the
official commit process.
I suggest github so we can work on the changes, perfecting the patch
before submitting.

Can you please also split out the easy-rsa while you are at it?

> > 2. Detach the TAP-Win32 build from the OpenVPN build. It should be a
> > simpler build as it now only use the DDK.
> This sounds like a job for me. I'll get on to it after the 2.3-alpha1
> release and buildbot connection test integration; expect first patches
> in 2-3 weeks. This should be fairly trivial to do, as the Python build
> system is split into separate steps stored in separate modules already.

Will you do this?

> > 3. Rename the TAP-Win32 to TAP-Windows as we do not need the legacy
> > "Win32" any more.
> > 4. Rename the TAP common.h into tap-windows.h.
> > 5. Sync tap-windows.h symbols per [2], I added prefix and removed the
> > "32", add another header for version information.
> > 6. Create tap nsis installation (based on current openvpn nsis), the
> > msi must be silent installation mode enabled.
> This (6) is something I can do also. Will get on to this after my other
> stuff ^^^.

OK, so I will do 3-5, just give me repository location.

> > 7. Within installation, add a group "SDK" or similar to nsis to
> > install the tap-windows.h as well.
> > 8. Create build script to build and optionally sign the driver and the
> > msi.
> This (8) is already being done for the driver. However, the Python glue
> for signtool.exe is missing, so signing won't work at the moment. James
> uses his own tricks to sign the TAP-driver - I don't any of the details.
>
> That said, rewriting the functionality should be trivial. Anyone
> interested? I got tons of stuff on my plate already.

The signing stuff is trivial.
The nsis is the complicate task.

>
> > 9. Output of build system would be [at least] (msi, tarball) for
> > (win32, win64). Why tarball? To enable people to fetch files without
> > hacking the msi (example: cross compile).
> As I responsed to Karl, this is trivial to do; essentially it's just
> packaging the "dist" directory into a tarball after the Windows build.
> I'll do this for future releases, including 2.3-alpha1.
> > Anyone interested?
> > Need someone experienced with courage!
> >
> > Alon.
> >
> > [1] https://github.com/alonbl/openvpn branch build.
> > [2] https://github.com/alonbl/openvpn/blob/build/include/tap-windows.h
> >
> >
> > -----------------------------------------------------------------------=
-------
> > Virtualization & Cloud Management Using Capacity Planning
> > Cloud computing makes use of virtualization - but cloud computing
> > also focuses on allowing computing to be delivered as a service.
> > http://www.accelacomm.com/jaw/sfnl/114/51521223/
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

