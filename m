From: "James Yonan" <jim@...41...>
Message-ID: <twig.1075215692.69623@...41...>
In-Reply-To: <Sea2-F37Vz2ce5xOEBW00039f30@...160...>
Subject: [Openvpn-devel] Re: [Openvpn-users] Problem while compiling openvpn
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
Date: Tue Jan 27 07:05:47 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: PremKumar Jayaram <premkumarjayaram@...160...>, openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

PremKumar Jayaram <premkumarjayaram@...160...> said:

> Hello Everybody,
> 
> I need to compile the opnevpn code on windows 2000. Using Win DDK I was able 
> to compile the driver code, but I am not able to compile the openvpn.c and 
> other files. I tired to compile using VC++ 6.0 but there where few header 
> files under openvpn's "sys" folder which was not defined in VC++.
> 
> In build.w32 file header I saw some instructions of compiling the code using 
> MingW compiler. Is the code supposed to be compiled only with MingW or can I 
> do with VC++ compiler also ?

OpenVPN needs the MinGW compiler to build openvpn.exe on Windows.  There would
probably be some porting work involved to get it to build under VC++.  I've
heard reports that VC++ doesn't like GNU or ISO C99 vararg-style macros, which
OpenVPN depends on heavily.

James


