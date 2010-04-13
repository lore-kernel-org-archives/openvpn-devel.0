Message-ID: <4BC4766A.3040601@...1114...>
Date: Tue, 13 Apr 2010 15:49:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1269951178-30419-1-git-send-email-dazo@...384...>	
	<4BBE3205.1040303@...1114...>	
	<p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>
	<h2z9e0cf0bf1004100035rc34e5c17rb7cb8554ba64509@...278...>
In-Reply-To: <h2z9e0cf0bf1004100035rc34e5c17rb7cb8554ba64509@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig91CC61EFD7811A3013451409"
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
 ./configure to --version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91CC61EFD7811A3013451409
Content-Type: multipart/mixed; boundary="------------010500000606050106050400"

This is a multi-part message in MIME format.
--------------010500000606050106050400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10/04/10 09:35, Alon Bar-Lev wrote:
> Also there is no proper dependency for configure.h in Makefile.am so
> it won't be built.
> Proper way to do so is like I done for OpenSC [1], look for OPENSC_FEATUR=
ES.
>=20
> [1] http://www.opensc-project.org/opensc/browser/trunk/configure.ac#L613

Thank you for catching this one.  I've obviously been too sloppy with
'make distcheck', which would have detected this one.

Even though I see you build up a string in configure.ac with enabled
features in your example [1], I personally feel that approach is less
flexible.  When this feature was implemented I considered that approach
as well, but I found it would require much more changes to configure.ac.
 It would also make it possible to skip listing enabled features, just
by forgetting to add the feature to the feature list.

The awk approach has the advantage of dynamically building up a list of
features found in ./config.h.  And in addition, the current
implementation also show which arguments was used with ./configure.

I've attached three patches, which cleans up this feature further.


kind regards,

David Sommerseth


> On Sat, Apr 10, 2010 at 10:05 AM, Alon Bar-Lev <alon.barlev@...277...> wr=
ote:
>> Highly none standard autotools usage.
>> Also requires awk which may not be available.
>> Please REVERT.
>>
>> On Thu, Apr 8, 2010 at 10:44 PM, David Sommerseth
>> <openvpn.list@...1114...> wrote:
> On 30/03/10 14:12, David Sommerseth wrote:
>>>>> This patch will create ./configure.h which will contain two new #defi=
ne
>>>>> strings.  CONFIGURE_DEFINES will contain all USE, ENABLED, DISABLED a=
nd
>>>>> DEPRECATED defines from ./config.h.  CONFIGURE_CALL will contain the
>>>>> complete ./configure line which was used when configuring the package
>>>>> for building.
>>>>>
>>>>> Signed-off-by: David Sommerseth <dazo@...384...>
>>>>> ---
>>>>>  Makefile.am       |    7 +++++++
>>>>>  configure_h.awk   |   39 +++++++++++++++++++++++++++++++++++++++
>>>>>  configure_log.awk |   36 ++++++++++++++++++++++++++++++++++++
>>>>>  options.c         |    3 +++
>>>>>  4 files changed, 85 insertions(+), 0 deletions(-)
>>>>>  create mode 100644 configure_h.awk
>>>>>  create mode 100644 configure_log.awk
>=20
> Applied to the openvpn-testing.git feat_misc branch.  To be merged into
> allmerged soon.
> Commit f27bf509315a48b0070294c3993a718df0c2626c
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>>>
---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>


--------------010500000606050106050400
Content-Type: text/x-patch;
	name="0001-Fix-dependency-checking-for-configure.h.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Fix-dependency-checking-for-configure.h.patch"

=46rom c8b840a50a64dfd03bec3a7ed3beb486c3a55f90 Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Tue, 13 Apr 2010 15:07:51 +0200
Subject: [PATCH 1/3] Fix dependency checking for configure.h

Alon Bar-Lev indicated commit f27bf509315a48b0070294c3993a718df0c2626c
was missing proper dependency checking.  This patch corrects this and
fixes an issue when creating configure.h via make distcheck.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 Makefile.am       |   10 +++++++---
 configure_log.awk |    8 ++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 20453d0..f509a4b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -66,7 +66,8 @@ dist_noinst_SCRIPTS =3D \
 	$(TESTS) \
 	doclean \
 	domake-win \
-	t_cltsrv-down.sh
+	t_cltsrv-down.sh \
+	configure_h.awk configure_log.awk
=20
 dist_noinst_DATA =3D \
 	openvpn.spec \
@@ -141,9 +142,12 @@ openvpn_SOURCES =3D \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
=20
+nodist_openvpn_SOURCES =3D configure.h
+options.$(OBJEXT): configure.h
+
 configure.h: Makefile
-	awk -f configure_h.awk config.h > $@
-	awk -f configure_log.awk config.log >> $@
+	awk -f $(srcdir)/configure_h.awk config.h > $@
+	awk -f $(srcdir)/configure_log.awk config.log >> $@
=20
 clean-local:
 	-rm -f configure.h
diff --git a/configure_log.awk b/configure_log.awk
index b305f71..6245168 100644
--- a/configure_log.awk
+++ b/configure_log.awk
@@ -30,7 +30,11 @@
 BEGIN {
 	printf ("#define CONFIGURE_CALL \"")
 }
-/\$ .\/configure/ {
-	print $0,"\""
+/\$ (.).\/configure/ {
+	printf ("%s", $0)
 	exit 0
 }
+
+END {
+	printf ("\"\n")
+}
--=20
1.6.6.1


--------------010500000606050106050400
Content-Type: text/x-patch;
	name="0002-Make-use-of-automake-CLEANFILES-variable-instead-of-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0002-Make-use-of-automake-CLEANFILES-variable-instead-of-.pa";
	filename*1="tch"

=46rom a260aa387846e6f12db58d120e1d61ce4732b30e Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Tue, 13 Apr 2010 15:12:27 +0200
Subject: [PATCH 2/3] Make use of automake CLEANFILES variable instead of =
clean-local rule

Signed-off-by: David Sommerseth <dazo@...384...>
---
 Makefile.am |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f509a4b..76573d1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -38,7 +38,7 @@ MAINTAINERCLEANFILES =3D \
 	$(srcdir)/depcomp $(srcdir)/aclocal.m4 \
 	$(srcdir)/config.guess $(srcdir)/config.sub \
 	$(srcdir)/config-win32.h $(srcdir)/openvpn.spec
-CLEANFILES =3D openvpn.8.html
+CLEANFILES =3D openvpn.8.html configure.h
=20
 EXTRA_DIST =3D \
 	easy-rsa \
@@ -149,9 +149,6 @@ configure.h: Makefile
 	awk -f $(srcdir)/configure_h.awk config.h > $@
 	awk -f $(srcdir)/configure_log.awk config.log >> $@
=20
-clean-local:
-	-rm -f configure.h
-
 dist-hook:
 	cd $(distdir) && for i in $(EXTRA_DIST) $(SUBDIRS) ; do find $$i -name =
=2Esvn -type d -prune -exec rm -rf '{}' ';' ; rm -f `find $$i -type f | g=
rep -E '(^|\/)\.?\#|\~$$|\.s?o$$'` ; done
=20
--=20
1.6.6.1


--------------010500000606050106050400
Content-Type: text/x-patch;
	name="0003-Don-t-add-compile-time-information-if-enable-small-i.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0003-Don-t-add-compile-time-information-if-enable-small-i.pa";
	filename*1="tch"

=46rom d940d655fd489ae1ec37ed7d4eabbdafb69fd6ca Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Tue, 13 Apr 2010 15:20:56 +0200
Subject: [PATCH 3/3] Don't add compile time information if --enable-small=
 is used

This is to satisfy those wanting to build openvpn for embedded devices
where every bytes matters.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 options.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index 25936d1..1cfa11a 100644
--- a/options.c
+++ b/options.c
@@ -2752,8 +2752,10 @@ usage_version (void)
   msg (M_INFO|M_NOPREFIX, "%s", title_string);
   msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
   msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2009 OpenVPN Technologies,=
 Inc. <sales@...515...>");
+#ifndef ENABLE_SMALL
   msg (M_INFO|M_NOPREFIX, "\n%s\n", CONFIGURE_CALL);
   msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES)=
;
+#endif
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
=20
--=20
1.6.6.1


--------------010500000606050106050400--

--------------enig91CC61EFD7811A3013451409
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvEdmoACgkQDC186MBRfrqO7QCfbm1Z52CB9Zc371itIo+5VM1J
pWYAnimALf9CesnKfwmeQRmb8FL/dxB6
=rq3n
-----END PGP SIGNATURE-----

--------------enig91CC61EFD7811A3013451409--

