References: <CAKuzo_hByb0e-3qVkV7zKScfxC3bAUO5MiXdBp3qJzy3uFLikw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b5e5674b-e04b-7a60-26a6-ac943bd1f1e7@...2080...>
Date: Fri, 12 Aug 2016 11:49:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hByb0e-3qVkV7zKScfxC3bAUO5MiXdBp3qJzy3uFLikw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4 2/4] Re-implement the systemd support
 using the new query user API
Reply-To: openvpn-users@lists.sourceforge.net
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
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 12/08/16 06:11, Selva Nair wrote:
> (sending again with the list in CC:)
> 
> Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth <davids@...515...
> <mailto:davids@...515...>> wrote:
> 
>     This provides exactly the same systemd functionality which existed
>     before the query user infrastructure got implemented.
> 
>       [v4 - change disapproved &= syntax ]
> 
>       [v3 - Remove QUERY_USER_EXEC_ALTERNATIVE macro, simplify
>             alternatives definition directly in console.h.  For
>             now only depend on ENABLE_SYSTEMD]
> 
>       [v2 - Removed the QUERY_USER_FOREACH macro]
> 
>     Signed-off-by: David Sommerseth <davids@...515...
>     <mailto:davids@...515...>>
>     ---
> 
> 
> 
>     -#ifdef QUERY_USER_EXEC_ALTERNATIVE
> 
> 
> This was introduced in patch 1, and now removed in patch 2. Any
> particular reason to split these patches into two? Much easier (and
> safer -- see below for why) to review if squashed together.

This is a result of earlier reviews.  I can understand this can be
puzzling, though.  See the v3 comment in the commit message.  And
basically, before this patch the OpenVPN console code paths knows
nothing about systemd so it would be odd to change the macro name in
patch 1.

I did not want to squash patch 1 + 2 into a single patch, basically to
isolate changes related to systemd from the more generic changes.  This
can help when needing to bisect later on along these code paths; then
you can easily say "this is related to systemd changes" - or the
opposite.  Generally, I prefer smaller and isolated patches - to ease
debugging.

>     +++ b/src/openvpn/console_systemd.c
> 
>     +static bool
>     +get_console_input_systemd (const char *prompt, const bool echo,
>     char *input, const int capacity)
>     +{
>     +    int std_out;
>     +    bool ret = false;
>     +    struct argv argv;
>     +
>     +    argv_init (&argv);
>     +    argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
>     +    argv_printf_cat (&argv, "%s", prompt);
>     +
>     +    if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
>     +       return false;
>     +    }
>     +    CLEAR (*input);
> 
> 
> Oh, here is a bug that was fixed sometime ago, and its trying to sneak
> back in, eh :)  Looks like a copy-paste from an old version. This
> function was removed in patch 1 and now added in patch 2 which made it
> hard to spot this. Anyway it should be:
> 
> memset (input, 0, capacity);
>  
> 
>     +    if (read (std_out, input, capacity) != 0)
>
> That leaves no room for the terminating NUL. Should be
>

Ouch!  Good catch!  I'll dig into this today and send an updated patch
for this issue.


-- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


