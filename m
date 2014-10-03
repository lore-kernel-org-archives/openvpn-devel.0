MIME-Version: 1.0
In-Reply-To: <1412344661-26600-1-git-send-email-openvpn.list@...1114...>
References: <1412344661-26600-1-git-send-email-openvpn.list@...1114...>
Date: Fri, 3 Oct 2014 10:47:40 -0400
Message-ID: <CAJ0EP410UgueO4xYY_QohFgA=TLyEghp3ByFVw0pkDDnG1iPEg@...278...>
From: Mike Gilbert <floppym@...594...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Use systemd functions to
 consider systemd availability
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
To: openvpn-devel@lists.sourceforge.net

On Fri, Oct 3, 2014 at 9:57 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> From: David Sommerseth <davids@...1347...>
>
> This is another systemd implementation clean-up.  It was found that
> SELinux will block OpenVPN from checking /sys/fs/cgroups.  As OpenVPN
> only checked /sys/fs/cgroups and /sys/fs/cgroups/systemd to see if
> systemd was available or not, it was considered better to query
> systemd directly to see whether or not to query for usernames and
> passwords via systemd.
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  configure.ac            | 37 ++++++++++++++++++++++++++++++++++++-
>  src/openvpn/Makefile.am |  1 +
>  src/openvpn/console.c   | 10 ++++++----
>  3 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 6667019..06371c8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -997,6 +997,41 @@ if test "$enable_lz4" = "yes" && test "$enable_comp_stub" = "no"; then
>  fi
>
>
> +dnl
> +dnl Check for systemd
> +dnl
> +
> +AC_ARG_VAR([SYSTEMD_LIBS], [linker flags for systemd])
> +if test "$enable_systemd" = "yes" ; then
> +    AC_CHECKING([for systemd Library and Header files])
> +    havesystemdlib=1
> +
> +    # if SYSTEMD_LIBS is set, we assume it will work, otherwise test
> +    saved_LIBS="${CFLAGS}"
> +    LIBS="${LIBS} ${SYSTEMD_LIBS}"
> +    if test -z "${SYSTEMD_LIBS}"; then
> +       AC_CHECK_LIB(systemd-daemon, sd_booted,
> +           [ SYSTEMD_LIBS="-lsystemd-daemon" ],
> +           [
> +               AC_MSG_ERROR([systemd-daemon library not found.])
> +               havesystemdlib=0
> +           ])
> +    fi

Checking for libsystemd-daemon this way will fail with newer releases
of systemd (>= 209), where all systemd libs have been consolidated
into a single "libsystemd".

Also, why not use PKG_CHECK_MODULES here?

