MIME-Version: 1.0
In-Reply-To: <20110312153620.8987.qmail@...1287...>
References: <20110308185252.301d0a1d@...1451...>
	<20110309084745.GN9835@...1296...>
	<20110309085656.18e0e796@...1451...> <20110311122309.1292c1dd@...1451...>
	<4D7A7455.4070805@...1114...> <20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
From: Joe Patterson <j.m.patterson@...277...>
Date: Sat, 12 Mar 2011 12:23:20 -0500
Message-ID: <AANLkTikhb8vVs_joR20NEjPyGy=W+4i2rEdVdVrpmYGA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
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
To: openvpn-devel@lists.sourceforge.net

I'm actually kind of curious what reasons there would be that
listening to 0.0.0.0 would be undesireable.  For other daemons, I can
see a rationale because of two reasons, one being that you don't trust
the security of the daemon and want to add interface specificity to
your firewall rules for belt-and-suspenders security.  The other
reason I can think of is if you want to have different configurations
bound to different interfaces, like maybe running squid as a caching
proxy for your internal users but as a load balancing proxy for
inbound connections to a web server, or if you want to have a DNS
server that returns different information based on what IP is being
accessed but don't want to use views.

Neither of these scenarios makes much sense.  If you don't trust the
security of openvpn enough to let it listen on the internet, you
probably shouldn't be using it in the first place.  And while I could
possibly see having one configuration for Internet users connecting
inbound via VPN and maybe internal wireless users using a different
configuration because they understandably don't trust WPA... it's a
stretch.  And I'm pretty sure that if you start one openvpn process
listening on a specific IP, then another listening on 0.0.0.0, it'll
still work, and the second instance will effectively be listening on
every *other* IP from the first.  You'd still have issues if you have
multiple dynamic IP's, but that's getting to be *really* convoluted
and weird.

I'm all for adding flexibility, but this really seems like a solution
to a problem for which there's hardly ever *not* a better work-around.

On Sat, Mar 12, 2011 at 10:36 AM, Peter Stuge <peter@...1287...> wrote:
> Federico Heinz wrote:
>> The reason I looked into this in the first place was that, unlike
>> those TCP-based protocols, I couldn't get OpenVPN to work on a
>> firewall with two external IP addresses without running two deamons,
>> each one bound to one interface only. It is then that I stumbled upon
>> the difficulty of setting up the server that must listen on an
>> interface that has a dynamically-assigned address.
>
> If this is the problem you want to solve I have to say I think you're
> doing it the wrong way.
>
> There are components in your system which *will* know when your
> address is reconfigured. Please just configure them to reconfigure
> OpenVPN. This would seem to be a good use for the management
> interface in OpenVPN.
>
> I like to use udhcpd for systems like this. It is fast and
> no-nonsense. It runs a script that you have to write.
>
> It makes no sense trying to work around the requirement of knowing
> your configuration. That is always neccessary, unless you are
> prepared to listen on 0.0.0.0, which I would guess already works
> without special OpenVPN options or code.
>
>
> //Peter
>
> ------------------------------------------------------------------------------
> Colocation vs. Managed Hosting
> A question and answer guide to determining the best fit
> for your organization - today and in the future.
> http://p.sf.net/sfu/internap-sfd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

