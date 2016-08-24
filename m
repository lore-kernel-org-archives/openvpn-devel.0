References: <c5ed5448-cff1-7407-7aa1-794e34455b72@...515...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <32453cb2-3c27-aae6-5ee6-6f0edd669d91@...68...>
Date: Thu, 25 Aug 2016 00:18:04 +0200
MIME-Version: 1.0
In-Reply-To: <c5ed5448-cff1-7407-7aa1-794e34455b72@...515...>
Content-Type: multipart/mixed; boundary="------------35046A1214C8E5FD57226933"
Subject: Re: [Openvpn-devel] OpenVPN 2.3.12 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------35046A1214C8E5FD57226933
Content-Type: multipart/alternative;
	boundary="------------CEF65222FEF57DA274F499ED"

--------------CEF65222FEF57DA274F499ED
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 23.08.2016 um 17:52 schrieb Samuli Sepp=E4nen:
> The OpenVPN community project team is proud to release OpenVPN 2.3.12.=20
> It can be downloaded from here:
>
> <http://openvpn.net/index.php/open-source/downloads.html>
>
> This release includes many small improvements and fixes. This is the=20
> first release that actively discourages the use of 64-bit block ciphers=20
> for security reasons. A full list of changes is available here:
>
> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>

Hi everyone,

thanks for handling the release.

The 2.3.12 tarball does not seem to pack the stuff needed for cmocka,
and even if it did, there seem to be issues with:

 1. out-of-source builds (aka: autoreconf -sivf && mkdir _build && cd
    _build && ../configure -C && make -j4 check) - for these, ${srcdir}/
    needs to be prefixed to the cmocka check, see patch (note: this is
    against the _/master/_ branch but can be cherry-picked onto
    release/2.3 without a hitch -
    also note that the patch does not support dangerous characters in
    srcdir.)
 2. cmocka.h needs to either be installed (not currently checked), or we
    need to add proper -I and -L options so that cmocka can be used locally,
 3. the build needs to figure whether to use a local or system-wide cmocka.

I am currently upgrading the FreeBSD port, chasing framework updates
etc. so don't have time to look too much into that, beyond the attached
patch that solves (1.) above partially. The FreeBSD port of OpenVPN will
forego the unit tests, and I will patch the warning out so I don't get
"but just add cmake as a requisite" spam - which, when rectified, would
lead to (2.) above...

Cheers,

Matthias


--------------CEF65222FEF57DA274F499ED
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Am 23.08.2016 um 17:52 schrieb Samuli
      Sepp=E4nen:<br>
    </div>
    <blockquote
      cite=3D"mid:c5ed5448-cff1-7407-7aa1-794e34455b72@...515..."
      type=3D"cite">
      <pre wrap=3D"">The OpenVPN community project team is proud to release=
 OpenVPN 2.3.12.=20
It can be downloaded from here:

<a class=3D"moz-txt-link-rfc2396E" href=3D"http://openvpn.net/index.php/ope=
n-source/downloads.html">&lt;http://openvpn.net/index.php/open-source/downl=
oads.html&gt;</a>

This release includes many small improvements and fixes. This is the=20
first release that actively discourages the use of 64-bit block ciphers=20
for security reasons. A full list of changes is available here:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/wiki/ChangesInOpenvpn23">&lt;https://community.openvpn.net/openvpn/wi=
ki/ChangesInOpenvpn23&gt;</a>
</pre>
    </blockquote>
    <p>Hi everyone,</p>
    <p>thanks for handling the release.<br>
    </p>
    <p>The 2.3.12 tarball does not seem to pack the stuff needed for
      cmocka, and even if it did, there seem to be issues with:</p>
    <ol>
      <li>out-of-source builds (aka: <tt>autoreconf -sivf &amp;&amp;
          mkdir _build &amp;&amp; cd _build &amp;&amp; ../configure -C
          &amp;&amp; make -j4 check</tt>) - for these, <tt>${srcdir}/</tt>
        needs to be prefixed to the cmocka check, see patch (note: this
        is against the <u><i>master</i></u> branch but can be
        cherry-picked onto release/2.3 without a hitch - <br>
        also note that the patch does not support dangerous characters
        in srcdir.)<br>
      </li>
      <li>cmocka.h needs to either be installed (not currently checked),
        or we need to add proper -I and -L options so that cmocka can be
        used locally,</li>
      <li>the build needs to figure whether to use a local or
        system-wide cmocka.</li>
    </ol>
    <p>I am currently upgrading the FreeBSD port, chasing framework
      updates etc. so don't have time to look too much into that, beyond
      the attached patch that solves (1.) above partially. The FreeBSD
      port of OpenVPN will forego the unit tests, and I will patch the
      warning out so I don't get "but just add cmake as a requisite"
      spam - which, when rectified, would lead to (2.) above...</p>
    <p>Cheers,</p>
    <p>Matthias<br>
    </p>
  </body>
</html>

--------------CEF65222FEF57DA274F499ED--

--------------35046A1214C8E5FD57226933
Content-Type: text/x-patch;
	name="0001-Make-CMOCKA_INITIALIZED-check-work-on-VPATH-out-of-s.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-Make-CMOCKA_INITIALIZED-check-work-on-VPATH-out-of-s.pa";
	filename*1="tch"

=46rom 9595ff1b4d89b8f25b742f1c105533dc12a3e276 Mon Sep 17 00:00:00 2001
From: Matthias Andree <matthias.andree@...68...>
Date: Thu, 25 Aug 2016 00:13:58 +0200
Subject: [PATCH] Make CMOCKA_INITIALIZED check work on VPATH (out-of-sour=
ce)
 builds.

---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4f14ebd..341105c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1215,7 +1215,7 @@ AC_SUBST([TEST_CFLAGS])
 # needed for unit testing
 AC_CHECK_PROGS([CMAKE], [cmake])
 if test -n "${CMAKE}"; then
-   if test -f vendor/cmocka/CMakeLists.txt; then
+   if test -f ${srcdir}/vendor/cmocka/CMakeLists.txt; then
       AM_CONDITIONAL([CMOCKA_INITIALIZED], [true])
    else
       AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])
--=20
2.7.4


--------------35046A1214C8E5FD57226933--

