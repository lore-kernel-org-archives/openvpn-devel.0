From: James Yonan <jim@...41...>
Subject: Re: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke scripts were broken
References: <40E18559.8020407@...244...> <200407040154.49974.vda@...216...> <40E75F4E.6030901@...83...>
In-Reply-To: <40E75F4E.6030901@...83...>
MIME-Version: 1.0
Message-Id: <200407032016.24981.jim@...41...>
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
Date: Sat Jul  3 17:17:37 2004
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Jan Kiszka <jan.kiszka@...83...>, Denis Vlasenko <vda@...216...>

> >>Thinking ahead, the challenge/response sequence for passing
> >> authentication info should be open-ended to provide for future
> >> implementation of alternative authentication methods such as Radius,
> >> LDAP, NT Auth, etc.
> >
> > Please don't do too much of that. I've seen this auth featuritis creeping
> > in ntp and ups tools(!). Results ain't pretty...

I don't think that supplying a generalized authentication mechanism (that's 
method agnostic) will add very much complexity.

The way I see this working is that the SSL/TLS authentication still provides 
the real security.  But after SSL/TLS authentication has occurred, one still 
might want to submit some sort of credentials string to the server (obtained 
via GUI from the user) to determine the common name which will be assigned to 
the client.  In any case, OpenVPN on the server is probably going to 
interface with an authentication library which will handle all the details.

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
> this may be that the key is bound to the device and not the user. The
> other one is security. Through this separation, malicious programs
> running in the context of the user can not so easily access the secret.
>
> And for those who don't trust this new interface (which will surely need
> a careful implementation): what about adding a configure switch and
> putting the respective code in some #ifdefs?

I agree -- the management interface should not be implicitly enabled by 
default.  You will need to specify the "management" config option to turn it 
on.

James

