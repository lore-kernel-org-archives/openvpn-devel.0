References: <1476996158-5390-1-git-send-email-davids@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <6c3649c3-75e0-df8a-d910-73441af695d9@...515...>
Date: Fri, 11 Nov 2016 14:28:49 +0200
MIME-Version: 1.0
In-Reply-To: <1476996158-5390-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This comes a bit late, sorry.

Il 20/10/2016 23:42, David Sommerseth ha scritto:
> There are several changes which allows systemd to take care of several
> aspects of hardening the execution of OpenVPN.
>
> - Let systemd take care of the process tracking directly, instead
>   of doing that via PID files
>

This makes sense, but it has one caveat. If there is no pidfile,=20
external, local monitoring applications might not be able to monitor the=20
status of the OpenVPN process anymore. I, for example, heavily utilize=20
monit for it's email notification capabilities, and because it can=20
actually do things if it detects anomalies.

The last time I checked, there is no easy way to get systemd to notify=20
the admin if, say, a daemon goes down and systemd restarts it. Is this=20
still the case?


> - Make systemd prepare proper runtime directories for the OpenVPN
>   process.
>
> - Let systemd do the chdir() before starting OpenVPN.  This allows
>   us to avoid using the --cd option when executing openvpn.
>
> - CAP_DAC_OVERRIDE was needed when using --chroot.  Otherwise
>   the root user would not be allowed to access files/directories
>   not owned by root.  This will change in the future, when we
>   find better ways to avoid calling chroot() in OpenVPN and
>   rather let systemd prepare a more isolated namespace.
>
> - Client configurations are now started with --nobind and
>   the OpenVPN client process have lost the CAP_NET_BIND_SERVICE
>   capability which allows binding to port < 1024.
>
> - Documentation URL now points at the OpenVPN 2.4 man page URL
>
> The majority of these changes have been proposed by Elias Probst
> (eliasp) in the GitHub PR #22.
>
> Contribution-by: Elias Probst <mail@...2185...>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  distro/systemd/openvpn-client@...1685... | 11 ++++++-----
>  distro/systemd/openvpn-server@...1685... | 14 ++++++++------
>  2 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/op=
envpn-client@...1685...
> index 56d93a9..051eb47 100644
> --- a/distro/systemd/openvpn-client@...1685...
> +++ b/distro/systemd/openvpn-client@...1685...
> @@ -3,15 +3,16 @@ Description=3DOpenVPN tunnel for %I
>  After=3Dsyslog.target network-online.target
>  Wants=3Dnetwork-online.target
>  Documentation=3Dman:openvpn(8)
> -Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn23ManP=
age
> +Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn24ManP=
age
>  Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO
>
>  [Service]
>  PrivateTmp=3Dtrue
> -Type=3Dforking
> -PIDFile=3D/var/run/openvpn/client_%i.pid
> -ExecStart=3D/usr/sbin/openvpn --cd /etc/openvpn/client --config %i.conf =
--daemon --writepid /var/run/openvpn/client_%i.pid
> -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE =
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
> +RuntimeDirectory=3Dopenvpn
> +RuntimeDirectoryMode=3D0710
> +WorkingDirectory=3D/etc/openvpn/client
> +ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind --config %i=
.conf
> +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGI=
D CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>  LimitNPROC=3D10
>  DeviceAllow=3D/dev/null rw
>  DeviceAllow=3D/dev/net/tun rw
> diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/op=
envpn-server@...1685...
> index c4c9a12..c8da5fa 100644
> --- a/distro/systemd/openvpn-server@...1685...
> +++ b/distro/systemd/openvpn-server@...1685...
> @@ -1,16 +1,18 @@
>  [Unit]
>  Description=3DOpenVPN service for %I
> -After=3Dsyslog.target network.target
> +After=3Dsyslog.target network-online.target
> +Wants=3Dnetwork-online.target
>  Documentation=3Dman:openvpn(8)
> -Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn23ManP=
age
> +Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/Openvpn24ManP=
age
>  Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO
>
>  [Service]
>  PrivateTmp=3Dtrue
> -Type=3Dforking
> -PIDFile=3D/var/run/openvpn/server_%i.pid
> -ExecStart=3D/usr/sbin/openvpn --cd /etc/openvpn/server --status /var/run=
/openvpn/server_%i-status.log --status-version 2 --config %i.conf --daemon =
--writepid /var/run/openvpn/server_%i.pid
> -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE =
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
> +RuntimeDirectory=3Dopenvpn
> +RuntimeDirectoryMode=3D0710
> +WorkingDirectory=3D/etc/openvpn/server
> +ExecStart=3D/usr/sbin/openvpn --status %t/openvpn/server_%i-status.log -=
-status-version 2 --suppress-timestamps --config %i.conf
> +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE =
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>  LimitNPROC=3D10
>  DeviceAllow=3D/dev/null rw
>  DeviceAllow=3D/dev/net/tun rw
>


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

