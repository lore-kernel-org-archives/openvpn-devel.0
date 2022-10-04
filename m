Date: Tue, 4 Oct 2022 11:33:04 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Yzv90NwaTpQ9IYN9@...2685...>
References: <20221004082532.84741-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20221004082532.84741-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] denoise tests/t_lpback.sh
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
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Oct 04, 2022 at 10:25:32AM +0200, Gert Doering wrote:
> Introduce V=<nn> levels to t_lpback.sh self test
> 
>  V=0  - do not print any output at all
>  V=1  - print intro line, summary at end, and "FAIL"+Log for failing tests
>  V=99 - print everything + summary
> 
> code-wise, introduce test_start() / test_end() functions which do
> the $? check as well, so the actual testing code is streamlined.

Small issue on dash, see below. Otherwise looks good to me.

> diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
> index 67952994..4cf29d26 100755
> --- a/tests/t_lpback.sh
> +++ b/tests/t_lpback.sh
> @@ -24,6 +24,52 @@ top_builddir="${top_builddir:-..}"
>  trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; trap 0 ; exit 77" 1 2 15
>  trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; exit 1" 0 3
>  
> +# verbosity, defaults to "1"
> +V="${V:-1}"
> +tests_passed=0
> +tests_failed=0
> +
> +# ----------------------------------------------------------
> +# helper functions
> +# ----------------------------------------------------------
> +
> +# output progress information
> +#  depending on verbosity level, collect & print only on failure
> +test_start()
> +{
> +    case $V in
> +	0) outbuf="" ;;			# no per-test output at all
> +	1) outbuf="$@" ;;		# compact, details only on failure
> +	*) printf "$@" ;;		# print all
> +    esac
> +}
> +test_end()
> +{
> +    RC=$1 ; LOG=$2
> +    if [ $RC != 0 ]
> +    then
> +	case $V in
> +	    0) ;;				# no per-test output
> +	    1) echo "$outbuf" "FAIL (RC=$RC)"; cat $LOG ;;
> +	    *) echo "FAIL (RC=$RC)"; cat $LOG ;;
> +	esac
> +        e=1

Wrong indent.

> +	tests_failed=$(( $tests_failed + 1 ))
> +    else
> +	case $V in
> +	    0|1) ;;				# no per-test output for 'OK'
> +	    *) echo "OK" ;;			# print all
> +	esac
> +	tests_passed=$(( $tests_passed + 1 ))
> +    fi
> +}
> +
> +# if running with V=1, give an indication what test runs now
> +if [ "$V" == 1  ] ; then

With dash this fails with
./t_lpback.sh: 68: [: 1: unexpected operator

Could use -eq (or "="), but "==" seems a bashism.

> +    echo "$0: running with V=$V, only printing test fails"
> +fi
> +
> +
[...]

Regards,
-- 
  Frank Lichtenheld

