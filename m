Message-ID: <4A6FFF46.7090102@...1114...>
Date: Wed, 29 Jul 2009 09:50:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4A5EFE61.3020100@...41...>	
	<3453b4110907280133n32070ed3rd93598fd1b64740e@...278...>	
	<9e0cf0bf0907280218p25c081f7v203b4780309cb6b9@...278...>	
	<4A6EFCFF.2090400@...1114...>	
	<9e0cf0bf0907280650i3dabf036gc9e2f8c745823e15@...278...>	
	<4A6F05B0.4020602@...1114...>	
	<9e0cf0bf0907280720y45b629d5sd7fe3d2525811280@...278...>	
	<3453b4110907281129x509c2bb1rbbfe4a817765e503@...278...>	
	<4A6F634E.7020202@...1114...>	
	<3453b4110907281422u4284faen6cd632e62f11cdf7@...278...>
	<9e0cf0bf0907282147n3dcdb7f6ue91065cc2d606f72@...278...>
In-Reply-To: <9e0cf0bf0907282147n3dcdb7f6ue91065cc2d606f72@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 29/07/09 06:47, Alon Bar-Lev wrote:
> Well,
> I do not understand you guys.
> 
> If you think SELinux is so great, why do you need chroot?
> It is like you put some money in safe, and then put the safe into
> another safe, it never ends... Why only two safe, let's put another
> safe...
> I know that this is the approach many of security advisors use, but I
> never could have found the logic.
> If you want to keep your money safe use a single safe and select the
> strongest one.

I understand partly your logic.  But unfortunately, this is what most
security crackers hope for.  They look for every possibility to get an
opening into a network or server, to gain root access and enable the box
they got access to for further usage.  To defend yourself from a
possibility of a break in, you need to take all possibilities available
in use.  If not, you are weaker than other solutions, and your setup
will be more attractive to those trying to crack into your server.
This is nothing new, this is how the daily life is.

Sooner or later, OpenVPN will be more attractive in general for being
cracked, when other solutions gets more and more secured.  Sooner or
later, OpenVPN will get the storm.  If we are ahead of that storm by
promoting and recommending all possible security features available,
implementing them, the damage after such a storm might not be as big as
it can be without taking advantage of all security measures available.

And another thing you do not take into consideration, is that in your
argument you take it for granted that OpenVPN do not have any security
related bugs, e.g. a buffer overflow which can be misused by carefully
hand crafted network packages, which is unexpected.  It can even be a
flaw inside OpenSSL (which is also not that uncommon).  With SELinux you
limit much more than what chroot() + setuid() can do alone.  But as I
said earlier, non of these calls exclude any other.

> And final note regarding the iproute wrapper.
> It is a *WRAPPER*, if I needed top secured implementation I would have
> created a daemon listening to network change requests using unix
> domain sockets, wrap this up in SELinux profile, and implementing a
> logic that allows only changes to tap/tun interface with specific
> attributes, and allowing routing table update with specific details.
> Then add a wrapper that uses the unix domain socket in order to access
> the daemon. OpenVPN will use the wrapper so it needs no special
> privilege. The daemon validates what SELinux or any other security
> product cannot validate: Network configuration changes. All done
> within a valid and separate context.

This is actually even a much better idea than a wrapper, seriously!
Wrappers, and especially wrappers with sudo access (or even worse, the
setsuid bit set on the file) are prune to be cracked and misused.

As the matter of fact, I've gotten a flaw demonstrated which managed,
through a overflow bug, to write a nicely crafted crontab entry which
then caused the crond to core dump on execution of that entry.  But when
that happened, you had a setsuid binary in /tmp ... which actually was a
copy of a shell.  But it required SELinux to be either to be disabled or
be in Permissive mode (logging only).

> As I wrote earlier, most of OpenVPN configurations need to execute
> iproute also during session. For example, if you like to connect two
> sites, your super SELinux secured solution will work only at one site.

Yes!  And WITH SELinux, it will still be able to run iproute or whatever
else the configuration requires - in a safer and more controlled regime.
 But it will not only work on one site.  It will work wherever SELinux
is properly configured and implemented.  In fact, it will not even break
the OpenVPN functionality if you run a SELinux enabled OpenVPN on a
kernel without SELinux enabled, you will just miss that extra layer of
security.

Security is not about picking the best solution of several options.
Security is about combining the best of all solutions together.


kind regards,

David Sommerseth


