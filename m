References: <20190613144113.6418-1-arne@...1227...>
 <20190613144113.6418-5-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <277155fb-bfbf-6c06-123e-5627e5f3f41d@...2080...>
Date: Tue, 22 Oct 2019 22:37:25 +0200
MIME-Version: 1.0
In-Reply-To: <20190613144113.6418-5-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 4/5] Implement sending response to
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

On 13/06/2019 16:41, Arne Schwabe wrote:
> When a client announces its support to support text based
> challenge/response via IV_SOO=cr_text,the client needs to also
> be able to reply to that response.
> 
> This adds the "cr-response" management function to be able to
> do this. The answer should be base64 encoded.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt |  8 ++++++++
>  src/openvpn/init.c       | 25 +++++++++++++++++++++++++
>  src/openvpn/manage.c     | 37 ++++++++++++++++++++++++++++++++++++-
>  src/openvpn/manage.h     |  1 +
>  4 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index 05d30b0a..29f2da75 100644
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

I'm pondering if this response should have a version identifier as well, which
probably should match the version in the CR_RESPONSE message.  I'm not
entirely convinced it is needed yet, but just raising it for further discussion.

I'm leaning against adding it, because it is the "UI interface" using this
cr-response call via the managment interface; which results in the client side
sending the CR_RESPONSE back to the server - where the client code should add
that in its own response.

As said, I'm not convinced yet ... just bringing it up for a quick discussion
to see if we've missed a few corner cases or not.

[...snip...]

> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 647f5336..08425d85 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -287,6 +287,30 @@ ce_management_query_proxy(struct context *c)
>      return ret;
>  }
>  
> +static bool
> +management_callback_send_cc_mesage(void *arg,
> +                                   const char *command,
> +                                   const char *parameters)

This function could use a doxygen documentation tag.

> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index a2b58296..8ec90bb1 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
[...snip...]
> +static void
> +man_send_cc_message(struct management *man, const char* message, const char* parameters)

This function could also benefit from a doxygen documentation tag.

> +{
> +    if (man->persist.callback.send_cc_message)
> +        {
> +            const bool status = (*man->persist.callback.send_cc_message)
> +                (man->persist.callback.arg, message, parameters);

This code is hard to read, due to the arguments being passed to the callback
function is after a line break.  Could we use a temporary/scoped function
pointer which is assigned to (*man->persist.callback.send_cc_message) and used
instead?

[...snip...]
> +    else
> +    {
> +        msg(M_CLIENT, "ERROR: This command is not supported by the current daemon mode");

Why this "current daemon mode" reference?  Can't we make it a bit clearer?
Like "management interface does not support responding to this
challenge/response protocol", or something like that?

> 
> +/**
> + *
> + * @param p         pointer to the parameter array
> + * @param n         number of arguments required
> + * @param flags     if MN_AT_LEAST require at least n parameters and not exactly n
> + * @return          Return wether p has n (or at least n) parameters
> + */
>  static bool
>  man_need(struct management *man, const char **p, const int n, unsigned int flags)

There's something missing here ... like a description of the function.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


