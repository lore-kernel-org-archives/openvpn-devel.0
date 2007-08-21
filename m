Message-ID: <46CB124E.9050400@...41...>
Date: Tue, 21 Aug 2007 10:26:54 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <f6l4sm$vdk$1@...165...>
In-Reply-To: <f6l4sm$vdk$1@...165...>
Subject: Re: [Openvpn-devel] build Openvpn 2.1RC4 on Windows failure (Repost,
 no answer in openvpn.user group.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: John <jknappers-argentia@...160...>
Cc: openvpn-devel@lists.sourceforge.net

John wrote:
> Hi,
>
> I'm reposting this question in openvpn.devel because no one responded in 
> openvpn.user to my question.
> If the build procedure has changed between RC1 and RC4, can anybody explain 
> how to build OpenVPN 2.1RC4 on Windows?
> make -f makefile.w32 was the the way that worked until RC1...
>
> Thanx in advance,
> John
>
> I'm trying to build Openvpn-2.1RC4 on Windows and it failed.
>
> C:\msys\1.0\src\openvpn-2.1_rc4>make -f makefile.w32
> gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -I/c/msys
> /1.0/src/openssl-0.9.7l/include -I/c/msys/1.0/src/lzo-2.02/include -c
> base64.c -
> o base64.o
> In file included from base64.c:35:
> config-win32.h:38:27: autodefs/defs.h: No such file or directory
> make: *** [base64.o] Error 1
>
>   

[ more stuff deleted ]

John,

Yes, there have been some changes in the Windows build procedure for the 
2.1 beta series. 

The ./domake-win script is now used to build OpenVPN on Windows (in the 
MinGW/MSYS environment).   This approach has a number of advantages, 
including the ability to build a signed Windows installer from source in 
a single step, and the consolidation of build-level configuration 
parameters in a single file: install-win32/settings.in

Changes such as these that are of interest to developers are always 
documented first in the subversion commit logs (use "svn log" to see them).

James


