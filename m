MIME-Version: 1.0
In-Reply-To: <4F466205.5020006@...1030...>
References: <4F466205.5020006@...1030...>
Date: Fri, 24 Feb 2012 00:55:25 +0200
Message-ID: <CAOazyz24mNbDRf0zoCMHrdCsrZui+cgWaETt7AA67qShfs4bGw@...278...>
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

Hello,

I am working on a new build system for OpenVPN, you can check it[1] out.

To cross compile master to arm in static, do:
$ git clone git://github.com/alonbl/openvpn-build.git
$ cd openvpn-build/generic
$ CHOST="arm-unknown-linux-gnueabi" CBUILD="x86_64-pc-linux-gnu"
DO_STATIC=1 ./build

It will create static dependencies, but dynamic libc, if you want
really static use DO_REALLY_STATIC=1.

Alon

[1] https://github.com/alonbl/openvpn-build

On Thu, Feb 23, 2012 at 5:57 PM, Mr Dash Four
<mr.dash.four@...1030...> wrote:
> I would like to build a slimmed-down version of OpenVPN for armv6 -
> would that be easy to achieve?
>
> My aim is to deploy it on my android device (I don't trust the version
> in existence there, so by statically building OpenVPN I won't be
> dependent on the bionic toolchain). Has this been attempted before? Many
> thanks!
>
> ------------------------------------------------------------------------------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

