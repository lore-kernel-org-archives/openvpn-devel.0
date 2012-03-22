MIME-Version: 1.0
In-Reply-To: <CAOazyz1d2xRaX6QCqOE3kqNCdSEu+Uj4sf2NVxf-Lxxb4x_nEw@...278...>
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
	<4F633B0C.8080502@...515...>
	<20120316152145.GF1359@...1296...>
	<4F66EE39.5050405@...515...> <4F66F5ED.30006@...1114...>
	<4F66FE98.4030707@...1114...>
	<20120319094235.GM1359@...1296...>
	<4F6700E1.60201@...1114...>
	<CAOazyz1aPWoiWWg=T7Ykw0YUL0S_wdAE-T6Gg=djpc=iwF9YXg@...278...>
	<4F6B10DC.1080306@...1114...>
	<CAOazyz1d2xRaX6QCqOE3kqNCdSEu+Uj4sf2NVxf-Lxxb4x_nEw@...278...>
Date: Thu, 22 Mar 2012 13:52:53 +0200
Message-ID: <CAOazyz1FHJ4idKKwdxFCMm-xThrZJM1jY=s6LnH9t-=fKiL+eQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, Mar 22, 2012 at 1:47 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> On Thu, Mar 22, 2012 at 1:45 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 19/03/12 16:16, Alon Bar-Lev wrote:
>>> The only component that is in question is lzo. I still think this is
>>> packager responsibility, not sure why this is an exception. But if it
>>> will make people happy, I will enable lzo by default. All the other
>>> components are optional by they nature, and again it is up to packager
>>> to decide what good for his configuration.
>>
>> Hi Alon,
>>
>> Okay, based on the discussion on this thread, it makes sense to then flip
>> LZO to be enabled by default.
>>
>> No need to hurry with any patches, as I can add such a patch on top of
>> everything when the merging is completed. =C2=A0The patch will be submit=
ted to
>> the mailing list when it's ready to be implemented.
>>
>
> OK, great.
> I will modify the branch with this (rebase) so it won't create additional=
 noise.
> So you be able to do a clean pull with complete feature set.
>
> Alon.

Ready.
Pull and reset.

Alon.

