References: <1476996158-5390-1-git-send-email-davids@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <88fab532-d93c-e65b-a604-eacfb888da74@...277...>
Date: Tue, 8 Nov 2016 15:40:31 +0000
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

I now have these unit files working on all my test VMS.

The only problem before was that on debian 8 these services failed to
start after reboot. (systemctl enable openvpn-{client/server}@config
was enabled) The error message was:
main process exited, code=exited, status=233/RUNTIME_DIRECTORY

On debian 8 this turned out to be something to do with sysvinit.

This warning lead me to the cause:
# apt-get install openvpn

<s>

Setting up openvpn (2.3.12-debian0) ...
insserv: warning: current start runlevel(s) (empty) of script `openvpn' 
overrides LSB defaults (2 3 4 ,5).
insserv: warning: current stop runlevel(s) (0 1 2 3 4 5 6) of script 
`openvpn' overrides LSB defaults (0 1 6).

So, I un-installed openvpn-2.3.12 using apt-get remove and then edited 
the unit files to use git_master instead:

openvpn-server@...1685...

#      ExecStart=/usr/sbin/openvpn --status 
%t/openvpn/server_%i-status.log --status-version 2 --suppress-timestamps 
--config %i.conf

  ExecStart=/usr/local/sbin/openvpn --status 
%t/openvpn/server_%i-status.log --status-version 2 --suppress-timestamps 
--config %i.conf

openvpn-client@...1685...

#      ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind 
--config %i.conf
  ExecStart=/usr/local/sbin/openvpn --suppress-timestamps --nobind 
--config %i.conf

reloaded the systemd daemon and rebooted, then the test client and 
server started properly with no errors.

I include these edits to demonstrate how I fixed this for debian,
hopefully somebody can explain the issue ?

Other than that these unit files now work properly for *all* my VMs.

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

