MIME-Version: 1.0
In-Reply-To: <20160525175756.56186-2-openvpn-devel@...2127...>
References: <20160525175756.56186-1-openvpn-devel@...2127...>
	<20160525175756.56186-2-openvpn-devel@...2127...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 26 May 2016 22:41:58 +0200
Message-ID: <CAA1Abx+JCzmZrVgQM==z+ozK=ZkYnMTN896yZohvWaOURz+b3g@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add unit testing support via cmocka
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
To: Jens <openvpn-devel@...2127...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, May 25, 2016 at 7:57 PM,  <openvpn-devel@...2127...> wrote:
> From: Jens Neuhalfen <jens@...2127...>
>
> cmocka [1,2] is a testing framework for C. Adding unit test capabilities to the
> openvpn repository will greatly ease the task of writing correct code.
>
> cmocka source code is added as git submodule in ./vendor. A submodule approach
> has been chosen over a classical library dependency because libcmocka is not
> available, or only available in very old versions (e.g. on Ubuntu).
>
> cmocka is build during 'make check' and installed in vendor/dist/.
>
> [1] https://cmocka.org/
> [2] https://lwn.net/Articles/558106/
>
> Signed-off-by: Jens Neuhalfen <jens@...2127...>
> ---
>  .gitmodules                               |  4 +++
>  Makefile.am                               |  2 +-
>  configure.ac                              | 16 +++++++++++
>  tests/Makefile.am                         |  3 +-
>  tests/unit_tests/.gitignore               |  1 +
>  tests/unit_tests/Makefile.am              |  3 ++
>  tests/unit_tests/README.md                | 40 ++++++++++++++++++++++++++
>  tests/unit_tests/example_test/Makefile.am | 13 +++++++++
>  tests/unit_tests/example_test/README.md   |  3 ++
>  tests/unit_tests/example_test/test.c      | 47 +++++++++++++++++++++++++++++++
>  tests/unit_tests/example_test/test2.c     | 22 +++++++++++++++
>  vendor/.gitignore                         |  2 ++
>  vendor/Makefile.am                        | 24 ++++++++++++++++
>  vendor/README.md                          |  9 ++++++
>  vendor/cmocka                             |  1 +
>  15 files changed, 188 insertions(+), 2 deletions(-)
>  create mode 100644 .gitmodules
>  create mode 100644 tests/unit_tests/.gitignore
>  create mode 100644 tests/unit_tests/Makefile.am
>  create mode 100644 tests/unit_tests/README.md
>  create mode 100644 tests/unit_tests/example_test/Makefile.am
>  create mode 100644 tests/unit_tests/example_test/README.md
>  create mode 100644 tests/unit_tests/example_test/test.c
>  create mode 100644 tests/unit_tests/example_test/test2.c
>  create mode 100644 vendor/.gitignore
>  create mode 100644 vendor/Makefile.am
>  create mode 100644 vendor/README.md
>  create mode 160000 vendor/cmocka
>
> diff --git a/.gitmodules b/.gitmodules
> new file mode 100644
> index 0000000..e9c6388
> --- /dev/null
> +++ b/.gitmodules
> @@ -0,0 +1,4 @@
> +[submodule "vendor/cmocka"]
> +       path = vendor/cmocka
> +       url = git://git.cryptomilk.org/projects/cmocka.git
> +       branch = master
> diff --git a/Makefile.am b/Makefile.am
> index 66d9f23..364785c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -54,7 +54,7 @@ BUILT_SOURCES = \
>         config-version.h
>  endif
>
> -SUBDIRS = build distro include src sample doc tests
> +SUBDIRS = build distro include src sample doc vendor tests
>
>  dist_doc_DATA = \
>         README \
> diff --git a/configure.ac b/configure.ac
> index 97ad856..fb3fa3c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1198,6 +1198,19 @@ sampledir="\$(docdir)/sample"
>  AC_SUBST([plugindir])
>  AC_SUBST([sampledir])
>
> +VENDOR_SRC_ROOT="\$(abs_top_srcdir)/vendor/"
> +VENDOR_DIST_ROOT="\$(abs_top_builddir)/vendor/dist"
> +VENDOR_BUILD_ROOT="\$(abs_top_builddir)/vendor/.build"
> +AC_SUBST([VENDOR_SRC_ROOT])
> +AC_SUBST([VENDOR_BUILD_ROOT])
> +AC_SUBST([VENDOR_DIST_ROOT])
> +
> +TEST_LDFLAGS="-lcmocka -L\$(abs_top_builddir)/vendor/dist/lib -Wl,-rpath,\$(abs_top_builddir)/vendor/dist/lib"
> +TEST_CFLAGS="-I\$(top_srcdir)/include -I\$(abs_top_builddir)/vendor/dist/include"
> +
> +AC_SUBST([TEST_LDFLAGS])
> +AC_SUBST([TEST_CFLAGS])
> +
>  AC_CONFIG_FILES([
>         version.sh
>         Makefile
> @@ -1216,6 +1229,9 @@ AC_CONFIG_FILES([
>         src/plugins/auth-pam/Makefile
>         src/plugins/down-root/Makefile
>         tests/Makefile
> +        tests/unit_tests/Makefile
> +        tests/unit_tests/example_test/Makefile
> +        vendor/Makefile
>         sample/Makefile
>         doc/Makefile
>  ])
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index b7980e0..2cba9e6 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -12,6 +12,8 @@
>  MAINTAINERCLEANFILES = \
>         $(srcdir)/Makefile.in
>
> +SUBDIRS = unit_tests
> +
>  test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
>
>  TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
> @@ -20,4 +22,3 @@ TESTS = $(test_scripts)
>  dist_noinst_SCRIPTS = \
>         $(test_scripts) \
>         t_cltsrv-down.sh
> -
> diff --git a/tests/unit_tests/.gitignore b/tests/unit_tests/.gitignore
> new file mode 100644
> index 0000000..8655de8
> --- /dev/null
> +++ b/tests/unit_tests/.gitignore
> @@ -0,0 +1 @@
> +*_testdriver
> diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
> new file mode 100644
> index 0000000..18267bd
> --- /dev/null
> +++ b/tests/unit_tests/Makefile.am
> @@ -0,0 +1,3 @@
> +AUTOMAKE_OPTIONS = foreign
> +
> +SUBDIRS = example_test
> diff --git a/tests/unit_tests/README.md b/tests/unit_tests/README.md
> new file mode 100644
> index 0000000..ef81b23
> --- /dev/null
> +++ b/tests/unit_tests/README.md
> @@ -0,0 +1,40 @@
> +Unit Tests
> +===========
> +
> +This directory contains unit tests for openvpn. New features/bugfixes should be written in a test friendly way and come with corresponding tests.
> +
> +Run tests
> +----------
> +
> +Tests are run by `make check`. A failed tests stops test execution. To run all
> +tests regardless of errors call `make -k check`.
> +
> +Add new tests to existing test suite
> +-------------------------------------
> +
> +Test suites are organized in directories. [example_test/](example_test/) is an example
> +for a test suite with two test executables. Feel free to use it as a template for new tests.
> +
> +Test suites
> +--------------------
> +
> +Test suites live inside a subdirectory of `$ROOT/tests/unit_tests`, e.g. `$ROOT/tests/unit_tests/my_feature`.
> +
> +Test suites are configured by a `Makefile.am`. Tests are executed by testdrivers. One testsuite can contain more than one testdriver.
> +
> +### Hints
> +* Name suites & testdrivers in a way that the name of the driver says something about which component/feature is tested
> +* Name the testdriver executable `*_testdriver`. This way it gets picked up by the default `.gitignore`
> +  * If this is not feasible: Add all output to a `.gitignore`* Use descriptive test names: `coffee_brewing__with_no_beans__fails` vs. `test34`
> +* Testing a configurable feature?  Wrap test execution with a conditional (see [auth_pam](plugins/auth-pam/Makefile.am) for an example)
> +* Add multiple test-drivers when one testdriver looks crowded with tests
> +
> +### New Test Suites
> +1.  Organize tests in folders for features.
> +2.  Add the new test directory to `SUBDIRS` in `Makefile.am`
> +3.  Edit `configure.ac` and add the new `Makefile` to `AC_CONFIG_FILES`
> +4.  Run `./configure`, and *enable* the feature you'd like to test
> +5.  Make sure that `make check` runs your tests
> +6.  Check: Would a stranger be able to easily find your tests by you looking at the test output?
> +7. Run `./configure`, and *disable* the feature you'd like to test
> +8.  Make sure that `make check` does *not run* your tests
> diff --git a/tests/unit_tests/example_test/Makefile.am b/tests/unit_tests/example_test/Makefile.am
> new file mode 100644
> index 0000000..04a5ad3
> --- /dev/null
> +++ b/tests/unit_tests/example_test/Makefile.am
> @@ -0,0 +1,13 @@
> +AUTOMAKE_OPTIONS = foreign
> +
> +check_PROGRAMS = example_testdriver example2_testdriver
> +
> +TESTS = $(check_PROGRAMS)
> +
> +example_testdriver_CFLAGS  = @TEST_CFLAGS@
> +example_testdriver_LDFLAGS = @TEST_LDFLAGS@
> +example_testdriver_SOURCES = test.c
> +
> +example2_testdriver_CFLAGS  = @TEST_CFLAGS@
> +example2_testdriver_LDFLAGS = @TEST_LDFLAGS@
> +example2_testdriver_SOURCES = test2.c
> diff --git a/tests/unit_tests/example_test/README.md b/tests/unit_tests/example_test/README.md
> new file mode 100644
> index 0000000..cb75d68
> --- /dev/null
> +++ b/tests/unit_tests/example_test/README.md
> @@ -0,0 +1,3 @@
> +This test only checks that test compilation works. This example contains two test executables.
> +
> +These tests can be used as template for 'real' tests.
> diff --git a/tests/unit_tests/example_test/test.c b/tests/unit_tests/example_test/test.c
> new file mode 100644
> index 0000000..c746b8b
> --- /dev/null
> +++ b/tests/unit_tests/example_test/test.c
> @@ -0,0 +1,47 @@
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdarg.h>
> +#include <string.h>
> +#include <setjmp.h>
> +#include <cmocka.h>
> +
> +static int setup(void **state) {
> +     int *answer  = malloc(sizeof(int));
> +
> +     *answer=42;
> +     *state=answer;
> +
> +     return 0;
> +}
> +
> +static int teardown(void **state) {
> +     free(*state);
> +
> +     return 0;
> +}
> +
> +static void null_test_success(void **state) {
> +    (void) state;
> +}
> +
> +static void int_test_success(void **state) {
> +     int *answer = *state;
> +     assert_int_equal(*answer, 42);
> +}
> +
> +static void failing_test(void **state) {
> +     // This tests fails to test that make check fails
> +     assert_int_equal(0, 42);
> +}
> +
> +int main(void) {
> +    const struct CMUnitTest tests[] = {
> +        cmocka_unit_test(null_test_success),
> +        cmocka_unit_test_setup_teardown(int_test_success, setup, teardown),
> +//        cmocka_unit_test(failing_test),
> +    };
> +
> +    return cmocka_run_group_tests_name("success_test", tests, NULL, NULL);
> +}
> +
> diff --git a/tests/unit_tests/example_test/test2.c b/tests/unit_tests/example_test/test2.c
> new file mode 100644
> index 0000000..2924c61
> --- /dev/null
> +++ b/tests/unit_tests/example_test/test2.c
> @@ -0,0 +1,22 @@
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdarg.h>
> +#include <string.h>
> +#include <setjmp.h>
> +#include <cmocka.h>
> +
> +
> +static void test_true(void **state) {
> +    (void) state;
> +}
> +
> +
> +int main(void) {
> +    const struct CMUnitTest tests[] = {
> +        cmocka_unit_test(test_true),
> +    };
> +
> +    return cmocka_run_group_tests_name("success_test2", tests, NULL, NULL);
> +}
> +
> diff --git a/vendor/.gitignore b/vendor/.gitignore
> new file mode 100644
> index 0000000..e11dfec
> --- /dev/null
> +++ b/vendor/.gitignore
> @@ -0,0 +1,2 @@
> +.build/
> +dist/
> diff --git a/vendor/Makefile.am b/vendor/Makefile.am
> new file mode 100644
> index 0000000..f68240e
> --- /dev/null
> +++ b/vendor/Makefile.am
> @@ -0,0 +1,24 @@
> +AUTOMAKE_OPTIONS = foreign
> +
> +cmockasrc     = @VENDOR_SRC_ROOT@/cmocka  # needs an absolute path bc. of the cmake invocation
> +cmockabuild   = @VENDOR_BUILD_ROOT@/cmocka
> +cmockainstall = @VENDOR_DIST_ROOT@
> +
> +MAINTAINERCLEANFILES = \
> +       $(srcdir)/Makefile.in \
> +       $(cmockabuild) \
> +       $(cmockainstall) \
> +       @VENDOR_BUILD_ROOT@
> +
> +distdir:
> +       mkdir -p $(cmockainstall)
> +
> +libcmocka: distdir
> +       mkdir -p $(cmockabuild)
> +       (cd $(cmockabuild) && cmake -DCMAKE_INSTALL_PREFIX=$(cmockainstall) $(cmockasrc) && make && make install)
> +
> +check: libcmocka
> +
> +clean:
> +       rm -rf $(cmockabuild)
> +       rm -rf $(cmockainstall)
> diff --git a/vendor/README.md b/vendor/README.md
> new file mode 100644
> index 0000000..6a46b35
> --- /dev/null
> +++ b/vendor/README.md
> @@ -0,0 +1,9 @@
> +Vendor
> +========
> +
> +Vendor source libraries are included in this directory. Libraries are included
> +when there is no good way to ensure that the package is available on all
> +systems.
> +
> +`Makefile.am` compiles these libraries and installs them into ./dist.
> +
> diff --git a/vendor/cmocka b/vendor/cmocka
> new file mode 160000
> index 0000000..b2732b5
> --- /dev/null
> +++ b/vendor/cmocka
> @@ -0,0 +1 @@
> +Subproject commit b2732b52202ae48f866a024c633466efdbb8e85a
> --
> 2.8.3

ACK

-Steffan

