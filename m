Message-ID: <51DC0505.7010301@...1435...>
Date: Tue, 9 Jul 2013 14:41:41 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <kr8jgd$3v7$1@...1062...>
	<03e201ce7bc8$f4c63870$de52a950$@polarssl.org>
	<51DAAB0F.3030006@...1833...> <51DAB3E5.2030602@...1833...>
	<005001ce7c84$020348a0$0609d9e0$@polarssl.org>
In-Reply-To: <005001ce7c84$020348a0$0609d9e0$@polarssl.org>
Subject: Re: [Openvpn-devel] OpenVPN Connect on Android fails to connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 07/09/2013 11:09 AM, p.j.bakker@...1543... wrote:
> Yeah!
> 
> -82 is: POLARSSL_ERR_NET_WANT_READ
> 
> It means that somewhere in the code, OpenVPN calls a read() or a write() and
> seems to not handle the return value properly.

I've peaked into the code, but in all cases where ssl_read() or
ssl_write() is called, there is checked for a POLARSSL_ERR_NET_WANT_READ
of POLARSSL_ERR_NET_WANT_WRITE return value. In those cases, no error is
returned and a read or write will be retried later on, but the polarssl
debugging output will still be printed. It could very well be that this
is not the actual issue.

Peter, do you perhaps have full, possibly redacted, logs available?

-Steffan


