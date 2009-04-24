Date: Sat, 25 Apr 2009 00:29:40 +0400
From: Victor Wagner <vitus@...1066...>
Message-ID: <20090424202940.GA30397@...1066...>
References: <20090424131323.GB21576@...1066...>
	<fa2e1350904240747m2b9a110w471bceb2c335e765@...278...>
MIME-Version: 1.0
In-Reply-To: <fa2e1350904240747m2b9a110w471bceb2c335e765@...278...>
Subject: Re: [Openvpn-devel] Solaris questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2009.04.24 at 07:47:54 -0700, Jonathan Petersson wrote:

> Hi Victor,
> 
> I haven't tried this myself and this guide is mainly for OpenSolaris, but:
> http://blogs.reucon.com/srt/2008/12/17/installing_openvpn_on_opensolaris_2008_11.html

There is nothing particulary  interesting here, except than linker
switches for GNU ld (and I use Solaris LD anyway)

> The issue you're seeing with the driver can be remediated by using this patch:
> http://www.whiteboard.ne.jp/~admin2/tuntap/

I know of this updated driver. Unfortunately I haven't figured out way
how to build 32-bit version of this driver on 64-bit machine. (I almost
forgot autoconf language and would have to dig into docs for few hours
to remember enough of it to add something like --disable-64bit).

And my task is to build a package which can be installed on any machine.
So, I have to build both versions of driver on systems which
support 64 bit.



