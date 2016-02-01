From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 1 Feb 2016 19:41:18 +0100
Message-ID: <42777399.uRlGseOKiX@...2001...>
In-Reply-To: <CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Monday 1 February 2016 11:34:47 Selva Nair wrote:
> (1) the config file should reside in some pre-defined location(s)
> controlled by, say, a registry key that only an admin user can change
> (2) only a limited set of "safe" options may be allowed on the command line

1) can be implemented by only accepting relative filenames for the --config 
parameter and appending it to the config_dir from the registry.
2) has been talked about but we decided that we go with what we have and 
implement improvements when the code has been integarted.

Currently the goal of the service is not so much to prevent a sophisticated 
person from setting routes. It's rather to enable ppl. to use openvpn without 
hacks, while providing a long term safe path of doing so.

> The msg_channel handle is passed on to openvpn.exe as a command line
> option, so it cannot trust it (could be that of a named pipe opened by a
> rogue process). This looks insecure ---- such a pipe server could
> impersonate the user.

Don't get it. Openvpn doesn't send or receive anything critical to/from the 
channel. It is just used to send requests for a set of predefined operations 
that need elevated privileges. If the passer of the channel doesn't have 
elevated rights as well it could fool openvpn to believe that the operation 
was successful while it wasn't. I don't think that's critical.

> A more serious problem is related to the the service requiring connections
> from UI with impersonation allowed. Again, an unprivileged process
> pretending to be the service could escalate privileges if an OpenVPNGUI
> instance running as admin connects to it. This looks easy to exploit.
>
> Possible mitigation:
> (i) The GUI should not connect to the interactive service if running with
> elevated privileges
> (ii) openvpn.exe should not honor the --msg-channel option if running with
> elevated privileges

Yeah. The point is no to run the GUI as admin anymore in the first place. So 
we could just do (ii) and be sure that this is circumvented. This is only 
exploitable when a user can run the GUI as admin anyways, so there's no real 
need for the detour through service and openvpn. So, it's basically a 
safeguard for legacy installations who worked around the route issue by 
granting the GUI higher privileges. Good catch.

> Other comments I have are more specific to code snippets and of minor
> consequence. Will send them after compile/test runs.

Yeah, I'll be in the meeting but probably (too) late.

Cheers
Heiko

