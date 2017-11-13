Reply-To: openvpn-devel@lists.sourceforge.net
References: <1477672963-5724-7-git-send-email-heiko.hund@...1489...>
 <20171112082736.15578-1-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ba9f0961-0f5a-1883-0a3f-7af917fd2943@...2080...>
Date: Mon, 13 Nov 2017 13:39:21 +0100
MIME-Version: 1.0
In-Reply-To: <20171112082736.15578-1-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="H0r5Q96JpVQgUpBupLr36Mo7iN6v71AEX"
Subject: Re: [Openvpn-devel] [PATCHv2 6/7] argv: do fewer memory
 re-allocations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H0r5Q96JpVQgUpBupLr36Mo7iN6v71AEX
Content-Type: multipart/mixed; boundary="bWdWE84J0cJXkM5xNsjpXUJc35npaMnAA";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ba9f0961-0f5a-1883-0a3f-7af917fd2943@...2080...>
Subject: Re: [Openvpn-devel] [PATCHv2 6/7] argv: do fewer memory
 re-allocations
References: <1477672963-5724-7-git-send-email-heiko.hund@...1489...>
 <20171112082736.15578-1-heiko.hund@...1489...>
In-Reply-To: <20171112082736.15578-1-heiko.hund@...1489...>

--bWdWE84J0cJXkM5xNsjpXUJc35npaMnAA
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 12/11/17 09:27, Heiko Hund wrote:
> Prevent the re-allocations of memory when the internal argv grows
> beyond 2 and 4 arguments by initially allocating argv to hold up to
> 7 (+ trailing NULL) pointers.
>=20
> While at it rename argv_reset to argv_free to actually express
> what's going on. Redo the argv_reset functionality so that it can
> be used to actually reset the argv without re-allocation.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c                   | 53 ++++++++++++++++++------------=
------
>  src/openvpn/argv.h                   |  2 +-
>  src/openvpn/console_systemd.c        |  2 +-
>  src/openvpn/init.c                   | 15 ++--------
>  src/openvpn/lladdr.c                 |  2 +-
>  src/openvpn/multi.c                  | 10 +++----
>  src/openvpn/options.c                |  2 +-
>  src/openvpn/plugin.c                 |  2 +-
>  src/openvpn/route.c                  |  8 +++---
>  src/openvpn/socket.c                 |  4 +--
>  src/openvpn/ssl_verify.c             |  6 ++--
>  src/openvpn/tun.c                    | 32 ++++++++++++----------
>  tests/unit_tests/openvpn/test_argv.c | 41 +++++++++++++++++++---------
>  13 files changed, 94 insertions(+), 85 deletions(-)
>=20
> diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
> index afe8efff..419b1dc6 100644
> --- a/src/openvpn/argv.c
> +++ b/src/openvpn/argv.c
> @@ -40,11 +40,30 @@
>  #include "options.h"
>=20=20
>  static void
> +argv_extend(struct argv *a, const size_t newcap)
> +{
> +    if (newcap > a->capacity)
> +    {
> +        char **newargv;
> +        size_t i;
> +        ALLOC_ARRAY_CLEAR(newargv, char *, newcap);

Did we agree on using the intern gc_arena for this array?
Or not?  I remember we talked about ALLOC_ARRAY_CLEAR_GC()
instead.

[...snip...]

>  static void
> @@ -133,14 +145,7 @@ argv_insert_head(const struct argv *a, const char *h=
ead)
>  const char *
>  argv_str(const struct argv *a, struct gc_arena *gc, const unsigned int f=
lags)
>  {
> -    if (a->argv)
> -    {
> -        return print_argv((const char **)a->argv, gc, flags);
> -    }
> -    else
> -    {
> -        return "";
> -    }
> +    return print_argv((const char **)a->argv, gc, flags);
>  }

Hmmm .... do we _really_  need argv_str()?

 $ git grep argv_str
src/openvpn/argv.c:argv_str(const struct argv *a, struct gc_arena *gc, cons=
t unsigned int flags)
src/openvpn/argv.c:    msg(msglev, "%s", argv_str(a, &gc, 0));
src/openvpn/argv.c:    msg(msglev, "%s: %s", prefix, argv_str(a, &gc, 0));
src/openvpn/argv.h:const char *argv_str(const struct argv *a, struct gc_are=
na *gc, const unsigned int flags);

(ignoring unit tests).

Or if we want it for convenience for those two callers in argv.c, remove it=
 from the
header and make it static inline.  But I'm still not really convinced we re=
ally need
it; as the usage is limited to within the argv.c code base.


Otherwise, this looks good.  Once we have figured out these two comments, t=
his is
fairly straight-forward to include.


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--bWdWE84J0cJXkM5xNsjpXUJc35npaMnAA--

--H0r5Q96JpVQgUpBupLr36Mo7iN6v71AEX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaCZJ5AAoJEIbPlEyWcf3yGG0P/iEmGKivv89vWFXYYjLzXvG3
lB8HJAyotpmup66v/+oEPWZeYivc9n6D/doM1DccU6CE8+AvvbpyOE+1FAaPP70d
x4seztiamDiunXPimCGB+pE8q+4gmdPslL2RmLBKV7AL7lYefPzAZVvvbgmKvvoX
x1ov0LhWeOKkCKtpWyVxuFqpSwv8C8pts/ZS9zUhOuAI1te9hKAbRsanqndbPVnt
KPnn86ojBayC8mHyE0PDQHz466Dyvw6H9aJ/DrcCiismTzGN2z2z4w4SofNHGgQa
bSDPPtzEJN2L1ZhaHVP0/dVdYgjsJpAtTR2hhSc/27bEOeSRLTOXya1WtZy320cR
BKxRwJi9H7Ha0V1dTEpUsptJC6kxsE9lU14JBiYdvCn+NBA3AjGuCJec8QStngtl
T/ALaZ5Q9zMWlOMZshB6zEGOALwvRkyZ5GTi/uXijBlvil/8e7UoLRtSY2tBEQQn
QbTSZj/mKoVOmB2Mpt5tbD7oq0ocfQkeq9SV9nEVtKOQK67px+aPd/0ZM95px6Yc
zmpM2cwfZSN3hJmzIXycz5FgaNaVxgQ9TAZvuOqTG8sJgRBvu2k8cCCHSwj8kahs
Xbc2lK/v24nzqxAHnrZ+N1nCRisvG71/JL9IUqUUFMCuntpojjO0sHbsyJDlbvEf
BCE58D6i8rJ0Q53ifH1i
=EWnZ
-----END PGP SIGNATURE-----

--H0r5Q96JpVQgUpBupLr36Mo7iN6v71AEX--

