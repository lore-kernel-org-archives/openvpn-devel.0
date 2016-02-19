References: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
	<56C71B50.4040502@...1227...>
	<CAP=zTkPMdCrhn16pLOmmGCrZ=tbpP=1mwewULove_tXF-QqH6Q@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56C724C7.1020603@...1227...>
Date: Fri, 19 Feb 2016 15:20:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAP=zTkPMdCrhn16pLOmmGCrZ=tbpP=1mwewULove_tXF-QqH6Q@...278...>
Subject: Re: [Openvpn-devel] Enabling TLS Session Resumption in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Shubham Chauhan <shubham13099@...2124...>
Cc: openvpn-devel@lists.sourceforge.net



Am 19.02.16 um 15:00 schrieb Shubham Chauhan:
> Thank you for such a quick reply. 
>
> I agree that VPN sessions and SSL sessions are not necessarily the same.
> Let me be more specific with my question for a better discussion.
>
> In an active OpenVPN session, at regular intervals, a full SSL
> handshake takes place (because the SSL session expires). I checked
> this by capturing packets with "openvpn && ssl" filter.
> In my implementation I don't want those regular full SSL negotiations
> to take place. 
> It should ideally check if the SSL session key or the session context
> is present in the cache (or some storage place), and if it is present,
> then full handshake should NOT take place. Instead an abbreviated
> handshake should take place which happens during TLS session resumption.
> I am looking for changes in the code that can be made to do this task
> (as minimal as possible).
>
> I understand the use of SSL_OP_NO_TICKET by OpenVPN against the triple
> handshake vulnerability, but my project is really specific and wants
> some specific functionality, which includes Session Resumptions.
>
Note that this interval is defined by --reneg-sec and you can disable
them by setting that to 0.

Arne

