References: <20161102120054.ih572dflb2sisb6d@...30...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6ec0e316-008a-1d77-3140-b411e840ff01@...1227...>
Date: Wed, 2 Nov 2016 13:13:37 +0100
MIME-Version: 1.0
In-Reply-To: <20161102120054.ih572dflb2sisb6d@...30...>
Subject: Re: [Openvpn-devel] Help with bug report
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



Am 02.11.16 um 13:00 schrieb Alberto Gonzalez Iniesta:
> Hi,
>
> I got this bug report [1] on the Debian BTS a long time ago but I
> haven't been able to debug it. Due to its severity it would be nice to
> have it fixed for Stretch. Could anyone take a look at it?
>
> Any suggestions on the best procedure to deal with bugs reported on the
> Debian BTS?
>
I looked at the bug and it seems to boil down to auth-pam in openvpn +
ldap pam in the pam leads to many /dev/urandom being since something in
that call stack opens /dev/urandom but never closes it.

From a first glance it looks like problem is not really in OpenVPN
itself but rather in the pam libraries/pam ldap libraries.

Of course someone could write a workaround to use the new async
authentication that is implemented in 2.4 and fork so that the leaking
of fds does not burden the main openvpn process.

Arne

