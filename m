Message-ID: <1581778776.3847.1.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sat, 15 Feb 2020 09:59:36 -0500
In-Reply-To: <CAFHpkQHiu5ChvP+5vgmQLigSq5C-NJ=bzLCxAF+raZm6z6kdKw@...278...>
References: <1518302884.3072.1.camel@...2316...>
 <1518303011.3072.4.camel@...2316...>
 <778643d1-7f14-a31b-949a-8aab94473e64@...1227...>
 <1581683898.3296.4.camel@...2316...>
 <CAFHpkQHiu5ChvP+5vgmQLigSq5C-NJ=bzLCxAF+raZm6z6kdKw@...278...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v4 2/2] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?=D0=98=D0=BB=D1=8C=D1=8F_=D0=A8=D0=B8=D0=BF=D0=B8=D1=86?= =?UTF-8?Q?=D0=B8=D0=BD?= <chipitsine@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Fri, 2020-02-14 at 18:33 +0500, Илья Шипицин wrote:
> пт, 14 февр. 2020 г. в 18:05, James Bottomley <
> James.Bottomley@...2317...>:
> 
> > On Thu, 2020-02-13 at 19:18 +0100, Arne Schwabe wrote:
> > > Am 10.02.18 um 23:50 schrieb James Bottomley:
> > > > Testing engines is problematic, so one of the prerequisites
> > > > built
> > > > for the tests is a simple openssl engine that reads a non-
> > > > standard
> > > > PEM guarded key.  The test is simply can we run a client/server
> > > > configuration with the usual sample key replaced by an engine
> > > > key.
> > > > The trivial engine prints out some operations and we check for
> > > > these in the log to make sure the engine was used to load the
> > > > key
> > > > and that it correctly got the password.
> > > 
> > > This tests the openssl engine functionality in a sensible way.
> > > But I
> > > think it is not fully ready to be commited. To get it working I
> > > needed to do following changes on my Mac:
> > 
> > That could be ... I only have a linux box to try this out on.
> > 
> > > commit afa697cec15b4e54e720efe9de39c9b20b13c5c8 (HEAD ->
> > > review/enginekeys)
> > > Author: Arne Schwabe <arne@...1227...>
> > > Date:   Thu Feb 13 18:13:34 2020 +0100
> > > 
> > >     foo
> > > 
> > > diff --git a/tests/unit_tests/engine-key/Makefile.am
> > > b/tests/unit_tests/engine-key/Makefile.am
> > > index 73921965..6d7fc9c5 100644
> > > --- a/tests/unit_tests/engine-key/Makefile.am
> > > +++ b/tests/unit_tests/engine-key/Makefile.am
> > > @@ -10,4 +10,6 @@ TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
> > >  TESTS = check_engine_keys.sh
> > > 
> > >  libtestengine_la_SOURCES = libtestengine.c
> > > -libtestengine_la_LDFLAGS = -rpath /lib -avoid-version
> > > +libtestengine_la_LDFLAGS = @TEST_LDFLAGS@  -rpath /lib
> > > +libtestengine_la_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir)
> > > -I$(compat_srcdir)
> > > +
> > > diff --git a/tests/unit_tests/engine-key/libtestengine.c
> > > b/tests/unit_tests/engine-key/libtestengine.c
> > > index fa7f5de1..46ec1e33 100644
> > > --- a/tests/unit_tests/engine-key/libtestengine.c
> > > +++ b/tests/unit_tests/engine-key/libtestengine.c
> > > @@ -30,7 +30,6 @@ static EVP_PKEY *engine_load_key(ENGINE *e,
> > > const
> > > char
> > > *key_id,
> > >         PKCS8_PRIV_KEY_INFO *p8inf;
> > >         UI *ui;
> > >         char auth[256];
> > > -       int len;
> > 
> > the variable is certainly unused and can go.
> > 
> > >         fprintf(stderr, "ENGINE: engine_load_key called\n");
> > > 
> > > diff --git a/tests/unit_tests/engine-key/openssl.cnf
> > > b/tests/unit_tests/engine-key/openssl.cnf
> > > index 53200c46..e9513a92 100644
> > > --- a/tests/unit_tests/engine-key/openssl.cnf
> > > +++ b/tests/unit_tests/engine-key/openssl.cnf
> > > @@ -9,4 +9,4 @@ engines         = engines_section
> > >  testengine     = testengine_section
> > > 
> > >  [testengine_section]
> > > -dynamic_path   = $ENV::srcdir/.libs/libtestengine.so
> > > +dynamic_path   = $ENV::srcdir/.libs/libtestengine.dylib
> 
> we use gost-engine (https://github.com/engine/gost-engine)
> 
> on both linux and osx.
> 
> for some time there was a bug in openssl:
> 
> https://github.com/openssl/openssl/issues/8950
> 
> 
> however, for now "dylib" is used for osx. and
> but we do not use "dynamic" path. we use config like that
> 
> openssl_conf = openssl_def
> 
> [openssl_def]
> engines = engine_section
> 
> [engine_section]
> gost = gost_section
> 
> [gost_section]
> default_algorithms = ALL
> engine_id = gost
> CRYPT_PARAMS = id-Gost28147-89-CryptoPro-A-ParamSet

Right, that works if the engine is in the correct directory.  The
problem with this engine is that it's only built as a test
demonstration for the openvpn engine code, so it's never installed in
the openssl engines directory, so we have to tell openssl exactly where
to find it in the openvpn tree ... and that seems to involve naming the
whole file and location, including extension.

James


