From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Compile OpenVPN for windows
In-Reply-To: <loom.20050302T225201-105@...171...>
Message-ID: <Pine.LNX.4.61.0503031231090.19911@...210...>
References: <loom.20050302T225201-105@...171...>
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
Date: Thu Mar  3 03:42:05 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: ullrich dittmer <ullrichdittmer@...360...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 2 Mar 2005, ullrich dittmer wrote:

> i'd like to compile a openvpn for Windows. Is there any howto, which discribes
> the steps for compiling?

Check the bottom ofinstall-win32 at openvpn.net and read makefile.w32 in 
the source package.

> I've installed MinGW, compiled lzo and OpenSSL. When a do a ./configure occurs
> an error that socket_len has no equivalent. Can you help me?

Don't use ./configure in MinGW, use make -f makefile.w32 instead.

If you run into problems, this thead might give you some hints.

http://openvpn.se/bb/viewtopic.php?t=95

/Mathias

