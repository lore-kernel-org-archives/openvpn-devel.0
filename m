Subject: Re: [Openvpn-devel] Daemon as non-root, high priority
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1076036683.40711@...41...>
In-Reply-To: <bvu60k$bpq$1@...165...>
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
Date: Thu Feb  5 19:07:28 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ian Pilcher <i.pilcher@...164...>, openvpn-devel@lists.sourceforge.net

Ian Pilcher <i.pilcher@...164...> said:

> I would like to put together a patch that will allow the openvpn daemon
> to run with elevated priority as a non-root user.  This currently
> doesn't work, because the daemon changes its UID before it renices
> itself.
> 
> Questions:
> 
>    * Are there any "philosophical" objections to this that would prevent
>      such a patch from being accepted?

The philosophy has always been to do as much as possible before losing root,
so that privilege downgrades are practical.

>    * Any gotchas?  From my brief look at openvpn.c, it seems pretty
>      simple.

Probably not.  Looking at the code, I think the nice call is where it is,
rather than a few lines up (to put it before the UID/GID downgrade), because
we wanted it to happen after work thread creation.  But quite honestly, I
don't really see why it's important that this be the case.  The only thing you
really gain by this approach is that the work thread doesn't inherit the
priority from the main thread, meaning that the work thread can set priority
independently.  But I would agree that being able to raise the main thread
priority in conjunction with a UID/GID downgrade is a more important capability.

So I would agree with you that we should relocate the nice call to before
UID/GID downgrade.

James


