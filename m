Date: Fri, 9 Apr 2010 14:18:28 -0400 (EDT)
From: R P Herrold <herrold@...43...>
In-Reply-To: <685194187.20100409162718@...449...>
Message-ID: <alpine.LRH.2.00.1004091415590.23080@...1344...>
References: <4BBF0AE8.6090705@...515...> <51530802.20100409143821@...449...>
	<4BBF2E96.80408@...515...> <685194187.20100409162718@...449...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Summary of the IRC meeting (8th Apr 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: TEXT/PLAIN; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 9 Apr 2010, Carsten Kr=FCger wrote:

> Where is the problem?
> Signing could be easily integrated in build process.

umm -- Signing requires unlocking the GnuPG key to get a human=20
set of eyes, and confirmation that all seems to be well into=20
the process

-- an autosigning from a non-protected key cannot sensibly be=20
trusted, particularly with a process that has to run at some=20
point with root access rights

-- Russ herrold

