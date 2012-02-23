MIME-Version: 1.0
In-Reply-To: <CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOazyz1buhSdSF7g6MzePAiQ=irD_Qo-RKPC_jXoR9AVqbtkvQ@...278...>
	<CAOBzU4P0SxY-jF7rb_HsvmtSH8i9PCk+qe5iDQiwJhajsBuYuw@...278...>
	<CAOazyz1naScdf+M0pnePS6-bb5deAHsAniTiv+DFw3ZQdAN+kg@...278...>
	<CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
Date: Thu, 23 Feb 2012 22:19:31 +0200
Message-ID: <CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello Again,

Now the openvpn-build supports creating nsis installation package, including
singing. Output package is at[1].

Notice that all process is done on Linux, Windows is not need to
create the package!

The process:
1. Create binaries using openvpn-build/generic.
2. Create tarball for easyrsa from master (temporary) files should be
at easy-rsa-2.0.
3. Create the installer using openvpn-build/windows-nsis.

I did not add the UI stuff, I think there should be a discussion why
these are embedded.

Alon.

[1] https://github.com/downloads/alonbl/openvpn/openvpn-install-2.3-alpha1-I000.exe

On Thu, Feb 23, 2012 at 2:45 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Hello All,
>
> I've reached 2nd milestone in rewrite the build system.
>
> So far:
> 1. autotools cleaned up >=autoconf-2.59, >=automake-1.9, >=libtool-1.5
> (not for cross compile)
> 2. build working for gcc/mingw.
> 3. build is working for MSVC using msbuild.
> 4. build script for cross compilers.
> 5. build script for MSVC.
> 6. perper directory structure.
> 7. compat library is standalone library.
> 8. most of platform specific [simple] wrapper renamed to platform_
> prefix and moved to platform module.
> 9. more cleanups of conditional compilations.
>
> This point is far enough from master to stop and test.
> I believe that after testing we can merge this.
> It is important to test and merge ASAP as it will be difficult to
> rebase new patches pushed to master.
>
> As usual git repository is available[1] and tarball is also available[2].
>
> Next milestone will be to split up syshead.h, move all conditionals to
> autoconf and reduce headers. This will also create a lot of noise.
>
> Alon.
>
> [1] https://github.com/alonbl/openvpn
> [2] https://github.com/alonbl/openvpn/downloads

