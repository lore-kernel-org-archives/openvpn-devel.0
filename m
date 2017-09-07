Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170906235202.26551-1-davids@...515...>
 <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <41cf1b9e-bb4b-a2f1-3c3a-cde43c8e0eb4@...2080...>
Date: Thu, 7 Sep 2017 17:46:14 +0200
MIME-Version: 1.0
In-Reply-To: <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="r5hg2xrmciJc9DfTP6XiMi56rmwJ6Q6Vj"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: fragmentux <fragmentux@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r5hg2xrmciJc9DfTP6XiMi56rmwJ6Q6Vj
Content-Type: multipart/mixed; boundary="sR5EMLSxJqJAvUUPaoLOtbFtlKEs0GxiC";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: fragmentux <fragmentux@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <41cf1b9e-bb4b-a2f1-3c3a-cde43c8e0eb4@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
References: <20170906235202.26551-1-davids@...515...>
 <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
In-Reply-To: <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>

--sR5EMLSxJqJAvUUPaoLOtbFtlKEs0GxiC
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 17:08, fragmentux wrote:
> Hi,
>=20
> On 07/09/17 00:52, David Sommerseth wrote:
>> Systemd supervises services it has started and can act upon unexpected
>> scenarios.=C2=A0 This change will restart OpenVPN after 5 seconds if the
>> OpenVPN
>> process exits unexpectedly.
>=20
> Define "unexpectedly"
> (my2c: something needs to be fixed)

Yes, that _could_ be, but is not for sure.  It is hard to define
"unexpectedly".  Or to flip it around, if we could define "unexpectedly"
properly, there is nothing unexpected happening.

But _some_ scenarios

 - The out-of-memory killer picks an openvpn process
   Fix: Add more memory, reduce the number of memory hungry processes,
   usually nothing OpenVPN can do anything with

 - The server process segfaults dies (segfault)
   This happens most commonly due to poor/badly written plug-ins
   Fix: Get an updated/fixed plug-in, not something OpenVPN can
   fully control.

 - A fatal error happened
   Which can have many reasons (grep M_FATAL in the source), most
   of them it is safe to restart the OpenVPN process.  It could be
   caused by the crypto layer not getting enough random data, it
   could be a malicious attempt of an attack, triggering some of
   the ASSERT() checks in the code.  M_FATAL in general is more
   of the error type "It is not safe to continue running this process"
   but it doesn't mean it isn't safe to restart the process.  Again,
   situations outside OpenVPN influences its ability to run.

And there's a plethora of other scenarios too.

So to define "unexpectedly" is not far away from trying to define "life".


>> The on-failure mode is the recommended mode by upstream systemd.
>=20
> IE:
> This is the way "upstream systemd" recommend to use systemd
> *if*=C2=A0 "some failed process"=C2=A0 is to be restarted.
>=20
> (my2c: A decision better left to the sys-admin not openvpn developer)

Why is it bad to have this behaviour being the default?  The sys-admin
still have the ability to override this.

And even though I have the role of developer here in the OpenVPN
community, outside of my day-work role I do also have the role as a
sys-admin.  From my point of view, this isn't a "this sounds like a cool
feature".  It is actually something I have enabled on systems manually
for some time, so if my smaller scale environment finds this useful -
why wouldn't others find it useful?  And also having had sys-admin roles
in former work life, this is something we deployed on many services in
far larger environments.

>> This change have been tested on a test server for some month, and it
>> works indeed as intended when provoking the OpenVPN process to stop.
>=20
> Define "provoking"
> (my2c: not unexpectedly at all, nothing to fix here)

Like adding a plug-in which triggers a segfault on the first connection
attempt.  Or sending a SIGKILL to the process.  This was needed to test
and verify that the restart mechanism did work.  Otherwise I would not
have had confidence in believing this was done correctly.  And even
though that my triggering isn't unexpected, it is unexpected by the
OpenVPN process.

But sure, if you have a way to trigger OpenVPN to unexpectedly failing,
we'd be delighted to hear about it .... as that is most likely something
we should fix in OpenVPN ;-)

In case you haven't noticed, OpenVPN is quite stable and seldom fails by
itself.  But when it does, it is for most end-users depending on it a
nice feature that things do try to recover on its own.

These events do also not happen in complete silence.  They are logged.
And a responsible sys-admin will check logs at regular intervals, some
even have automated alerts happening.  But most sys-admins will be
pleased that they don't have to go into panic rescue mode instantly
because a VPN server went down and they have 50 users on the phone
complaining they can't reach the intranet.

> Either way,
> it is only a few lines of a systemd unit.service file
> to be deleted/customised by the relevant sys-admin.

systemctl edit openvpn-server@...2302...
then add Restart=3Dno

Which have the advantage of disabling this feature on selected
configurations, not all configs by default.  If you want the default, I
believe you just do: systemctl edit openvpn-server@


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--sR5EMLSxJqJAvUUPaoLOtbFtlKEs0GxiC--

--r5hg2xrmciJc9DfTP6XiMi56rmwJ6Q6Vj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsWnGAAoJEIbPlEyWcf3ydRoP/2RnbSmOrVUgsWUkVyvC9L6m
YWVRuadzJWvLZ9JWIFdZ2vPtc4Cz4chDg3NrqFTscg5vEsfB+6f8GflvU7MNR05p
kZjRofUc8KMq5P78l0dbKFIH/TB9ueEoAz14GzPj8VZZ4/K8ddeuZYVFFIkJJdcM
TxmJDbA0nVvaeo2v+hCbdT6GerjrEasoUSJ+OiaNi9Adnx3xnPXpg2WyzU+0Wv11
gqXvnyqC6/Os7F52b1Nd+Mp37DcJiOT0WAG5uoIhliecRrLCbAnXQsru3MiEXmeC
+vxMryzmZghZH5LpjxLCDe2UhQ7EBR2Ux4IvB0bQaqgULLoqPhJnZhPMiHs5kTk9
wM7PZeloHeAphZd0La9I10jhw2GcpowD2rqXtE3CgZrPwwj3uh2bX0e6ZF+n+w7Y
iZcAkLVxTvreCpLMpNYCbGUCR0Anfev8TyhczCHVj8TklJThQH9DJGeMRTDTAUTW
Cn2s6mJdT2Sc1MAdF+iQ6Pc8sO49W4z0iPJ1eecqvhi/PfY2pNGLnucRJQsZML4C
XpLrs9wdgOGFMoPS/UTZZonWC/GT6sHPlD3MAZU3/6yORhJHuL8tYTMCgwP8aOgg
NqJPocryvqpJtGHbWUHwOdJieiC94KYpSdXZzp+Gf1BSurGJ+6M9y4219z5wvm0w
xM3tx4e7sj11mTEXWzsh
=BbvC
-----END PGP SIGNATURE-----

--r5hg2xrmciJc9DfTP6XiMi56rmwJ6Q6Vj--

