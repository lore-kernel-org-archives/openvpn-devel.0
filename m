Message-Id: <200302080347.h183lrf20924@...41...>
Subject: Re: [Openvpn-devel] Opened file descriptors in script calls
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030206111436.GA8606@...30...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Feb  7 19:49:02 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>, openvpn-devel@lists.sourceforge.net

Alberto,

Yes, I agree.  The child process that executes a script doesn't need those
file descriptors, so they can be closed.  Since openvpn uses the system()
function to run scripts, and because the system() function doesn't close any
file descriptors on its own, it would be necessary to write an alternate
version of the function (unless it already exists somewhere) which closes the
file descriptors between the fork and the execve calls.

James

Alberto Gonzalez Iniesta <agi@...64...> said:

> Hi,
> 
> I got another bug report on Debian's openvpn package. It states that
> openvpn's file descriptors are kept open while scripts are called. It
> claims they should be closed. My C knowledge is far from make a patch
> for this one :) And maybe you don't agree with this (James?).
> 
> You can see the report here:
> 
> http://bugs.debian.org/179551
> 
> Thanks.
> 
> -- 
> Alberto Gonzalez Iniesta       | They that give up essential liberty
> agi@(agi.as|debian.org)        | to obtain a little temporary safety
> Encrypted mail preferred       | deserve neither liberty nor safety.
> 
> Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




