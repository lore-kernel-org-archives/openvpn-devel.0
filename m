MIME-Version: 1.0
References: <1580388208-26594-1-git-send-email-selva.nair@...277...>
 <CAGyAFMX6+K_7jzPqnubjJ7oyYR5udq37ZpcR7GDVVfxFV8t_NA@...278...>
In-Reply-To: <CAGyAFMX6+K_7jzPqnubjJ7oyYR5udq37ZpcR7GDVVfxFV8t_NA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 31 Jan 2020 08:42:50 -0500
Message-ID: <CAKuzo_gzQj-02zfGssPV6kJwv24GBVYEYVY6EW0NvEmP04eJpQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Swap the order of checks for validating
 interactive service user
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Jan 31, 2020 at 5:29 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> Hi,
>
>> +    if (!ValidateOptions(pipe, sud.directory, sud.options)
>> +        && !IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn_admin_group)
>>      {
>
>
> Closing parenthesis is missing:

That is embarrassing.. I went through the motions of compile testing it without
updating the source tree in openvpnbuild. Yikes..

>
> >C:\Users\lev\Projects\openvpn\src\openvpnserv\interactive.c(1586,5): error C2143: syntax error: missing ')' before '{'
>
> Also it is probably just me, but took me a while to figure out what that code is doing and why.
>
> Could you slightly improve the comment above lines you touch
> ("Check user is authorized or options are white-listed") and mention something like
> "Non-authorized users are allowed to use only white-listed options and
> have config only in global openvpn config directory"?

Will do.

>
> When I started to debug it, I realized that I have to be authorized user when config
> is in my current user's directory (C:\Users\lev\OpenVPN\config) and not in "global" config
> directory ("C:\Program Files\OpenVPN\config"). Is this by design?

Yes, that is by design. As iservice allows the users to do some actions that
normally require admin privilege, a limited user is only allowed to use some
whitelisted options or a config installed by an admin in the global config
directory. They are not allowed to run arbitrary configs
that they can edit. Unless an admin explicitly gives them permission to do
so --- checked by membership in "OpenVPNAdministrators" group. Users
who have admin privilege (even if not enabled in the token by UAC) are
considered authorized.

Selva

