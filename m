MIME-Version: 1.0
In-Reply-To: <20091006113348.GF3183@...30...>
References: <7bb795fd0910050745i6ea96b75t6e9e0fcd5da385e5@...278...> 
	<20091006113348.GF3183@...30...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Tue, 6 Oct 2009 13:48:56 +0200
Message-ID: <7bb795fd0910060448g5fddc622kede409a6a2bcd42c@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support v0.4.9,
	rebased 	on 2.1_rc20 [was: v0.4.6]
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
To: agi@...64..., openvpn-devel@lists.sourceforge.net

Hola Alberto,

On Tue, Oct 6, 2009 at 1:33 PM, Alberto Gonzalez Iniesta
<agi@...64...> wrote:
> On Mon, Oct 05, 2009 at 04:45:24PM +0200, JuanJo Ciarlante wrote:
>> Hi
>>
>> On Mon, Oct 5, 2009 at 4:11 PM, Marcel Pennewi=DF
>> <mailinglists@...1145...> wrote:
>> > On Wednesday 30 September 2009 19:41:01 Marcel Pennewi=DF wrote:
>> >> On Friday 25 September 2009 23:36:19 JuanJo Ciarlante wrote:
>> >> > Hi,
>> >> >
>> >> > I'm(back) working on openvpn/ipv6 endpoint support, aka udp6/tcp6,
>> >> > please refer to README.ipv6[1] and TODO.ipv6[2] for more details.
>> >>
>> >> OpenVPN 2.1-rc19 crashs on Gentoo (Xen DomU, AMD64( using tcp6-server=
 with
>> >> and segfaulted using "tcp-server"
>> >
>> > Both problems fixed in 0.4.8-patch. big thx to JuanJo.
>>
>> Thank you Marcel for the invaluable debugging and re-patching.
>>
>> FYI I rebased my current tree onto 2.1_rc20, git-push'd[1]
>> and uploaded rc20 diffs [2].
>
> Hi All!
>
> I just included the patch on the official Debian package. It will enter
> the Sid repository today,

wooHooo, cool! ... muchas gracias, Alberto =3D)

>  hopefully a bunch of new people will test it
> now. :)

Indeed!  0:)

Cheers,

>
> Regards,
>
> Alberto
>
> --
> Alberto Gonzalez Iniesta =A0 =A0| Formaci=F3n, consultor=EDa y soporte t=
=E9cnico
> agi@(inittab.org|debian.org)| en GNU/Linux y software libre
> Encrypted mail preferred =A0 =A0| http://inittab.com
>
> Key fingerprint =3D 9782 04E7 2B75 405C F5E9 =A00C81 C514 AF8E 4BA4 01C3
>
> -------------------------------------------------------------------------=
-----
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#3=
3;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

