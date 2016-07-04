References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<1467502488-31549-1-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <11772d2a-4877-0ed0-2484-7ef66e059737@...1227...>
Date: Mon, 4 Jul 2016 11:23:11 +0200
MIME-Version: 1.0
In-Reply-To: <1467502488-31549-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Exponentially back off on repeated
 connect retries
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
To: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net



Am 03.07.16 um 01:34 schrieb Selva Nair:
> - When the number of retries per remote exceeds a limit
>   (hard coded to 5), double the restart pause interval
>   for each additional retry per remote.
> - Trigger a SIGHUP to reset the retry count when the pause
>   interval exceeds 1024 times the base value of restart pause.
>   (removed in v2 of the patch)
>
> The base value of restart pause is set using --connect-retry
> (5 seconds by default).
>
> v2 changes (based on suggestions from Arne Schwabe <arne@...1227...>)
>
> - Do not throw SIGHUP.
> - Add an optional argument to "--connect-retry n [m]" where 'm'
>   specifies the max value of restart pause interval (default
>   300 sec).
>   E.g., "--connect-retry 5 1800" will cause the restart pause to
>   scale up starting at 5 until it exceeds 1800 seconds at which
>   point it gets capped at 1800.
> - If n =3D=3D m no slow down will occur.
> - While at it, fix typos and clarify the description of connect-retry-max
>   in the man page and Changes.rst
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  Changes.rst           |    8 ++++++--
>  doc/openvpn.8         |   19 ++++++++++++-------
>  src/openvpn/init.c    |    8 ++++++++
>  src/openvpn/options.c |   13 ++++++++++---
>  src/openvpn/options.h |    1 +
>  5 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index d12cdad..59722e2 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -75,8 +75,8 @@ User-visible Changes
>    In --static mode connect-timeout specifies the timeout for TCP and
>    proxy connection establishment
>=20=20
> -- connect-retry now specifies the maximum number of unsucessfully
> -  trying all remote/connection entries before exiting.
> +- connect-retry-max now specifies the maximum number of unsuccessful
> +  attempts of each remote/connection entry before exiting.
>=20=20
Ooops, my bad.
>  - sndbuf and recvbuf default now to OS default instead of 64k
>=20=20
> @@ -120,6 +120,10 @@ User-visible Changes
>  - --http-proxy-retry and --sock-proxy-retry have been removed. Proxy con=
nections
>      will now behave like regular connection entries and generate a USR1 =
on failure.
>=20=20
> +- --connect-retry gets a optional third argument that specifies the maxi=
mum
> +  time in seconds to wait between reconnection attempts when an exponent=
ial
> +  backoff is triggered due to repeated retries. Default =3D 300 seconds.
Shouldn't that be 2nd argument?
> +
>  Maintainer-visible changes
>  --------------------------
>  - OpenVPN no longer supports building with crypto support, but without T=
LS
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 64cc934..3ca6f50 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -462,22 +462,27 @@ application-level UDP protocols, or tunneling proto=
cols which don't
>  possess a built-in reliability layer.
>  .\"*********************************************************
>  .TP
> -.B \-\-connect\-retry n
> +.B \-\-connect\-retry n [max]
>  Wait
>  .B n
> -seconds  between connection attempts (default=3D5).
> +seconds  between connection attempts (default=3D5). Repeated reconnection
> +attempts are slowed down after 5 retries per remote by doubling the wait
> +time after each unsuccessful attempt. The optional argument
> +.B max
> +specifies the maximum value of wait time in seconds at which it gets
> +capped (default=3D300).
>  .\"*********************************************************
>  .TP
>  .B \-\-connect\-retry\-max n
>  .B n
> -specifies the number of times all
> +specifies the number of times each
>  .B \-\-remote
> -respectively
> +or
>  .B <connection>
> -statements are tried. Specifiying
> +entry is tried. Specifying
>  .B n
> -as one would try each entry exactly once. A sucessful connection
> -resets the counter. (default=3Dumlimited).
> +as one would try each entry exactly once. A successful connection
> +resets the counter. (default=3Dunlimited).
>  .\"*********************************************************
>  .TP
>  .B \-\-show\-proxy\-settings
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 498d36f..247a526 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1955,6 +1955,7 @@ static void
>  socket_restart_pause (struct context *c)
>  {
>    int sec =3D 2;
> +  int backoff =3D 0;
>=20=20
>    switch (c->options.ce.proto)
>      {
> @@ -1977,6 +1978,13 @@ socket_restart_pause (struct context *c)
>      sec =3D 10;
>  #endif
>=20=20
> +  /* Slow down reconnection after 5 retries per remote */

I still do not like this arbitary 5 times and then the exponential
backoff starts. I would prefer a start with a small time and do a
consistent backoff. But since tcp does the thing with syn packets (at
least on my mac), I can agree to this behaviour too.

Btw. if we introduce this backoff mechansim I think it is safe to lower
the connect-retry small time from 5 to 1 since the potential for looping
very fast through the connection entries is not there anymore.
> +  backoff =3D (c->options.unsuccessful_attempts / c->options.connection_=
list->len) - 4;
> +  if (backoff > 0 && sec < 1<<16)
the 1<<16 seems a bit random here. Could you at least add a comment of
why? I don't see any valid reason here since sec is limited between 1 and
connect_retry_seconds_max by the next two lines anyway.
> +    sec =3D max_int (sec, 1) << min_int (backoff, 15);
The 15 here is the same. Both lines seem to only make sense with 16 bit
integers.
> +  if (sec > c->options.ce.connect_retry_seconds_max)
> +    sec =3D c->options.ce.connect_retry_seconds_max;
Oh, my suggestion made the max time time configurable per connection
entry. We should address that in a seperate patch. I think connect-retry
as a whole can be made a non connection config entry. (connect-retry
traditionally was the time between tcp connects for a tcp connection
which looped on its own before the dual stack patch if anyone wonders
why it was connection specific).

Other than that, the patch gets an ACK from me.

Arne

P.S.: If you do a third patch, you might rename sec to something more
aptly named.


