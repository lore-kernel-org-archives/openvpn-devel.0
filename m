Message-Id: <200305020432.h424WN105246@...41...>
Subject: Re: [Openvpn-devel] Openvpn for RH62 - eek!
From: "James Yonan" <jim@...41...>
In-Reply-To: <3EB1726A.4000700@...7...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu May  1 21:36:03 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: bishop <bishop@...7...>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

How do most other initialization scripts handle the differences between bash 1
and 2?  Do they just restrict themselves to the least common denominator (a)?

Or do they try to explicitly instantiate bash2 (b)?

-#!/bin/sh
+#!/bin/bash2

(b) could be risky if there are distros where where /bin/bash2 is not present.

I would lean towards (a) if trivial changes in the script can make it both
bash1 and bash2 compliant.  If that is not the case, and we think that we have
a reliable, distro-independent method to instantiate bash2, then I would favor
(b).

What does the patch look like for (a)?

James

bishop <bishop@...7...> said:

> James, Folks,
> 
> I noticed a minor problem as my RH62 box started up:
> 
> > $Starting openvpn: /etc/rc.d/init.d/openvpn: [: ==: binary operator expected
> 
> That's two distinct, common errors:
>   - $localization stuff that doesn't work on bash1
>   - an == in a [] in the script.
> 
> These are both directly related to the fact that the standard bash on 
> RH62 is bash1.  We can fix compatibility in a few ways:
>   - ignore the odd $localization $artefact and make the one change to 
> the init script (as if we did perl -pi -e 's:==:=:' to is) in one place.
> 
> OR
>   - this patch:
> 
> > --- /etc/rc.d/init.d/openvpn~	Sun Apr 27 03:51:51 2003
> > +++ /etc/rc.d/init.d/openvpn	Thu May  1 12:07:50 2003
> > @@ -1,4 +1,4 @@
> > -#!/bin/sh
> > +#!/bin/bash2
> >  #
> >  # openvpn       This shell script takes care of starting and stopping
> >  #               openvpn.
> 
> Super-trivial, but I'm wondering about any possible complications with 
> either approach.  As it is now, we do have a valid bug in that, on RH62, 
> openVPN will not start.
> 
> (I also noticed I can start it multiple times.  This may be another 
> problem - service openvpn start ; service openvpn start ; service 
> openvpn start ; service openvpn start - because it should normally 
> generate a minor gripe message)
> 
> Anyway, whatever the consensus, I can submit a patch.
> 
>   - bish
> 
> -- 
> 	"Every well-bred petty crook knows -- the small concealable
> 	weapons always go to the far left of the place setting."
> 		-- Inara (Morena Baccarin), "Firefly"
> 		   (unaired - into production AFTER fox crushed it)
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




