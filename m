Message-ID: <4F4BA12E.4080707@...1030...>
Date: Mon, 27 Feb 2012 15:28:46 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4F466205.5020006@...1030...>
	<CAOazyz24mNbDRf0zoCMHrdCsrZui+cgWaETt7AA67qShfs4bGw@...278...>
	<4F4978D2.70706@...1030...>
	<CAOazyz2jCkj2ox9edFap05zze2i5-pW1J9W4ho=jSVhZTUZQFw@...278...>
	<4F4A31E1.2080503@...1030...>
	<CAOazyz1n6Uz3TuSywisO41J=tjNJ94rbq7LUgw5y3b+dR0J8nA@...278...>
	<4F4A4929.6040407@...1030...>
	<CAOazyz1wNQQgxTciUq0uQjfMyDSJqDdpy63LcUpcwXbs3pWsxQ@...278...>
	<4F4A52DB.1040907@...1030...>
	<CAOazyz2SyQjGk9w00KA93tKUyyMMY9iQ3rL=C8X0wpFKFrLZrw@...278...>
	<4F4B584A.30705@...515...>
In-Reply-To: <4F4B584A.30705@...515...>
Subject: Re: [Openvpn-devel] static build
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Mr Dash Four: could you try following the steps Alon gave in his earlier
> mail to see if it works for you? The buildsystem fetches the
> dependencies from standard URLs, see "openvpn-build/generic/build.vars".
>   
Except that they are not "standard", at least not all of them.

The openvpn url in build.vars from Alon's project defaults to 
"https://github.com/downloads/alonbl/openvpn/openvpn-${OPENVPN_VERSION}.tar.gz". 
As evident, the openvpn source refers to 
"openvpn-${OPENVPN_VERSION}.tar.gz" (${OPENVPN_VERSION} itself defaults 
to "2.3_alpha1").

Naturally, one would assume that this is the standard openvpn source 
version 2.3 alpha1, hence I did not use 
"https://github.com/downloads/alonbl" - a private github repository of 
Alon himself (nothing whatsoever to do with openvpn), but opted to 
download  and archive that same openvpn version from the main 
openvpn.net git repository, using the appropriate tag ("v2.3_alpha1"). 
It is worth noting that I did exactly the same with all other source 
dependencies, like lzo, openssh etc (something I have made very clear in 
one of my last posts) and downloaded their corresponding sources from 
"official" repositories directly.

That, I thought, rather naively as it turned out, should get me the 
desired version of openvpn as I assumed that the openvpn source code 
"offered" by Alon and the official one were exactly the same. How wrong 
was I!

The Alon's version of "openvpn 2.3_alpha1" is very different from 
"openvpn 2.3_alpha1" downloaded from the official openvpn git repository 
using the same tag! If you do not believe me - take a look for yourself.

I don't mind Alon (or anybody else for that matter) altering the openvpn 
source code and its structure, because at the end of the day it is an 
open source project, but to give it a name like "openvpn 2.3_alpha1" 
clearly implying that this is the official "openvpn 2.3_alpha1" source 
without explicitly stating that there were alterations/changes made to 
that source code is clearly very misleading and in this respect Alon is 
no better than the scum out there offering "loaded" source code of 
well-known software products to naive idiots like myself, stupid enough 
to download it.

As for the main topic of this thread - static build of openvpn, the 
following is the last gcc command line which links and creates the final 
openvpn executable (again, using the "standard" openvpn source and not 
the mickey-mouse version Alon is "offering") - judge for yourself 
whether this produces a monolithic, statically-linked openvpn executable:

arm-pc-linux-gnueabi-gcc  -g -O2   -o openvpn base64.o buffer.o crypto.o 
dhcp.o error.o event.o fdmisc.o forward.o fragment.o gremlin.o helper.o 
httpdigest.o lladdr.o init.o interval.o list.o lzo.o manage.o mbuf.o 
misc.o mroute.o mss.o mtcp.o mtu.o mudp.o multi.o ntlm.o occ.o pkcs11.o 
openvpn.o options.o otime.o packet_id.o perf.o pf.o ping.o plugin.o 
pool.o proto.o proxy.o ieproxy.o ps.o push.o reliable.o route.o 
schedule.o session_id.o shaper.o sig.o socket.o socks.o ssl.o status.o 
tun.o win32.o cryptoapi.o  memcmp.o -lssl -lcrypto -llzo2

As I already pointed out in my previous post, to produce a proper, 
statically-linked openvpn executable, the following options need to be 
added to the above command line:

"-static", "-static-libgcc" and "-ldl" at the very end, in order to 
avoid "unknown symbol" link errors like:

"undefined reference to `dlopen'", "undefined reference to `dlsym'", 
"undefined reference to `dladdr'" and "undefined reference to `dlerror'".

To conclude this, I am very happy that I was finally able to produce 
openvpn, which is statically-linked so that I could avoid all bionic 
dependencies or depending on any other android-based stuff. Now I can, 
hopefully, use this on my android device without further problems, 
fingers crossed!

