MIME-Version: 1.0
In-Reply-To: <1239203062l.18482l.11l@...1207...>
References: <1239166995l.18482l.9l@...1207...>
	<F9B005F620B74BD29BB0A36AF509BCED@...576...>
	<1239203062l.18482l.11l@...1207...>
Date: Thu, 9 Apr 2009 01:46:46 +0300
Message-ID: <9e0cf0bf0904081546y3daea253u62c234e63a6e5b08@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
	building 2.1 rc15 on Windows XP
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, dave <dev@...575...>

Available as part of OpenSC build [1].

[1] http://www.opensc-project.org/build

On Wed, Apr 8, 2009 at 6:04 PM, Karl O. Pinc <kop@...1206...> wrote:
>
> On 04/08/2009 07:58:12 AM, dave wrote:
>> > -----Original Message-----
>> > From: Karl O. Pinc [mailto:kop@...1206...]
>> ...
>> > I suspect that what I want is exactly what OpenVPN already has at
>> > http://openvpn.net/prebuilt/. =C2=A0The problem is that it's not
>> > labeled as such and does not seem to have the same "supported"
>> ...
>> > So I guess what I'm asking is for this build to be documented
>> > and placed on the download page with the rest of the
>> > official downloads. =C2=A0(Assuming I can just run
>> > install-win32/buildinstaller and have an installer
>> > produced.)
>> ...
>>
>> I'm pretty sure you can setup MinGW to build on Linux, though I
>> haven't.
>
> Yeah. =C2=A0On Debian it just installs and seems to work. =C2=A0But there=
 must
> be more involved, somewhere, to have it go from source to nsis
> installer. =C2=A0I say this because I thought the instructions would
> enable me to cross compile, and so I installed the prerequisites
> on Linux and gave it a go. =C2=A0The ./configure failed it's tests
> for libraries, because of course the Windows libraries would
> not run on Linux.
>
>>
>> Agreed on the binary tarball, but brace yourself: =C2=A0the source tarba=
ll
>> is
>> not always up-to-date to the current version either.
>
> Well, if the developers grant my wish then it _would_ be current. :)
>
>
> Karl <kop@...1206...>
> Free Software: =C2=A0"You don't pay back, you pay forward."
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- Robert A=
. Heinlein
>
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by:
> High Quality Requirements in a Collaborative Environment.
> Download a free trial of Rational Requirements Composer Now!
> http://p.sf.net/sfu/www-ibm-com
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

