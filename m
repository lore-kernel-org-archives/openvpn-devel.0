Date: Thu, 21 Jan 2016 22:47:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160121214758.GQ24952@...1296...>
References: <1439311312-2682-1-git-send-email-openvpn.list@...1114...>
	<1439311312-2682-2-git-send-email-openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YmG28HrH/cYA+PoZ"
Content-Disposition: inline
In-Reply-To: <1439311312-2682-2-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/4] Rework the user input interface
 to make it more modular
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--YmG28HrH/cYA+PoZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

so, I finally found time to review this - apologies.=20=20

We need a rebase (because of the isatty() change, sorry for that) - and=20
a v3, though, as I found a few minor things...

On Tue, Aug 11, 2015 at 06:41:49PM +0200, David Sommerseth wrote:
> index d66d408..212a0a8 100644
> --- a/src/openvpn/console.c
> +++ b/src/openvpn/console.c
> @@ -5,7 +5,8 @@
[..]
> -static bool
> -get_console_input_win32 (const char *prompt, const bool echo, char *inpu=
t, const int capacity)
> +void query_user_init(struct gc_arena *gc, struct query_user ** setup)
>  {
> -  HANDLE in =3D INVALID_HANDLE_VALUE;
> -  HANDLE err =3D INVALID_HANDLE_VALUE;
> -  DWORD len =3D 0;
> +    ASSERT (&gc !=3D NULL);

This needs to be "ASSERT (gc !=3D NULL)" or just "ASSERT (gc)"... &gc will
always be !=3D NULL.

(Theoretically it could just go, as gc_malloc() is safe to be used with
gc being NULL... so it would allocate global memory, but since this is
just called once, even *that* would not be actually harmful)

> +    *setup =3D (struct query_user *) gc_malloc (sizeof(**setup)+2, true,=
 gc);

Why "+2"?  This is a structure, it has a well defined size, no
"extra 0 bytes" to be expected.

> +    if( unlikely(*setup =3D=3D NULL) )
>      {

gc_malloc() guarantees that the resulting pointer is not NULL, as it
will always call check_malloc_return() and that will exit(1) on NULL
(out_of_memory() in error.c, which is safer than calling msg() in an
out of memory situation anyway)

[..]
> +bool query_user_add(struct query_user * setup,
> +                    char *prompt, size_t prompt_len,
> +                    char *resp, size_t resp_len,
> +                    bool query, bool echo)
>  {
[..]
> +    /* Save the information needed for the user interaction */
> +    p->_gc =3D setup->_gc;
> +    p->prompt =3D prompt;
> +    p->prompt_len =3D prompt_len;
> +    p->response =3D resp;
> +    p->response_len =3D resp_len;
> +    p->query =3D query;
> +    p->echo =3D echo;
> +    query_user_init(p->_gc, &p->next);
[..]
> +    return (p->next !=3D NULL) ? true : false;
>  }

I don't think this final check makes sense.  First of all, no caller
of query_user_add() ever *cares*, and second, it just cannot happen
given that query_user_init() exit()s anyway if malloc fails.

So just make this "void query_user_add(...)" :-)


> diff --git a/src/openvpn/console.h b/src/openvpn/console.h
> index 268f3fe..4d0a57f 100644
> --- a/src/openvpn/console.h
> +++ b/src/openvpn/console.h
> @@ -5,7 +5,8 @@
[..]
> + *  Configuration setup for declaring what kind of information to ask a =
user for
> + */
> +struct query_user {
> +    struct gc_arena *_gc;     /**< Local pointer to the gc_arena maintai=
ning this chained list */
> +    char *prompt;             /**< Prompt to present to the user */
> +    size_t prompt_len;        /**< Lenght of the prompt string */
> +    char *response;           /**< The user's response */
> +    size_t response_len;      /**< Lenght the of the user reposone */
> +    bool query;               /**< True: Expect user to provide a respon=
se, False: only print  */
> +    bool echo;                /**< True: The user should see what is bei=
ng typed, otherwise mask it */
> +    struct query_user *next;  /**<  Next information to query for, NULL =
indicates end of list */
> +};

Is there anything in OpenVPN that would print out a message to console
but not prompt for a response?  The "query" field adds a bit of carry-on
to structure and code, but all current uses of query_user_add() set it=20
to "true"...

[..]
> diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
> new file mode 100644
> index 0000000..b8d6430
> --- /dev/null
> +++ b/src/openvpn/console_builtin.c
> @@ -0,0 +1,246 @@
[..]
> +static bool get_console_input_win32 (const char *prompt, const bool echo=
, char *input, const int capacity)
> +{
[..]
> +                if (echo)
> +                    flags |=3D ENABLE_ECHO_INPUT;
> +                SetConsoleMode (in, flags);
> +	    } else
> +                is_console =3D 0;

When moving code, please do not change coding style in-progress - this
used to have an "else" on its own line, which makes comparing "has this
just be moved or what was changed" more complicated...

> +            free (winput);
> +        } else
> +            status =3D ReadFile (in, input, capacity, &len, NULL);

Same here.

[..]
> + * If no alternative implementation is declared, a wrapper in console.h =
will ensure
> + * query_user_exec() will call this function instead.
> + *
> + */
> +bool query_user_exec_builtin(struct query_user * setup)
> +{
> +    struct query_user *p;
> +    bool ret =3D true;
> +
> +    ASSERT( setup !=3D NULL );
> +
> +    /* Loop through the complete query setup and when needed, collect th=
e information */
> +    for (p =3D setup; p->next !=3D NULL; p =3D p->next)
> +    {

I wonder why you coose to implement the linked list this way, instead of
the more common "for (p=3Dfirst; p !=3D NULL; p =3D p->next)" approach?

Yours will work fine, but will always have fully-empty structure dangling
at the end of the list, serving only to have an "p->next" of NULL...  or
am I misreading this?

(Of course the query_user_add() function would need to be changed=20
accordingly - right now it's symmetric and should work fine, it just
makes me curious what the underlying trade-off is)

> +        if( p->query )
> +        {
> +            /* If the user is expected to provide some data */
> +            ret &=3D get_console_input(p->prompt, p->echo, p->response, =
p->response_len);
> +        } else {
> +            /* If the prompt should only be presented to the user with n=
o further action */
> +            msg(M_INFO|M_NOPREFIX, "%s", p->prompt);
> +        }
> +    }

See above, I'm wondering about the use case of having a mechanism for
"print stuff only" which we then never *use* (... there's way too much
"we might eventually do that!" code in OpenVPN today).

> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 5627cb9..cc1dc7b 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -5,7 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2015 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> @@ -1049,11 +1050,15 @@ get_user_pass_cr (struct user_pass *up,
>         */
>        if (flags & GET_USER_PASS_NEED_OK)
>  	{
> +	  struct query_user *qucfg =3D NULL;
>  	  struct buffer user_prompt =3D alloc_buf_gc (128, &gc);
>=20=20
> +	  query_user_init (&gc, &qucfg);

After the change from "return false to M_FATAL", we could keep this more
in line with the rest of the code - which avoids double pointers for=20
return values - and make it

> +	  struct query_user *qucfg =3D query_user_init (&gc);

(adjusting query_user_add() appropriately, of course).

But the way it is works, of course.

>  	  buf_printf (&user_prompt, "NEED-OK|%s|%s:", prefix, up->username);
> +	  query_user_add (qucfg, BSTR(&user_prompt), BLEN(&user_prompt), up->pa=
ssword, USER_PASS_LEN,
> +                          true, true);
>=20=20=09=20=20
> -	  if (!get_console_input (BSTR (&user_prompt), true, up->password, USER=
_PASS_LEN))
> +	  if (!query_user_exec (qucfg))
>  	    msg (M_FATAL, "ERROR: could not read %s ok-confirmation from stdin"=
, prefix);

... also, all but one of these invocations use the same sequence

query_user_init()
query_user_add()   (only a single time)
query_user_exec()

but use quite a bit of "screen real estate" of the three independent steps
- while I value the flexibility (and it's used when querying for usename
*and* password), for single-shot calls, wouldn't a wrapper that just does
all in one go make the code more readable?

So you'd call something like

> +	  query_user_single_exec (BSTR(&user_prompt), BLEN(&user_prompt), up->p=
assword, USER_PASS_LEN,
> +                          true, true);

which would expand to init()/add()/exec() calls inside...

(I'm sure I suggested this already for v1)


> --- a/src/openvpn/pkcs11.c
> +++ b/src/openvpn/pkcs11.c
> @@ -5,7 +5,8 @@
>   *             packet encryption, packet authentication, and
>   *             packet compression.
>   *
> - *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2002-2015 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>

I'm not sure if this is really "our style" - I can see adding a copyright
notice if a module is basically rewritten (console.c, console.h), but for=20
a 3-line change I find this surprising, as it is not done elsewhere - most
of our modules only have the generic OpenVPN Technologies, just a very
small set carry other copyright notices (and these usually stem from=20
"we wrote this from scratch" or "this was taken from elsewhere").

Just thinking out loud, though.  Not considering this a showstopper.

>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> @@ -740,6 +741,7 @@ _pkcs11_openvpn_show_pkcs11_ids_pin_prompt (
>  	const size_t pin_max
>  ) {
>  	struct gc_arena gc =3D gc_new ();
> +	struct query_user *qucfg =3D NULL;
>  	struct buffer pass_prompt =3D alloc_buf_gc (128, &gc);
>=20=20
>  	(void)global_data;
> @@ -748,10 +750,14 @@ _pkcs11_openvpn_show_pkcs11_ids_pin_prompt (
>=20=20
>  	ASSERT (token!=3DNULL);
>=20=20
> +	query_user_init (&gc, &qucfg);
>  	buf_printf (&pass_prompt, "Please enter '%s' token PIN or 'cancel': ", =
token->display);
> +	query_user_add(qucfg, BSTR(&pass_prompt), BLEN(&pass_prompt),
> +		       pin, pin_max, true, false);
>=20=20
> -	if (!get_console_input (BSTR (&pass_prompt), false, pin, pin_max)) {
> -		msg (M_FATAL, "Cannot read password from stdin");
> +	if (!query_user_exec (qucfg))
> +	{
> +	    msg (M_FATAL, "Could not retrieve the PIN");
>  	}

...this would be another good candidate for "query_user_single_exec()"... :=
-)


So - in principle feature-ACK, but I think the code can be improved
(and it needs a rebase due to the changes in console.c and misc.c anyway
- please do not forget to move the isatty() bits to console_builtin.c,
git might not be smart enough to get *that* right.  But maybe it is...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--YmG28HrH/cYA+PoZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVqFSDakuBuNlUUl1AQL2YwP+LH0iCJ9rQjjiGgkRvOpjYJk2SFgRhLFd
XZuekTuNOLKpqX7Qm/WTkp8DxBh4ZXipVnzjEQ+EULULiGa05sgCg0XeTGdKxWnC
ByFEClIepO5164ONXlLH8+FGRhqQ8lq4qayXhhs9F8nxCUA32FqgOi9B747DeWIG
4sIY58/VWFA=
=YRPq
-----END PGP SIGNATURE-----

--YmG28HrH/cYA+PoZ--

