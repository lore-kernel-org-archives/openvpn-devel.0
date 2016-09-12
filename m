MIME-Version: 1.0
From: Steffan Karger <steffan@...1856...>
Date: Mon, 12 Sep 2016 14:31:23 +0200
Message-ID: <CAA1Abx+EMAz=fTF26NyAZJE3de8BLoAXsa2nHyhjjoXnYk8=ag@...278...>
Subject: [Openvpn-devel] RFC: Pushable options and sigusr1 restarts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,

OpenVPN (2.x) currently caches pushed options across sigusr1 restarts.
This 'allowes' a server admin to push some options that the code can't
really handle, until the client times out and performs a sigusr1
restart.  The client will then execute a number of initialisation
routines that might (or might not, depending op the option?) now
process the pushed option successfully.

This results is surprising behaviour, as discussed in trac #128 and on
the openvpn-devel mailinglist (Message-ID:
<326b8ff7-39a6-1974-c0b0-82fd2abdc7b7@...277...>).

I'd like to get rid of this behaviour, by restoring the original
options on a sigusr1 restart.  Imho, options should either be pushable
and implemented properly (without needing a sigusr1 restart at the
client side) or not pushable at all.  This code is however from well
before I got involved into OpenVPN. So what I'm wondering about though
is:

Does anyone think this behaviour is intended and/or does anyone rely
on this behaviour?

-Steffan

