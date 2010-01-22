MIME-Version: 1.0
In-Reply-To: <4B5900F3.7050206@...1298...>
References: <4B5900F3.7050206@...1298...>
Date: Fri, 22 Jan 2010 07:08:27 +0200
Message-ID: <9e0cf0bf1001212108h751589bdx5ab37b792c4799ec@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] pkcs11 support in openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: John R Pierce <pierce@...1298...>
Cc: Openvpn-devel@lists.sourceforge.net

It uses pkcs11-helper [1].

http://opensc-project.org/pkcs11-helper

On Fri, Jan 22, 2010 at 3:35 AM, John R Pierce <pierce@...1298...> wrote:
> I'm looking at the pkcs11 support in openvpn 2.1...
> does that use the openssl engine_pkcs11 developed by the opensc group, or
> does it directly implement the interface to a pkcs11 driver without going
> through the openssl engine interface ?
>
>
> upon my initial examination of the source, it appears to be the latter ?
>
>
>
> I ask because I've been searching in vain for a sample C program that
> utilizes the engine_pkcs11 so I can better understand how to utilize it.
>
>
>
>
>

