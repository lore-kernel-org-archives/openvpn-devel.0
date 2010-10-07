From: Jorge Peixoto <jorgepeixoto@...277...>
Date: Thu, 7 Oct 2010 23:27:49 +0000 (UTC)
Message-ID: <loom.20101008T012704-921@...171...>
References: <201008132145.25557.hhund@...194...>
	<201009082232.56460.hhund@...194...>
	<4C87F888.10907@...1400...>
	<201009091113.09853.hhund@...194...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] New openvpn-gui snapshot
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Heiko Hund <hhund <at> astaro.com> writes:

> 
> On Wednesday 08 September 2010 22:56:40 Arne Schwabe wrote:
> >   On 08.09.2010 22:32, Heiko Hund wrote:
> > > On Wednesday 08 September 2010 17:34:28 you wrote:
> > >> We found one problem in the GUI already: if you only have a single
> > >> openvpn config file (foo.ovpn) in your config directory, the gui
> > >> crashes if you double-left-click on the tray icon.  It works if you
> > >> right-click on the tray icon and then click on "connect".  (Heiko can
> > >> reproduce it, so it's fixable  ).
> > > 
> > > I just uploaded a new OpenVPN GUI snapshot to [1]. It should fix the
> > > issues found by Gert. Please report if you run into problems.
> > 
> > Can you build the openvpn gui with the "this application need
> > Adminstrator rights" flag? In our expriences the amount of user
> > questions "vpn does not work" is just too big otherwise.
> 
> I believe this is the wrong approach. A better solution would be not to 
> require any privileges for the GUI at all. The switch to the openvpn 
> management interface for communication was the first step in the transition 
> towards achieving that. In the midterm I envision the Windows service to be 
> enhanced to allow starting OpenVPN on behalf of the GUI. However, I suppose 
> this will take a while to happen. If you need a solution right now the thread 
> at http://www.astaro.org/astaro-gateway-products/vpn-site-site-remote-
> access/32659-ssl-vpn-non-admin-vista-win7.html may be interesting for you.
> 
> @Samuli: is there some time left in the meeting tonight to kick off the 
> discussion on that? If so, I'd like this topic to be added to the agenda.
> 
> Regards
> Heiko

Do you know any OpenVPN GUI implementation which takes this approach
of controlling openvpn.exe daemon through management interface? I have
been playing with openvpn management interface for a while. I wish if there
is a GUI interface which an user, through a mouse click,:
0. Open OpenVPN tunnel
1. List certificates in token/smartcard:
2. Select certificate
3. Type PIN
4. Close tunnel

I have mapped this useful commands respectively:
0. hold release
1. pkcs11-id-count and pkcs11-id-get
2. needstr pkcs11-id-request
3. password
4. signal


