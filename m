From: "dave" <dev@...575...>
Date: Mon, 1 Jun 2009 10:02:33 -0500
Message-ID: <71E07DE543304779823588CC51F53E5C@...576...>
MIME-Version: 1.0
In-Reply-To: <20090601125130.GA26473@...1066...>
Subject: Re: [Openvpn-devel] Unable to use -OFB or -CFB ciphers in	OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Victor Wagner' <vitus@...1066...>, openvpn-devel@lists.sourceforge.net

> -----Original Message-----
> From: 'Victor Wagner' [mailto:vitus@...1066...] 
...
> As far as I can see, openvpn can be thoroughly tested in automated
> fashion. I have some test farm with half a hundred various 
> OSes (Linux,
> Windows, Solaris, FreeBSD on several architectures), and planning to 
> do some openvpn testing for this platform anyway. 
> 
> If people would suggest me which things to test, I'll try to implement
> it in the automated test environment.
> 
> 
> > I'm curious as to why you want this support specifically, 
> since these
> > modes aren't really faster than CBC.  Are you concerned about the
> > padding?
> 
> I've stated it clearly. There is no CBC in the Russian 
> National Standard
> for symmetric ciphers. CFB is standartized, CNT is 
> standartized, CBC is
> not. So, if I want my VPNs to be considered secure by goverment
> certification authorites, I have to use CFB or CNT.

Gotcha; sorry for asking a redundant question.  I'm not familiar with
the automated test system, but possibly if you ran that then the devs
would accept the results and enable those ciphers.

Barring admission of the enablement into the official code base, would
it be a bad idea for you to build your version with the support of the
stream versions and use that?  Provided that  you  tests ran fine?

-dave


