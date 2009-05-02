MIME-Version: 1.0
Sender: ichiga2@...277...
In-Reply-To: <49FAFB9F.5020201@...95...>
References: <20090424131323.GB21576@...1066...>
	<fa2e1350904240747m2b9a110w471bceb2c335e765@...278...>
	<20090424202940.GA30397@...1066...>
	<251896ce0904250031l5aa2d985r234602e3fbc4d358@...278...>
	<20090426143946.GA17612@...1066...>
	<20090426160734.GA19542@...1066...>
	<251896ce0904260939w188a31der8e93269f2aac39f3@...278...>
	<251896ce0904300908q55adfcf3mb6c8c683eccf1097@...278...>
	<49FAFB9F.5020201@...95...>
Date: Sat, 2 May 2009 21:26:41 +0900
Message-ID: <251896ce0905020526i21454bf6ra1725cecd6e79123@...278...>
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
To: Carsten Menke <bootsy52@...95...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Carsten,

Thank you for the notice.
It would be nice if solaris itself support tun/tap driver.
But at present, I believe my modified tun/tap driver still be usable
to work with openvpn.
Please try this if interesting, and let me know if you find any defects.

Thanks,

Kazuyoshi

2009/5/1 Carsten Menke <bootsy52@...95...>:
> Kazuyoshi Aizawa wrote:
>>
>> Hi,
>>
>> I modified the build scripts of tun/tap driver for Solaris and
>> uploaded it to web site below.
>>
> I've filed a feature request in the solaris bug database some time
> ago concerning adding support for the tun/tap driver, so maybe you
> also leave your comments there, too. I've added your post to the
> RFE already
>
> the url is
>
> http://defect.opensolaris.org/bz/show_bug.cgi?id=3D6220
>
> NOTE: The status CLOSED: TRACKEDINBUGSTER means that this
> RFE is tracked in the sun internal bug database, so there is still
> hope that this will be added to solaris :-)
>
>
>
> --
> "There are two major products that came out of Berkeley: LSD and UNIX.
> =A0We don't believe this to be a coincidence." --Jeremy S. Anderson
>
>

