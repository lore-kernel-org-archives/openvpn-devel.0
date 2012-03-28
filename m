MIME-Version: 1.0
In-Reply-To: <1332935990-26510-1-git-send-email-alon.barlev@...277...>
References: <CAOazyz35uT3nK=93mLzVewNO8q9p_uDtsQcGVbeLT3R3zg+W3w@...278...>
	<1332935990-26510-1-git-send-email-alon.barlev@...277...>
Date: Wed, 28 Mar 2012 14:05:44 +0200
Message-ID: <CAOazyz2xgNeb-hxuMzcMzg5HEPpoPkx=b6nhtQ06C6jLuX75QQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: automake fixups
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
To: openvpn-devel@lists.sourceforge.net

On Wed, Mar 28, 2012 at 1:59 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> 1. Rename resource includes to rch, see[1].
> 2. Use implicit rule for resources.
> 3. Fixup resources build using automake conventions.
> 4. Misc cleanups
>
> [1] http://comments.gmane.org/gmane.comp.gnu.binutils/56459
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 51 ++++---
> =C2=A0res/openvpn-gui-res-de.rc =C2=A0| =C2=A0343 -----------------------=
-------------------
> =C2=A0res/openvpn-gui-res-de.rch | =C2=A0343 ++++++++++++++++++++++++++++=
++++++++++++++
> =C2=A0res/openvpn-gui-res-dk.rc =C2=A0| =C2=A0342 -----------------------=
-------------------
> =C2=A0res/openvpn-gui-res-dk.rch | =C2=A0342 ++++++++++++++++++++++++++++=
++++++++++++++
> =C2=A0res/openvpn-gui-res-en.rc =C2=A0| =C2=A0340 -----------------------=
------------------
> =C2=A0res/openvpn-gui-res-en.rch | =C2=A0340 ++++++++++++++++++++++++++++=
+++++++++++++
> =C2=A0res/openvpn-gui-res-es.rc =C2=A0| =C2=A0339 -----------------------=
------------------
> =C2=A0res/openvpn-gui-res-es.rch | =C2=A0339 ++++++++++++++++++++++++++++=
+++++++++++++
> =C2=A0res/openvpn-gui-res-fi.rc =C2=A0| =C2=A0357 -----------------------=
---------------------
> =C2=A0res/openvpn-gui-res-fi.rch | =C2=A0357 ++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A0res/openvpn-gui-res-fr.rc =C2=A0| =C2=A0339 -----------------------=
------------------
> =C2=A0res/openvpn-gui-res-fr.rch | =C2=A0339 ++++++++++++++++++++++++++++=
+++++++++++++
> =C2=A0res/openvpn-gui-res-it.rc =C2=A0| =C2=A0338 -----------------------=
------------------
> =C2=A0res/openvpn-gui-res-it.rch | =C2=A0338 ++++++++++++++++++++++++++++=
+++++++++++++
> =C2=A0res/openvpn-gui-res-jp.rc =C2=A0| =C2=A0341 -----------------------=
-------------------
> =C2=A0res/openvpn-gui-res-jp.rch | =C2=A0341 ++++++++++++++++++++++++++++=
++++++++++++++
> =C2=A0res/openvpn-gui-res-nl.rc =C2=A0| =C2=A0339 -----------------------=
------------------
> =C2=A0res/openvpn-gui-res-nl.rch | =C2=A0339 ++++++++++++++++++++++++++++=
+++++++++++++
> =C2=A0res/openvpn-gui-res-no.rc =C2=A0| =C2=A0325 -----------------------=
-----------------
> =C2=A0res/openvpn-gui-res-no.rch | =C2=A0325 ++++++++++++++++++++++++++++=
++++++++++++
> =C2=A0res/openvpn-gui-res-pl.rc =C2=A0| =C2=A0342 -----------------------=
-------------------
> =C2=A0res/openvpn-gui-res-pl.rch | =C2=A0342 ++++++++++++++++++++++++++++=
++++++++++++++
> =C2=A0res/openvpn-gui-res-pt.rc =C2=A0| =C2=A0327 -----------------------=
-----------------
> =C2=A0res/openvpn-gui-res-pt.rch | =C2=A0327 ++++++++++++++++++++++++++++=
++++++++++++
> =C2=A0res/openvpn-gui-res-se.rc =C2=A0| =C2=A0336 -----------------------=
------------------
> =C2=A0res/openvpn-gui-res-se.rch | =C2=A0336 ++++++++++++++++++++++++++++=
+++++++++++++
> =C2=A0res/openvpn-gui-res-tr.rc =C2=A0| =C2=A0341 -----------------------=
-------------------
> =C2=A0res/openvpn-gui-res-tr.rch | =C2=A0341 ++++++++++++++++++++++++++++=
++++++++++++++
> =C2=A0res/openvpn-gui-res.rc =C2=A0 =C2=A0 | =C2=A0 28 ++--
> =C2=A030 files changed, 4791 insertions(+), 4786 deletions(-)
> =C2=A0create mode 100644 m4/.keep
> =C2=A0delete mode 100644 res/openvpn-gui-res-de.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-de.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-dk.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-dk.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-en.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-en.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-es.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-es.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-fi.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-fi.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-fr.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-fr.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-it.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-it.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-jp.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-jp.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-nl.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-nl.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-no.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-no.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-pl.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-pl.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-pt.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-pt.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-se.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-se.rch
> =C2=A0delete mode 100644 res/openvpn-gui-res-tr.rc
> =C2=A0create mode 100644 res/openvpn-gui-res-tr.rch
>
> diff --git a/Makefile.am b/Makefile.am
> index c1753e0..349db19 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -18,8 +18,7 @@
> =C2=A0# =C2=A0distribution); if not, write to the Free Software Foundatio=
n, Inc.,
> =C2=A0# =C2=A059 Temple Place, Suite 330, Boston, MA =C2=A002111-1307 =C2=
=A0USA
>
> -RCCOMPILE =3D $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
> - =C2=A0 =C2=A0$(AM_CPPFLAGS) $(CPPFLAGS)
> +SUFFIXES =3D .rc
>
> =C2=A0AUTOMAKE_OPTIONS =3D foreign 1.9
>
> @@ -31,6 +30,8 @@ MAINTAINERCLEANFILES =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(srcdir)/depcomp $(srcdir)/aclocal.m4 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(srcdir)/config.guess $(srcdir)/config.sub
>
> +EXTRA_DIST =3D .gitignore
> +
> =C2=A0bin_PROGRAMS =3D openvpn-gui
>
> =C2=A0dist_doc_DATA =3D \
> @@ -42,21 +43,20 @@ AM_CPPFLAGS =3D -D_UNICODE
> =C2=A0AM_CFLAGS =3D -municode
>
> =C2=A0openvpn_gui_RESOURCES =3D \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-de.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-dk.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-en.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-es.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-fi.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-fr.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-it.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-jp.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-nl.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-no.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-pl.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-pt.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-se.rc \
> - =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-tr.rc \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-de.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-dk.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-en.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-es.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-fi.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-fr.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-it.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-jp.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-nl.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-no.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-pl.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-pt.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-se.rch \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res-tr.rch \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res/connected.ico \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res/connecting.ico \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res/disconnected.ico \
> @@ -64,8 +64,6 @@ openvpn_gui_RESOURCES =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res/reconnecting.ico \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res/openvpn-gui.manifest
>
> -EXTRA_DIST =3D $(openvpn_gui_RESOURCES)
> -
> =C2=A0openvpn_gui_SOURCES =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0main.c main.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn.c openvpn.h \
> @@ -82,14 +80,21 @@ openvpn_gui_SOURCES =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_config.c \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_config.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0chartable.h \
> - =C2=A0 =C2=A0 =C2=A0 openvpn-gui-res.h
> + =C2=A0 =C2=A0 =C2=A0 openvpn-gui-res.h \
> + =C2=A0 =C2=A0 =C2=A0 res/openvpn-gui-res.rc \
> + =C2=A0 =C2=A0 =C2=A0 $(openvpn_gui_RESOURCES)
>
> -openvpn_gui_LDFLAGS =3D -mwindows
> =C2=A0openvpn_gui_LDADD =3D \
> - =C2=A0 =C2=A0 =C2=A0 openvpn-gui-res.o \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(OPENSSL_CRYPTO_LIBS) \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-lws2_32 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-lcomctl32
> +openvpn_gui_LDFLAGS =3D \
> + =C2=A0 =C2=A0 =C2=A0 -mwindows
> +
> +$(srcdir)/res/openvpn-gui-res.rc: $(openvpn_gui_RESOURCES) $(srcdir)/ope=
nvpn-gui-res.h
> + =C2=A0 =C2=A0 =C2=A0 touch "$(srcdir)/res/openvpn-gui-res.rc"
>
> -openvpn-gui-res.o: $(openvpn_gui_RESOURCES) $(srcdir)/openvpn-gui-res.h
> +RCCOMPILE =3D $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
> + =C2=A0 =C2=A0 =C2=A0 $(AM_CPPFLAGS) $(CPPFLAGS)
> +.rc.o:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(RCCOMPILE) -i $< -o $@

OK, too large for mailing list again...
Full patch is at[1].

Alon

[1] https://github.com/alonbl/openvpn-gui/commit/8ceead092ca498906f289042ae=
23991fb651ebe1

