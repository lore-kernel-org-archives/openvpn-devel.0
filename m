Message-ID: <4BFB8D77.4050501@...1114...>
Date: Tue, 25 May 2010 10:42:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BF63BBE.4030603@...515...>
In-Reply-To: <4BF63BBE.4030603@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (20th May 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/05/10 09:52, Samuli Seppänen wrote:
> Hi,
> 
> Here's the summary of the previous community meeting.
> 
> ---
> 
> COMMUNITY MEETING
> 
> Place: #openvpn-devel on irc.freenode.net
> Date: Thursday, 20th May 2010
> Time: 18:00 UTC
> 
> Planned meeting topics for this meeting were on this page:
> 
> <https://community.openvpn.net/openvpn/wiki/Topics-2010-05-20>
> 
> Next meeting next week, same place, same time. Your local meeting time
> is easy to check from services such as
> 
> <http://www.timeanddate.com/worldclock>
> 
> or with
> 
> $ date -u
> 
> 
> SUMMARY
> 
> Discussed the possibility of users offering bounties for development
> tasks (e.g. adding features or fixing bugs). Agreed that having a bounty
> system would be a good idea. The ideas brought up in the IRC discussion
> before and during the meeting are here:
> 
> <https://community.openvpn.net/openvpn/wiki/Topics-2010-05-20#Developerbounties>

I've been thinking about the license issues for a while ... and I'm
wondering if this should be discussed with someone who knows law and
Open Source licenses, as IANAL.

<disclaimer>
   It is not easy to debate licenses, as they can quickly evolve into
   religious wars.  I have no intention to either start or feed such
   a disagreement or debate.  This is a reflection of how I see things
   in OpenVPN's perspective, and that perspective only.
</disclaimer>

Something which makes me wonder ...

* Developer would have to use the BSD license for the bounty features
  o This would allow the project to relicense the code under GPLv2
    (while mentioning the original author)

Does this mean that we can take the BSD contributed code and publish it
as GPL in OpenVPN?  Just like that (while maintaining the original
author)?  If so, what is the point of enforcing BSD on the contribution?
 As OpenVPN is GPLv2 licensed, we need to provide the source code.

  o This would allow both developer (payee) and payer to use the code
    any way they wish

Is it likely that someone who pays for a feature to be included into
OpenVPN - and then would do something extra "magic" with it, throw out
the original patch and replace it with their changes?  They can anyway
not distribute this software unless providing the source code with these
changes.

You can argue that it's a company specific change and that the software
is not distributed - but the employees in that company do get this
software somehow - most often as verbatim copy, and these employees can
then internally request the source code according to the GPL license.
Since the GPL is so restrictive, this modified source code cannot be
distributed (even though internally) with even an NDA.  In the moment
you copy this change from one place to another place, it is technically
speaking a form of distribution.

In this context a BSD license does not make sense to me.  OpenVPN is
GPLed, and any modifications done to OpenVPN needs to be shared and to
be made available in source code format on request.


Personally, I would also not enforce BSD as the only license for
bounties.  We need to provide at least a choice, at least between GPL
and BSD.

I would not consider to license my contributions to OpenVPN as BSD,
because a) I want other people to be able to review my code at any
point, no matter the circumstances the code is used, and b) If someone
modifies/improves the code, I want these changes to be shared with the
community.  GPL gives that possibility.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkv7jXUACgkQDC186MBRfrpCoQCeMgQnLAcFJnFDFTbpepKeUDkm
qcAAn1ex3wxMyfihEFJEmJIEjfYaSd8K
=9awe
-----END PGP SIGNATURE-----

