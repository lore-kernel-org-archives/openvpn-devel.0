Message-ID: <4F72EF52.8060301@...515...>
Date: Wed, 28 Mar 2012 14:00:34 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz065tGCsmMkqCy57+jHcBLFCuOTBfbtFaeiQYBg5Ye15w@...278...>
In-Reply-To: <CAOazyz065tGCsmMkqCy57+jHcBLFCuOTBfbtFaeiQYBg5Ye15w@...278...>
Subject: Re: [Openvpn-devel] [DISCUSS] OpenVPN public repositories at
	github.com
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

> A basic ticketing system is also provided, not sure it is that far
> from trac features... not a must.
> It wiki is better than track as people can subscribe for changes,
> hence cooperate much better than current state.
A few years ago, when I started setting up the community services I
discussed the option of using external, hosted services (e.g. SF.net)
internally and our CEO strongly disagreed[*] with that approach. I don't
think anything has changed on that front since... and there are
advantages in the approach we have now, e.g. being able to use the same
authentication backend for all of our random services.

That said, the code itself is hosted externally on SF.net, so we have
the _option_ of using GitHub for that part. I'd first look at the big
picture of how we want to enhance our development processes and then
move on to the tools. I hope to have the review of the ACK system ready
by next Monday, maybe sooner. That'll give us some hard data which we
can use as a basis for further discussion...

[*] As in "We will have the community services on our own servers. Period."

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


