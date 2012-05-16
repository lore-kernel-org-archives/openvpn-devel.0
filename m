Message-ID: <4FB39E94.1070202@...1114...>
Date: Wed, 16 May 2012 14:33:24 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz0V=cE7R=nTefCbP4Z1=+WoYnxhPfNuWasEZjf1EUSOHA@...278...>
	<4FB3810A.4050209@...1114...>
	<CAOazyz11iQ6wuNJ_tp=2U5gH5=jeLkLHL6EG_8+yrDjXtEbFUA@...278...>
	<4FB38570.90902@...1114...>
	<CAOazyz29iYJ2rDPBZzk0Otac543AcYFf_gbHgRgaFo+qcVLpTQ@...278...>
	<4FB39166.9050906@...1114...>
	<CAOazyz2puY6DiXcDKiDy2QaUmHqEtSaTsdgZS6dj=D2RT73mzw@...278...>
In-Reply-To: <CAOazyz2puY6DiXcDKiDy2QaUmHqEtSaTsdgZS6dj=D2RT73mzw@...278...>
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

On 16/05/12 14:03, Alon Bar-Lev wrote:
[...snip...]
> But if I get this right, a new configuration option is needed, not 
> compile time directive, something like:
> 
> --setenv-data [-]<data>, ...
> 
> data :: cert-digest-sha1
> 
> This way, only users which require this functionality may enable
> it and perform hash of the chain. No stability issues in this
> mode.

I think when James is concerned about stability issues, it is more the
situation of the code changing than growing the environment list too
long.  However, a too big environment list may cause stability issues
as well (overflow situations, etc).  So you have a good argument as well.

(In my case with the eurephia support, I added the #ifdef to make it
more likely that it would be accepted by James.)

> In this scheme we can add more data types if required, and assign
> data types for existing functionality, allowing to disable using
> "-", example is cert-serial or cert-subject or certh-depth.
> 
> What do you think?

I like this idea.  However, the plug-in v3 API is probably solving
some of these things as well, as that provides access to the whole
X509 structure.  That doesn't solve it for scripts, though, but for
plug-ins that will provide all the information ever needed directly.

But if I see it from a security perspective, reducing the amount of
environment variables and only providing the information requested for
makes a lot of sense - and this would affect both plug-ins and scripts
too.  So from a 'need to know' basis, I like this approach.  But if we
add a revolution here, it's probably better suited for a v3.0 scope.
However, if we provide a way of backwards compatibility, we can scope
it for v2.x.

What I'm actually thinking, in regards to backwards compatibility, is
that there is a default environment variable list which consists of
the variables we provide today.  If --setenv-data is used, this list
is reset.  So if you use --setenv-data, you need to also include those
variables which was there before - if you really need them.  It will
naturally require more thinking when this is being configured by the
users.

Of course, it's possible to add a keyword 'default' to re-enable the
default list as well.  But that will only allow mindless
configurations, where people just add this keyword instead of really
evaluating the variables they need  (We already have a lot of mindless
configuration questions on IRC, haven't checked the forum carefully
enough; but we don't need more of these requests).  And if they end up
listing all, something else is most likely wrong in the config as well.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+znpMACgkQDC186MBRfrpZ2ACeLpcDSPtUodxgh3QKYG0rcPFs
h2kAn0AnO8LYCTTyiEZl/5h+7I7TaUMq
=D6NW
-----END PGP SIGNATURE-----

