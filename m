Date: Fri, 9 Apr 2010 16:27:18 +0200
From: =?windows-1252?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <685194187.20100409162718@...449...>
In-Reply-To: <4BBF2E96.80408@...515...>
References: <4BBF0AE8.6090705@...515...> <51530802.20100409143821@...449...>
	<4BBF2E96.80408@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (8th Apr 2010)
Reply-To: =?windows-1252?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

> Thanks for the clarifications! The releases will have signed drivers, of
> course. The idea is to use self-signed drivers for the OpenVPN testing
> tree only. These drivers change rapidly, so an easy, non-bureaucratic
> way to sign the drivers is an absolute necessity.

Where is the problem?
Signing could be easily integrated in build process.
If you crosscompile from *nix you need a windows (virtual)machine with
SSHd to fully automate the process.

Only people that compile the drivers themself need test signing.

greetings
Carsten


