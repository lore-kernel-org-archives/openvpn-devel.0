Message-ID: <4BBC71F6.7040802@...1147...>
Date: Wed, 07 Apr 2010 13:52:22 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>
	<201004070959.09215.hhund@...194...>
In-Reply-To: <201004070959.09215.hhund@...194...>
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net

Heiko Hund wrote:
>
> Hi,
>
> On Tuesday 06 April 2010 22:36:31 Johan Ymerson wrote:
> > I have tested on 3 PC's with Windows XP, all 3 show the same 
> problem, at
> > almost 100% of my connection attempts. OpenVPN 2.0.9 does not have this
> > issue (ie. reverting back to 2.0.9 on the same machines with the same
> > config never show the problem).
>
> We also tried 2.0.9 but were able to reproduce the bug with it as 
> well, so it
> has nothing to do with the openvpn driver version involved. I came to the
> conclusion that it's rather some kind of race condition in the Windows 
> XP DNS
> resolver. At least I haven't seen this problem on Vista or 7 personally.
>  
> > Is this problem known, and is someone working on it?
> > I can of course help debugging this, but I don't have the development
> > environment needed to compile the Windows binaries.
>
> Not much to debug anyway. The DNS servers get passed correctly via 
> DHCP and
> Windows actually takes notice of them as they show up in `ipconfig /all`.
> Problem is that XP resolver somehow forgets to reprioritize the DNS 
> servers
> list after an DHCP update sometimes and sticks with the old preferred 
> name
> server until the scheduled reprioritization. At least that's my personal
> conclusion. And it would explain why a /renew fixes it.
>
> We've contacted Microsoft tech support about this issue. If anything 
> like a
> fix comes out of that I'll post an update here. If not we'll have to 
> consider
> a workaround of some kind, but let's wait with that discussion until 
> we're
> sure it's not fixable the right way.
>
isn't
  ipconfig /flushdns
or
  net stop dnscache
  net start dnscache
enough? This might be related to
 http://support.microsoft.com/kb/311218

I've recommended to people on the -users list to use an 'up' script with
  net stop dnscache
  net start dnscache
this has worked in 99% of the cases.

cheers,

JJK


