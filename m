From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Assertion failed at crypto.c:147
In-Reply-To: <20040910064542.GN1711@...30...>
Message-ID: <Pine.LNX.4.58.0409111013570.23109@...269...>
References: <20040910064542.GN1711@...30...>
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
Date: Sat Sep 11 09:18:04 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...5...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

I've sent a message to the poster to get more info.  This assertion would 
happen if OpenVPN underestimated the maximum amount of cipher/HMAC 
overhead bytes which might be added to a packet.  I've never seen it 
before.

James

On Fri, 10 Sep 2004, Alberto Gonzalez Iniesta wrote:

> Hi all,
> 
> After returning from my holidays, I found the following two [1][2] bug
> reports in the Debian Bug Tracking System. I haven't had this problem
> and the source code says it should never happen :) so any hints would
> be appreciated.
> 
> Thanks,
> 
> Alberto
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=265632
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=270005
> 
> -- 
> Alberto Gonzalez Iniesta   | BOFH excuse #178:
> agi@(agi.as|debian.org)    | short leg on process table
> Encrypted mail preferred   | 
> 
> Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM. 
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

