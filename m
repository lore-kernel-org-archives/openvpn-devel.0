From: Dirk Tronienne <daniel@...297...>
Message-ID: <loom.20041021T203059-948@...171...>
References: <loom.20041020T155229-690@...171...> <pan.2004.10.20.14.37.12.570340@...294...> <loom.20041021T090420-337@...171...> <pan.2004.10.21.15.26.37.612170@...294...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: compile statically with LZO and SSL support?
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
Date: Thu Oct 21 11:35:23 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Charles Duffy <cduffy <at> spamcop.net> writes:

> 
> Instead of adding /usr/lib/liblzo.a, you should *replace* the -llzo with
> it. Also, according to the error (the other two messages were warnings),
> you need access to the dynamic linker (-ldl or /usr/lib/libdl.a on my
> system) so the OpenSSL libraries can access getservbyname() at runtime.
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> 

Thanks a lot! 

It worked, I got my openvpn binary with lzo and openssl up and running. I added
the following in the Makefile: 
"LDADD= -static /usr/lib/liblzo.a /usr/lib/libcrypto.a \
/usr/lib/libssl.a /usr/lib/libdl.a /usr/lib/libc.a"

> Instead of adding /usr/lib/liblzo.a, you should *replace* the -llzo with
That "-llzo" was somewhere else in the Makefile. Again thank you very much
for your help! 

Dirk




