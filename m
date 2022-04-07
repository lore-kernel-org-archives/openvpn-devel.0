Message-ID: <3a31b6cf-4810-63c3-6e5d-8e8d0a38904f@...2080...>
Date: Thu, 7 Apr 2022 12:24:06 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220310115718.11188-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20220310115718.11188-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Enable deferred auth for multiple
 plugins (RFC).
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/03/2022 12:57, Gert Doering wrote:
> Without this patch, OpenVPN behaviour if more than one plugin wants
> to do deferred user/password authentication not well-defined, as
> there is just one set of auth control files and a single plugin state.
> 
> This patch changes "key state -> plugin_auth" from a single struct
> to an array of MAX_PLUGINS elements that have per-plugin auth-control
> files and auth status.
> 
> All direct access is changed to iterating over this array.
> 
> The actual plugin calls are no longer done with the "do them all"
> function plugin_call() (or plugin_call_ssl()) but plugin.c/plugin.h
> is changed to expose the "call one" function plugin_call_item(), and
> verify_user_pass_plugin() calls this for each loaded plugin,
> keeping track of "overall" state.
> 
> key_state_test_plugin_auth() is introduced to do the
> "key_state_test_auth_control_file()" test for all plugins, and
> return "FAIL if one fails, PENDING if one is pending, SUCCESS
> if one was pending and succeeded now".
> 
> This was tested with the "auth-multi" test plugin, with 5-7 plugins
> loaded (some deferred, some direct) and "some of them failing" or
> "all succeeding".  Testing included "will it leak files if multiple
> deferred plugins are ongoing, and one of the earlier ones rejects
> authentication".
> 
> This patch is not suitable for production use:
>   - it's full of debug output
>   - it will break compilation without ENABLE_PLUGINS
>   - it stands to argue whether plugin_call_item() should be exposed,
>     or key_state_test_plugin_auth() might be moved to plugin.c instead
>     (with a null function if ENABLE_PLUGINS is not defined)
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   src/openvpn/plugin.c     |   2 +-
>   src/openvpn/plugin.h     |   9 +++
>   src/openvpn/ssl.c        |   5 +-
>   src/openvpn/ssl_common.h |   4 +-
>   src/openvpn/ssl_verify.c | 127 ++++++++++++++++++++++++++++++++-------
>   5 files changed, 123 insertions(+), 24 deletions(-)
Hi,

So I've had a deeper dive into this proposal.  At the moment, I have 
only glared at the code and considered the overall implementation idea.

TL;DR: This makes a lot of sense, and we should pursue this further. But 
there are room for some adjustments and further improvements.

When it comes to exposing plugin_call_item(), I think it makes sense to 
refactor the changes you've added to verify_user_pass_plugin() into 
plugin_call_ssl() instead.  This will make this implementation more 
generic and not having a special behavior only for auth-user-pass.

I also had a quick look at verify_user_pass_script() as well, and I 
think this needs to be re-evaluated with this change as well.  Scripts 
can now also do deferred authentication (which I believe is a new 
feature in git master/coming 2.6).  We may hit the same undefined 
behavior here as well with at least --auth-user-pass-verify, possibly 
other too.

The critical code path in regards to the authentication is in the new 
key_state_test_plugin_auth().  This implementation looks sane.  I would 
probably suggest to use a different variable name than 'ret_one'. 
Perhaps 'plugin_state' is a better name?  It was especially the last 
if() clause requiring me to re-read it a few times, as I missed the 
'_one' part and didn't quite understand the logic behind "ret = 
ACF_SUCCEEDED && ret != ACF_PENDING"; it made more sense when I grasped 
the first "ret" was supposed to be "ret_one".

Also, in that function "&(ads[i])" isn't the prettiest approach, but 
will work.  Could we do this nicer?

Another improvement I think can be reasonable is to refactor plugin_n() 
to return an internal counter of loaded plug-ins instead of passing a 
pointer to a plugin struct.  This allows the proposed changes to use 
plugin_n() more freely and to avoid iterating over MAX_PLUGINS.  Now 
there is a mixture between iterating plugin_n() and MAX_PLUGINS, and in 
most configurations plugin_n() will return a lower value than MAX_PLUGINS.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


