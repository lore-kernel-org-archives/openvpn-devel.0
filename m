Message-ID: <4F633B0C.8080502@...515...>
Date: Fri, 16 Mar 2012 15:07:24 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
In-Reply-To: <CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On Fri, Mar 16, 2012 at 2:47 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> The impact on this change mainly hits packagers on the Linux, *BSD and
>> Solaris packagers platforms - and those who do their own Windows builds.
>>  The official Windows builds we control and can make sure this feature is
>> enabled.
> Please keep in mind that this is not the only change packager will
> need to do when this is released.
> I rewrote the Gentoo ebuild, in preparation for this.
> I rewrote the spec file within the openvpn tree.
> When release of beta, a large note should be written for other
> packagers to update their packages for this version.
>
> Alon.
>
Having as much stuff as possible disabled by default and then enabled
selectively _feels_ cleaner. But I'm fine with either approach.

Personally, I don't think we'll get many complaints if lzo is disabled
by default. As Alon points out, this is not the only thing packagers
need to adjust to, so they expect things to work differently. Hopefully
this translates to them paying some attention while doing the builds :).

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


