MIME-Version: 1.0
In-Reply-To: <534AAAEC.7050105@...1227...>
References: <1397366216-657-1-git-send-email-cernekee@...277...>
	<20140413104705.GL16637@...1296...>
	<CAJiQ=7DYg6PnTJ0piiUDKaT5wefVBxvPH3ZPHANQxOgWeDHjPg@...278...>
	<534AAAEC.7050105@...1227...>
From: Kevin Cernekee <cernekee@...277...>
Date: Sun, 13 Apr 2014 09:31:11 -0700
Message-ID: <CAJiQ=7COCWVzV1pq+ek8zimj65CdB0UM8S+1om1k8p_75yDjRA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] Support non-root operation using
	ocproxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Apr 13, 2014 at 8:19 AM, Arne Schwabe <arne@...1227...> wrote:
> You could look at the TARGET_ANDROID. That uses the management interface and
> fds over unix socket to achieve something similar.

Do you think it would be feasible to enable TARGET_ANDROID by default
in the Linux OpenVPN builds, and change the logic so that if the user
passes e.g. "--android" it will accept commands over the management
socket instead of using the standard CLI?

This would not work with ocproxy as-is, but I could write a wrapper program.

Let me know if you think it's worth putting together a patch set.


BTW, here is an example of how my current patch works with an existing
OpenVPN service:

$ ./src/openvpn/openvpn --config /tmp/vpnbook/vpnbook-us1-udp25000.ovpn \
        --verb 0 --script-security 2 \
        --dev "|/usr/bin/ocproxy -D 12345" &
Sun Apr 13 08:46:44 2014 WARNING: file '/tmp/vpnbook/user.txt' is
group or others accessible
Sun Apr 13 08:46:44 2014 WARNING: No server certificate verification
method has been enabled.  See http://openvpn.net/howto.html#mitm for
more info.
Sun Apr 13 08:46:44 2014 WARNING: this configuration may cache
passwords in memory -- use the auth-nocache option to prevent this

$ SOCKS5_SERVER=127.0.0.1:12345 socksify links -source ipchicken.com |
grep -A1 Address
            Address:
            198.7.62.204            </font></td>


Using port forwarding with "ocproxy -L", socksify, or FoxyProxy,
individual connections / applications / URLs can be seamlessly
forwarded over different VPN links.  Or, if I omit the --dev option,
OpenVPN will fall back to standard "create tunX" behavior.

