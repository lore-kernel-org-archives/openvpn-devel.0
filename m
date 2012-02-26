Message-ID: <4F4A52DB.1040907@...1030...>
Date: Sun, 26 Feb 2012 15:42:19 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4F466205.5020006@...1030...>	<CAOazyz24mNbDRf0zoCMHrdCsrZui+cgWaETt7AA67qShfs4bGw@...278...>	<4F4978D2.70706@...1030...>	<CAOazyz2jCkj2ox9edFap05zze2i5-pW1J9W4ho=jSVhZTUZQFw@...278...>	<4F4A31E1.2080503@...1030...>	<CAOazyz1n6Uz3TuSywisO41J=tjNJ94rbq7LUgw5y3b+dR0J8nA@...278...>	<4F4A4929.6040407@...1030...>
	<CAOazyz1wNQQgxTciUq0uQjfMyDSJqDdpy63LcUpcwXbs3pWsxQ@...278...>
In-Reply-To: <CAOazyz1wNQQgxTciUq0uQjfMyDSJqDdpy63LcUpcwXbs3pWsxQ@...278...>
Subject: Re: [Openvpn-devel] static build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net


> arm-unknown-linux-gnueabi-objdump:
> image-arm-static/openvpn/sbin/openvpn: Invalid operation
>   
Huh?

Have you altered the sources/makefiles of openvpn or any of the 
dependent libraries (lzo, openssh etc) by any chance? I noticed you are 
applying a single patch to the lzo source, which I had to re-adjust as I 
was using a newer version, but I am not aware of any alterations that 
you have made to these - if you have done so, please state what these 
alterations are?

I don't know whether you've altered the original build script or not, 
but the end result, before applying my changes, clearly produces openvpn 
executable, which has external dependencies on all statically-produced 
.la files/libraries (lzo, openssh etc) - they are all packed in the .tar 
archive produced at the end of this script (located in the /lib 
directory to be more precise).

I don't know what you are trying to prove by posting the above though - 
the final gcc linker call, which produces the openvpn executable before 
packing the image does *not* have any static-linking related options 
whatsoever! I could post the exact gcc command line, but I do not have 
access to that machine at present.

These options are, as I already pointed out previously, "-static", 
"-static-gcc" as well as "-ldl" - the latter being a new dependencies, 
necessary to offset the fact that all dl* calls (dlopen etc) won't be 
satisfied if static linking is invoked, so this external library needs 
to be included so that static linking succeeds, otherwise you will get 
"unknown symbol" errors.

Again, all that is provided you haven't altered any of the core source 
and/or makefile scripts in any way (I haven't used your own - alonbv - 
repos to download these, but downloaded these packages from their 
original source where these projects are created - openvpn.net, 
openssh.org etc). If you have made such alterations, I'd like to know 
what changes have you made?


