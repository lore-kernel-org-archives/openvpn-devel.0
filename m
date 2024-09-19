Date: Thu, 19 Sep 2024 11:51:53 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Zuv0OeZHJjbrNIkh@...2685...>
References: <20240918162917.6809-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20240918162917.6809-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] make t_server_null "server alive?"
 check more robust
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

On Wed, Sep 18, 2024 at 06:29:17PM +0200, Gert Doering wrote:
> - use "$RUN_SUDO kill -0 $pid" to test if a given process is running, not
>   "ps -p $pid" - the latter will not work if security.bsd.see_other_uids=0
>   is set
> 
> - produce proper error messages if pid files can not be found or are
>   empty at server shutdown time
> ---
>  tests/t_server_null_client.sh | 5 ++++-
>  tests/t_server_null_server.sh | 5 +++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
> index e7dd3324..c1a25dfc 100755
> --- a/tests/t_server_null_client.sh
> +++ b/tests/t_server_null_client.sh
> @@ -87,7 +87,10 @@ while [ $count -lt $server_max_wait ]; do
>      # the active server count as the processes won't be running.
>      for i in `set|grep 'SERVER_NAME_'|cut -d "=" -f 2|tr -d "[\']"`; do
>          server_pid=$(cat $i.pid 2> /dev/null)
> -        if ps -p $server_pid > /dev/null 2>&1; then
> +        if [ -z "$server_pid" ] ; then
> +            continue
> +        fi
> +        if $RUN_SUDO kill -0 $server_pid > /dev/null 2>&1; then
>              servers_up=$(( $servers_up + 1 ))
>          fi
>      done
> diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
> index e5906eec..32f0362d 100755
> --- a/tests/t_server_null_server.sh
> +++ b/tests/t_server_null_server.sh
> @@ -82,6 +82,11 @@ for PID_FILE in $server_pid_files
>  do
>      SERVER_PID=$(cat "${PID_FILE}")
>  
> +    if [ -z "$SERVER_PID" ] ; then
> +        echo "WARNING: could not kill server ${PID_FILE}!"
> +	continue

Indentation looks slightly wrong.

Otherwise looks good to me, so
Acked-by: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

