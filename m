Date: Fri, 9 Apr 2010 22:11:36 +0200
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <529032470.20100409221136@...449...>
In-Reply-To: <alpine.LRH.2.00.1004091415590.23080@...1344...>
References: <4BBF0AE8.6090705@...515...> <51530802.20100409143821@...449...>
	<4BBF2E96.80408@...515...> <685194187.20100409162718@...449...>
	<alpine.LRH.2.00.1004091415590.23080@...1344...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (8th Apr 2010)
Reply-To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hallo,

> umm -- Signing requires unlocking the GnuPG key to get a human
> set of eyes, and confirmation that all seems to be well into 
> the process

Not GPG key but code signing certificate.

The user that starts build process could unlock the key, BUT if the
build machine is not trusted enough to put the key unencrypted in
memory you have other problems.

> -- an autosigning from a non-protected key cannot sensibly be
> trusted, particularly with a process that has to run at some 
> point with root access rights

Why should building drivers need root rights?

greetings
Carsten


