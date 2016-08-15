References: <1470684488-21307-1-git-send-email-davids@...515...>
	<1470684488-21307-2-git-send-email-davids@...515...>
	<CAKuzo_ggo2A5hFwe3u=+fwAWBoRQxhRvf_LDTCsSTrSLU+AZCA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <43ba7b4d-2c78-d748-97b9-bf1fdaed3379@...2080...>
Date: Mon, 15 Aug 2016 12:49:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ggo2A5hFwe3u=+fwAWBoRQxhRvf_LDTCsSTrSLU+AZCA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4 1/4] Rework the user input interface
 to make it more modular
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/08/16 05:48, Selva Nair wrote:
> Hi,
>=20
> On Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth
> <davids@...515... <mailto:davids@...515...>> wrote:

[...snip...]

> } @@ -1184,32 +1192,46 @@ get_user_pass_cr (struct user_pass *up,=20
> struct buffer user_prompt =3D alloc_buf_gc (128, &gc); struct buffer
> pass_prompt =3D alloc_buf_gc (128, &gc);
>=20
> +             query_user_clear (); buf_printf (&user_prompt, "Enter
> %s Username:",
prefix);
> buf_printf (&pass_prompt, "Enter %s Password:",
prefix);
>=20
>=20
> if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))=20
> { -                 if (!get_console_input (BSTR (&user_prompt),
> true, up->username, USER_PASS_LEN)) -                   msg
> (M_FATAL, "ERROR: could not read %s username from stdin", prefix);=20
> +                 query_user_add (BSTR(&user_prompt),=20
> BLEN(&user_prompt), +
> up->username, USER_PASS_LEN,
true);
> +               } + +             query_user_add
> (BSTR(&pass_prompt),
BLEN(&pass_prompt),
> +                              up->password, USER_PASS_LEN,
> false);
>=20
>=20
> The above call should be conditional on "if
> (password_from_stdin)". Else it will get called even after reading
> password from a file. Unfortunately get_user_pass_cr() has become
> so fragile after repeated hacks, its so easy to break it...

Good catch!  I've noticed that in some very few configurations git
master already behaves somewhat odd with systemd enabled.  I think
what you've spotted here is one of the issues I've seen but not had
time to investigate yet.  This week I'm fairly tied up in some other
projects, but I'll dig into this and test these things.  You've
pointed me into a very sane code path, though.

> The following may sound harsh, but that's not the intention. I've=20
> spent hours on these patches now, so just trying to get the best
> out of it: In the end, I'm not sure what is achieved by this new
> framework. I see multiple queries can be combined into one exec
> call, but the way its used in get_user_pass_cr() does not make full
> use of it. Sure, username and password are prompted in one call,
> but static challenge is still handled by an additional call. FWIW,
> to be true to the spirit of the implementation, a request for=20
> username/password/static-challenge-response should result in only
> one call to query_user_exec, not two. Only then one can even
> remotely hope to have a way prompting the user for all that info in
> one dialog by some future ask-password agent.  Unless you set a
> clear style and guidance here, over time  this will degenerate into
> something logically identical to the original code except for
> different function names and twice the function calls.

Fair point!  The thing is that *currently* systemd-ask-password isn't
clever at all.  I've been discussing this with a few upstream systemd
developers already, and basically they are going to re-write much of
the systemd-ask-password stuff to be far more intelligent.  But much
of that work has halted as a new approach is planned to use DBus.
That again creates other challenges at boot time as DBus might not be
running when systemd-ask-password is called.  This will be resolved
once the kdbus work gets into an upstream kernel, then things can
start to move forward too.

> Even with one exec call, finally systemd-ask-password has to be
> called multiple times and it seems currently there are no agents
> that could take multiple queries and prompt the user in one dialog,
> for example.

And these patches are just the first step.  First we need a more sane
API to work with, then we can start juggling things more around.  My
plan is to move as much of these user query calls as early as possible
during the init phase.  Then depending on the backend (standard
console, systemd, dbus, whatever fancy someone else writes), the user
is queried for this information as efficiently as possible.

I've also started to ponder how we can make use of this via the
management interface too, for the current GUIs we have around.  Which
means that an end user can be asked for private key password or
PKCS#11 PIN, username and password in one go - as OpenVPN can now tell
the UI what it needs to establish a connection.  This could also give
some benefits to the OpenVPN plug-in in NetworkManager too.

There are absolutely some challenges which needs to be resolved with
the challenge/response protocols.  But this needs to be looked into
far more closely when a reasonable framework is in place.  I prefer to
start at the low hanging fruits to gain experience and then start
solving the harder ones, especially when they're related.  For the
challenge/response protocol there are actually two protocol, which
works quite differently.  Anyway, this is on the TODO list as well.

I am also considering if we should have some plug-in API hooks for
this as well, so that a third-party can add a separate query mechanism
without needing to recompile OpenVPN.  But this comes much later once
we know where and how things move forward.  Currently the goal is to
have the query-user interface somewhat similar to the SSL library,
where you flip it at compile time for the default.

> Its more like a solution looking for a problem. Which is not a bad=20
> thing per se..

As this patch-set has been discussed for a year now or so, I can
understand this point of view if you've not followed the discussions
over time.

My main goal is to improve the end user interaction with OpenVPN, as I
find the current model less user friendly and very limited when
integrating OpenVPN with today's more modern user interfaces.  So
these patches, are just laying a foundation for what can come next.
Without a new approach to query users, it is fairly limited what you
can do with the situation as it is today.

If someone sees a better approach for resolving this, then I'm willing
to look into that ... but considering this process have been going on
for over a year without too much fuzz around this approach, the
barrier to redesign everything from scratch again is quite high.


- --
kind regards,

David Sommerseth
OpenVPN Technologies, Inc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlexnkUACgkQDC186MBRfroidQCeMMKyVVJYxdTlgQz9VvhgjQ4T
0JcAoJEqUtx9N6jbgkNzvCwY91Uhk6b5
=3D3wuk
-----END PGP SIGNATURE-----

