References: <20161216225203.609cf163@...1799...>
	<20161216220004.20867-1-list@...1798...>
From: debbie10t <debbie10t@...277...>
Message-ID: <9a6d51f5-831b-6fd5-109f-0688623f08d9@...277...>
Date: Sat, 24 Dec 2016 11:10:01 +0000
MIME-Version: 1.0
In-Reply-To: <20161216220004.20867-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
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



On 16/12/16 22:00, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>
> Different unit instances create and destroy the same RuntimeDirectory.
> This leads to running instances where the status file (and possibly
> more runtime data) is no longer accessible.
>
> So do not handle this in unit files but provide a tmpfiles.d
> configuration and let systemd-tmpfiles do the work.
> Nobody will (unintentionally) delete the directories and its content.
> As /run is volatile we do not have to care about cleanup.
>
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  distro/systemd/openvpn-client@...1685... | 2 --
>  distro/systemd/openvpn-server@...1685... | 2 --
>  distro/systemd/openvpn.conf            | 2 ++
>  3 files changed, 2 insertions(+), 4 deletions(-)
>  create mode 100644 distro/systemd/openvpn.conf
>
> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
> index 5618af3..1187ee8 100644
> --- a/distro/systemd/openvpn-client@...1685...
> +++ b/distro/systemd/openvpn-client@...1685...
> @@ -9,8 +9,6 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
>  [Service]
>  Type=notify
>  PrivateTmp=true
> -RuntimeDirectory=openvpn-client
> -RuntimeDirectoryMode=0710
>  WorkingDirectory=/etc/openvpn/client
>  ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind --config %i.conf
>  CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...1685...
> index b9b4dba..25a6bb7 100644
> --- a/distro/systemd/openvpn-server@...1685...
> +++ b/distro/systemd/openvpn-server@...1685...
> @@ -9,8 +9,6 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
>  [Service]
>  Type=notify
>  PrivateTmp=true
> -RuntimeDirectory=openvpn-server
> -RuntimeDirectoryMode=0710
>  WorkingDirectory=/etc/openvpn/server
>  ExecStart=/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
>  CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> diff --git a/distro/systemd/openvpn.conf b/distro/systemd/openvpn.conf
> new file mode 100644
> index 0000000..bb79671
> --- /dev/null
> +++ b/distro/systemd/openvpn.conf
> @@ -0,0 +1,2 @@
> +d /run/openvpn-client 0710 root root -
> +d /run/openvpn-server 0710 root root -
>

ACK

This works as expected from debian8/systemd 215 to arch/systemd 232

-- 

