From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Google summer of code
In-Reply-To: <42A23828.3010709@...411...>
Message-ID: <Pine.LNX.4.58.0506051541490.16160@...41...>
References: <42A1824B.8010106@...277...> <Pine.LNX.4.58.0506041341370.16160@...41...>
 <42A23828.3010709@...411...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Jun  5 15:03:10 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Giancarlo Razzolini <linux-fan@...411...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 4 Jun 2005, Giancarlo Razzolini wrote:

> James Yonan wrote:
> > On Sat, 4 Jun 2005, Pawel Pokrywka wrote:
> > 
> > 
> >>-----BEGIN PGP SIGNED MESSAGE-----
> >>Hash: SHA1
> >>
> >>Hello,
> >>Google organizes contest, see:
> >>
> >>http://code.google.com/summerofcode.html
> > 
> > 
> > Unfortunately, I think we are late :(
> > 
> >   From: Chris DiBona <cdibona@...410...>
> >   To: jim@...41...
> >   Subject: Re: [M#27498536] [Openvpn-devel] Google summer of code (fwd)
> > 
> >   Hi jim,
> > 
> >   You have a terrific project, but I'm sorry to say that we've already
> >   gone well past our limit for projects.
> > 
> >   Chris
> > 
> > 
> >>In short: It is about conntributions to known open source projects. 200
> >>students could get $4500 each, $500 goes to mentor organization.
> >>
> >>I think OpenVPN is mature enough to particate in Summer of Code as
> >>mentor organization.
> >>There are wishlists already on the wiki and there are many things that
> >>could be done as projects sponsored by google.
> >>
> >>In particular, there is one missing feature - and no one is intereseted
> >>in doing it - Windows 9x/ME support in TAP-win32. Programming for old
> >>Windows is not so nice, but maybe $4500 stipend would make it nicer? :-)
> >>I wonder why this feature is not included in wishlists - there are many
> >>requests for it in mailing list archives. It's not true, that this OS
> >>died. Sadly, it lives, especially in enviroments, when XP couldn't be
> >>installed because hardware is so low-end.
> >>Windows 9x support will give significiant adventage: ability to run on
> >>every PC. It could increase OpenVPN position on "VPN-market", because
> >>now many people choose other VPN solutions which are in many places no
> >>so good, but runs on 9x (for example PPTP, criticized for its security,
> >>or IPSEC with comercial 9x clients).
> >>And, though IMHO 9x/ME will live for about 3-5 years, porting TAP-win32
> >>is worth its effort. It will greatly increase OpenVPN user base, which
> >>as you all know, increases number of developers and all blesses of open
> >>source.
> > 
> > I'm a bit worried that this project might never happen because:
> > 
> > (a) Open source developers who are motivated by working on cool, 
> > intellectually stimulating projects may not want to jump into a difficult 
> > project involving an obsolete, unsupported OS.
> > 
> > (b) While I'm sure that someone would step up to the plate if the money 
> > was there, the user base who needs this done is, by definition, 
> > cash-strapped (otherwise they would have upgraded).
> > 
> > If you really must continue to use Win98, why not pay $50 to put an 
> > OpenWRT box between it and the internet?
> > 
> 	Hi for all you developers and contributors to this wonderful project
> which is Openvpn. I would like to give my contribution in this matter.
> Unfortunatelly, i'm not the programmer i'd wanted to be. Time, patience,
> many reasons. But i'm interested in contribute with openvpn in every way
> i can. First, in this matter of a TAP driver for win 9x, i have to say
> that they aren't as dead as everyone might think. In countries that are
> in development or more poor, win 9x are the majority, The complications
> that come with winxp (bugs, worms, etc...) and the hardware that it
> requires are limitation factors for many people in these countries. I do
> live in Brasil, and here, there still are many windowses 9x. I had one
> time to choose IPSEC/L2TP, because one of my clients wanted to use VPN
> with its clients, and many of them had windows 9x. Some of then had
> windows 95. Openvpn doesn't work with them, so i used IPSEC/L2TP. I know
> that there are many implications and complications in programming for
> these os'es, but i think that the result might compensate the effort. So
> i wouldn't see a reason to openvpn not to become "tha facto" industry
> standard, as everyone says that ipsec is.

I would be happy to merge a Win9x port into the OpenVPN tree if someone
makes the effort to do the port.  When you see great open source software
(like the Linux kernel) which has been ported to nearly every platform in
existence, there is a reason for this:  the people who use those platforms
care enough about them that they have collectively made the effort to do
the port, or support those who do.

I think it's no different with OpenVPN + Win9x -- the people who most care 
about this happening need to make it happen.

I have already stated my willingness to help in the effort -- if someone
wants to port OpenVPN to another platform, I will answer any technical
questions they might have to the best of my knowledge.

James


