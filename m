Message-ID: <411111B9.2000405@...259...>
From: Tomasz Chmielewski <mangoo@...259...>
MIME-Version: 1.0
Subject: [Openvpn-devel] compiling statically - how?
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
Date: Wed Aug  4 09:42:10 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

OpenVPN is a great tool, however, whenever I persuade someone to using 
it, I'm having problems with installing it.

For example, one server is Debian 3.0, second RedHat 7.3, I compiled the 
binary somewhere else, and the effect is, it will only work on my 
machine, and not on Debian or Redhat, as OpenSSL libraries differ and so on.

So my big question is: can OpenVPN be compiled statically? If so, how?

I was thinking of an option like ./configure --compile-statically - and 
with such compiled binary, I wouldn't have to install compilers, compile 
OpenVPN, deinstall compilers on every machine I want it to run.


Regards,

Tomasz Chmielewski

----------------------------------------------------------------------
Laczysz sie przez modem? Mamy dla Ciebie bonusy! 
>>> http://link.interia.pl/f1826


