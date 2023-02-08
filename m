Message-ID: <74a4194f-2d86-2bce-195b-0cae9f294597@...1227...>
Date: Wed, 8 Feb 2023 01:18:50 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230204004512.250271-2-selva.nair@...277...>
 <20230204064010.257925-1-selva.nair@...277...>
 <20230204064010.257925-2-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230204064010.257925-2-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Add a unit test for functions in
 cryptoapi.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 04.02.23 um 07:40 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - Though named cryptoapi_testdriver, right now this only tests
>    parsing of thumbprint specified as a selector for --cryptioapicert
>    option. More tests coming..
> 
> v2: a line that belongs here was mistakenly included in the previous
> commit. Corrected.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>

While a good step, this still has problems. With OpenSSL 1.1.1 it still 
tries to run the check-engine.sh script and unsurprisingly fails:

---- begin log.txt ----
./check_engine_keys.sh: 25: ../../../src/openvpn/openvpn: not found
--- end log.txt ---
Key mismatch not detected
FAIL: check_engine_keys.sh

This can be fixed by:

--- a/tests/unit_tests/engine-key/Makefile.am
+++ b/tests/unit_tests/engine-key/Makefile.am
@@ -12,7 +12,9 @@ TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
         top_srcdir="$(top_srcdir)"; \
         export srcdir builddir top_builddir top_srcdir;

+if !CROSS_COMPILING
  TESTS = check_engine_keys.sh
+endif
  check_engine_keys.sh: $(conffiles)

  CLEANFILES = \


I have working github actions for this running which was a real pain to 
get working. I will send this after we get a v3 of the patch with that 
patch above included.


Then my mingw seems to be more pendantic then every other compiler. I 
will send a separate patch for that on the mailing list.

Also libtool is utterly broken on my mingw cross building on the mac:

libtool:   error: Could not determine the host path corresponding to
libtool:   error: 
'/Users/arne/ovpn/mingw64/lib:/Users/arne/ovpn/mingw64/bin:/Users/arne/ovpn/deps-mingw64/lib:/Users/arne/ovpn/deps-mingw64/bin'
libtool:   error: Continuing, but uninstalled executables may not work.
./.libs/lt-provider_testdriver.c:41:5: warning: '_putenv' redeclared 
without dllimport attribute: previous dllimport ignored [-Wattributes]
    41 | int _putenv (const char *);
       |     ^~~~~~~
./.libs/lt-provider_testdriver.c: In function 'lt_dump_script':
./.libs/lt-provider_testdriver.c:837:10: warning: missing terminating " 
character
   837 |   fputs ("# provider_testdriver - temporary wrapper script for 
.libs/provider_testdriver.
       |          ^
./.libs/lt-provider_testdriver.c:837:10: error: missing terminating " 
character
   837 |   fputs ("# provider_testdriver - temporary wrapper script for 
.libs/provider_testdriver.
       | 
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./.libs/lt-provider_testdriver.c:838:4: warning: missing terminating " 
character
   838 | exe", f);
       |    ^



 From the lt-provider_testdriver.c:

void lt_dump_script (FILE* f)
{
   fputs ("#! /bi", f);
   fputs ("", f);
   fputs ("# packet_id_testdriver - temporary wrapper script for 
.libs/packet_id_testdrive
r.exe", f);
   fputs ("r.exe", f);
   fputs ("# Ge", f);
   fputs ("#", f);
   fputs ("#", f);
   fputs ("# This wrapper script should ", f);
   fputs ("# If it is, it will ", f);
   fputs ("", f);
   fputs ("# Sed substitutio", f);
   fputs ("# metacharacters that are still active withi", f);
   fputs ("sed_quote_subst='s|", f);
   fputs ("", f);
   fputs ("# Be Bour", f);
   fputs ("if test -", f);
   fputs ("  emulate sh", f);
   fputs ("  NULLCMD=:", f);
   fputs ("  # Zsh 3.x a", f);
   fputs ("  # is co", f);


I have to say the autoconf/libtool/automake is pretty broken here and I 
absolutely no idea how to fix it. Any idea or help would be appricated.

Arne


