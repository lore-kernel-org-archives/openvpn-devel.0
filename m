References: <1476996158-5390-1-git-send-email-davids@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <aa47d230-4e40-4ca3-9851-faf2470b7258@...277...>
Date: Sat, 5 Nov 2016 15:07:20 +0000
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

I have tested these two unit files on Archlinux, CentOS7, Debian8,
Fedora 24, OpenSuse 42 and Ubuntu 16.04 and they all work.
I tested for a week, starting ,stopping, restarting and rebooting on 1
server and 1 client per OS. (And two instance of 2x client and 2x
server)

Notes:
The problems I encountered were rectified by modifying my openvpn config 
files.

One issue remains when rebooting:
Services fail to start complaining about the RuntimeDirectory file 
exists.  This only happens on reboot not starting or restarting.
I could not determine which file exists but changing this fixed it:

(Diff style):
-RuntimeDirectory=openvpn
+RuntimeDirectory=openvpn-%i

(As suggested by thermi)


I would say that these .service files are likely to temporarily break
(m)any existing systemd usage until admins change their configs.
Especially use of --cd

Although I am not qualified to thoroughly test systemd security
features, those features appear to work.

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

