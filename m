MIME-Version: 1.0
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Mon, 5 Oct 2009 16:45:24 +0200
Message-ID: <7bb795fd0910050745i6ea96b75t6e9e0fcd5da385e5@...278...>
Subject: [Openvpn-devel] [PATCH] openvpn over ipv6 support v0.4.9,
	rebased on 2.1_rc20 [was: 	v0.4.6]
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
To: =?ISO-8859-1?Q?Marcel_Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

Hi

On Mon, Oct 5, 2009 at 4:11 PM, Marcel Pennewi=DF
<mailinglists@...1145...> wrote:
> On Wednesday 30 September 2009 19:41:01 Marcel Pennewi=DF wrote:
>> On Friday 25 September 2009 23:36:19 JuanJo Ciarlante wrote:
>> > Hi,
>> >
>> > I'm(back) working on openvpn/ipv6 endpoint support, aka udp6/tcp6,
>> > please refer to README.ipv6[1] and TODO.ipv6[2] for more details.
>>
>> OpenVPN 2.1-rc19 crashs on Gentoo (Xen DomU, AMD64( using tcp6-server wi=
th
>> and segfaulted using "tcp-server"
>
> Both problems fixed in 0.4.8-patch. big thx to JuanJo.

Thank you Marcel for the invaluable debugging and re-patching.

FYI I rebased my current tree onto 2.1_rc20, git-push'd[1]
and uploaded rc20 diffs [2].

Cheers,

[1] http://github.com/jjo/openvpn-ipv6
[2] http://github.com/jjo/openvpn-ipv6/downloads


>
> Marcel
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

