MIME-Version: 1.0
In-Reply-To: <20090424131323.GB21576@...1066...>
References: <20090424131323.GB21576@...1066...>
From: Jonathan Petersson <jpetersson@...1214...>
Date: Fri, 24 Apr 2009 07:47:54 -0700
Message-ID: <fa2e1350904240747m2b9a110w471bceb2c335e765@...278...>
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

I haven't tried this myself and this guide is mainly for OpenSolaris, but:
http://blogs.reucon.com/srt/2008/12/17/installing_openvpn_on_opensolaris_2008_11.html

The issue you're seeing with the driver can be remediated by using this patch:
http://www.whiteboard.ne.jp/~admin2/tuntap/

Good luck.

/Jonathan

On Fri, Apr 24, 2009 at 6:13 AM, Victor Wagner <vitus@...1066...> wrote:
> Hi, all
>
> I've tried to build Solaris OpenVPN packages for various versions of
> solaris and encountered some problems, probably related more with TUN
> driver, than with openvpn itself
>
> I'm using openvpn 2.1rc15 and tun driver 1.1 as recommended on
> openvpn.net site.
>
> 1. Openvpn is unable to close tun interface, if daemon is not running
> with root priveleges. with increased debug level it reports "not owner".
>
> 2. I was unable to run two openvpn daemons at once. First one starts,
> and second is unable to open another tun interface.
>
> These problems was experienced on Solaris 10 intel both with 32-bit and
> 64-bit (amd64) kernel, and Solaris 10 sparc, 64-bit kernel.
>
> Is this known issue and is there any workarounds/patches
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

