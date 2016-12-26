References: <20161216225203.609cf163@...1799...>
	<20161216220004.20867-1-list@...1798...>
	<9a6d51f5-831b-6fd5-109f-0688623f08d9@...277...>
	<20161226171257.5b611618@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a039446c-5dc5-74a7-12f3-53a084cfc192@...2080...>
Date: Mon, 26 Dec 2016 17:45:28 +0100
MIME-Version: 1.0
In-Reply-To: <20161226171257.5b611618@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3E4k9Bo8mD8jbGHUdBU9gJwfP0lSohj73"
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3E4k9Bo8mD8jbGHUdBU9gJwfP0lSohj73
Content-Type: multipart/mixed; boundary="fVi47xt7hbb71oNIQWoUprnEmwfXxWA1Q";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <a039446c-5dc5-74a7-12f3-53a084cfc192@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
References: <20161216225203.609cf163@...1799...>
	<20161216220004.20867-1-list@...1798...>
	<9a6d51f5-831b-6fd5-109f-0688623f08d9@...277...>
	<20161226171257.5b611618@...1799...>
In-Reply-To: <20161226171257.5b611618@...1799...>

--fVi47xt7hbb71oNIQWoUprnEmwfXxWA1Q
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 26/12/16 17:12, Christian Hesse wrote:
> debbie10t <debbie10t@...277...> on Sat, 2016/12/24 11:10:
>> On 16/12/16 22:00, Christian Hesse wrote:
>>> From: Christian Hesse <mail@...1798...>
>>>
>>> Different unit instances create and destroy the same RuntimeDirectory.
>>> This leads to running instances where the status file (and possibly
>>> more runtime data) is no longer accessible.
>>>
>>> So do not handle this in unit files but provide a tmpfiles.d
>>> configuration and let systemd-tmpfiles do the work.
>>> Nobody will (unintentionally) delete the directories and its content.
>>> As /run is volatile we do not have to care about cleanup.
>>>
>>> Signed-off-by: Christian Hesse <mail@...1798...>
>>> ---
>>>  distro/systemd/openvpn-client@...1685... | 2 --
>>>  distro/systemd/openvpn-server@...1685... | 2 --
>>>  distro/systemd/openvpn.conf            | 2 ++
>>>  3 files changed, 2 insertions(+), 4 deletions(-)
>>>  create mode 100644 distro/systemd/openvpn.conf
>>>
>>> diff --git a/distro/systemd/openvpn-client@...1685...
>>> b/distro/systemd/openvpn-client@...1685... index 5618af3..1187ee8 100644
>>> --- a/distro/systemd/openvpn-client@...1685...
>>> +++ b/distro/systemd/openvpn-client@...1685...
>>> @@ -9,8 +9,6 @@
>>> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Servi=
ce]
>>>  Type=3Dnotify
>>>  PrivateTmp=3Dtrue
>>> -RuntimeDirectory=3Dopenvpn-client
>>> -RuntimeDirectoryMode=3D0710
>>>  WorkingDirectory=3D/etc/openvpn/client
>>>  ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind --config
>>> %i.conf CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW
>>> CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE diff --git
>>> a/distro/systemd/openvpn-server@...1685...
>>> b/distro/systemd/openvpn-server@...1685... index b9b4dba..25a6bb7 100644
>>> --- a/distro/systemd/openvpn-server@...1685... +++
>>> b/distro/systemd/openvpn-server@...1685... @@ -9,8 +9,6 @@
>>> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Servi=
ce]
>>>  Type=3Dnotify
>>>  PrivateTmp=3Dtrue
>>> -RuntimeDirectory=3Dopenvpn-server
>>> -RuntimeDirectoryMode=3D0710
>>>  WorkingDirectory=3D/etc/openvpn/server
>>>  ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log
>>> --status-version 2 --suppress-timestamps --config %i.conf
>>> CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
>>> CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE diff
>>> --git a/distro/systemd/openvpn.conf b/distro/systemd/openvpn.conf new
>>> file mode 100644 index 0000000..bb79671 --- /dev/null
>>> +++ b/distro/systemd/openvpn.conf
>>> @@ -0,0 +1,2 @@
>>> +d /run/openvpn-client 0710 root root -
>>> +d /run/openvpn-server 0710 root root -
>>>=20=20
>>
>> ACK
>>
>> This works as expected from debian8/systemd 215 to arch/systemd 232
>=20
> Great! Thanks for testing!
>=20
> But I think this will not make its way into 2.4.0? Will we see this in
> release/2.4 for a bugfix release?

That is correct.  What is in release/2.4 currently is what will be the
v2.4.0 release unless something of a real blocker appears before I'll
tag and push out the release commit some time tomorrow.  I don't dare to
add anything which is not absolutely strictly needed for the comming
release.  I'm just waiting for a the final Windows test results from
Samuli before pushing out the final release.  Then Samuli will publish
all source tarballs, Windows installers and do the announcement.

It's good that this is tested, but I'd like to have a more thorough
review of this patch as well in addition to look at the automake rules
so that we can install unit files and the tmpfiles.d config to the
proper place as well during 'make install'.  This will simplify the job
of the packagers as well.

One thing I'm pondering on though, is how clever it is to call the
tmpfiles.d config file 'openvpn.conf' ... but that's something I can fix
at commit time.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--fVi47xt7hbb71oNIQWoUprnEmwfXxWA1Q--

--3E4k9Bo8mD8jbGHUdBU9gJwfP0lSohj73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYYUkoAAoJEIbPlEyWcf3yKQQP/29fXXAhHokC8WrpzCGii+Rv
tHHw3Inci9Y0t2n2Lm+RF0VPTObRVQ1+hpSMzFRsIfpW9B83fxF2Q+BmZnVa6QSo
p02dIkHOhxZIXTrHfyjy3RRszYl1U2VJN4Mn0lJkW4V+fcCLLEIfu8gODBX6dwSU
OnBiS3Cgo+ZLr09nICakAD+svGd7fBpm3jHsBBMnYgalgGSCBetea+YvOU+H/9Fw
lQWYEO2u1awVvvZBYrv+9+Kbjk8edNTEh+OTPWwtzW67QPXlN3om7NlsOYp3Bt81
wW/yi7eMmOLeuFCuQgHnoYEk6HC3kfBBpnwaSDDpOPmt23MFagwyFlA3SXoDIJte
ddeKS1BBerUZ5LNSyksEcYHAuPn5vwh6b/ntNfZYi8t36SfYLOM3TJaOQVvhGDA7
8R8EmBqDK56wBedC4bv5bqZhJnUqGPbmPJxJcHGPXUlUPWcFIiq+POPZc5Et6Lqr
Ht84/oO7lyU3Pt59Y67H39CHtmHmX4vKiVDihzd0yiSvQc2jwBHb8XWddsrb/T+F
ojObqzigJWoFZGMO+nkOK8/lN7LYdK8tlRGhdCvP6+mlZeYaeeogaANtQuWP/MTh
YCZ/AwKjcRDVGUPztkGKiPiQ0Q6K7UDhw67LSrK8Y36sVPfpwXKC+rGxALZSqNTd
jmEkwke9w9Uye1XjuX0b
=sY5s
-----END PGP SIGNATURE-----

--3E4k9Bo8mD8jbGHUdBU9gJwfP0lSohj73--

