Subject: Re: [Openvpn-devel] CVS
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1066095913.35405@...41...>
In-Reply-To: <E1A80Yw-0000lA-Gb@...110...>
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
Date: Mon Oct 13 19:33:09 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: peter@...115..., openvpn-devel@lists.sourceforge.net

Peter Sandström <peter@...115...> said:

> Hey,
> 
> What's the current status of the CVS tree? I can't login using anonymous
> access.
> 
> I was planning on implementing multiple-connections-to-one-openvpn-instance
> since I need it for a usecase.
> Not beeing able to checkout the source complicates this though :)

I just checked, and it looks like the OpenVPN anonymous CVS is back online,
and the 24 hour delay seems to have vanished.

So these commands should set you up for working on the 1.5 beta series
(branch=EXP15):

cvs -d:pserver:anonymous@...116...:/cvsroot/openvpn login

cvs -z3 -d:pserver:anonymous@...116...:/cvsroot/openvpn co -r EXP15
openvpn

James


