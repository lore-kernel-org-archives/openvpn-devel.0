From: Denis Vlasenko <vda@...216...>
Subject: Re: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke scripts were broken
References: <40E18559.8020407@...244...> <200407040154.49974.vda@...216...> <40E75F4E.6030901@...83...>
In-Reply-To: <40E75F4E.6030901@...83...>
MIME-Version: 1.0
Message-Id: <200407041232.59822.vda@...216...>
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
Date: Sun Jul  4 02:34:02 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Jan Kiszka <jan.kiszka@...83...>
Cc: openvpn-devel@lists.sourceforge.net

On Sunday 04 July 2004 04:37, Jan Kiszka wrote:
> >>Thinking ahead, the challenge/response sequence for passing
> >> authentication info should be open-ended to provide for future
> >> implementation of alternative authentication methods such as Radius,
> >> LDAP, NT Auth, etc.
> >
> > Please don't do too much of that. I've seen this auth featuritis creeping
> > in ntp and ups tools(!). Results ain't pretty...
> >
> > Reconfiguration of openvpn can always be done by editing config file
> > and restarting openvpn daemon. Simple. Elegant. No additional coding
> > - no risk of introducing bugs.
> >
> > This can be done via systray app, too.
>
> I can understand your concerns, and mostly you are right. However, there
> is one quite important scenario - at least as I see it - where you need
> the core daemon and the GUI running in different accounts: whenever the
> key or secret has to be looked away from the user while it shall still
> be possible for her/him to start/stop VPN connections. One reason for

Easy. openvpn shall start in admin account, then read the key,
and *then* change its uid to the uid killable by user.
--
vda


