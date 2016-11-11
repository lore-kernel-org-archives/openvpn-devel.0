References: <1476996158-5390-1-git-send-email-davids@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <5f201645-8325-b93c-42db-355fef4da9ea@...277...>
Date: Fri, 11 Nov 2016 12:09:57 +0000
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
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

following are the server and client systemd unit files
which work best for me.


Tested on:
Archlinux     - OpenVPN 2.3.13 x86_64-unknown-linux-gnu - systemd 231
CentOS 7      - OpenVPN 2.3.12 x86_64-redhat-linux-gnu  - systemd 219
Debian 8      - OpenVPN 2.3.13 x86_64-pc-linux-gnu      - systemd 215
OpenSUSE 42.2 - OpenVPN 2.3.8 x86_64-suse-linux-gnu     - systemd 228
Fedora 24     - OpenVPN 2.3.12 x86_64-redhat-linux-gnu  - systemd 229
Ubuntu 16.04  - OpenVPN 2.3.13 x86_64-pc-linux-gnu      - systemd 229

Tested with:
Multiple server and multiple client configs all enabled.

Tests:
systemctl enable/disable/start/stop/restart/reboot

Result:
ALL Tests passed.

Note:
I have inserted blank lines to help with email line wrap.


=====


openvpn-client@...1685...

[Unit]
Description=OpenVPN tunnel for %I
After=syslog.target network-online.target
Wants=network-online.target
Documentation=man:openvpn(8)
Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO

[Service]
PrivateTmp=true
RuntimeDirectory=openvpn-client
RuntimeDirectoryMode=0710
WorkingDirectory=/etc/openvpn/client

ExecStart=/usr/sbin/openvpn --config %i.conf --nobind --suppress-timestamps

CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID 
CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE

LimitNPROC=10
DeviceAllow=/dev/null rw
DeviceAllow=/dev/net/tun rw

[Install]
WantedBy=multi-user.target


=====


openvpn-server@...1685...

[Unit]
Description=OpenVPN service for %I
After=syslog.target network-online.target
Wants=network-online.target
Documentation=man:openvpn(8)
Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO

[Service]
PrivateTmp=true
RuntimeDirectory=openvpn-server
RuntimeDirectoryMode=0710
WorkingDirectory=/etc/openvpn/server

ExecStart=/usr/sbin/openvpn --config %i.conf --status 
%t/openvpn-server/%i-status.log --status-version 2 --suppress-timestamps

CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE 
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE

LimitNPROC=10
DeviceAllow=/dev/null rw
DeviceAllow=/dev/net/tun rw

[Install]
WantedBy=multi-user.target


=====


Regards



On 20/10/16 21:42, David Sommerseth wrote:
> There are several changes which allows systemd to take care of several
> aspects of hardening the execution of OpenVPN.
>
> - Let systemd take care of the process tracking directly, instead
>   of doing that via PID files
>
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
> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
> index 56d93a9..051eb47 100644
> --- a/distro/systemd/openvpn-client@...1685...
> +++ b/distro/systemd/openvpn-client@...1685...
> @@ -3,15 +3,16 @@ Description=OpenVPN tunnel for %I
>  After=syslog.target network-online.target
>  Wants=network-online.target
>  Documentation=man:openvpn(8)
> -Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
> +Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
>  Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
>
>  [Service]
>  PrivateTmp=true
> -Type=forking
> -PIDFile=/var/run/openvpn/client_%i.pid
> -ExecStart=/usr/sbin/openvpn --cd /etc/openvpn/client --config %i.conf --daemon --writepid /var/run/openvpn/client_%i.pid
> -CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
> +RuntimeDirectory=openvpn
> +RuntimeDirectoryMode=0710
> +WorkingDirectory=/etc/openvpn/client
> +ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind --config %i.conf
> +CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>  LimitNPROC=10
>  DeviceAllow=/dev/null rw
>  DeviceAllow=/dev/net/tun rw
> diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...1685...
> index c4c9a12..c8da5fa 100644
> --- a/distro/systemd/openvpn-server@...1685...
> +++ b/distro/systemd/openvpn-server@...1685...
> @@ -1,16 +1,18 @@
>  [Unit]
>  Description=OpenVPN service for %I
> -After=syslog.target network.target
> +After=syslog.target network-online.target
> +Wants=network-online.target
>  Documentation=man:openvpn(8)
> -Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
> +Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
>  Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
>
>  [Service]
>  PrivateTmp=true
> -Type=forking
> -PIDFile=/var/run/openvpn/server_%i.pid
> -ExecStart=/usr/sbin/openvpn --cd /etc/openvpn/server --status /var/run/openvpn/server_%i-status.log --status-version 2 --config %i.conf --daemon --writepid /var/run/openvpn/server_%i.pid
> -CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
> +RuntimeDirectory=openvpn
> +RuntimeDirectoryMode=0710
> +WorkingDirectory=/etc/openvpn/server
> +ExecStart=/usr/sbin/openvpn --status %t/openvpn/server_%i-status.log --status-version 2 --suppress-timestamps --config %i.conf
> +CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>  LimitNPROC=10
>  DeviceAllow=/dev/null rw
>  DeviceAllow=/dev/net/tun rw
>

