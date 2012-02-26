MIME-Version: 1.0
In-Reply-To: <4F4978D2.70706@...1030...>
References: <4F466205.5020006@...1030...>
	<CAOazyz24mNbDRf0zoCMHrdCsrZui+cgWaETt7AA67qShfs4bGw@...278...>
	<4F4978D2.70706@...1030...>
Date: Sun, 26 Feb 2012 02:33:52 +0200
Message-ID: <CAOazyz2jCkj2ox9edFap05zze2i5-pW1J9W4ho=jSVhZTUZQFw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] static build
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
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Feb 26, 2012 at 2:12 AM, Mr Dash Four
<mr.dash.four@...1030...> wrote:
>> To cross compile master to arm in static, do:
>> $ git clone git://github.com/alonbl/openvpn-build.git
>> $ cd openvpn-build/generic
>> $ CHOST="arm-unknown-linux-gnueabi" CBUILD="x86_64-pc-linux-gnu"
>> DO_STATIC=1 ./build
>>
>> It will create static dependencies, but dynamic libc, if you want
>> really static use DO_REALLY_STATIC=1.
> This build fails at the same point as in my srpm static compilation:
>
> checking for lzo1x_1_15_compress in -llzo2... no
> checking for lzo1x_1_15_compress in -llzo... no
> configure: error: LZO headers were found but LZO library was not found
> FATAL: Configure openvpn
>
>
> Reason being, I suspect, that the lzo static libraries cannot be found (strange as the compilation succeeded).

I need tmp/openvpn/config.log
Better to have the complete build output...

Alon.

