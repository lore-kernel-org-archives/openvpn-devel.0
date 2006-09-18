From: Charles Duffy <cduffy@...294...>
Date: Mon, 18 Sep 2006 14:44:03 -0500
Message-ID: <eemsu7$os3$1@...165...>
References: <450C6060.6060605@...777...>	<9e0cf0bf0609161341n286986d8i4a39a8cab4d59a5c@...278...>	<450C6B2E.9040107@...777...>
	<450E9BD1.9030703@...277...> <450EE9E8.6020000@...777...>
Mime-Version: 1.0
In-Reply-To: <450EE9E8.6020000@...777...>
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] request for input re: OpenVPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Mike Martin wrote:
> It would need to last indefinitely, and be managed by a remote client, 
> using Web Services, with minimal human intervention

A tool such as runit, with some wrappers, can provide the most immediate 
layer of management -- at least with regard to ensuring that the VPN 
stays up when it's expected to, triggering restarts when intended, etc.

> If parameters change over time, messages outlining changes must be 
> passed to the remote client in specific Web Services format. e.g. I f a 
> certificate expires, or is not found because if a change in directory 
> structure,  the remote client must be made aware of the cause of the 
> failure, so steps can be taken to correct it without having to dig down 
> for the information. We may be talking about a large number of 
> connections spread over a huge distributed computing environment, so 
> human intervention may not be an option.

The best solution to that isn't necessarily going to be very specific to 
OpenVPN. My company has a tool we designed and built in-house (actually 
very simple in terms of LOC count) which maintains configuration files 
on servers on customer sites, based off of templates and a tree of data 
representing the server's current and intended state. Writing a 
web-services frontend to the engine as a whole would be child's play, 
and further would provide far more power than trying to build a separate 
API for each individual component being managed. (However, I would be 
very hesitant to write such a frontend which accepted commands or 
updates not passing through the VPN proper, as this would reduce my 
security model's strength to the weaker of the VPN and the control 
channel -- which given the depth of countermeasures protecting the VPN 
[such as a tls-auth key, client and server keys, unprivileged users and 
groups, and the use of a chroot jail] would quite certainly be the latter).

> There may be long periods without traffic. The hold command would likely 
> be used here.

Hmm. Let me try to get a bigger picture.

You have a web service which is used to control a VPN connection. This 
control presumably may include not only starting, stopping and otherwise 
modifying the immediate state of the service but also making 
configuration changes -- which presumably may include modifying keys, 
remote addresses, etc.

Because this control includes being able to remotely start the VPN from 
a halted state, you need to have a control channel which is separate 
from the VPN proper. Because this control channel may need to pass 
sensitive data or commands when the VPN is down, it needs to have 
security characteristics at least as strong as those of the VPN itself.
Because it needs to be able to write to the areas of the drive where 
OpenVPN's configuration data and keys are stored, the process also has 
permissions which allow it to be substantially dangerous if subverted -- 
more such permissions than OpenVPN itself, which is unable to change its 
own configuration.

I'm not entirely sold on the purpose of running both the control channel 
and the VPN as externally accessible services. Certainly, the VPN 
provides more functionality -- but if it's only being used for specific, 
well-defined data streams (which seems to be the case if you can turn it 
on only when you expect data to be passed), why not secure that content 
via the same mechanism you use for the control channel? That way you 
only expose a single route of attack -- rather than two -- and generally 
suffer quite a bit less complexity. If the control channel is 
established via a mechanism such as SSH rather than a web service, quite 
a bit of flexibility is provided there as well (as SSH's ability to run 
arbitrary tunnels, act as a SOCKS proxy, etc. can be leveraged).



If my concerns reflect some misunderstanding of your proposal, 
clarification would be appreciated.


