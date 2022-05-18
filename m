From: Jan Mikkelsen <janm@...2674...>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Message-Id: <2735E502-7F1F-48E9-8011-6740251E81DE@...2674...>
Date: Wed, 18 May 2022 16:10:47 +0200
Subject: [Openvpn-devel] [PATCH] cipher-negotiation.rst missing from
 doc/Makefile.am
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Openvpn-devel@lists.sourceforge.net

Hi,

The file doc/man-sections/cipher-negotiation.rst is missing from the from t=
he openvpn-2.5.6 source tarball, making it hard to rebuild the openvpn(8) m=
an page from source.

That file is also missing from the "openvpn_sections" assignment in doc/Mak=
efile, meaning that the openvpn(8) man page won't get rebuilt if the man-se=
ctions/cipher-negotiation.rst file changes.

The underlying problem seems to be that doc/Makefile.am has not been update=
d according to the directions in the file:

# NOTE: Remember to add source .rst files to $(dist_noinst_DATA) below
# This could be automated with GNU Make, but we need BSD Make support

This has been forgotten for doc/man-sections/cipher-negotiation.rst. Trivia=
l patch attached.

--- doc/Makefile.am.orig        2022-04-07 12:46:47.384178000 +0200
+++ doc/Makefile.am     2022-04-07 12:47:10.961292000 +0200
@@ -25,6 +25,7 @@
=20
 openvpn_sections =3D \
        man-sections/advanced-options.rst \
+       man-sections/cipher-negotiation.rst \
        man-sections/client-options.rst \
        man-sections/connection-profiles.rst \
        man-sections/encryption-options.rst \


I reported this as a bug a while ago, but I=E2=80=99m not sure they get not=
iced.

For reference: https://community.openvpn.net/openvpn/attachment/ticket/1461

Thanks,

Jan M.
