From: Matthias Andree <matthias.andree@...68...>
Subject: Re: [Openvpn-devel] OpenVPN Licensing Issues
Message-ID: <20040916190040.GA12175@...33...>
References: <twig.1095190172.87806@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1095190172.87806@...41...>
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
Date: Thu Sep 16 13:00:13 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 14 Sep 2004, James Yonan wrote:

> Therefore, in order for a dual licensing scheme to work, anyone who has ever
> submitted code to the OpenVPN source code would need to agree to the dual
> licensing scheme, since their code might now be potentially licensed under a
> commercial license (in addition to the GPL).
> 
> There are different forms in which this agreement can be legally stated:
> 
> Here is Hans Reiser's version:
> 
> http://namesys.com/legalese.html
> 
> I'd like to invite some discussion on this idea, and I'd especially like
> feedback from past OpenVPN contributors as to whether this is something they
> could agree to.

IANAL, but the copyright system in considerable parts of Europe, among
them Germany, my home country, is fundamentally different from the
Anglo-American system, and I wonder if the Hans's legal agreement,
particularly not having a salvatory clause, is a. valid and b.
enforcable in Germany - and that the rights transfer to Hans is water
tight is of interest to Hans's customer.

German copyright law is centered around the idea of an originator, and
if I'm writing code, I am the originator, and will be, until the end of
time. I cannot reassign my authorship.
(OK, if I'm hired, the employer is officially the originator, but this
involves payments of minimum salaries and, depending on work volume,
social insurance.)

The idea that I am prohibited to sublicence my own contribution for
money is daunting, and I'd think twice before submitting code for use
under such an agreement.

I can see what Hans is aiming at, preventing licenses for proprietary
work that is based on ReiserFS to float around, but Hans's agreement is
unacceptable: suppose I'm writing two modules, all on my own. Module A is a
standalone piece of code with a certain function but which can be sold
to a project outside ReiserFS; Module B interfaces Module A to ReiserFS.

The agreement would mean I can either

- contribute _my_ Module A to ReiserFS, agree not to make money out of
  it unless I'm willing to not sublicense under different licenses than
  GPL and whatever other perpetual license or copyleft license Hans uses,

or

- sell it on my own, without adding to ReiserFS.

How the heck is that going to work?

What this means for OpenVPN:

1. I retain authorship in my code no matter how often I write (C) James
   Yonan in the code

2. I can certainly license the code with a perpetual right to
   sublicense, but for an _exclusive_ transfer of right to duplicate and
   relicense conditions would have to be different than Hans Reiser's.

I have reassigned exclusive copyright once in my life, with bad
experiences, and I'd have to be paid some larger sum to ever do that
again.

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)

