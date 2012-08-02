MIME-Version: 1.0
In-Reply-To: <CAOazyz0v-DMCY3y-sozWSN53uyqdFZBryv+sfZt7snQuQ3E4kw@...278...>
References: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
	<1343901239-25526-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz0v-DMCY3y-sozWSN53uyqdFZBryv+sfZt7snQuQ3E4kw@...278...>
Date: Thu, 2 Aug 2012 13:54:06 +0300
Message-ID: <CAOazyz3cN=FfmB+zZ-Roav2D3Z6zbS4v+-g6_mFjSXB8NfFa7Q@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2 v2.2] add plugin_log() API to write
 to openvpn log
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

And export vprintf variant as well, to allow wrapper.

On Thu, Aug 2, 2012 at 1:02 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> This is how it should be done, no games with symbols and linkage.
>
> Please add printf style pragmas to the function.
>
> On Thu, Aug 2, 2012 at 12:53 PM, Heiko Hund <heiko.hund@...1489...> wrote:
>> Some plugins want to add messages to the openvpn log file. The
>> plugin_log() API provides a way for them to do so.
>>
>> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
>> ---
>>
>> This is the second variant of PATCH 2/2 that deals with the fact that
>> the original plugin_log() approach was not working on Windows.
>>
>> It passes the function pointer of plugin_log() to the plug-in's open_v3 hook.
>>
>> Pros:
>>   + cleaner, more standard approach; less magic
>>   + no special treatment of Windows necessary
>>
>> Cons:
>>   - only works for plugins supporting the open_v3 API
>>   - bit harder to use as the callback is only available inside open_v3 at first
>>
>>  include/openvpn-plugin.h |   25 +++++++++++++++++++++-
>>  src/openvpn/plugin.c     |   52 +++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 75 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
>> index 1c80eec..ea0d84e 100644
>> --- a/include/openvpn-plugin.h
>> +++ b/include/openvpn-plugin.h
>> @@ -145,7 +145,7 @@ typedef void *openvpn_plugin_handle_t;
>>  /*
>>   * For Windows (needs to be modified for MSVC)
>>   */
>> -#if defined(__MINGW32_VERSION) && !defined(OPENVPN_PLUGIN_H)
>> +#if defined(WIN32) && !defined(OPENVPN_PLUGIN_H)
>>  # define OPENVPN_EXPORT __declspec(dllexport)
>>  #else
>>  # define OPENVPN_EXPORT
>> @@ -221,12 +221,35 @@ struct openvpn_plugin_string_list
>>   *        variables in "name=value" format.  Note that for security reasons,
>>   *        these variables are not actually written to the "official"
>>   *        environmental variable store of the process.
>> + *
>> + * plugin_log : a pointer to the plugin logging function.
>> + *              Use this function to add information to the OpenVPN log file.
>> + *              Messages will only be displayed if the plugin_name parameter
>> + *              is set. Debug messages will only be displayed with plug-in
>> + *              debug log verbosity.
>>   */
>> +typedef enum
>> +{
>> +  PLOG_ERR    = (1 << 0),  /* Error condition message */
>> +  PLOG_WARN   = (1 << 1),  /* General warning message */
>> +  PLOG_NOTE   = (1 << 2),  /* Informational message */
>> +  PLOG_DEBUG  = (1 << 3),  /* Debug message, displayed if verb >= 7 */
>> +
>> +  PLOG_ERRNO  = (1 << 8),  /* Add error description to message */
>> +  PLOG_NOMUTE = (1 << 9),  /* Mute setting does not apply for message */
>> +
>> +} openvpn_plugin_log_flags_t;
>> +
>> +typedef void (*plugin_log_t) (openvpn_plugin_log_flags_t flags,
>> +                              const char *plugin_name,
>> +                              const char *format, ...);
>> +
>>  struct openvpn_plugin_args_open_in
>>  {
>>    const int type_mask;
>>    const char ** const argv;
>>    const char ** const envp;
>> +  plugin_log_t plugin_log;
>>  };
>>
>>
>> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
>> index 7ce2f5e..59fb8a0 100644
>> --- a/src/openvpn/plugin.c
>> +++ b/src/openvpn/plugin.c
>> @@ -287,6 +287,55 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
>>  }
>>
>>  static void
>> +plugin_log (openvpn_plugin_log_flags_t flags, const char *name, const char *format, ...)
>> +{
>> +  unsigned int msg_flags;
>> +
>> +  if (!format)
>> +    return;
>> +
>> +  if (!name || name[0] == '\0')
>> +    {
>> +      msg (D_PLUGIN_DEBUG, "PLUGIN: suppressed log message from plugin with unknown name");
>> +      return;
>> +    }
>> +
>> +  if (flags & PLOG_ERR)
>> +    msg_flags = M_INFO | M_NONFATAL;
>> +  else if (flags & PLOG_WARN)
>> +    msg_flags = M_INFO | M_WARN;
>> +  else if (flags & PLOG_NOTE)
>> +    msg_flags = M_INFO;
>> +  else if (flags & PLOG_DEBUG)
>> +    msg_flags = D_PLUGIN_DEBUG;
>> +
>> +  if (flags & PLOG_ERRNO)
>> +    msg_flags |= M_ERRNO;
>> +  if (flags & PLOG_NOMUTE)
>> +    msg_flags |= M_NOMUTE;
>> +
>> +  if (MSG_TEST (msg_flags))
>> +    {
>> +      struct gc_arena gc;
>> +      va_list arglist;
>> +      char* msg_fmt;
>> +
>> +      /* Never add instance prefix; not thread safe */
>> +      msg_flags |= M_NOIPREFIX;
>> +
>> +      gc_init (&gc);
>> +      msg_fmt = gc_malloc (ERR_BUF_SIZE, false, &gc);
>> +      openvpn_snprintf (msg_fmt, ERR_BUF_SIZE, "PLUGIN %s: %s", name, format);
>> +
>> +      va_start (arglist, format);
>> +      x_msg_va (msg_flags, msg_fmt, arglist);
>> +      va_end (arglist);
>> +
>> +      gc_free (&gc);
>> +    }
>> +}
>> +
>> +static void
>>  plugin_open_item (struct plugin *p,
>>                   const struct plugin_option *o,
>>                   struct openvpn_plugin_string_list **retlist,
>> @@ -312,7 +361,8 @@ plugin_open_item (struct plugin *p,
>>        if (p->open3) {
>>          struct openvpn_plugin_args_open_in args = { p->plugin_type_mask,
>>                                                      (const char ** const) o->argv,
>> -                                                    (const char ** const) envp };
>> +                                                    (const char ** const) envp,
>> +                                                    plugin_log };
>>          struct openvpn_plugin_args_open_return retargs;
>>
>>          CLEAR(retargs);
>> --
>> 1.7.10.4
>>
>>
>> ------------------------------------------------------------------------------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and
>> threat landscape has changed and how IT managers can respond. Discussions
>> will include endpoint security, mobile security and the latest in malware
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

