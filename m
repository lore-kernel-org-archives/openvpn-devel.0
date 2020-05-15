From: David Sommerseth <openvpn@...2080...>
References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-3-arne@...1227...>
Message-ID: <f375b7b2-0080-06aa-0d4e-03536a7ffe66@...2080...>
Date: Fri, 15 May 2020 17:23:43 +0200
MIME-Version: 1.0
In-Reply-To: <20191109151306.18597-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 3/5] Implement sending response to
 challenge via CR_RESPONSE
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net


Hi,

So I'm giving this one another look again.  I started now by trying to use
this feature manually, to see that each step works as expected.  But this time
I also discovered a few other details.

On 09/11/2019 16:13, Arne Schwabe wrote:
> When a client announces its support to support text based
> challenge/response via IV_SOO=cr_text,the client needs to also

Just reminding of the IV_SOO -> IV_SSO typo-fix ... and it should also be
'crtext', not 'cr_text'.  The former is what is used in the management notes.

The more I dive into this, I'm also not sure IV_SSO is the proper term.  As it
is actually defines additional authentication mechanisms, where SSO (Single
Sign-on) is just one potential user of this feature.  What about just using
IV_AUTH? (knowing this will change the prior patches)

[...snip...]

> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index 17645c1d..e380ca2b 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -806,6 +806,14 @@ To accept connecting to the host and port directly, use this command:
>  
>    proxy NONE
>  
> +COMMAND -- cr-response (OpenVPN 2.5 or higher)
> +-------------------------------------------------
> +Provides support for sending responses a challenge/response
> +query via INFOMSG,CR_TEXT. The response should be base64 encoded:
> +
> +  cr-response SGFsbG8gV2VsdCE=
> +
> +

Could we please have more documentation how to use to enable and use this
feature properly?  Similar to the examples later down for both the static and
dynamic challenge protocols.  This does not need to happen in this patch
though, as this is also tightly connected to the next patches.

> +static bool
> +management_callback_send_cc_mesage(void *arg,

I didn't spot this earlier, but there's a typo in the function name; it is
'message' with two 's'.

>  static bool
>  management_callback_remote_cmd(void *arg, const char **p)
> @@ -3990,6 +4028,7 @@ init_management_callback_p2p(struct context *c)
>          cb.show_net = management_show_net_callback;
>          cb.proxy_cmd = management_callback_proxy_cmd;
>          cb.remote_cmd = management_callback_remote_cmd;
> +        cb.send_cc_message = management_callback_send_cc_mesage;

Same typo here in the callback function name; which is why it compiles ;-)



-- 
kind regards,

David Sommerseth
OpenVPN Inc




