From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] Re: Interface with GUI agent
References: <40E18559.8020407@...244...> <200407082328.32017.vda@...216...> <Pine.LNX.4.60.0407082318240.6520@...210...>
In-Reply-To: <Pine.LNX.4.60.0407082318240.6520@...210...>
MIME-Version: 1.0
Message-Id: <200407090123.51480.vda@...216...>
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
Date: Thu Jul  8 15:25:10 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net

On Friday 09 July 2004 00:35, Mathias Sundman wrote:
> > What I am trying to say? I am very happy that you guys are actively
> > working on openvpn. Really.
> >
> > Just please do not OVERdesign it.
> >
> > Maybe it's better to try to port daemontools to Windows
> > and run openvpn daemon(s) under it.
>
> I agree that we must watch out so we don't overdesign it. It's easily
> done. However, one thing to keep in mind is that we're not talking about
> adding complexity to the openvpn binary (except for an interface to get
> status information), and we're not talking about removing current
> functionallity.
>
> Which means that it will still be perfectly possible to run openvpn just
> like we have always done from the cmd-line or from the init-scripts, and I
> think this will continue to be the most-used method on unix platforms.
>
> Windows users on the other hand tends to want automatic graphical
> installation packages and a nice gui to click on, and get afraid if they
> need to edit a textfile! So we need to keep the whole chain from
> installation to operating really simple.
>
> Do you think we can achive this using deamon tools?

IMHO daemontools for windows, if ported, can handle quite a variety
of different setups, including one needed by openvpn. Then you can
install it as part of openvpn install.
--
vda


