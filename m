Message-ID: <4F479221.40907@...1030...>
Date: Fri, 24 Feb 2012 13:35:29 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4F466205.5020006@...1030...>
	<CAOazyz24mNbDRf0zoCMHrdCsrZui+cgWaETt7AA67qShfs4bGw@...278...>
In-Reply-To: <CAOazyz24mNbDRf0zoCMHrdCsrZui+cgWaETt7AA67qShfs4bGw@...278...>
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
To: openvpn-devel@lists.sourceforge.net


> I am working on a new build system for OpenVPN, you can check it[1] out.
>
> To cross compile master to arm in static, do:
> $ git clone git://github.com/alonbl/openvpn-build.git
> $ cd openvpn-build/generic
> $ CHOST="arm-unknown-linux-gnueabi" CBUILD="x86_64-pc-linux-gnu"
> DO_STATIC=1 ./build
>
> It will create static dependencies, but dynamic libc, if you want
> really static use DO_REALLY_STATIC=1.
>   
Thanks Alon, I'll give it a try.

I'll probably use REALLY_STATIC as well, because, as I already pointed 
out, the libc is bionic and I do not wish to rely on it - I want 
everything openvpn depends on to be included in the binary. I know it 
could be massive in size, but I am prepared to take that hit. I also 
take it I can still run configure with the desired configuration 
options, is that correct?


