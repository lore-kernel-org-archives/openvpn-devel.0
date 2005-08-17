From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] portable pkitool shell script
Message-ID: <20050817175118.GA30248@...33...>
References: <Pine.LNX.4.58.0508161354420.10152@...41...> <ddtt8m$41j$1@...165...> <Pine.LNX.4.58.0508170649000.15439@...41...> <20050817171707.GA39058@...440...>
Mime-Version: 1.0
In-Reply-To: <20050817171707.GA39058@...440...>
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
Date: Wed Aug 17 10:53:16 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 17 Aug 2005, Johnny C. Lam wrote:

>     (3) Solaris /bin/sh fix: don't set and export in one command;
> 	rather, export all the variables after setting them.
> 
>     (4) Solaris /bin/sh fix: "if ! cmd ; then ... fi" isn't understood,
> 	so change it to "if cmd; then :; else ... fi".

These are no "fixes", but workarounds for a truly rotten and unusable
/bin/sh on Solaris. Sun should have replaced /bin/sh by something POSIX
compliant by now...

Solaris however ships with a decent shell, namely /usr/xpg4/bin/sh, also
known as /usr/bin/ksh.

The XPG4 manual page on Solaris suggests putting /usr/xpg4/bin and
/usr/ccs/bin up front in the path, and that is what Solaris systems
should do. Solaris' XPG4 sh and ksh understand both "export VAR=value"
and "if ! cmd1 ; then cmd2 ; fi", here are my tests (Solaris 8 SPARC):

SHELL=/usr/xpg4/bin/sh
$SHELL -c 'if ! false ; then echo true ; fi'
$SHELL -c 'export A=test ; echo $A'

Both tests pass, and both fail with SHELL=/bin/sh.

We can lift auto* magic to get this working on Solaris from bogofilter
if desired for #! lines.

-- 
Matthias Andree

