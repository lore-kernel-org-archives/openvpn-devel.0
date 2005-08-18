From: Johnny Lam <jlam@...438...>
Message-ID: <4303918B.2000205@...438...>
References: <Pine.LNX.4.58.0508161354420.10152@...41...> <ddtt8m$41j$1@...165...> <Pine.LNX.4.58.0508170649000.15439@...41...> <20050817171707.GA39058@...440...> <20050817175118.GA30248@...33...>
Mime-Version: 1.0
In-Reply-To: <20050817175118.GA30248@...33...>
Subject: [Openvpn-devel] Re: portable pkitool shell script
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
Date: Thu Aug 18 12:36:44 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Matthias Andree wrote:
> On Wed, 17 Aug 2005, Johnny C. Lam wrote:
> 
>>    (3) Solaris /bin/sh fix: don't set and export in one command;
>>	rather, export all the variables after setting them.
>>
>>    (4) Solaris /bin/sh fix: "if ! cmd ; then ... fi" isn't understood,
>>	so change it to "if cmd; then :; else ... fi".
> 
> These are no "fixes", but workarounds for a truly rotten and unusable
> /bin/sh on Solaris. Sun should have replaced /bin/sh by something POSIX
> compliant by now...

Working as I do on pkgsrc which supports NetBSD and Solaris (as well as 
several other operating systems), I don't disagree with this sentiment. 
  For larger scripting jobs within pkgsrc, I tend to use a more 
appropriate shell than Solaris' /bin/sh.  However, if you look at the 
patch, you can see that the changes are extremely minor to get pkitool 
to work with the stock /bin/sh on Solaris, which is still a popular Unix 
platform, and I think that the benefit is quite worthwhile of not 
needing some configure script magic to detect the operating system and 
select an appropriate shell.

	Cheers,

	-- Johnny Lam <jlam@...438...>


