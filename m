From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] Fwd: Re: comp-lzo and licensing issues
In-Reply-To: <3EAD6DC9.7030502@...7...>
Message-ID: <Pine.LNX.4.50.0304281423090.25721-100000@...48...>
References: <20030428142748.GA826@...30...>
 <Pine.LNX.4.50.0304281058060.7360-100000@...48...>
 <3EAD6DC9.7030502@...7...>
MIME-Version: 1.0
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
Date: Mon Apr 28 11:34:09 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: bishop <bishop@...7...>
Cc: Alberto Gonzalez Iniesta <agi@...5...>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>


On Mon, 28 Apr 2003, bishop wrote:

> >> Of course another option here is to consider getting OpenVPN to play nice
> >> with gnutls, though I am not familiary with the maturity of that piece of
> >> software.
>
> Does anyone else here consider this to be entirely the wrong way to go?
I'm not saying this is right or wrong, I'm just throwing out options.

>
> First off, the problem appears to be one that's present in all cases
> where GPL-licensed software is linked with non-GPL-licensed software
> (I'm lazy, and assuming OpenSSL is `BSD).  The OpenSSL people are only
> stating a commonly-overlooked problem that will eventually bite every
> single one of us.
OpenSSL is BSD licensed.

> So, what do we do?  We write an exeption in a GPL-licensed project's
> software license?  That only seems shady on the surface, like one's
> trying to exempt oneself from someone else's licensing - -I'd like to do
> that with MS.  In fact, the only problem is that, soon, maintainers of
> GPL-licensed projects will need to maintain an entire list of
> exemptions, and it may eventually be larger than the GPL boilerplate -
> no mean feat, but as time_t->oo ...

Well one simple solution is not to use liblzo.  We lose some functionality
that could be replaced with the slightly slower but better compressing
zlib.


>
> I think that this is another example of how the GPL1 license is really
> not intended for a world that is not either entirely GPL or entirely
> non-GPL.  It's perhaps meant to eventually edge-out the non-GPL
> licenses, something we'd normally consider a bit more difficult if it
> weren't the much-loved GNU doing it.  The motives are similar to any
> other empire-builder (Oh yes, and please let us remora the name of your
> operating system).
Please lets not have this into a license penis measuring war.  This
doesn't solve anything for the problem at hand.

>
> I would suggest, for our sanity and not for the sake of any freedom we
> require to link with whatever projects we choose, that we do NOT
> consider adding any more GPL-covered projects to this one.  In case we
> run into any more snags, the remaining GPL bits can be pulled more easily.

Just because its not simple, doesn't mean some software authors don't want
to GPL their software.  Personally I think you can make a very strong
argument that on a lot of systems openssl is considered a system library.
The is a rather old discussion that has been brought up various times with
regards to different pieces of software.

>
> Is this an issue that should be Asked of Slashdot?
And this will help us how?  I think maybe somebody should ask a good
lawyer, not /.

Regards,

Aaron

