From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] When the link used for openvpn goes down, the
 daemon hangs
In-Reply-To: <20041102173519.GD1542@...30...>
Message-ID: <Pine.LNX.4.58.0411031221430.17216@...41...>
References: <20041102173519.GD1542@...30...>
MIME-Version: 1.0
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
Date: Wed Nov  3 11:30:05 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Tue, 2 Nov 2004, Alberto Gonzalez Iniesta wrote:

> Hi again,
> 
> Another bug report received in the Debian BTS [1]. Quoting:
> |when the link which was used for openvpn transport goes down, it hangs
> |in a D state
> |
> |root      2037  0.0  0.2  3376 1620 pts/1    D    10:45   0:04 openvpn
> |
> |and there is no way to kill it, I have to reboot. Other programs (eg.
> |wavemon) can handle this situation more sanely.

Any idea how to reproduce it?

OpenVPN normally has no problem with intermittent links.

James


