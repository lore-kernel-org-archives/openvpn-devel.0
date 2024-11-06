Message-ID: <77861124-f340-48d1-b021-c56dd37c43ad@...1227...>
Date: Wed, 6 Nov 2024 18:59:59 +0100
MIME-Version: 1.0
References: <20241106165950.14469-1-michael.m.clarke@...277...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20241106165950.14469-1-michael.m.clarke@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Allow auth plugins not to be invoked if
 other auth plugins fail
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Michael Clarke <michael.m.clarke@...277...>, Openvpn-devel@lists.sourceforge.net

Am 06.11.24 um 17:59 schrieb Michael Clarke:

Thanks for submitting a patch to OpenVPN. I have gone through the patch 
and commented on the things that I found when going through it.

> The current authentication process loops through all plugins, invoking
> them each in turn, then returning a combined result from each
> invocation. This causes a challenge if multiple plugins are configured
> and a later plugin should only be executed if an earlier plugin
> succeeds - such as sending a Multi-factor authentication challenge only
> if a previous username/password verification succeeds - as the OpenVPN
> admin has no way of configuring a dependency between plugins, and
> plugins have no visibility of the current authentication state, so an
> MFA challenge would always be sent even on a password challenge failure
> in the stated scenario.

This seems to only if you are using a different MFA approach than the 
current/recommended one, e.g. demonstrated by the demo script totp.py in 
the OpenVPN repository.

> 
> To overcome this, a system similar to Linux PAM's control flags is being
> introduced where auth plugins can be marked as one of four states:
> allows the plugin to fail without impacting other plugins whilst success
> of that plugin prevents any other plugins being run (sufficient),
> allow a plugin to fail whilst still then invoking certain other plugins
> before failing auth (required), allow a plugin's failure to abort the
> process immediately (requisite), or allow the plugin to be invoked but
> the result ignored (optional). For backwards compatibility plugins
> defined without a scope are treated as having a `required` scope.
> Attempting to specify a scope for a plugin that does not return
> an `OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY` mask will result in server
> startup aborting with an error, as will attempting to specify
> `sufficient` plugins after other auth plugins. For simplicity, any
> auth plugin that returns a deferred result but isn't specified as being
> a `required` scope will result in a server abort so that any subsequent
> plugins in the configuration aren't making an assumption about the
> deferred result.

To better understand what this patch is actually addressing, it would be 
nice to describe the scenario that you are addressing with this patch as 
that me do better understand what real-world scenario is actually 
addressed by this patch as the this is a bit abstract.


> 
> To maintain backwards compatibility for plugins being invoked, the
> plugin scope is dropped from the command arguments passed to the plugin
> initialisation although the plugin binary path continues to be retained.
> ---
>   doc/man-sections/plugin-options.rst |  37 +++++++-
>   src/openvpn/plugin.c                | 125 ++++++++++++++++++++++++++--
>   src/openvpn/plugin.h                |  10 +++
>   3 files changed, 164 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/man-sections/plugin-options.rst b/doc/man-sections/plugin-options.rst
> index 9266429e..1884fae9 100644
> --- a/doc/man-sections/plugin-options.rst
> +++ b/doc/man-sections/plugin-options.rst
> @@ -13,8 +13,41 @@ plug-ins must be prebuilt and adhere to the OpenVPN Plug-In API.
>        plugin module-name
>        plugin module-name "arguments"
>   
> -  The ``module-name`` needs to be the first
> -  argument, indicating the plug-in to load.  The second argument is an
> +  Additionally, an auth plugin can use the following syntax:
> +  ::
> +
> +     plugin [scope] module-name
> +     plugin [scope] module-name "arguments"
> +


plugin foo foo

could be both as

  plugin module-name "arguments"

and as

plugin [scope] module-name


according to the man page. I do not like the approach of using a 
whitelist of argument to determine which of the two is being used as a 
typo for example or using an old version can then change the parsing in 
unexpected way. I would rather see something that has not this ambiguity 
like introducing a new keyword like plugin-something.



> +  The ``scope`` argument is optional but must be the first argument
> +  if specified, and can be one of the following:
> +
> +    * :code:`sufficient` - If the plugin returns success, the connection is
> +      authenticated without calling any other plugins. If the plugin fails
> +      then processing will continue on to the next plugin.

What happens with other auth methods like management and auth scripts? 
That should be made clear without having to read the source code.

> +      :code:`sufficient` plugins must be listed before any other plugins.
> +    * :code:`required` - The plugin must return success for the connection to
> +      be authenticated. If the plugin fails then plugins will continue to be
> +      invoked until a plugin not defined as :code:`required` is reached, at
> +      which point the connection be be aborted as unauthenticated.
> +
> +      Any plugin returning a deferred result must be in the :code:`required`
> +      scope, or not have a scope set.
> +    * :code:`requisite` - The plugin must return success for the connection to
> +      be authenticated, but if the plugin fails, the connection is immediately
> +      terminated without calling any other plugins.
> +    * :code:`optional` - The plugin is called, but the result is ignored and
> +      will have no bearing on the authentication state of the connection.

What happens if all plugins are optinal. And what is the point of a 
plugin being called but ignored? Some idea what to use this for would be 
good.

> +
> +  If :code:`scope` is not specified for an auth plugin then the plugin will
> +  be treated as :code:`required`.

do we define what an auth plugin vs a non-plugin is anywhere?

> +  If :code:`scope` is specified for a non-auth plugin then the configuration
> +  will be treated as invalid.
> +

And then what will happen?


> +  The ``module-name`` needs to be the first argument - unless ``scope```, has
> +  been specified - indicating the plug-in to load.  The next argument is an
>     optional init string which will be passed directly to the plug-in.
>     If the init consists of multiple arguments it must be enclosed in
>     double-quotes (\").  Multiple plugin modules may be loaded into one
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index 944ce94a..6aeb381f 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -172,8 +172,36 @@ plugin_option_list_add(struct plugin_option_list *list, char **p,
>       {
>           struct plugin_option *o = &list->plugins[list->n++];
>           o->argv = make_extended_arg_array(p, false, gc);
> -        if (o->argv[0])
> +        if (o->argv[0] && o->argv[1])
>           {
> +            if (!strcmp(o->argv[0], "required"))
> +            {
> +                o->plugin_scope = PLUGIN_SCOPE_REQUIRED;
> +            }
> +            else if (!strcmp(o->argv[0], "requisite"))
> +            {
> +                o->plugin_scope = PLUGIN_SCOPE_REQUISITE;
> +            }
> +            else if (!strcmp(o->argv[0], "sufficient"))
> +            {
> +                o->plugin_scope = PLUGIN_SCOPE_SUFFICIENT;
> +            }
> +            else if (!strcmp(o->argv[0], "optional"))
> +            {
> +                o->plugin_scope = PLUGIN_SCOPE_OPTIONAL;
> +            }
> +            else
> +            {
> +                o->plugin_scope = PLUGIN_SCOPE_UNDEFINED;
> +                o->so_pathname = o->argv[0];
> +                return true;
> +            }
> +            o->argv = make_extended_arg_array((char **) &o->argv[1], false, gc);
> +            o->so_pathname = o->argv[0];
> +        }
> +        else if (o->argv[0])
> +        {
> +            o->plugin_scope = PLUGIN_SCOPE_UNDEFINED;
>               o->so_pathname = o->argv[0];
>           }
>           return true;
> @@ -184,6 +212,28 @@ plugin_option_list_add(struct plugin_option_list *list, char **p,
>       }
>   }
>   
> +static char *
> +plugin_scope_name(enum plugin_scope scope)
> +{
> +    switch (scope)
> +    {
> +        case PLUGIN_SCOPE_REQUIRED:
> +            return "required";
> +
> +        case PLUGIN_SCOPE_REQUISITE:
> +            return "requisite";
> +
> +        case PLUGIN_SCOPE_SUFFICIENT:
> +            return "sufficient";
> +
> +        case PLUGIN_SCOPE_OPTIONAL:
> +            return "optional";
> +
> +        default:
> +            return "";
> +    }
The PLUGIN_SCOPE_UNDEFINED is missing from this function and default 
should be something other than an empty string I think




> +    bool non_scope_sufficient_auth_plugin_seen = false;

I have trouble parsing this variable name and meaning. A plugin without 
scope is required from the earlier manpage changes. The combination of 
no scope but a sufficent scope makes no sense to me.

>       for (i = 0; i < pc->n; ++i)
>       {
>           plugin_open_item(&pc->plugins[i],
> @@ -746,6 +807,19 @@ plugin_common_open(struct plugin_common *pc,
>                            pr ? &pr->list[i] : NULL,
>                            envp,
>                            init_point);
> +        if (pc->plugins[i].plugin_type_mask != plugin_supported_types() && (pc->plugins[i].plugin_type_mask & OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)) == OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
> +        {
> +            if (non_scope_sufficient_auth_plugin_seen && pc->plugins[i].plugin_scope == PLUGIN_SCOPE_SUFFICIENT)
> +            {
> +                msg(M_FATAL,
> +                    "PLUGIN_INIT: auth plugin %s is defined as 'sufficient' but has been specified after other auth plugins not specified as 'sufficient'",
> +                    pc->plugins[i].so_pathname);
> +            }

Is this restriction documented in the man page? Also why has this 
decision been made. I don't see any obvious reason for it.

Arne


