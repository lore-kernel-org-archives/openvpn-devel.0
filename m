Date: Thu, 11 Mar 2010 14:44:16 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100311192119.GM25238@...1296...> (from
	gert@...1296... on Thu Mar 11 13:21:19 2010)
Message-Id: <1268340256.5095.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 03/11/2010 01:21:19 PM, Gert Doering wrote:


> This might be the other big misunderstanding here.  As of today, if
> you
> want to use "ifplugd + dhcp + ..." on a TAP interface, just do so -
> OpenVPN
> won't stand in your way.  This is not the issue at hand - the issue=20
> is
> that OpenVPN wants to be friendly to the users, and give them an
> option
> to do DHCP-on-TAP without(!) having to fiddle with their local=20
> network
> setup.

This is not so much a mis-understanding as a big rift in
design approach.  Both sides can be "right", for some
value of right.

On one side we have those who want tight integration and
multi-functionality within a single tool.  The argument
is that then you only ever need to use the 1 tool.
On the other side is the Unix philosophy of having
each tool do one thing well.  The argument is that
once you learn to do "thing", you're done learning
forever until you decide to switch tools.

Frankly I always get stuck bumping up against the
limits of the 'do everything' tools, whether
it's a "framework", a computer language,
or an app like mozilla before firefox
when there was a web browser, an email reader,
a usenet reader and whatever all else bundled
in one program.  To address Gert's point above,
bundling yet more into OpenVPN makes it just
a little bit harder for a new user to figure
out what to ignore to get OpenVPN to do a VPN.
But that's minor.  The more important point
is that the user is much better served learning
how to fiddle with their local network setup
than how to fiddle with OpenVPN because there
is much more opportunity and reason to do the
former.

To re-state this last point, there are good (and bad too
but that's immaterial here) reasons
why Un*x has multiple ways to configure
interfaces and setup dhcp.  OpenVPN
won't be able to replicate all this functionality.

There are exceptions to the one-tool-per-task
rule.  I find I use emacs/readline
quite a bit and make a little bit of extra
effort to plug it into my work flow.  I believe
this makes sense because, in this case, using
a single application leverages "muscle memory".
This kind of argument cannot often be made.

So, the discussion has uncovered a fundamental
rift over whether to help OpenVPN users integrate
OpenVPN into their existing systems or whether
OpenVPN should _be_ the user's system.   Gert is
right, so long as OpenVPN does not interfere with
integration with existing tools then in some sense
the Unix philosophy people shouldn't care.  They
would not be the ones doing the code maintenance.
But it does not save the "Unix people" from having
to do the work they'd otherwise have to do because
there will still be people for whom OpenVPN won't
work who will have to revert to integrating with
the Unix environment.  It will be harder for
those people because they will have to discover
that they have a problem and un-learn what they've
tried and discover the less-often-used approach
that fixes the problem.

"Unix makes easy things hard and hard
things possible."  The corollary is that making
the easy things easier makes the harder things
harder.

James seems to want DHCP integration and
nobody's mind seems to be changing at this
point.  So if somebody steps up to maintain
the DHCP code and docs then that will happen.
Hopefully there's also a place in the documentation
and examples for some of the U*ix side alternatives
if somebody wants to step up and provide those.
I can't help but think that documentation that
points the user to the Un*x tools will be a whole
lot easer to maintain, but at this point it comes
down to people actually doing the work so which
approach works best over time remains to be
discovered.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


