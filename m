From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] Openvpn for RH62 - eek!
Message-ID: <20030502092546.GA984@...30...>
References: <3EB1726A.4000700@...7...> <200305020432.h424WN105246@...41...>
Mime-Version: 1.0
In-Reply-To: <200305020432.h424WN105246@...41...>
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
Date: Fri May  2 02:26:16 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

IMHO init scripts must be POSIX (Bourne?) compliant. 
They should work in bash, ksh, whateversh, and don't depend on the
administrator's will to install one or another.

i.e.
I'll say this:
	if [ $errors == 1 ]; then
is better this way:
	if [ $errors -eq 1 ]; then


And this:
	# can't detect error...
	#if [ $? != 0 ]; then
	#  errors=1
	#fi
is better this way:
	# can't detect error...
	#if [ $? -ne 0 ]; then
	#  errors=1
	#fi

Anyway, I'm attaching Debian's init.d script in case you want to take a
look at it.

Regards,

Alberto

On Fri, May 02, 2003 at 04:32:23AM -0000, James Yonan wrote:
> How do most other initialization scripts handle the differences between bash 1
> and 2?  Do they just restrict themselves to the least common denominator (a)?
> 
> Or do they try to explicitly instantiate bash2 (b)?
> 
> -#!/bin/sh
> +#!/bin/bash2
> 
> (b) could be risky if there are distros where where /bin/bash2 is not present.
> 
> I would lean towards (a) if trivial changes in the script can make it both
> bash1 and bash2 compliant.  If that is not the case, and we think that we have
> a reliable, distro-independent method to instantiate bash2, then I would favor
> (b).
> 
> What does the patch look like for (a)?
> 
> James
> 
> bishop <bishop@...7...> said:
> 
> > James, Folks,
> > 
> > I noticed a minor problem as my RH62 box started up:
> > 
> > > $Starting openvpn: /etc/rc.d/init.d/openvpn: [: ==: binary operator expected
> > 
> > That's two distinct, common errors:
> >   - $localization stuff that doesn't work on bash1
> >   - an == in a [] in the script.
> > 


-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@(agi.as|debian.org)        | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

