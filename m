Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAKuzo_jzvzxh-exre_W1oG7pUU7+RBOe-zX2P0RDq4nv-pSbQw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b56a8658-5d18-6e51-b22f-c3c2f7022d2a@...2080...>
Date: Fri, 22 Sep 2017 00:00:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jzvzxh-exre_W1oG7pUU7+RBOe-zX2P0RDq4nv-pSbQw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NkBdUGDGd07OTRFgOw9u2lPsJKgONBpBT"
Subject: Re: [Openvpn-devel] Better error recognition and error/status
 reporting to the mgmt i/f
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NkBdUGDGd07OTRFgOw9u2lPsJKgONBpBT
Content-Type: multipart/mixed; boundary="DL88nNVhTUHj7eTr69n59Ln1W2txEPAIA";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva <selva.nair@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <b56a8658-5d18-6e51-b22f-c3c2f7022d2a@...2080...>
Subject: Re: [Openvpn-devel] Better error recognition and error/status
 reporting to the mgmt i/f
References: <CAKuzo_jzvzxh-exre_W1oG7pUU7+RBOe-zX2P0RDq4nv-pSbQw@...278...>
In-Reply-To: <CAKuzo_jzvzxh-exre_W1oG7pUU7+RBOe-zX2P0RDq4nv-pSbQw@...278...>

--DL88nNVhTUHj7eTr69n59Ln1W2txEPAIA
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 14/09/17 21:21, Selva wrote:
> Hi,

Hi Selva,

Sorry for the long wait.  Things have been quite busy since that meeting.

>=20
> Quoting from the meeting logs:
> =C2=A0
>=20
>     Discussed having more fine-grained signalling from OpenVPN to OpenVPN
>     GUI. The lack of clear signals from OpenVPN to OpenVPN GUI has been a
>     rather common problem:
>=20
> =C2=A0
>=20
>     <https://github.com/OpenVPN/openvpn-gui/issues/168#issuecomment-30524=
3166>
>     <https://github.com/OpenVPN/openvpn-gui/issues/9>
>     <https://github.com/OpenVPN/openvpn-gui/issues/183>
>=20
> =C2=A0
>=20
>     This problem is probably not limited to OpenVPN GUI (Windows), but al=
so
>     affects other GUI's like NetworkManager. It was agreed that the best
>     approach is that Selva, mattock and others involved on the Windows si=
de
>     come up with a PoC or "RFC" of how this issue could be tackled ...
>     OpenVPN core will then be modified if necessary.
>=20
>=20
> No time to write an "RFC" or such for something of this sort, but here
> are some comments/suggestions:
>=20
> 0. Do not send a status message that reads "CONNECTED, SUCCESS" to the
> management when there has been critical errors such as: failed to add
> routes or to set ipv6 address using the service or to talk to the
> service, etc.. Send something like "CONNECTED,ERROR".

I agree that "CONNECTED, SUCCESS" is wrong if routing or other network
configuration related details fails.  On the other side,
"CONNECTED,ERROR" have an interesting contradiction; almost sounds like
an oxymoron.

I'd probably prefer something like "CONNECTED,PARTIAL_SUCCESS",
"CONNECTED,SOME_FAILURES" or something similar.  But can easily tend
towards a discussion of the colour of the bike shed.  As long as we have
a clear understanding and documentation of these strings, we're good.

> A status signalling with more fine-grained info to the management would
> be helpful, but as a short-term fix, just changing SUCCESS to ERROR in
> some cases may be a good start.
> =C2=A0
> 1. Mark all messages to the management as I (for info), W (for warning),
> N (for non fatal error) etc. -- on some log lines this info is currently
> missing. I think, part of the problem is not all messages are printed
> with an M_xx flag.

This sounds like a good idea.  But we need to sync-up with the Access
Server team, to ensure we won't break anything there.

> 2. Mark non-fatal=C2=A0opevpn_execve=C2=A0errors as M_NONFATAL instead of=
 M_WARN =C2=A0

This needs a careful analysis to fully understand the consequences.
There are quite some areas of the code where openvpn_execve_check() is
used, which is the instance calling openvpn_execve().

We have 70 direct callers of openvpn_execve_check(), but also
openvpn_run_script() is used for the script hooks.  There might be a few
more too.  And this covers also all supported platforms, which needs to
be thoroughly tested.

In addition, openvpn_execve_check() takes a flag argument, which
controls if errors should be M_WARN or M_FATAL.

> 3. Treat failure to talk to the service (when=C2=A0msg_channnel=C2=A0is d=
efined)
> as M_NONFATAL not M_WARN

Sounds reasonable.

> 4. Mark route add/del=C2=A0errors via service as M_NONFATAL -- currently =
M_WARN.
> =C2=A0Mark route addition failure by other means as M_NONFATAL -- current=
ly
> M_WARN on all platforms, and all methods, I think.

This is somewhat related to 2), as the route manipulation happens via
openvpn_execve_check().  I do think this needs to be handled in a
platform agnostic approach and not have one set of error behaviour on
Windows and another one of the other platforms.

That said, at this years hackathon we will discuss a more thorough
clean-up of the route.c and tun.c code.  So this issue here is something
to bring into that discussion as well.

> 5. Mark "ifconfig" (set address) errors as consistently M_FATAL or
> M_NONFATAL (see comment on "fatality" below).
> Currently these are M_WARN if done by service, M_FATAL otherwise.
>=20
> Given that M_FATAL should be used only very rarely, if at all --- e.g.,
> if proceeding further makes no sense --- =C2=A0most errors should be
> M_NONFATAL. The above comments reflect that sentiment.

M_FATAL is targeting scenarios where there is no point in continuing at
all; where OpenVPN will not be able to recover on its own.  So I do
understand that IP address configuration failing is initially tagged as
M_FATAL.  But this is not as easy and clear when there is another tool
OpenVPN needs to co-operate with which will manage parts of the tunnel.
One of them have to be the final decision maker when to bail out and
when to not do that.

> That said, whether address and route addition errors should be FATAL
> deserves some discussion -- In case of address addition, an error
> probably has to be FATAL, but "route add" failures are borderline cases.
> E.g., if =C2=A0"--redirect-gateway" fails, the tunnel may be =C2=A0consid=
ered
> meaningless in many use cases and thus a fatal error. So, some but not
> all route-add errors may have to be treated as FATAL.=C2=A0

This is the crux of it.  There is no way OpenVPN by itself knows
beforehand when a route change is fatal or not.  This touches more some
kind of policy handling, which needs to be configurable.  Right now it
is more the kind of "best efforts" approach on the routing setup and
"required" for the IP address configuration.

> If there is consensus, and an appetite for patch review, I can send in
> some patches for 2 to 5 and possibly 1. For 0, I'm not sure how to keep
> track of past errors to construct a useful status message.

I think we all agree we need to improve this.  But how and at which
scale is currently an open topic.  Right now, I think it is good to take
some time to discuss and debate this issue.  Perhaps we should allocate
one community developers meeting after the hackathon for discussing
this.  I'm suggesting after the hackathon, to ensure we have some clear
path forward on how we want to clean up route.c/tun.c.  This is a
massive effort and I doubt it will be done too quickly, so once the have
some path forward we should look into the error handling as well
instantly afterwards.

Anyway ... Thank you, Selva, for going into the depths here.  We sure
have quite something to consider and discuss.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--DL88nNVhTUHj7eTr69n59Ln1W2txEPAIA--

--NkBdUGDGd07OTRFgOw9u2lPsJKgONBpBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZxDZ6AAoJEIbPlEyWcf3yZ5IQAJSLGEyAApndApGK21CGcWOD
28Le34odwzmY+klslp1qZiEi0X7DxwcsHto6vZAlI7N99jX36bWx3VnoQYpRzCK+
zLVYw0rDgyb/KRDdYRpPvHzJHLpkRy3ePREqCY6dcsO+xJIR2wcfu+pKDWC1ddQ+
kVZ94o+KyGjhqGGPgMhAPASI8un1lslhRr/mkRIAazKMUI1yhd/Sja/x+Q01nZQr
k0JjGTf6ZSfEHDlvXGO1cLD+nARZq8nWYWYed6bY0QotRc/KHmZ1GHvjKwa+cXIe
ev29d7ieaAr31UB149mjza5/4slTGxcfL6h6CMGgooRJk4ibelgND53NqULmh4Wt
bLDUtsYSmhy2bSScy0pplZ73FNqlPEurDAhlUwc+IJxHmwjl8X6+/WtpFC5f9WVl
2UZNRuhya9CDy/pRmHoK44Qf2bAeTANZL3HDA5u9QXTVUiX53eIdGK0IHMUg/ICb
C3w/7pLQqraaczhXqeyU8PsQZLknzrAqo5JfctaS4aS8zqYU1co2SP4CaWu6p9mf
D75/N98Tfb/9iXuL/Yx+nxm1pKlLU73hQ0UqwmcJkTf2WyhsyI5z3V86Y3hyXhuU
1hRjU1tOal4fvT8iF/yBJYu6stC1Vvf6XGOZrujWblG+t372ovrpMLOIeVKYf+st
WncWOkNuvKF1n//vVNZq
=gPAq
-----END PGP SIGNATURE-----

--NkBdUGDGd07OTRFgOw9u2lPsJKgONBpBT--

