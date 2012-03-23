Message-ID: <4F6D06C5.3030408@...1114...>
Date: Sat, 24 Mar 2012 00:27:01 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/52] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

On 29/02/12 21:11, Alon Bar-Lev wrote:
> 1. Many cleanups.
> 2. New directory layout.
> 3. Remove easy-rsa, install-win32, windows build, tap-win32.
> 4. Standard autotools build system.
> 5. msbuild build system.
> 6. Split out most of platform specific code.

All patches in this patch set has been ACKed, and I've pushed out a new
master branch with these changes.  Below is a completely git history
with all commits references and ACK credits.

Thanks a lot to Alon for his hard work on this patch set.  But we must
beware that more changes and improvements will come in the near future
too.  Many improvements are to come on top of this.


kind regards,

David Sommerseth



commit 0e4b6c455e0236a4eb45eb1df869b5ce0b97518a
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:22 2012 +0200

    build: use tap-windows.h as external dependency

    tap-windows.h is provided by the tap project

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 880a2ae97c44d75a3529adda8a11e266fb61092e
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:21 2012 +0200

    build: distribute samples in windows

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 6187644b660ce284d0a706811eae2dce7cb411b2
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:20 2012 +0200

    build: windows: install version.sh to allow installer read version

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 14a131ac1cfc95e5ba2518ff887d04c034aecc53
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:19 2012 +0200

    build: move wrappers into platform module

    + Some fixups within the platform.c functions.
    - need to check environment set on Windows.

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 72c7b12cb65cee69ea129cc520b26dcc64977a17
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:18 2012 +0200

    cleanup: move console related function into its own module

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit f106f64b1cc228b3b937ed15a1a45bc28edefed9
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:17 2012 +0200

    build: move inet_ntop(), inet_pton() emulation into compat

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 7b49c16761b4a11f1f0846cd46bd7194392efbfa
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:16 2012 +0200

    build: move daemon() emulation into compat

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 3d163bc544ab9dfc62d9a2c865f8abb865bf6eb3
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:15 2012 +0200

    build: move gettimeofday() emulation to compat

    Remove all references to gettimeofday() from main project.

    SIDE EFFECT: mingw will use its own internal gettimeofday().

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit dc81e743989640cc681a40e69455cc9fc736ab9c
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:14 2012 +0200

    build: split out compat

    compat should not use any of the main project headers or conventions,
    it should be a standalone library that provides missing library
    functions.

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit c110b289eced4a792fd7c7c29e651b22f602fd24
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:13 2012 +0200

    build: move out config.h include from syshead

    Yet another step in reducing the syshead.h content.

    Conditional compilation of sources needs to be based on
    a minimum program prefix (config.h only).

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 4b1a82db0975088dbfe69c2a97f0a96ef972b2a4
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:12 2012 +0200

    build: win-msvc: msbuild format

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 709f7a1f73baade82f07146273d31d53007f394d
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:11 2012 +0200

    build: autoconf: update defaults for options

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 9b33b5a4b1aa170080d18b0f32f6599b519589f0
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:10 2012 +0200

    build: proper crypto detection and usage

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 74bbc71b75bac49f5c9df81827fa184b8a365d36
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:09 2012 +0200

    build: proper lzo detection and usage

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 0708426170fd578f598fb0f0d3df78bd1fca7117
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:08 2012 +0200

    build: properly process lzo-stub

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 18b5fbdfb3aba63a62de197b4931cac77af2323c
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:07 2012 +0200

    build: proper pkcs11-helper detection and usage

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit e06832a7edcf93e0feda8802beea55a3cc7ddf9f
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:06 2012 +0200

    build: distribute pkg.m4

    RHEL and others do not install this globally, so we provide our own
copy.

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit cd5990e0e0da1621b9c2d9ca927ff8d1af3c241a
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:05 2012 +0200

    build: proper selinux detection and usage

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit cab53332e11b9a447883da0c95552c453f760f0b
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:04 2012 +0200

    build: autoconf: minor cleanups

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 7647a48c2d2c446ee387316389085fe83c6ef894
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:03 2012 +0200

    build: properly detect and use socket libs

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit bdae41107ddde61cae5ae2037c1420b539c52ff8
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:02 2012 +0200

    build: libdl usage

    1. properly detect.
    2. Link only required components.
    3. No way we don't have LoadLibrary on Windows.
    4. ENABLE_PLUGIN should be controlled in autoconf.

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit c3fc703d31f47ceef66bc8006e2870e3c4d05ee6
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:01 2012 +0200

    build: autoconf: commands as environment

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 98bc1a3e06a11be62bb1f5ab3d7c1b98dfbabbaa
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:12:00 2012 +0200

    build: add libtool + windows resources for executables

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 34cb9132ef2dae08f91a66015ea5437539a4b557
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:59 2012 +0200

    build: standard directory layout

    Suitable for mature project.

    root   - administrative stuff
    doc    - documents
    src    - sources
    tests  - tests
    distro - distro specific files
    sample - samples

    SIDE EFFECT: many changes to rpm spec.

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit fcff80aac1f71ebf881fbc269fb3c4df0789de6b
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:58 2012 +0200

    build: remove awk and non-standard autoconf output processing

    Replace with simpler environment solution.

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit e02570fd7d1f7fcc0928b42c0f7a7bb597e80208
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:57 2012 +0200

    build: autoconf: remove OPENVPN_ADD_LIBS useless macro

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 51bd56f46f55177cf0f8b7811b35a009e150d55e
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:56 2012 +0200

    build: autotools: first pass of trivial autotools changes

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 0dbd45db7d76fdff9fbaa64d147c2d2278492efc
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:55 2012 +0200

    build: m4/ax_socklen_t.m4: cleanup

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit bdd80be1fed0f4b3956246a44082a4226362074d
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:54 2012 +0200

    build: m4/ax_emptyarray.m4: cleanup

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit c5c3cef6d374108ca230d701c86fe0b812e2cd3f
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:53 2012 +0200

    build: m4/ax_varargs.m4: cleanup

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 0fc5b8b3390797b67bc48036649109a78f36a186
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:52 2012 +0200

    build: split acinclude.m4 into m4/*

    ax_emptyarray.m4  ax_openvpn_lib.m4  ax_socklen_t.m4  ax_varargs.m4

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit d313dc950308d960f550279a69f445e712244beb
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:51 2012 +0200

    build: remove windows specific build system

    It will be completely re-written in future

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit ac2447cd533763a7240f12603eab463ebb5c4bac
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:50 2012 +0200

    cleanup: rename tap-windows function from win32 to win

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 8e3ca1f6c1400f4a9275760d1680a65bb4a99eae
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:49 2012 +0200

    Remove tap-win32

    Introduce tap-windows.h which is modified tap-win32/common.h.
    Except of function rename, it is the same without the tap_id.
    This file should be provided as part of tap-win32 MSI.
    For now we hold a copy.

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 26abb83cb1cf0c331db875186250b0c8d55d6013
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:48 2012 +0200

    Remove easy-rsa

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 30029449d475c1e45f080d7481e4c7bf762b2480
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:47 2012 +0200

    Remove install-win32

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 31d19917af05d7730e3c397ade5bb9c21c047bef
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:46 2012 +0200

    build: we need the sample.ovpn in future

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit fbae7d2b7e94a7849e086f08cbb424aee32391a7
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:45 2012 +0200

    build: plugins: properly use CC, CFLAGS and LDFLAGS

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 5c2922c4593b7eedc3f9c93958285d67afeb0d37
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:44 2012 +0200

    build: rename plugin directory to plugins

    This to avoid conflit with plugin.c rules

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit ce3862789e5443758441c905569703577e67525a
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:43 2012 +0200

    build: handle printf style format in mingw

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 195b17e9f2d197b591221153c853f8d458b1c259
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:42 2012 +0200

    Update .gitignore

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit bae6143d3fa1bf47d36d6f3a55afcd26aa8403e4
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:41 2012 +0200

    build: correct place to alter WINVER is at build system

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 16d909e2c88f49231475c4163541394e16969d45
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:40 2012 +0200

    fixup: init.c: add missing conditional for ENABLE_CLIENT_CR

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 553d95da5a5663e371c0cf35356a8fdfdc22975b
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:39 2012 +0200

    cleanup: memcmp.c: remove unused source

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 8a4eaf5aa6debaca434b1bd2099394724edb31d9
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:38 2012 +0200

    cleanup: tun.c: fix incorrect option in message (ip-win32)

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 435b02dceee397a630c8fe7f08cbdcac11820e1a
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:37 2012 +0200

    cleanup: crypto_openssl.c: remove support for pre-openssl-0.9.6

    autoconf rejecting this anyway:
    ----
    AC_MSG_CHECKING([that OpenSSL Library is at least version 0.9.6])
    <snip>
    AC_MSG_ERROR([OpenSSL crypto Library is too old.])
    ----

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 68c7df22639c60b243dce4459e04e572fd32a3ed
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:36 2012 +0200

    cleanup: remove redundant ';'

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit b2c1643eabfc27c662510401c1841ca5fe721593
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:35 2012 +0200

    cleanup: win32.c: wrong printf format

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit cc8dd14442ed10a2a7079d1707a045a33e451c13
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:34 2012 +0200

    cleanup: remove C++ warnings

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 74b6d864453d757a59e7b33d0415a5af6da22d76
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:33 2012 +0200

    cleanup: options.c: remove redundant include

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit b3c099d5dd249f7e2b8b5fcef5e795d88aaf35d4
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:32 2012 +0200

    package: rpm: strip should be handled by package management

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit e87f4b611d4f75fda908838160a39a0aea992fdc
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Feb 29 22:11:31 2012 +0200

    build: version should not contain '-'

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

