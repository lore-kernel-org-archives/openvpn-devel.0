MIME-Version: 1.0
References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-8-arne@...1227...>
In-Reply-To: <20200930131317.1299-8-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 21 Jan 2021 15:44:17 +0200
Message-ID: <CAGyAFMWSR5rA8oU-pm2YVSQz6+YLzQNK_0f4XtjnAew3FZ=qGg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 06/11] Add S_EXITCODE flag for
 openvpn_run_script to report exit code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> +platform_ret_code(int stat)
> +{
> +
> +    if (stat >= 0 && stat < 255)

Unneeded line break.


> -/* interpret the status code returned by execve() */
> +/** interpret the status code returned by execve() */
>  bool platform_system_ok(int stat);
>
> +/** Return a return code if valid and between 0 and 255, -1 otherwise */
> +int platform_ret_code(int stat);

"Return a return code" looks odd. Maybe "status code" or "exit code" ?


> +    if(flags & S_EXITCODE)

Missing whitespace after if.


> +/**
> + * Will run a script and return the exit code if it
> + */

"If it" what?

Assuming committer will fix those nit-picks (especially last one),

Acked-by: Lev Stipakov <lstipakov@...277...>

