Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-3-christian.ehrhardt@...1808...>
 <20180829210556.0b76af25@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c103429d-fff6-df7d-1f99-4e1a161a16ab@...2080...>
Date: Thu, 30 Aug 2018 01:38:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180829210556.0b76af25@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="nCzvjqIHTlrs4wQNheraSwzM1O9B4j9CS"
Subject: Re: [Openvpn-devel] [PATCH 2/2] systemd: extend
 CapabilityBoundingSet for learn-address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, Christian Ehrhardt <christian.ehrhardt@...1808...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nCzvjqIHTlrs4wQNheraSwzM1O9B4j9CS
Content-Type: multipart/mixed; boundary="egpMyJU5pL8obMsKhul51G9b9lyWawHRF";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>,
 Christian Ehrhardt <christian.ehrhardt@...1808...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <c103429d-fff6-df7d-1f99-4e1a161a16ab@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] systemd: extend CapabilityBoundingSet
 for learn-address
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-3-christian.ehrhardt@...1808...>
 <20180829210556.0b76af25@...1799...>
In-Reply-To: <20180829210556.0b76af25@...1799...>

--egpMyJU5pL8obMsKhul51G9b9lyWawHRF
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 29/08/18 21:05, Christian Hesse wrote:
> Christian Ehrhardt <christian.ehrhardt@...1808...> on Wed, 2018/08/29
> 16:27:
>> It seems a not too uncommon case that learn-address needs to recycle
>> dnsmasq - to do so it would need CAP_KILL.
>>
>> This was suggested on https://community.openvpn.net/openvpn/ticket/918
>>
>> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@...1808...>
>> ---
>>  distro/systemd/openvpn-server@...2221... | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/distro/systemd/openvpn-server@...2221...
>> b/distro/systemd/openvpn-server@...2221... index d1cc72cb..edace213 1006=
44
>> --- a/distro/systemd/openvpn-server@...2221...
>> +++ b/distro/systemd/openvpn-server@...2221...
>> @@ -11,7 +11,7 @@ Type=3Dnotify
>>  PrivateTmp=3Dtrue
>>  WorkingDirectory=3D/etc/openvpn/server
>>  ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log
>> --status-version 2 --suppress-timestamps --config %i.conf
>> -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
>> CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>> CAP_AUDIT_WRITE +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN
>> CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT
>> CAP_DAC_OVERRIDE CAP_AUDIT_WRITE CAP_KILL LimitNPROC=3D10
>> DeviceAllow=3D/dev/null rw DeviceAllow=3D/dev/net/tun rw
>=20
> I do not like services being allowed to send signals to other processes. =
As
> dnsmasq supports a dbus interface... How about using that? For example to
> clear the dns cache of an instance started from Networkmanager:
>=20
> dbus-send --system --print-reply \
> --dest=3Dorg.freedesktop.NetworkManager.dnsmasq /uk/org/thekelleys/dnsmas=
q \
> uk.org.thekelleys.ClearCache

+1 ... CAP_KILL privileges can too easily prepare the ground for DoS attack=
s.

The D-Bus approach above seems much saner and safer.  Also because D-Bus gi=
ves
a reasonable protection in regards to privilege escalation attacks.  But you
most likely need to prepare a D-Bus policy for dnsmasq though, to allow the
openvpn user (or whatever user who will execute this script) access to the
uk.org.thekelleys.ClearCache D-Bus method.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--egpMyJU5pL8obMsKhul51G9b9lyWawHRF--

--nCzvjqIHTlrs4wQNheraSwzM1O9B4j9CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbhy6EAAoJEIbPlEyWcf3y0B8QAK9dx2n3izbmNDbHsdvcv3h0
kyDy8Zd1mBfdOUMGiM2JJitcbMB2xhckCN4mC7okTOvUNTD6QUfccVVo8n9zwEnY
hTPCFjPf+j0rd5p3mZUwKpuDG7s8WXIfJgF2H/ogejU9J2dt86sBHxHxh3ycvG/Y
qNq7CRCtgJuLFbp92rRn+NgDuxV5gVQl1erQ9z2QJ4AkU6QGQu1CfY5GHmODYFaO
IBTDptdqg5cv0pqv/2RrsWqbN9Jv7yBAnyPKjeWA1doVMI6ryOvrWkMIEvH0h0Ia
nhyz5HgQjHyP3s9mtFpT2RVMzT8v4Ngeg8gmuSI38BDdu3gSlCd3Rlzmt08SPvVE
sjZj+EvWPiQAgvvi1eIbKXudQESmVcniQ9OjL64kZeJlBgbF/wd6of0GmzB/hB+B
QMHLCVYeh98ST9ExNqY1dosd3X4Tz8+HOTQmmsN9AO4UuRFb4M5hsqfXfMCzny7y
4FVBjCiDvEbWXdDeC0k4iXJT11NdXWiCy/fKsf2voPZtEMX5yqCxyvg7ZQBevpLT
hyqJ53GapO/IoOKoLeh8T+crzYuAPR1wj4M9tpqvaB0WLlQbu2WjA5APTklvPtct
KMk6LxTICMOPn0D6i1ZwGMWJSsjO/AahesWw100Rx9EyyTrAp4MOdFuNNbQH6Djx
pPPkkUxwo4GTXLSokEoL
=8b03
-----END PGP SIGNATURE-----

--nCzvjqIHTlrs4wQNheraSwzM1O9B4j9CS--

