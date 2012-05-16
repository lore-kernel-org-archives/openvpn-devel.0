Message-ID: <4FB3BA1D.8060608@...1114...>
Date: Wed, 16 May 2012 16:30:53 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz0V=cE7R=nTefCbP4Z1=+WoYnxhPfNuWasEZjf1EUSOHA@...278...>
	<4FB3810A.4050209@...1114...>
	<CAOazyz11iQ6wuNJ_tp=2U5gH5=jeLkLHL6EG_8+yrDjXtEbFUA@...278...>
	<4FB38570.90902@...1114...>
	<CAOazyz29iYJ2rDPBZzk0Otac543AcYFf_gbHgRgaFo+qcVLpTQ@...278...>
	<4FB39166.9050906@...1114...>
	<CAOazyz2puY6DiXcDKiDy2QaUmHqEtSaTsdgZS6dj=D2RT73mzw@...278...>
	<4FB39E94.1070202@...1114...>
	<CAOazyz3SFQ9Wm070nvvhfn4E0bnpbwsfGc48rnhSMRLwpP_Y9A@...278...>
In-Reply-To: <CAOazyz3SFQ9Wm070nvvhfn4E0bnpbwsfGc48rnhSMRLwpP_Y9A@...278...>
Subject: Re: [Openvpn-devel] eurephia plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/05/12 14:38, Alon Bar-Lev wrote:
> On Wed, May 16, 2012 at 3:33 PM, David Sommerseth 
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 16/05/12 14:03, Alon Bar-Lev wrote: [...snip...]
>>> But if I get this right, a new configuration option is needed,
>>> not compile time directive, something like:
>>> 
>>> --setenv-data [-]<data>, ...
>>> 
>>> data :: cert-digest-sha1
>>> 
>>> This way, only users which require this functionality may
>>> enable it and perform hash of the chain. No stability issues in
>>> this mode.
>> 
>> I think when James is concerned about stability issues, it is
>> more the situation of the code changing than growing the
>> environment list too long.  However, a too big environment list
>> may cause stability issues as well (overflow situations, etc).
>> So you have a good argument as well.
>> 
>> (In my case with the eurephia support, I added the #ifdef to make
>> it more likely that it would be accepted by James.)
>> 
>>> In this scheme we can add more data types if required, and
>>> assign data types for existing functionality, allowing to
>>> disable using "-", example is cert-serial or cert-subject or
>>> certh-depth.
>>> 
>>> What do you think?
>> 
>> I like this idea.  However, the plug-in v3 API is probably
>> solving some of these things as well, as that provides access to
>> the whole X509 structure.  That doesn't solve it for scripts,
>> though, but for plug-ins that will provide all the information
>> ever needed directly.
> 
> Oh... so if the 2.3 can provide this information to your plugin,
> can we remove this entirely?

I would prefer not to change this at the current point.  The eurephia
plug-in needs to be updated before we can do such a move.

And even though eurephia is the only known user of this information
currently;  We don't know if there are others who have began using
this information already which we don't know about.  So we might break
things, especially if other users are scripts.

>> But if I see it from a security perspective, reducing the amount
>> of environment variables and only providing the information
>> requested for makes a lot of sense - and this would affect both
>> plug-ins and scripts too.
> 
> But plugins should not communicate via environment... I was
> confused, as I concluded that if you set the environment the target
> consumer is a script.

Please, look carefully at the plug-in API.  It provides an extra array
pointer, which contains the environment variables.

OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v1)
     (openvpn_plugin_handle_t handle, const int type, const char
      *argv[], const char *envp[]);

OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v2)
     (openvpn_plugin_handle_t handle,
      const int type,
      const char *argv[],
      const char *envp[],
      void *per_client_context,
      struct openvpn_plugin_string_list **return_list);

OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v3)
     (const int version,
      struct openvpn_plugin_args_func_in const *arguments,
      struct openvpn_plugin_args_func_return *retptr);

struct openvpn_plugin_args_func_in
{
  const int type;
  const char ** const argv;
  const char ** const envp;
  ...

For C based plug-ins, you don't use the "traditional" getenv()
function, to grab this info.  You need to extract this information
from the envp pointers.

>> What I'm actually thinking, in regards to backwards
>> compatibility, is that there is a default environment variable
>> list which consists of the variables we provide today.  If
>> --setenv-data is used, this list is reset.  So if you use
>> --setenv-data, you need to also include those variables which was
>> there before - if you really need them.  It will naturally
>> require more thinking when this is being configured by the 
>> users.
> 
> I thought of having the default as enabled and put '-' before
> element to remove... -* can remove all like Gentoo USE flags :)

Well, I believe most average admins are lazy by nature.  And to make
them use a more securer approach, you need to force them to do it.
Even though '-*' is quite elegant, it won't last long before someone
asks for '+*' to enable all - with the reason "It's so many variables,
I'll just take them all and don't think about it any more".

> But now that you describe you can do this using the plugin API,
> why not modify the plugin to perform this and just remove this?

I don't know if I'm the only user of this information or not.  If I'm
not, then we will break things for others as well.  That I don't like,
especially when the current implementation covers both plug-ins and
scripts.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+zuhsACgkQDC186MBRfrpxRgCgmuDjQjL03g8drXkACuk+qGiZ
jGQAmwX6EWh71ci2DOMALovlC3hoH5M0
=ocVF
-----END PGP SIGNATURE-----

