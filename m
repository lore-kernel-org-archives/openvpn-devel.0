References: <20170809123256.25694-1-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <7a76d766-5349-ec0d-2a08-e15f9fd3f01f@...1856...>
Date: Sat, 12 Aug 2017 12:33:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170809123256.25694-1-davids@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] tests: Add a simple build sanity check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Some high-level comments:

On 09-08-17 14:32, David Sommerseth wrote:
> This runs openvpn --help to check if the output is somewhat
> sensible and sane.  It will catch if the binary segfaults,
> if it is a normal build or an --enable-small build and
> does some simple checks when a list of options is produced.
> 
> This is based on the discussions in this [1] mailing thread.
> 
> [1] https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15172.html
>     Message-Id: <20170807132301.22759-3-chipitsine@...277...>

While extensive testing is good, fragile tests are not so good.  I'm
afraid this patch crosses that line.

> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  tests/Makefile.am       |   2 +-
>  tests/t_sanity_check.sh | 118 ++++++++++++++++++++++++++++++++++++++++++++++++

t_sanity_check is less descriptive than the t_usage proposed by Ilya.
(Sanity check could be anything, while we specifically test the usage
output.)

>  2 files changed, 119 insertions(+), 1 deletion(-)
>  create mode 100755 tests/t_sanity_check.sh
> 
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 0795680c..7af5101e 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -14,7 +14,7 @@ MAINTAINERCLEANFILES = \
>  
>  SUBDIRS = unit_tests
>  
> -test_scripts = t_client.sh
> +test_scripts = t_sanity_check.sh t_client.sh
>  if ENABLE_CRYPTO
>  test_scripts += t_lpback.sh t_cltsrv.sh
>  endif
> diff --git a/tests/t_sanity_check.sh b/tests/t_sanity_check.sh
> new file mode 100755
> index 00000000..e6c228c8
> --- /dev/null
> +++ b/tests/t_sanity_check.sh
> @@ -0,0 +1,118 @@
> +#! /bin/sh
> +#
> +# t_sanity_check.sh  --  Check that openvpn --help makes somewhat sense
> +#
> +# Copyright (C) 2017  David Sommerseth <davids@...515...>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License
> +# as published by the Free Software Foundation; either version 2
> +# of the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> +# 02110-1301, USA.
> +
> +set -u
> +top_builddir="${top_builddir:-..}"
> +
> +failed=0
> +count_failure()
> +{
> +    failed=$(($failed + 1))
> +}
> +
> +
> +check_option_count()
> +{
> +    num_min="$1"
> +    num_max="$2"
> +
> +    echo -n "Checking if number of options are between $num_min and $num_max ... "
> +    optcount="$(cat sanity_check_options.$$ | wc -l )"
> +    if [ $optcount -le $num_min ]; then
> +        echo "FAIL  (too few, found $optcount options)"
> +        count_failure
> +        return
> +    fi
> +    if [ $optcount -gt $num_max ]; then
> +        echo "FAIL  (too many, found $optcount options)"
> +        count_failure
> +        return
> +    fi
> +    echo "PASS (found $optcount options)"
> +}

This is quite fragile.  For example, this breaks 'make check' for
--disable-crypto builds.  It will also fail easily after adding or
removing some options, and we probably have more configure flags that
will cause this check to fail.  That's we I don't like it very much.

> +
> +check_options_present()
> +{
> +    for opt in $*;
> +    do
> +        echo -n "Checking for option --${opt} ..."
> +        grep -E "^--${opt} " sanity_check_options.$$ 1>/dev/null 2>&1
> +        if [ $? -ne 0 ]; then
> +            echo "FAIL (missing option)"
> +            count_failure
> +        else
> +            echo "PASS"
> +        fi
> +    done
> +}
> +
> +echo "*** OpenVPN sanity check: openvpn --help"
> +echo -n "Running 'openvpn --help' ... "
> +"${top_builddir}/src/openvpn/openvpn" --help > sanity_check_log.$$ 2>&1
> +res=$?
> +if [ $res -ne 1 ]; then
> +    echo "FAIL   (Something bad happened)"
> +    cat sanity_check_log.$$
> +    count_failure
> +else
> +    echo "PASS"
> +    echo -n "Check build type ... "
> +    linecount="$(cat sanity_check_log.$$ | wc -l)"
> +    if [ $linecount -eq 1 ]; then
> +        # Is this an --enable-small build?
> +        grep "Usage message not available" sanity_check_log.$$ \
> +            1> /dev/null 2> /dev/null
> +        if [ $? -ne 0 ]; then
> +            echo "Unknown build type"
> +            cat sanity_check_log.$$
> +            count_failure
> +        else
> +            echo "PASS  (--enable-small build, no further checks)"
> +        fi
> +    else
> +        echo "PASS  (normal build)"
> +
> +        # Extract only the options
> +        echo -n "Extracting options ... "
> +        grep -E -- ^-- sanity_check_log.$$ > sanity_check_options.$$
> +        if [ $? -ne 0 ]; then
> +            echo "FAIL"
> +            count_failure
> +        else
> +            echo "PASS"
> +
> +            # Check that the number of option counts are between 220 and 245
> +            check_option_count 225 245
> +
> +            # Check for a selected subset of options we always expect to see
> +            options_check="dev dev-type remote local port proto topology route ifconfig"
> +            check_options_present $options_check
> +        fi
> +    fi
> +fi
> +echo "*** OpenVPN sanity check result - Failed tasks: $failed"
> +
> +rm -f sanity_check_log.$$ sanity_check_options.$$
> +if [ $failed -gt 0 ]; then
> +    exit 1
> +fi
> +exit 0
> 

-Steffan

