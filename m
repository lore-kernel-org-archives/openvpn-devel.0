From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] client-up/client-down scripts (Linux)
In-Reply-To: <20050524105922.85017.qmail@...404...>
Message-ID: <Pine.LNX.4.58.0505241056390.3503@...41...>
References: <20050524105922.85017.qmail@...404...>
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
Date: Tue May 24 10:21:20 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jesse Adelman <someone@...402...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 24 May 2005, Jesse Adelman wrote:

> Hi, good OpenVPN devs. I don't really hope to have these simple scripts
> integrated into the contrib/ directory in their current form, but I
> thought I'd get the ball rolling for others who are more adept than me
> to perhaps build on them. Should work for any GNU/Linux system with a
> standard /etc/resolv.conf, and an OpenVPN server "push"ing down dhcp
> DNS options.
> 
> They work very well for me so far, but, YMMV, of course. client.down
> won't work unless OpenVPN is running as root, the user OpenVPN is
> running under has rights to run the script and to write to
> /etc/resolv.conf, or you use the down-root plugin in the plugin/
> directory in the OpenVPN source tarball (haven't tried this yet).
> 
> Thanks to "UNIX Power Tools (O'Reilly)", "Learning the Bash Shell
> (O'Reilly)" and #bash on Freenode for the assistance.
> 
> I assign the copyright over to OpenVPN, and releasing these under GPL
> v2. I'm sure v3 is great, but I haven't read it yet ;). I'll be glad to
> help with bugfixing, as time permits.

Jesse,

Thanks for the scripts -- people have asked for these.

You might want to put some sort of "what this does" comment in -- e.g. 
this script will allow a Linux/Unix OpenVPN client to pull DNS server info 
from an OpenVPN server, automatically editing /etc/resolv.conf.

James


