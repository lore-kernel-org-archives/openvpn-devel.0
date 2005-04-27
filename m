From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Suggestion - change of config file suffix .conf
 -> .ovpn
In-Reply-To: <loom.20050427T234146-175@...171...>
Message-ID: <Pine.LNX.4.58.0504271948430.31737@...41...>
References: <loom.20050427T234146-175@...171...>
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
Date: Wed Apr 27 19:05:01 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Plamen <cz-plamen@...384...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 27 Apr 2005, Plamen wrote:

> Hi all,
>   thank you for your openvpn 2.0, it is really good work. I am implementing it
> in one company with about 30 users. I have to prepare some scripts to help
> end-users with installation to theirs computers, generate their keys and pack
> keys with proper configuration file into archive. Every user has its own config
> pack with common configuration and its own key set. Users then just copy and
> install openvpn from internet (or our local copy of installation package) and
> then unpack corresponding file with configuration and keys.
>   I've found that I can prepare one config file for all users with one
> exception: Windows end-users need file <config>.ovpn (replace "<config>" with
> any usable name), but linux end users need file <config>.conf. This is not too
> useful, because when I am generating user pack I do not want to know who use
> linux and who use Windows. So - because linux users are more flexible, at first
> I added note into our Installation Manual to change suffix.
>   At second I have to solve my own situation: My computer is 1) ovpn server for
> one peer-to-peer VPN 2) client of this new VPN. What does it mean? I need tu run
> oVPN(1) just during computer starts and keep this tunnel all the time. But then
> I need run oVPN(2) on my request. Well, it needs some small changes in init
> scripts.  But if I need change these scripts, I can change suffix of config
> files to .ovpn and solve problem with different platforms. Second problem I've
> solved by config file attributes - init script checks if file is "executable"
> and run just these files when no config file is sent into script via
> command-line. I do not know if this is the best solution, but at least for me it
> works fine.
>   Sorry for my long mail, but I cannot explain it shorter. My _question_ is:
> Don't you think about just one config file suffix? I think it can help to all
> administrators with mixed linux/windows clients. I can share my solution -
> changed init scripts with described two enhancements. Originals are from debian
> woody (backports). You can think about it and merge the solution into mainstream
> if you'll find it useful. Then I can share my (usually one-line) scripts to
> generate SSL keys, CRL list etc. If you want such scripts into examples section.

The major reason for having both .ovpn and .conf is that Windows and
Linux/BSD/Unix both have fundamentally different notions about how
config files should be named.  In the Windows world, the file extension
denotes the application which handles the file.  In Linux/BSD/Unix, most
daemon configuration files are named .conf, and multiple apps all use the
.conf file extension.  I agree that it might be nice to use a single
extension standard across all platforms, but I would be concerned that
changing things at this late stage would generate too much confusion and
breakage.

Of course, it's pretty trivial to fix this for yourself by editing the
init script to use .ovpn intead of .conf.

James


