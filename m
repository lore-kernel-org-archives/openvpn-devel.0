Subject: Re: [Openvpn-devel] CVS
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1065844270.27618@...41...>
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
Date: Fri Oct 10 20:52:02 2003
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

I just tried an anon CVS login and I got this:

bash-2.05b$ cvs -d:pserver:anonymous@...116...:/cvsroot/openvpn login
Logging in to :pserver:anonymous@...116...:2401/cvsroot/openvpn
CVS password: 
cvs [login aborted]: unrecognized auth response from cvs.sourceforge.net: M
PserverBackend::PserverBackend() Connect (Connection refused)

I think this is an overloading issue with SF's cvs servers.  They've been
having growing pains with CVS for some time now and I know there are plans to
upgrade the hardware.

In the meantime, the best approach would probably be to start with the beta11
tarball.

James


