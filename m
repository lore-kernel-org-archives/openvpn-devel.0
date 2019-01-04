References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
 <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
 <9280d234-8240-9bcd-98d5-71909e02efb2@...515...>
 <c83727e1-907c-cdd3-1c0d-9c563a7dc757@...2080...>
 <dfb116ab-cde6-1269-ff14-a11c2e1111fb@...376...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <807eba32-9b74-9261-4763-e8a2bb40acd8@...2080...>
Date: Sat, 5 Jan 2019 00:21:44 +0100
MIME-Version: 1.0
In-Reply-To: <dfb116ab-cde6-1269-ff14-a11c2e1111fb@...376...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6BrrY5fG25Aqg9HUjZEYJn2tSu1xwuoyI"
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Bernhard Schmidt <berni@...376...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6BrrY5fG25Aqg9HUjZEYJn2tSu1xwuoyI
Content-Type: multipart/mixed; boundary="bPUrtJVlBtMHtoMws7sX8s55TEqjvEEEA";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Bernhard Schmidt <berni@...376...>,
 =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <807eba32-9b74-9261-4763-e8a2bb40acd8@...2080...>
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
 <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
 <9280d234-8240-9bcd-98d5-71909e02efb2@...515...>
 <c83727e1-907c-cdd3-1c0d-9c563a7dc757@...2080...>
 <dfb116ab-cde6-1269-ff14-a11c2e1111fb@...376...>
In-Reply-To: <dfb116ab-cde6-1269-ff14-a11c2e1111fb@...376...>

--bPUrtJVlBtMHtoMws7sX8s55TEqjvEEEA
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On 04/01/2019 18:32, Bernhard Schmidt wrote:
> Am 04.01.19 um 17:25 schrieb David Sommerseth:
>=20
> Hi everyone,
>=20
>> Okay, I was a bit unclear.  The approach used with openvpn.service and
>> openvpn@...1685... are broken by (Debian) design.  Quite many users have
>> reported that these service files does not work at all.  But I'll admit,=
 I'm
>> not really up-to-date if these service files have been updated by
>> distro-packagers later on.
>
> (One of the) Debian OpenVPN maintainer here. I'd like to get some input
> about the perceived brokenness of the openvpn@...1685... in Debian. Freeze
> is coming up, but we still have time to fix issues if they arise. I'm
> not aware of any major bugs reported for this.
>=20
> First of all, we ship both openvpn@...1685... (which is maintained in
> Debian) and openvpn-client@...1685... and openvpn-server@...1685... from =
the
> upstream sources. As a user of our package you are very much free (and
> encouraged) to work with OpenVPN in the officially documented way.

That's really good!  Thank you, Bernhard!

> openvpn@...1685... mostly comes from a compatibility layer. Since years in
> Debian you could drop a .conf into /etc/openvpn and had it executed at
> startup (controlled by a variable in /etc/default/openvpn). This is
> pretty much remodeled by the use of a custom generator, see
> https://sources.debian.org/src/openvpn/2.4.6-1/debian/openvpn-generator/
> . openvpn.service just binds these instances together to allow for a
> service openvpn restart to work. And I currently don't see a compelling
> reason to drop this, since it allows upgrading users to keep working).

I have no strong opinions about what the best approach for the official Deb=
ian
packages is, from pure a Debian perspective (my responses to Samuli has been
the .deb packaging we place into our own repositories).

I do know that this generator has been quite unreliable and a lot of users =
got
confused in the past and several users did 'systemctl start openvpn.service'
... and no OpenVPN services did start while the configuration files was to =
be
found in /etc/openvpn and users did claim this worked earlier.  Switching to
the new unit files, and everything worked instantly.  Another challenge has
been that it has been hard to find the proper location where log entries en=
ds
up.  Too many users don't realise that openvpn.service is something very
different from openvpn@...2485...

> Since the .conf files are not split between client and server we have to
> use one openvpn@...1685... that can accomodate both. But I really fail to
> see the problem here. openvpn@...1685... and openvpn-server@...1685... are
> not that much different.=20

We move slowly forward in regards to hardening both services.  And the serv=
er
operational mode has more privileges than the client mode.  Currently proba=
bly
not the biggest issue, but this is something we will need to work further o=
n.

> We do use systemd readyness notification, the
> capability bounding set is the same (for server),

That's good!  That has been one of the major pain points.

> the ExecStart line is similar, we do restart on error.

Restart on error is reasonable and good in server mode.  For client mode, f=
or
some that is the proper thing to do; while for others it can be annoying.
Hence we have only added restart-on-error for the server mode.

We generally recommend users to do 'systemctl edit openvpn-client@...2486...=
.'
to add restart-on-error for those configurations where it is wanted.

> openvpn@...1685...
> ExecStart=3D/usr/sbin/openvpn --daemon ovpn-%i --status
> /run/openvpn/%i.status 10 --cd /etc/openvpn --config
> /etc/openvpn/%i.conf --writepid /run/openvpn/%i.pid

--daemon is definitaly a NOOP if Type=3Dnotify, so that can go out.  --writ=
epid
is really questionable to me.  With Type=3Dnotify, systemd should not care =
about
any PID files at all.

There is an outstanding issue with our LimitNPROC=3D setting.  That might n=
eed
to be increased on the server side, but I don't think we've really found a
reasonable default.  For client side, it will typically allow 5-10
simultaneously running tunnels, so it might not be hit too hard.  The
challenge is that LimitNPROC is set on a user account level, it's not a
per-process setting.

But I see you don't have --supress-timestamps ... how does the log entries =
in
the log files look like?  Don't you get duplicated timestamps per line?

> openvpn-server@...1685...
> ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log
> --status-version 2 --suppress-timestamps --config %i.conf
>=20
> -client.service is a bit more restricted and uses --nobind and no status
> file, but that's about it.

Yes, currently.  And I would like to restrict it even further, but the scri=
pt
hooks are really tricky to tackle correctly as it is now.  We've tightened =
the
OpenVPN 3 Linux  client quite well, and I'd like to see some of those
approaches reimplemented in OpenVPN 2 as well.

We are now also in a state with OpenVPN 3 Linux that we can start playing w=
ith
re-using the openvpn3-service-netcfg D-Bus interface in OpenVPN 2, which wi=
ll
allow the openvpn process to run completely unprivileged.  The netcfg servi=
ce
has potential to become a kind of a more generic VPN API for Linux.  But for
OpenVPN 2.x, the tricky detail is, once again, script hooks - too many scri=
pts
expects to have root privileges.  That said, the netcfg service will also
handle DNS configuration in addition to IP address and routing configuratio=
n,
so part of the root access requirement on the client side is probably less
crucial.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--bPUrtJVlBtMHtoMws7sX8s55TEqjvEEEA--

--6BrrY5fG25Aqg9HUjZEYJn2tSu1xwuoyI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcL+qJAAoJEIbPlEyWcf3yYuMQAKzQuYm2p+LlfjLej2yKDcFm
MheXu6fRzLZDzT7RBejKuPV7FEwcLRCmB3Ab4yohF8ctdq33/iaz1XXIb/HTO/AW
dKfB/0YMmyoS4o84H1GycY01YLlzfn9tSeJ9TajWt6ta401uBD665xSp7MNpx2UH
HDxt367G1ostgAjBdg88yWYMFXNkbE+umKtg0ZGoAA1IUWJXrxefUOgU9UV0Z92B
TMcZGpRqG+AIRDbJgVfcmIAIDHk7b0MTqEKJudTFB0wHEnVHtwVqyqTD4t0DmCN7
DLpqj2RqbxbRzqz4Nj6rLj1qSWiP/NDFHxr8IGAdlyusFyzNrmwQQNkH2lf8MTvU
JtXalKbA5R55YmESpkGFEZ3WSKZt+kOroZpz0ixePxeSc18qae4BBQcWvVwWv3GK
m6sWpbw+rYiGT7LNnUfZl5fpFnYOITPW3fy1gtH68wOAardX9LfVXT9Z0pxBJzYC
tUeYkepBshQ6ogXSmOcnGTWqM/I3ybevW1RJ4K/HqtkdL4f3QwxeVoh2uw6FKPTd
DvDCmZMbdfR/mOa12wXphl5VCrZUo0nuwScB7ni8Ch/6FMxpgQsWwmdvRVm74Joq
sOZ5tDgWWSB+Y15NMYph9fpRyGvmXtv26VVnDJBKXasiowucuUFtNctPz9HE3sk2
90tDt2Q3Qfe9xlcYzvro
=r9Ez
-----END PGP SIGNATURE-----

--6BrrY5fG25Aqg9HUjZEYJn2tSu1xwuoyI--

