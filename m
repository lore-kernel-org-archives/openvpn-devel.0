Date: Mon, 31 Aug 2015 07:59:11 +0200
From: "Lukasz K." <movrax-dev@...2061...>
Message-ID: <20150831075911.40c7b9bc.movrax-dev@...2061...>
In-Reply-To: <20150830203749.GW34798@...1296...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
	<20150830162534.4ee0c9f2.movrax-dev@...2061...>
	<20150830203749.GW34798@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	boundary="Sig_/NrL+=xWjC2WFwxn4nvePkth";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Privileges not being dropped if the
 first connection is not successful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/NrL+=xWjC2WFwxn4nvePkth
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, 30 Aug 2015 22:37:49 +0200
Gert Doering <gert@...1296...> wrote:

> Hi,
>=20
> On Sun, Aug 30, 2015 at 04:25:34PM +0200, Lukasz K. wrote:
> > -  if (c->first_time && c0 && !c0->uid_gid_set)
> > +  if (c0 && !c0->uid_gid_set)
> >      {
> >        /* chroot if requested */
> >        if (c->options.chroot_dir)
> >  	{
> >  	  if (no_delay)
> >  	    platform_chroot (c->options.chroot_dir);
> > -	  else
> > +	  else if (c->first_time)
> >  	    msg (M_INFO, "NOTE: chroot %s", why_not);
> >  	}
>=20
> Looking a bit more closely at this one.  What happens if you do not
> set uid/gid, but *do* set --chroot?  Will it then execute the chroot
> call every single time (since effectively the first_time check is
> removed, and c0->uid_git_set will never be set)?
>=20
> Or am I misreading this?
>=20
> gert
>=20

As I've mentioned in my first message:
"[...] even when UID/GID are not specified ("context_0.uid_gid_set" is
set to "true" one way or another) [...]"

To see this it's necessary to take a better look at
"do_uid_gid_chroot()" code.
This is original, unmodified part of code from git (I have stripped out
original comments and added my own in places worth to look at with
explanations):
---
[...]
  /* "c0->uid_gid_set" is controlling whether to enter this block
   * regardless of "c->first_time" presence
   */
  if (c->first_time && c0 && !c0->uid_gid_set)
    {
      if (c->options.chroot_dir)
	{
	  if (no_delay)
	    platform_chroot (c->options.chroot_dir);
	  else
	    msg (M_INFO, "NOTE: chroot %s", why_not);
	}

      /* There's no explicit check for UID/GID presence, so it will
       * always enter this block when everything has been set and
       * "no_delay" is passed as "true", even when there's no
       * UID/GID change (only chroot etc.).
       */
      if (no_delay)
	{
	  /* "platform_*_set()" is internally checking on it's own
	   * whether UID/GID has been specified.
	   */
	  platform_group_set (&c0->platform_state_group);
	  platform_user_set (&c0->platform_state_user);
	  /* "c0->uid_gid_set" is flipped to "true", which means that
	   * from now on "c0 && !c0->uid_gid_set" expression from the
	   * beginning will return "false", which in turn will omit the
	   * entire block next time like "c->first_time =3D=3D false" would
	   */
	  c0->uid_gid_set =3D true;
	}
      else if (c0->uid_gid_specified)
	{
	  msg (M_INFO, "NOTE: UID/GID downgrade %s", why_not);
	}
[...]
--

External calls are made only when "no_delay" is passed as "true", and
when this happens "c0->uid_gid_set" is always set to "true".
The only exception is memstat (where it's not bound to "no_delay"
checks) and call to "msg()" with "NOTE:":
---
[...]
#ifdef ENABLE_MEMSTATS
      if (c->options.memstats_fn)
	mstats_open(c->options.memstats_fn);
#endif
[...]
--
That's why it gets a "first_time" check as this is something that could
be called more than once.

User will also keep receiving appropriate "NOTE:" messages (depending on
which privileges are going to be dropped) on each reconnect until
"no_delay" is passed as "true" (everything is initialized and ready to
actually do privilege dropping if requested, and where
"c0->uid_gid_set" is set to "true"):
---
[...]
	  if (no_delay)
	    platform_chroot (c->options.chroot_dir);
	  else
	    msg (M_INFO, "NOTE: chroot %s", why_not);
[...]
      if (no_delay)
	{
	  platform_group_set (&c0->platform_state_group);
	  platform_user_set (&c0->platform_state_user);
	  c0->uid_gid_set =3D true;
	}
      else if (c0->uid_gid_specified)
	{
	  msg (M_INFO, "NOTE: UID/GID downgrade %s", why_not);
	}
[...]
	  if (no_delay) {
	    if (-1 =3D=3D setcon (c->options.selinux_context))
	      msg (M_ERR, "setcon to '%s' failed; is /proc
accessible?", c->options.selinux_context);
	    else
	      msg (M_INFO, "setcon to '%s' succeeded",
c->options.selinux_context);
	  }
	  else
	    msg (M_INFO, "NOTE: setcon %s", why_not);
[...]
--
And this is something that second patch also targets (with the use of
"first_time").

This logic hasn't changed since 2.1.3 (this is the oldest release I've
tested).
In 2.1.3/2.2.1 there's no memstat section though, it looks like it has
been added in 2.3.x. There are some minor naming changes between those
versions too.

It's worth to note that the use of "context_0.uid_gid_set" seems to be
limited to said function only.

Lukasz K.

--Sig_/NrL+=xWjC2WFwxn4nvePkth
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJV4+02AAoJENIr6TaVB1CU4tcP/3OrX1JUomiTWAboWhG1mW0Y
a4mvjyNYDXirP3cTsjeSGpc0ZNOhp0GNXlAhWO8RjtOIMipiz74v0/7gAw6/Ymue
oEkh2XnLJmTvfaJNiTQEIDsDuCwX+/fu7tOBFZ3SFpgQKGLWI7eZBOMcR2dOlvh8
xTH7bMNdiXwHaB49VCVLEG/Xf4xzA4p+5faxj4Vu9hemUXOEteYMe0F3JtRKKhak
TBbVHubvd11ehuKlbD3ghXhPdKDOe8VwTaFC8jHYBh4uIwIzMLOWDhtFks6U0fKt
BfHKaEE0LH5+x4/S//JVzX4NYNI1SzspgdJ0DEqgesisSO1ujQD7JeY5UVaK4VlU
M/MlV99VS9PpR6Qsy3F29Y1nlXo9mVHFDMQbFkK5GPy+uL8IkPwlf1dbo7sLpUOX
M9yb2eizssZyei7YJZRmLVJSAtTyYb2cXgsRJk9rtSC4NHFfu6D7jCkWZXyVKIZM
Z0RiU8/TOGNsLpBSNOYrPAoH7cmcmYZ7vTVSJBvPo2sGG6dg/EdLkxWxEzUP3Oy9
Q1YrETLrzpHIzwTpijCqlmibyZo+hmERAba3wLLRRt0/kemyAS1sB6k2L8UMMFVF
1zI+GVv2OMxCEKOLH24qTWvCPOChlOe7qbyLjh56FUXi6KUiiI8+wSDvPwuCbk7a
J3oiwu16w3frUZB/Xo32
=aXi2
-----END PGP SIGNATURE-----

--Sig_/NrL+=xWjC2WFwxn4nvePkth--

