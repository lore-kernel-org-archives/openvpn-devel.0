Message-ID: <1592917531.4768.4.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Tue, 23 Jun 2020 06:05:31 -0700
In-Reply-To: <20200623072123.GA2034@...1296...>
References: <20200622232319.8143-2-James.Bottomley@...2316...>
 <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 2020-06-23 at 09:21 +0200, Gert Doering wrote:
> Hi,
> 
> On Tue, Jun 23, 2020 at 08:28:36AM +0200, Gert Doering wrote:
> > Acked-by: Gert Doering <gert@...1296...>
> > 
> > Tested on :
> >  - MacOS Mojave with OpenSSL 1.1.1c (brew) and out-of-tree build,
> > works.
> >  - Linux with mbedtls (does not try engine tests, good :-) )
> >  - Linux with OpenSSL 1.1.1, works
> >  - FreeBSD 11.3 with OpenSSL 1.0.2s -> v6 fails, v6 works \o/
> > 
> > Conferred with Arne, we agreed on "this is good enough, and who
> > wants 
> > something more sophisticated is welcome to send more patches".
> 
> Oh well.  We do need another round - Travis tells me that "make
> distcheck"
> is failing.  Which hints at "autoconf is not told what to pack in the
> tarball"
> 
> https://travis-ci.org/github/OpenVPN/openvpn/jobs/701158155
> ...
> make[6]: Entering directory
> '/home/travis/build/OpenVPN/openvpn/openvpn-
> 2.5_git/_build/sub/tests/unit_tests/engine-key'
> 3672make[6]: *** No rule to make target
> '../../../../../tests/unit_tests/engine-key/openssl.cnf.in', needed
> by 'openssl.cnf'.  Stop.
> 3673make[6]: Leaving directory
> '/home/travis/build/OpenVPN/openvpn/openvpn-
> 2.5_git/_build/sub/tests/unit_tests/engine-key'
> 3674
> 
> (so now the source file is missing)
> 
> Please... :-)

Sorry about that ... it's missing files from EXTRA_DIST ... plus I
don't usually use make dist, so I never remember to run make distcheck.
 It passes after this

---8>8>8><8<8<8---

From: James Bottomley <James.Bottomley@...2316...>
Subject: [PATCH] Fix make distcheck for new engine key unit test

Add config precursor and script to extra dist and make sure
built and test leftover files are cleaned up afterwards.

Signed-off-by: James Bottomley <James.Bottomley@...2316...>
---
 tests/unit_tests/engine-key/Makefile.am | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_tests/engine-key/Makefile.am
index 95e7d868..0bfdfcd4 100644
--- a/tests/unit_tests/engine-key/Makefile.am
+++ b/tests/unit_tests/engine-key/Makefile.am
@@ -2,6 +2,9 @@ AUTOMAKE_OPTIONS = foreign
 
 check_LTLIBRARIES = libtestengine.la
 conffiles = openssl.cnf
+EXTRA_DIST = \
+	openssl.cnf.in \
+	check_engine_keys.sh
 
 TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
 	builddir="$(abs_builddir)"; \
@@ -12,8 +15,11 @@ TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
 TESTS = check_engine_keys.sh
 check_engine_keys.sh: $(conffiles)
 
-clean-local:
-	rm -f $(conffiles)
+CLEANFILES = \
+	client.key \
+	passwd \
+	log.txt \
+	$(conffiles)
 
 $(builddir)/openssl.cnf: $(srcdir)/openssl.cnf.in
 	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $< > $@
-- 
2.26.2


