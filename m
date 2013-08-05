MIME-Version: 1.0
In-Reply-To: <CAFLxGvxgzpM2n8zLhsm5Ag5BNNMp7GnFEo14d54fkgF=Cv7PPg@...278...>
References: <CAFLxGvxgzpM2n8zLhsm5Ag5BNNMp7GnFEo14d54fkgF=Cv7PPg@...278...>
Date: Mon, 5 Aug 2013 16:24:03 +0200
Message-ID: <CAFLxGvykyE-rtVRjqGvgBhwA4b+syTqFDn5i2hs2_97bMO6zEQ@...278...>
From: richard -rw- weinberger <richard.weinberger@...277...>
Subject: Re: [Openvpn-devel] Windows 8 issue: TUN/TAP adapter does not start
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: david@...1834...

On Wed, Jul 10, 2013 at 2:25 PM, richard -rw- weinberger
<richard.weinberger@...277...> wrote:
> Hi!
>
> I'm facing a strange issue on Windows 8.
> It happens very often that the TUN/TAP adapter is not started and
> OpenVPN is unable to setup IPs and routes.
>
> openvpn.exe writes over and over "Waiting for TUN/TAP interface to come up...".
> After ~30 seconds it continues without a proper network configuration.
> This is very nasty because from the users point of few it looks like
> the tunnel is up but nothing works.
>
> On the net I found some halve baked "solutions" for that issue.
> Like disabling the Windows Firewall, disabling IPv6, setting the
> DHCP-Client service to autostart, and so on. But nothing helped so far
> nor really explained the root issue.
>
> Please see the attached log file.
> (It is sightly censored to hide my customers name and public IP.)
>
> I ran also Wireshark on my TUN/TAP device while connecting.
> When facing the issue zero packets were captured. So, it is not really
> a networking issue between server and client.
>
> Can you please help me?

...still facing the issue.
How can I help you with debugging this issue?

BTW: Dear other list members, there is *zero* reason to mail me
privately regarding this issue.
If you see that issue too, post this here and don't send me useless
private mails.

-- 
Thanks,
//richard

