References: <1444224734-18721-1-git-send-email-lstipakov@...277...>
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <561910F6.6070504@...1114...>
Date: Sat, 10 Oct 2015 15:21:58 +0200
MIME-Version: 1.0
In-Reply-To: <1444224734-18721-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Send push reply right after async
 auth complete
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

On 07/10/15 15:32, Lev Stipakov wrote:
> v2:
> More careful inotify_watchers handling
> * Ensure that same multi_instance is added only once
> * Ensure that multi_instance is always removed
> 
> v1:
> This feature speeds up connection establishment in cases when async
> authentication result is not ready when first push request arrives. At
> the moment server sends push reply only when it receives next push
> request, which comes 5 seconds later.
> 
> Implementation overview.
> 
> Add new configure option ENABLE_ASYNC_PUSH, which can be enabled if
> system supports inotify.
> 
> Add inotify descriptor to an event loop. Add inotify watch for a
> authentication control file. Store mapping between watch descriptor and
> multi_instance in a dictionary. When file is closed, inotify fires an
> event and we continue with connection establishment - call client-
> connect etc and send push reply.
> 
> Inotify watch descriptor got automatically deleted after file is closed
> or when file is removed. We catch that event and remove it from the
> dictionary.
> 
> Feature is easily tested with sample "defer" plugin and following settings:
> 
> auth-user-pass-optional
> setenv test_deferred_auth 3
> plugin simple.so
> 
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  configure.ac          |  15 +++++
>  src/openvpn/forward.c |   8 +++
>  src/openvpn/mtcp.c    |  28 ++++++++++
>  src/openvpn/mudp.c    |  27 +++++++++
>  src/openvpn/multi.c   | 152 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/openvpn/multi.h   |  14 +++++
>  src/openvpn/openvpn.h |  11 ++++
>  src/openvpn/push.c    |  69 +++++++++++++----------
>  src/openvpn/push.h    |   2 +
>  9 files changed, 295 insertions(+), 31 deletions(-)
> 

[...snip...]

> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 7a5d383..134905c 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1371,6 +1371,9 @@ io_wait_dowork (struct context *c, const unsigned int flags)
>  #ifdef ENABLE_MANAGEMENT
>    static int management_shift = 6; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
>  #endif
> +#ifdef ENABLE_ASYNC_PUSH
> +  static int file_shift = 8;
> +#endif

Can we please have a comment on what this 'file_shift' value means?  Just a
single line comment.  Perhaps 'file_change' would be a better name?

[...snip...]

> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index 57118f8..30ec345 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -38,6 +38,10 @@
>  
>  #include "memdbg.h"
>  
> +#ifdef ENABLE_ASYNC_PUSH
> +#include <sys/inotify.h>
> +#endif
> +

Maybe HAVE_SYS_INOTIFY_H is better?

[...snip...]

> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 902c4dc..0da9ca7 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -28,6 +28,11 @@
>  #include "config-msvc.h"
>  #endif
>  
> +#ifdef ENABLE_ASYNC_PUSH
> +#include <sys/inotify.h>
> +#define INOTIFY_EVENT_BUFFER_SIZE 16384
> +#endif
> +

Maybe HAVE_SYS_INOTIFY_H is better here too?

>  #include "syshead.h"
>  
>  #if P2MP_SERVER
> @@ -243,6 +248,20 @@ cid_compare_function (const void *key1, const void *key2)
>  
>  #endif
>  
> +#ifdef ENABLE_ASYNC_PUSH
> +static uint32_t
> +int_hash_function (const void *key, uint32_t iv)
> +{
> +  return (unsigned long)key;
> +}
> 
This looks very odd, but I understand it's required by hash_init().  Could you
add a little remark about why this function looks so "useless"?

[...snip...]

> @@ -1877,6 +1932,14 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
>  
>  	  /* set context-level authentication flag */
>  	  mi->context.c2.context_auth = CAS_SUCCEEDED;
> +
> +#ifdef ENABLE_ASYNC_PUSH
> +	  /* authentication complete, send push reply */
> +	  if (mi->context.c2.push_request_received)
> +	    {
> +	      process_incoming_push_request(&mi->context);
> +	    }
> +#endif
>  	}
>        else
>  	{
> @@ -1906,6 +1969,54 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
>    mi->context.c2.push_reply_deferred = false;
>  }
>  
> +#ifdef ENABLE_ASYNC_PUSH
> +void
> +multi_process_file_closed (struct multi_context *m, const unsigned int mpp_flags)

It would be great to see a more verbose doxygen comment here, explaining what
this function do, why and who calls it in which situations.

> +{
> +  char buffer[INOTIFY_EVENT_BUFFER_SIZE];
> +  size_t buffer_i = 0;
> +  int r = read (m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);
> +
> +  while (buffer_i < r)
> +    {
> +      /* parse inotify events */
> +      struct inotify_event *pevent = (struct inotify_event *) &buffer[buffer_i];
> +      size_t event_size = sizeof (struct inotify_event) + pevent->len;
> +      buffer_i += event_size;
> +
> +      msg(D_MULTI_DEBUG, "MULTI: modified fd %d, mask %d", pevent->wd, pevent->mask);
> +
> +      struct multi_instance* mi = hash_lookup(m->inotify_watchers, (void*) (unsigned long) pevent->wd);
> +
> +      if (pevent->mask & IN_CLOSE_WRITE)
> +	{
> +	  if (mi)
> +	    {
> +	      /* continue authentication and send push_reply */
> +	      multi_process_post (m, mi, mpp_flags);
> +	    }
> +	  else
> +	    {
> +	      msg(D_MULTI_ERRORS, "MULTI: multi_instance not found!");
> +	    }
> +	}
> +      else if (pevent->mask & IN_IGNORED)
> +	{
> +	  /* this event is _always_ fired when watch is removed or file is deleted */
> +	  if (mi)
> +	    {
> +	      hash_remove(m->inotify_watchers, (void*) (unsigned long) pevent->wd);
> +	      mi->inotify_watch = -1;
> +	    }
> +	}
> +      else
> +	{
> +	  msg(D_MULTI_ERRORS, "MULTI: unknown mask %d", pevent->mask);
> +	}
> +    }
> +}
> +#endif
> +
>  /*
>   * Add a mbuf buffer to a particular
>   * instance.
> @@ -2066,19 +2177,54 @@ multi_process_post (struct multi_context *m, struct multi_instance *mi, const un
>  
>    if (!IS_SIG (&mi->context) && ((flags & MPP_PRE_SELECT) || ((flags & MPP_CONDITIONAL_PRE_SELECT) && !ANY_OUT (&mi->context))))
>      {
> +#ifdef ENABLE_ASYNC_PUSH
> +#ifdef ENABLE_DEF_AUTH

Could we combine these #ifdefs instead of nesting them?  Something like:

   #if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)

> +      bool was_authenticated = false;
> +      struct key_state *ks = NULL;
> +      if (mi->context.c2.tls_multi)
> +        {
> +          ks = &mi->context.c2.tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
> +          was_authenticated = ks->authenticated;
> +        }
> +#endif
> +#endif
> +
>        /* figure timeouts and fetch possible outgoing
>  	 to_link packets (such as ping or TLS control) */
>        pre_select (&mi->context);
>  
> -      if (!IS_SIG (&mi->context))
> +#ifdef ENABLE_ASYNC_PUSH
> +#ifdef ENABLE_DEF_AUTH

Same here ... combine these #ifdefs

> +      if (ks && ks->auth_control_file && ks->auth_deferred && !was_authenticated)
>  	{
> -	  /* tell scheduler to wake us up at some point in the future */
> -	  multi_schedule_context_wakeup(m, mi);
> +	  /* watch acf file */
> +	  long wd = inotify_add_watch(m->top.c2.inotify_fd, ks->auth_control_file, IN_CLOSE_WRITE | IN_ONESHOT);

What does 'wd' mean in this context?  Could the variable be slightly more
descriptive.

[...snip...]

> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index ef22269..da2a807 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -241,6 +241,9 @@ struct context_2
>  #  define MANAGEMENT_READ  (1<<6)
>  #  define MANAGEMENT_WRITE (1<<7)
>  # endif
> +#ifdef ENABLE_ASYNC_PUSH
> +# define FILE_CLOSED       (1<<8)
> +#endif

I see that the management stuff is also #ifdef'ed here.  But I'm not sure it's
a clever idea to #ifdef bitmasks ... that can seed some fun debugging
situations.  On the otherhand, you can't use these macros if they're #ifdef'ed
and you use them without of ENABLE_ASYNC_PUSH.  I'm torn.

>    unsigned int event_set_status;
>  
> @@ -436,6 +439,9 @@ struct context_2
>  #if P2MP_SERVER
>    /* --ifconfig endpoints to be pushed to client */
>    bool push_reply_deferred;
> +#ifdef ENABLE_ASYNC_PUSH
> +  bool push_request_received;
> +#endif
>    bool push_ifconfig_defined;
>    time_t sent_push_reply_expiry;
>    in_addr_t push_ifconfig_local;
> @@ -479,6 +485,11 @@ struct context_2
>  #ifdef MANAGEMENT_DEF_AUTH
>    struct man_def_auth_context mda_context;
>  #endif
> +
> +#ifdef ENABLE_ASYNC_PUSH
> +  /* descriptor for monitoring file changes */
> +  int inotify_fd;

Just a nit pick, could we move the comment to the same line as the declaration?

[...snip...]

Otherwise, this looks reasonable and fine.  Feature wise it is very useful.
I've done some quick compile and sanity tests, as this has been used in
production in your own environment for about a year or so.  So most of the
bugs have hopefully already been squashed.


-- 
kind regards,

David Sommerseth

