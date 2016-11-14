References: <1476996158-5390-1-git-send-email-davids@...515...>
	<1478950738-12861-1-git-send-email-davids@...515...>
	<e7f7340f-947e-ec15-37bf-9db1fb33ff11@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <44a5aeb9-1fc1-ebd9-960e-cbea6680a8af@...2080...>
Date: Mon, 14 Nov 2016 12:02:16 +0100
MIME-Version: 1.0
In-Reply-To: <e7f7340f-947e-ec15-37bf-9db1fb33ff11@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Ja4rp3aWSWxCUB68dMSumoXVsQoHOlGAs"
Subject: Re: [Openvpn-devel] [PATCH v2] systemd: Improve the systemd unit
 files
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ja4rp3aWSWxCUB68dMSumoXVsQoHOlGAs
Content-Type: multipart/mixed; boundary="lG62XOJJFcwPEqSeobNqbGmSSL5D9vPCE";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <44a5aeb9-1fc1-ebd9-960e-cbea6680a8af@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] systemd: Improve the systemd unit files
References: <1476996158-5390-1-git-send-email-davids@...515...>
	<1478950738-12861-1-git-send-email-davids@...515...>
	<e7f7340f-947e-ec15-37bf-9db1fb33ff11@...277...>
In-Reply-To: <e7f7340f-947e-ec15-37bf-9db1fb33ff11@...277...>

--lG62XOJJFcwPEqSeobNqbGmSSL5D9vPCE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 12/11/16 14:48, debbie10t wrote:
>=20
>=20
> On 12/11/16 11:38, David Sommerseth wrote:
>> There are several changes which allows systemd to take care of several
>> aspects of hardening the execution of OpenVPN.
>>
>> - Let systemd take care of the process tracking directly, instead
>>   of doing that via PID files
>>
>> - Make systemd prepare proper runtime directories for the OpenVPN
>>   process.
>>
>> - Let systemd do the chdir() before starting OpenVPN.  This allows
>>   us to avoid using the --cd option when executing openvpn.
>>
>> - CAP_DAC_OVERRIDE was needed when using --chroot.  Otherwise
>>   the root user would not be allowed to access files/directories
>>   not owned by root.  This will change in the future, when we
>>   find better ways to avoid calling chroot() in OpenVPN and
>>   rather let systemd prepare a more isolated namespace.
>>
>> - Client configurations are now started with --nobind and
>>   the OpenVPN client process have lost the CAP_NET_BIND_SERVICE
>>   capability which allows binding to port < 1024.
>>
>> - Documentation URL now points at the OpenVPN 2.4 man page URL
>>
>> The majority of these changes have been proposed by Elias Probst
>> (eliasp) in the GitHub PR #22.
>>
>> v2 - Change RuntimeDirectory=3D to a profile specific (client, server)
>>      directory to avoid clashing with older distro unit files
>>
>> Contribution-by: Elias Probst <mail@...2185...>
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>  distro/systemd/openvpn-client@...1685... | 11 ++++++-----
>>  distro/systemd/openvpn-server@...1685... | 14 ++++++++------
>>  2 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/o=
penvpn-client@...1685...
>> index 56d93a9..661f4a9 100644
>> --- a/distro/systemd/openvpn-client@...1685...
>> +++ b/distro/systemd/openvpn-client@...1685...
>> @@ -3,15 +3,16 @@ Description=3DOpenVPN tunnel for %I
>>  After=3Dsyslog.target network-online.target
>>  Wants=3Dnetwork-online.target
>>  Documentation=3Dman:openvpn(8)
>> -Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn23Man=
Page
>> +Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn24Man=
Page
>>  Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO
>>
>>  [Service]
>>  PrivateTmp=3Dtrue
>> -Type=3Dforking
>> -PIDFile=3D/var/run/openvpn/client_%i.pid
>> -ExecStart=3D/usr/sbin/openvpn --cd /etc/openvpn/client --config %i.conf=
 --daemon --writepid /var/run/openvpn/client_%i.pid
>> -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE=
 CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
>> +RuntimeDirectory=3Dopenvpn-client
>> +RuntimeDirectoryMode=3D0710
>> +WorkingDirectory=3D/etc/openvpn/client
>> +ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind --config %=
i.conf
>> +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETG=
ID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>>  LimitNPROC=3D10
>>  DeviceAllow=3D/dev/null rw
>>  DeviceAllow=3D/dev/net/tun rw
>> diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/o=
penvpn-server@...1685...
>> index c4c9a12..48d9271 100644
>> --- a/distro/systemd/openvpn-server@...1685...
>> +++ b/distro/systemd/openvpn-server@...1685...
>> @@ -1,16 +1,18 @@
>>  [Unit]
>>  Description=3DOpenVPN service for %I
>> -After=3Dsyslog.target network.target
>> +After=3Dsyslog.target network-online.target
>> +Wants=3Dnetwork-online.target
>>  Documentation=3Dman:openvpn(8)
>> -Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn23Man=
Page
>> +Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn24Man=
Page
>>  Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO
>>
>>  [Service]
>>  PrivateTmp=3Dtrue
>> -Type=3Dforking
>> -PIDFile=3D/var/run/openvpn/server_%i.pid
>> -ExecStart=3D/usr/sbin/openvpn --cd /etc/openvpn/server --status /var/ru=
n/openvpn/server_%i-status.log --status-version 2 --config %i.conf --daemon=
 --writepid /var/run/openvpn/server_%i.pid
>> -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE=
 CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
>> +RuntimeDirectory=3Dopenvpn-server
>> +RuntimeDirectoryMode=3D0710
>> +WorkingDirectory=3D/etc/openvpn/server
>> +ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log =
--status-version 2 --suppress-timestamps --config %i.conf
>> +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE=
 CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>>  LimitNPROC=3D10
>>  DeviceAllow=3D/dev/null rw
>>  DeviceAllow=3D/dev/net/tun rw
>>
>=20
> Out of curiosity, is there a reason to put --config last ?

Yes, that is to allow a sys-admin to easily change our defaults without
modifying the unit file.

With that said, I do see a potential little trap.  A config file cannot
use --daemon, as that will break how systemd expects the process to
behave when being started successfully.  We should probably add a simple
'grep' check in the config file, to ensure "^daemon" is not found there.
 I'll check this out further.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--lG62XOJJFcwPEqSeobNqbGmSSL5D9vPCE--

--Ja4rp3aWSWxCUB68dMSumoXVsQoHOlGAs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYKZm4AAoJEIbPlEyWcf3yR2IQAMoHIdAxnY65bxP0G5ygks3E
xo8ih9Nz1CrYJbIJcLV38/WO8OrXsaXMPAZwxoDrstVMeYm5Im+bKHJvPmd1vYSu
IsX87fxx16vN2/pov5SOEs0twQ9A/yavARhKusngjEhGLticz32IMnyA02Ue3n5Q
NI7NAaihedEhNqQyTUDIex8TwH1sw0OAwpb5wUIQN1prqORNquhccDXmoHZF82K5
B3CURSpTNtcaLbsXF/+5vcRrAwGfu7FpnztrRrqZBxUcyeKPK6i3tyC0OT/LZMfB
ycgBjdPEs7kRTPMSNZWUvDjLUo9ocYM29HHaH3KoB8QpD+Iae/2V2A5YW/vYItYO
5mmQ5auwDj/4tj69f8AvnPswnHmpM279xZOUx7LnRehpNS2gveFvml0lBbcp+CTO
1mQtLJzQR/GkKb8rHpF3IYozKIl9NZcZNVpwK/rXZt0glhzP/c+n9eR9LWw28DU5
wpewWe7EsvyaWPaM9WJ0oPsycOVg29M/EkDjqZ7+aQWl6G3RI+QIeLW02WlCAdTj
8ZPpkyM49q0GR8/zMb7mWUnBylhYY3dX/WgFtodKWT+1RnRlnSmAJVb++Ldtii8I
PRGXt6PcVZkGzNGlYQJJuEwMEJq/OjUYZPpPSrCZjZk162bN4f/ElU0tE52170dg
b7zPTuyhlnNIe8uMkHmz
=oSOt
-----END PGP SIGNATURE-----

--Ja4rp3aWSWxCUB68dMSumoXVsQoHOlGAs--

