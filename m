Date: Wed, 8 Mar 2023 15:58:10 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZAiigihG8Cwnetl9@...2685...>
References: <20230204004512.250271-1-selva.nair@...277...>
 <202302101859.31AIx3Y8031056@...2054...>
 <ZAieahHoe5SjTOnT@...1296...>
MIME-Version: 1.0
In-Reply-To: <ZAieahHoe5SjTOnT@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Conditionally add
 subdir-objects option to automake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

On Wed, Mar 08, 2023 at 03:40:42PM +0100, Gert Doering wrote:
> Not sure what to do about it... for now we've decided to move onwards
> with the 2.6.1 release, as the "make dist" built tarball passes all
> the tests - including "out of tree" builds - so it's not crucially
> urgent ("yesterday" urgent), but it would be good to get this fixed again.
> 
> Anyone who understands autoconf...?

So I have a fix %)

Turns out one needs to read the automake release notes *very* carefully. When
they fixed the issues with subdir-objects in 1.16.1 they wrote:

The 'subdir-object' option no longer causes object files corresponding
to source files specified with an explicit '$(srcdir)' component to be
placed in the source tree rather than in the build tree.

And they wrote

Automatic dependency tracking has been fixed to work also when the
'subdir-object' option is used and some 'foo_SOURCES' definition
contains unexpanded references to make variables, as in, e.g.:

  a_src = sources/libs/aaa
  b_src = sources/bbb
  foo_SOURCES = $(a_src)/bar.c $(b_src)/baz.c

With such a setup, the created makefile fragment containing dependency
tracking information will be correctly placed under the directories
named 'sources/libs/aaa/.deps' and 'sources/bbb/.deps', rather than
mistakenly under directories named (literally!) '$(src_a)/.deps' and
'$(src_b)/.deps'

What they did not explicitely mention is that the fixes do not work
*together*. So if you have $(a_src) in foo_SOURCES the .deps directory
will be created in the *source* tree, not the *build* tree. Only if you
have literally srcdir or top_srcdir in SOURCES, then it puts them in
the build tree.

That breaks make distcheck.

So we need to apply fixes like this:
-auth_pam_testdriver_SOURCES = test_search_and_replace.c  $(sut_sourcedir)/utils.h $(sut_sourcedir)/utils.c
+auth_pam_testdriver_SOURCES = test_search_and_replace.c  $(top_srcdir)/src/plugins/auth-pam/utils.h $(top_srcdir)/src/plugins/auth-pam/utils.c

Will send a patch.

Regards,
-- 
  Frank Lichtenheld

