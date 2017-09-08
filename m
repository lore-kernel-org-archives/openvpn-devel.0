MIME-Version: 1.0
Date: Fri, 08 Sep 2017 11:30:06 +1000
From: Steven Haigh <netwiz@...2277...>
In-Reply-To: <f5e56e77-e810-78d0-47b0-474f660f78b5@...277...>
References: <20170906235202.26551-1-davids@...515...>
 <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
 <41cf1b9e-bb4b-a2f1-3c3a-cde43c8e0eb4@...2080...>
 <84bc7ec5-886e-7ae6-87a7-0385d0506376@...277...>
 <8c9c7f22-30a6-a192-f56d-961605a6d1c2@...2080...>
 <8aaacc62-7c5f-14d0-e1a4-a38b89c90625@...277...>
 <f5e56e77-e810-78d0-47b0-474f660f78b5@...277...>
Message-ID: <dbb9942d9beb584473690320e9603933@...2277...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 2017-09-08 10:41, fragmentux wrote:
> WRT systemd and 3rd party 'servers'
> 
> I am curious to know of any other "Server service" who decide ..
> to *rely* on ..
> a *forced* 'systemd (almost) unconditional restart by default'

As a basic list:

/usr/lib/systemd/system $ grep -r Restart *.service
autovt@...1685...:Restart=always
autovt@...1685...:RestartSec=0
console-getty.service:Restart=always
console-getty.service:RestartSec=0
container-getty@...1685...:Restart=always
container-getty@...1685...:RestartSec=0
dbus-org.freedesktop.login1.service:Restart=always
dbus-org.freedesktop.login1.service:RestartSec=0
debug-shell.service:Restart=always
debug-shell.service:RestartSec=0
getty@...1685...:Restart=always
getty@...1685...:RestartSec=0
mariadb.service:# Restart crashed server only, on-failure would also 
restart, for example, when
mariadb.service:Restart=on-abort
mariadb.service:RestartSec=5s
NetworkManager.service:Restart=on-failure
rsyslog.service:Restart=on-failure
rsyslog.service:Restart=on-failure
serial-getty@...1685...:Restart=always
sshd.service:Restart=on-failure
sshd.service:RestartSec=42s
sssd-autofs.service:Restart=on-failure
sssd-nss.service:Restart=on-failure
sssd-pac.service:Restart=on-failure
sssd-pam.service:Restart=on-failure
sssd-ssh.service:Restart=on-failure
sssd-sudo.service:Restart=on-failure
systemd-journald.service:Restart=always
systemd-journald.service:RestartSec=0
systemd-logind.service:Restart=always
systemd-logind.service:RestartSec=0
systemd-nspawn@...1685...:RestartForceExitStatus=133
systemd-udevd.service:Restart=always
systemd-udevd.service:RestartSec=0

-- 
Steven Haigh

? netwiz@...2277...     ? http://www.crc.id.au
? +61 (3) 9001 6090    ? 0412 935 897

