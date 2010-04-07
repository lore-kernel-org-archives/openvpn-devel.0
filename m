In-Reply-To: <201004070959.09215.hhund@...194...>
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>
	<201004070959.09215.hhund@...194...>
Message-ID: <OF83959B35.6804C8B1-ONC12576FE.0041E6AD-C12576FE.00424FE8@...1343...>
From: Johan Ymerson <johan.ymerson@...1342...>
Date: Wed, 7 Apr 2010 14:04:18 +0200
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net



"Heiko Hund" <hhund@...194...> wrote on 2010-04-07 09:59:08:
>
> Hi,
> On Tuesday 06 April 2010 22:36:31 Johan Ymerson wrote:
> > I have tested on 3 PC's with Windows XP, all 3 show the same problem, at
> > almost 100% of my connection attempts. OpenVPN 2.0.9 does not have this
> > issue (ie. reverting back to 2.0.9 on the same machines with the same
> > config never show the problem).
> We also tried 2.0.9 but were able to reproduce the bug with it as well, so it
> has nothing to do with the openvpn driver version involved. I came to the
> conclusion that it's rather some kind of race condition in the Windows XP DNS
> resolver. At least I haven't seen this problem on Vista or 7 personally.

Then I don't think we see the same problem. We have been using 2.0.9 on ~100 machines for a couple of years now without these problems. We upgraded 3 of them to 2.1.1, and they all instantly got this problem. We downgraded them to 2.0.9, and all problems gone. Then started switching between 2.0.9
and 2.1_rcX to determine when this problem started, but all 2.1_rcX seems to suffer from it, but 2.0.9 does _not_! So something must have changed between 2.0.9 and 2.1 that at least makes this a lot worse.

/Johan


