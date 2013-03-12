Date: Tue, 12 Mar 2013 11:07:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130312100706.GN953@...1296...>
References: <C673F57BE2DD3148AC2DD4AF464686F901BBDB56@...1815...>
	<1363032625-23311-1-git-send-email-gert@...1296...>
	<513E4DEB.7000403@...1227...>
	<1CED409804E2164C8104F9E623B08B9013B8D6EDA6@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bQaHVRvwpJFI6oid"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B9013B8D6EDA6@...1436...>
Subject: Re: [Openvpn-devel] [PATCH v2] Repair "tcp server queue overflow"
	brokenness, more <stdbool.h> fallout.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--bQaHVRvwpJFI6oid
Content-Type: multipart/mixed; boundary="v+yx4Fq+rcVvnsQ8"
Content-Disposition: inline

--v+yx4Fq+rcVvnsQ8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 12, 2013 at 09:32:36AM +0100, Steffan Karger wrote:
> Shouldn't the return type be size_t or at least unsigned int, as mbuf->le=
n is also of type unsigned int?

Well, unsigned int, as ->len is not a size_t.=20=20

Not that it makes any real difference as we're talking about a range=20
between "0" and "65" here.  But anyway.  Patch v2 is below.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v+yx4Fq+rcVvnsQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Repair-tcp-server-queue-overflow-brokenness-more-std.patch"
Content-Transfer-Encoding: quoted-printable

=46rom b6add3999621825420f7e56e4c7790dc30a68ffe Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Mon, 11 Mar 2013 21:03:20 +0100
Subject: [PATCH v2] Repair "tcp server queue overflow" brokenness, more
 <stdbool.h> fallout.

Return value of mbuf_len() wrong - it's returning a length value, not
a yes/no value - so when the queue length approached 65 (full!), it
still only returned "1", leading to MBUF overflow later on.  Change
from "bool" to "unsigned int", misbehaviour gone...

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mbuf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index a0de679..1085adc 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -83,7 +83,7 @@ mbuf_defined (const struct mbuf_set *ms)
   return ms && ms->len;
 }
=20
-static inline bool
+static inline unsigned int
 mbuf_len (const struct mbuf_set *ms)
 {
   return ms->len;
--=20
1.7.8.6


--v+yx4Fq+rcVvnsQ8--

--bQaHVRvwpJFI6oid
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUT7+SakuBuNlUUl1AQIwkwP+P2yxfDqzyGi9+hMtEN/pxYQwSDp5veTG
FxQXCTv74x/UjHJ/lsikZNwKSmzuxhxdCGXbfQG0mW4hFv4w4KB8JzcvHcrTtYzu
+adN/YLA9SK/+eCajpzVKmXNaHpaPOq5Gt6PgM2Xd6wldf8kmBaoIOFADv6ipB5p
5TIFNt+PPGs=
=p8nS
-----END PGP SIGNATURE-----

--bQaHVRvwpJFI6oid--

