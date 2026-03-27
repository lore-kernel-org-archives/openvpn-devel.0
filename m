Date: Fri, 27 Mar 2026 15:45:55 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <acaYI8dJvKrMzoLz@...2685...>
References: <20260326062016.3856597-1-haixiao.yan.cn@...3018...>
MIME-Version: 1.0
In-Reply-To: <20260326062016.3856597-1-haixiao.yan.cn@...3018...>
Subject: Re: [Openvpn-devel] [PATCH] tests: skip test execution when
 cross-compiling
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
To: haixiao.yan.cn@...3018...
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Mar 26, 2026 at 02:20:16PM +0800, haixiao.yan.cn--- via Openvpn-devel wrote:
> From: Haixiao Yan <haixiao.yan.cn@...3018...>
> 
> The auth-pam unit test Makefile.am unconditionally assigns the TESTS variable,
> causing test execution to fail during cross-compilation because the target
> binaries are not executable on the build host.
> 
> Signed-off-by: Haixiao Yan <haixiao.yan.cn@...3018...>
> ---
>  tests/unit_tests/plugins/auth-pam/Makefile.am | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/unit_tests/plugins/auth-pam/Makefile.am b/tests/unit_tests/plugins/auth-pam/Makefile.am
> index ba32013ac920..7da299ccde92 100644
> --- a/tests/unit_tests/plugins/auth-pam/Makefile.am
> +++ b/tests/unit_tests/plugins/auth-pam/Makefile.am
> @@ -4,8 +4,10 @@ AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) auth_pam Plugin Unit-Tests
>  
>  if ENABLE_PLUGIN_AUTH_PAM
>  check_PROGRAMS = auth_pam_testdriver
> +if !CROSS_COMPILING
>  TESTS = $(check_PROGRAMS)
>  endif
> +endif

Makes sense and is consistent with existing Makefile.am files in
example_test and openvpn.

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

