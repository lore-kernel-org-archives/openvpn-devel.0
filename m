From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] Opened file descriptors in script calls
In-Reply-To: <20030210103449.GH4850@...30...>
Message-ID: <Pine.LNX.4.50.0302101550090.32300-100000@...48...>
References: <200302080347.h183lrf20924@...41...>
 <Pine.LNX.4.50.0302091959100.10985-100000@...48...>
 <20030210103449.GH4850@...30...>
MIME-Version: 1.0
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
Date: Mon Feb 10 12:52:04 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...5...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 10 Feb 2003, Alberto Gonzalez Iniesta wrote:

>
> Hi,
>
> Again, I'm no C hacker, but I think this should be better:
>
> for(x = 3; x < 100; x++)
>
> Since the first 3 fds (stdin, stdout and stderr) should be kept open.
>
Wasn't sure if stdin, stdout and stderr needed to be left open or not in
this case.  Obviously this is an easy fix :)

Regards,

Aaron

