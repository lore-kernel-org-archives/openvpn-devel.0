MIME-Version: 1.0
Sender: ichiga2@...277...
In-Reply-To: <20090424202940.GA30397@...1066...>
References: <20090424131323.GB21576@...1066...>
	<fa2e1350904240747m2b9a110w471bceb2c335e765@...278...>
	<20090424202940.GA30397@...1066...>
Date: Sat, 25 Apr 2009 16:31:14 +0900
Message-ID: <251896ce0904250031l5aa2d985r234602e3fbc4d358@...278...>
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
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi Victor,

Could you please post the script once you have built drivers for your packa=
ge?
So that I can update my script as well.
I've wanted to make script to be capable to build drivers on various
platforms. But I don't have enough systems which can use for test.
So if you would share your information, it would be appreciated.

Thanks,

Kazuyoshi

2009/4/25 Victor Wagner <vitus@...1066...>:
> On 2009.04.24 at 07:47:54 -0700, Jonathan Petersson wrote:
>
>> Hi Victor,
>>
>> I haven't tried this myself and this guide is mainly for OpenSolaris, bu=
t:
>> http://blogs.reucon.com/srt/2008/12/17/installing_openvpn_on_opensolaris=
_2008_11.html
>
> There is nothing particulary =A0interesting here, except than linker
> switches for GNU ld (and I use Solaris LD anyway)
>
>> The issue you're seeing with the driver can be remediated by using this =
patch:
>> http://www.whiteboard.ne.jp/~admin2/tuntap/
>
> I know of this updated driver. Unfortunately I haven't figured out way
> how to build 32-bit version of this driver on 64-bit machine. (I almost
> forgot autoconf language and would have to dig into docs for few hours
> to remember enough of it to add something like --disable-64bit).
>
> And my task is to build a package which can be installed on any machine.
> So, I have to build both versions of driver on systems which
> support 64 bit.
>
>
>
> -------------------------------------------------------------------------=
-----
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

