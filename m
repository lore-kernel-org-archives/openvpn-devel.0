MIME-Version: 1.0
Sender: ichiga2@...277...
In-Reply-To: <20090426160734.GA19542@...1066...>
References: <20090424131323.GB21576@...1066...>
	<fa2e1350904240747m2b9a110w471bceb2c335e765@...278...>
	<20090424202940.GA30397@...1066...>
	<251896ce0904250031l5aa2d985r234602e3fbc4d358@...278...>
	<20090426143946.GA17612@...1066...>
	<20090426160734.GA19542@...1066...>
Date: Mon, 27 Apr 2009 01:39:22 +0900
Message-ID: <251896ce0904260939w188a31der8e93269f2aac39f3@...278...>
From: Kazuyoshi Aizawa <admin2@...628...>
Subject: Re: [Openvpn-devel] Solaris questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Victor,

Thank you very much for the patch and info.
It is really helpful.
I intend to apply it to my script.
And I'll consider to provide tun.c as a patch.

Thanks,

Kazuyoshi

2009/4/27 Victor Wagner <vitus@...1066...>:
> On 2009.04.26 at 18:39:46 +0400, Victor Wagner wrote:
>
>> Of course. See attached patch (configure.patch).
>
> Unfortunately, I've send untested patch. I've checked configure
> invocation, but was too haste to check whether produced Makefile would
> work.
>
> Now there is tested patch.
>
> Only thing is that to do make install without root rights (which is
> common thing when building package and installing into temporary
> directory) you need /usr/ucb/install from SUNscpu package.
>
> Either included install-sh or GNU install from sunfreeware fails for
> unability to chown files.
>
> With this patch I've been able to build package for
> Solaris 8,9,10 both i386 and sparc. And all Sparc packages and 10/intel
> contain both 64-bit and 32-bit drivers.
>
> I do not attach packaging Makefile yet, becouse it depends on my
> solaris packaging scripts, which are not published anywhere.
>
>
>
> ------------------------------------------------------------------------------
> Crystal Reports &#45; New Free Runtime and 30 Day Trial
> Check out the new simplified licensign option that enables unlimited
> royalty&#45;free distribution of the report engine for externally facing
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

