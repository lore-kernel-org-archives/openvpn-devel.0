Message-ID: <20100223122840.9010.qmail@...1287...>
Date: Tue, 23 Feb 2010 13:28:40 +0100
From: Peter Stuge <peter@...1287...>
References: <4B82F647.5050405@...1305...> <4B82FDC9.7000101@...1114...>
	<4B82F647.5050405@...1305...>
MIME-Version: 1.0
In-Reply-To: <4B82FDC9.7000101@...1114...> <4B82F647.5050405@...1305...>
Subject: Re: [Openvpn-devel] segfault issue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

mark wrote:
> -----sys.log: issue------
> .. error 6 in libc-2.10.1.so[b7ef5000+16a000]
> .. error 6 in bash[8048000+d4000]

David Sommerseth wrote:
> Would you mind installing the openvpn-debug package and then run
> openvpn via gdb?

Since the crash is in libc and bash I don't know if openvpn-debug
will help? But gdb backtrace would be interesting. Also strace -o
trace.txt -fF openvpn --config .. could be interesting.


//Peter

