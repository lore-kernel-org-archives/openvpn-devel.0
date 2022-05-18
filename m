Date: Wed, 18 May 2022 13:12:23 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1476138134.1141343.1652872343570@...2642...>
In-Reply-To: <20220518093212.2802495-4-arne@...1227...>
References: <20220518093212.2802495-1-arne@...1227...>
 <20220518093212.2802495-4-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/4] Implement AUTH_FAIL,
 TEMP message support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Documentation-only review.

> Arne Schwabe <arne@...1227...> hat am 18.05.2022 11:32 geschrieben:
> This allows a server to indicate a temporary problem on the server and
> allows the server to indicate how to proceed (i.e. move to the next server,
> retry the same server, wait a certain time,...)
> 
> This adds options_utils.c/h to be able to unit test the new function.
[...]
> diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
> index 6be0686d7..bacf6b381 100644
> --- a/doc/man-sections/script-options.rst
> +++ b/doc/man-sections/script-options.rst
> @@ -97,6 +97,36 @@ SCRIPT HOOKS
>    the authentication, a :code:`1` or :code:`0` must be written to the
>    file specified by the :code:`auth_control_file`.
>  
> +  If the file specified by :code:`auth_failed_reason` exists and has non-empty
> +  content, the content of this file will be used as AUTH_FAILED message. To
> +  avoid race condition, this file should be written before

either "a race condition" or "race conditions"

> +  :code:`auth_control_file`.
> +
> +  This auth fail reason can be something simple like "User has permanently

"has been"

> +  disabled" but there are also some special auth failed messages.
> +
> +  The ``TEMP`` message indicates that the authentication
> +  temporarily failed and that the client should continue to retry to connect.
> +  The server can optionally give a user readable message and hint the client a
> +  behavior how to proceed. The keywords of the ``AUTH_FAILED,TEMP`` message

"and a hint to the client on how to proceed" maybe?

> +  are comma separated keys/values. Currently defined are:
> +
> +  - ``backoff s`` - instructs the client to wait at least s seconds before the
> +                    next connection attempt. If the client has already a higher

"has already" -> "already uses" ?

> +                    delay before reconnecting, the delay will not be
> +                    shortened.
> +  - ``advance addr`` - Instructs the client to reconnect to the (IP)

"to the" -> "to a specific"

> +                       address of the current server.
> +  - ``advance remote`` - Instructs the client to skip the remaining IP
> +                         addresses of the current server and instead connect to
> +                         the next server specified in the configuration file

Missing full stop.

> +  - ``advance no`` - Instructs the client to retry connecting to the same server
> +                    again.
> +
> +  For example, the message ``TEMP[backoff 42,advance no]: No free IP addresses``
> +  to indicates that the VPN connection can currently not succeed and instructs

Remove "to"

> +  the client to retry in 42 seconds again.
> +
>    When deferred authentication is in use, the script can also request
>    pending authentication by writing to the file specified by the
>    :code:`auth_pending_file`. The first line must be the timeout in

Regards,
--
Frank Lichtenheld

