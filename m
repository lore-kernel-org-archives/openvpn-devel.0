Date: Fri, 8 Apr 2022 11:35:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YlAB9NJWMd9H/EUg@...1296...>
References: <20220330205536.139-1-timo@...2669...>
 <20220407184023.249-1-timo@...2669...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LUi3xDWe3R1LrIek"
Content-Disposition: inline
In-Reply-To: <20220407184023.249-1-timo@...2669...>
Subject: Re: [Openvpn-devel] [PATCH v3] platform: Retain CAP_NET_ADMIN when
 dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

--LUi3xDWe3R1LrIek
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 07, 2022 at 08:40:24PM +0200, Timo Rothenpieler wrote:
> +    else if (res < 0)
> +    {
> +        if (res =3D=3D -3)
> +        {
> +            msg(M_NONFATAL, "Following error likely due to missing capab=
ility CAP_SETPCAP.");
> +        }
> +        msg(err_flags | M_ERRNO, "capng_change_id('%s','%s') failed reta=
ining capabilities: %d",
> +            user_state->username, group_state->groupname, res);
> +        goto fallback;
> +    }

Wouldn't that overwrite errno for the "res =3D=3D -3" case, given that
msg() will do stdio stuff?  Maybe reorder and print the "error likely due..=
."
message with a preceding "NOTE:" after the capng_change_id() message?

(That would be more typical for our logs - the "NOTE: this could be
because..." tends to come after the error message)

> +    if (new_uid >=3D 0)
> +    {
> +         msg(M_INFO, "UID set to %s", user_state->username);
> +    }
> +    if (new_gid >=3D 0)
> +    {
> +         msg(M_INFO, "GID set to %s", group_state->groupname);
> +    }
> +
> +    msg(M_INFO, "Capabilities retained: CAP_NET_ADMIN");
> +
> +    return;
> +fallback:

My inner whitespace dragon does would prefer to have the blank line
between "return" and "fallback:" (and no blank linke after the M_INFO).

> +    /* capng_change_id() can leave this flag clobbered on failure
> +     * This is working around a bug in libcap-ng, which can leave the fl=
ag set
> +     * on failure: https://github.com/stevegrubb/libcap-ng/issues/33 */
> +    if (prctl(PR_GET_KEEPCAPS) && prctl(PR_SET_KEEPCAPS, 0) < 0)
> +    {
> +        msg(M_ERR, "Clearing KEEPCAPS flag failed");
> +    }
> +#endif  /* HAVE_LIBCAPNG */

This one does not really look like it should be in "fallback:" - because
that way it always gets called, even if we jump there right at function
entry, if keep_caps =3D=3D 0.

> +
> +    if (keep_caps)
> +    {
> +        msg(err_flags, "Unable to retain capabilities");
> +    }
> +
> +    platform_group_set(group_state);
> +    platform_user_set(user_state);
> +}
> +

Maybe "fallback:" should be right before platform_group_set()?


(Sorry for being late to the "complain about your code" party...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LUi3xDWe3R1LrIek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiUAH0AAoJEB2Cnv7KVigSlwIL/2n1TjhcE/XYEVvohX+54UoP
SMl1c9Jy3cA+eC2/a9z5Hb3e+lj0ZQXnKvGIKReukn/dpjFI7pHo97nwT2WJNhCp
Fs384jy3pXQadllIHvYgCO9W4VgtTl3wZ0nr+PmoxrmPyP7EDEPpG8jtPmqMD2Am
2AATVKk0ojHw1s/0C6Krl5rFB9omPw6vWji4KisYc6FqHCJNOnec8nvmjEuhUMED
QDUH0hSuSmhEScDsPRXSxfU2nWdSpi6yrx522oBy5rUTN4o5ABBwu2T9hCQZs5q8
ni24S7IfIrrWq09kpNWuzBeWjNS2SNiEPGcyr3+ahuKhuozyQsH02edSN9QEwxS8
rcjgZQtkD/1f97hkO/kXEbr1TmBULnTptGoWB/XYYASscf4ebpBaqLSoI2VFn+oy
u6KnCCzGLwSPGq602owv94cfOxDFCJc8PlE9faZJDX5YmhaK5CauUFepzxOsdJv9
t3IIzYxSKzqPcnCdAyfGBMqdr2XMh3DR/IubTHcFfA==
=N+R3
-----END PGP SIGNATURE-----

--LUi3xDWe3R1LrIek--

