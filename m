References: <20161201213104.5667-1-list@...1798...>
	<20161201213104.5667-2-list@...1798...>
From: debbie10t <debbie10t@...277...>
Message-ID: <b032d2cd-6e14-7189-4192-040c9b663f98@...277...>
Date: Fri, 2 Dec 2016 01:45:59 +0000
MIME-Version: 1.0
In-Reply-To: <20161201213104.5667-2-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Refuse to daemonize when running
 from systemd
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

Gutted ..

I have to step in here NOW and say that this did not work for me.

I applied to the current (as of this email) git master:

* Use systemd service manager notification
* The patch below
* No others.

-----

then
$ autoreconf -ivf
$ ./configure --enable-systemd
$ make
# make uninstall
# make install

I then used the systemd unit from
b/src/distro/systemd/openvpn-server@...1685...
copied and renamed to my conf file as
/etc/systemd/system/openvpn-server@...2204...

systemctl'd to the correct unit file:

# ls -l /etc/systemd/system/multi-user.target.wants
total ..
lrwxrwxrwx 1 root root 47 Dec  1 15:56 openvpn-server@...2204... -> 
/etc/systemd/system/openvpn-server@...2204...


changed the unit file as below:


# cat /etc/systemd/system/openvpn-server@...2204...
[Unit]
Description=OpenVPN service for %I
After=syslog.target network-online.target
Wants=network-online.target
Documentation=man:openvpn(8)
Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO

[Service]
Type=notify
PrivateTmp=true
RuntimeDirectory=openvpn-server
RuntimeDirectoryMode=0710
WorkingDirectory=/etc/openvpn/server

# Not using 2.3.x
#ExecStart=/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log 
--status-version 2 --suppress-timestamps --config %i.conf
# Do not like --supress-timestamps
#ExecStart=/usr/local/sbin/openvpn --status 
%t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps 
--config %i.conf
# Using this
ExecStart=/usr/local/sbin/openvpn --status 
%t/openvpn-server/status-%i.log --status-version 2 --config %i.conf
CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE 
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
LimitNPROC=10
DeviceAllow=/dev/null rw
DeviceAllow=/dev/net/tun rw

[Install]
WantedBy=multi-user.target

My east.conf file:

# cat server/east.conf

### TESTS
#
## systemd enhancements: failed as expect
;bad-opt

## daemon: Did *not* fail when run from systemd service
daemon vpn-srv-east

                  server 10.25.25.0 255.255.255.248
  server-ipv6 12fc:1918::10:25:25:0:0/112

push "setenv-safe PUSH_east arch"

keepalive 10 30
push "comp-lzo no"
       comp-lzo no
push "explicit-exit-notify 3"
client-config-dir /etc/openvpn/server/east/ccd
ccd-exclusive

log /etc/openvpn/server/east/temp/east.log
verb 4

management 127.0.0.1 10025
dev tun25s
port 10025
cipher AES-256-CBC
auth RSA-SHA512

# cert/key stuff
...


Then:
# systemctl daemon-reload
# systemctl start openvpn-server@...2205...

** Openvpn started but should have failed **


Just for the hell of it

# nano b/src/openvpn/init.c

/*
  * Should we become a daemon?
  * Return true if we did it.
  */
bool
possibly_become_daemon (const struct options *options)
{
   bool ret = false;

#ifdef ENABLE_SYSTEMD
   /* return without forking if we are running from systemd */
   if (sd_notify(0, "READY=0") > 0)
     return ret;
#endif

   if (options->daemon)
     {
       ASSERT (!options->inetd);
       /* Don't chdir immediately, but the end of the init sequence, if 
needed */
       if (daemon (1, options->log) < 0)
         msg (M_ERR, "daemon() failed or unsupported");
       restore_signal_state ();
       if (options->log)
                                 [ line 921/4014 (22%), col 1/3 (33%), 
char 22889/106307 (21%) ]

-----

I have probably done something wrong but could not sleep without letting 
someone know!

Regards




On 01/12/16 21:31, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>
> We start with systemd Type=notify, so refuse to daemonize. This does not
> affect starting openvpn from script or command line.
>
> v2: Update commit message about script and command line.
>
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  distro/systemd/openvpn-client@...1685... | 1 -
>  distro/systemd/openvpn-server@...1685... | 1 -
>  src/openvpn/init.c                     | 7 +++++++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
> index f64a239..5618af3 100644
> --- a/distro/systemd/openvpn-client@...1685...
> +++ b/distro/systemd/openvpn-client@...1685...
> @@ -12,7 +12,6 @@ PrivateTmp=true
>  RuntimeDirectory=openvpn-client
>  RuntimeDirectoryMode=0710
>  WorkingDirectory=/etc/openvpn/client
> -ExecStartPre=/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0 && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when being managed by systemd" ; exit 1'
>  ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind --config %i.conf
>  CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>  LimitNPROC=10
> diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...1685...
> index 890e6a9..b9b4dba 100644
> --- a/distro/systemd/openvpn-server@...1685...
> +++ b/distro/systemd/openvpn-server@...1685...
> @@ -12,7 +12,6 @@ PrivateTmp=true
>  RuntimeDirectory=openvpn-server
>  RuntimeDirectoryMode=0710
>  WorkingDirectory=/etc/openvpn/server
> -ExecStartPre=/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0 && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when being managed by systemd" ; exit 1'
>  ExecStart=/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
>  CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>  LimitNPROC=10
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index f99c934..74f1139 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -930,6 +930,13 @@ bool
>  possibly_become_daemon (const struct options *options)
>  {
>    bool ret = false;
> +
> +#ifdef ENABLE_SYSTEMD
> +  /* return without forking if we are running from systemd */
> +  if (sd_notify(0, "READY=0") > 0)
> +    return ret;
> +#endif
> +
>    if (options->daemon)
>      {
>        ASSERT (!options->inetd);
>

