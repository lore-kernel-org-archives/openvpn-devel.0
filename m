Message-ID: <5098C44B.3080806@...515...>
Date: Tue, 06 Nov 2012 10:03:23 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20121009185233.GS48053@...1777...> <3225194.uqCr5OXhPF@...1526...>
	<5097DE86.7070103@...1777...>
In-Reply-To: <5097DE86.7070103@...1777...>
Subject: Re: [Openvpn-devel] Backslash in user/pass breaks OpenVPN-GUI
 management authentication
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
To: Adam McDougall <mcdouga9@...1777...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On 10/10/12 04:13, Heiko Hund wrote:
>> Hi Adam
>>
>> On Tuesday 09 October 2012 14:52:33 Adam McDougall wrote:
>>> This report concerns the OpenVPN-GUI application included with
>>> 2.3-alpha3 and 2.3_beta1.  I am excited to see native support for the
>>> Management Interface which I will ultimately need if I start deploying
>>> the Windows client, but I discovered username/password authentication
>>> chokes if either contain a backslash: \
>> Thanks for the report. Currently "special" characters in username and pa=
ssword
>> are not quoted. I've had a report about a double quote breaking auth as
>> well... and forgot about fixing it. =3D) Expect this to be fixed in the =
next
>> beta release. And again, thanks for testing!
>>
>> Heiko
>>
> I tested the recent rc1 build but it was not fixed, did it go in?  Thanks.
>
I checked the Windows installer and indeed, it was using an older
version of openvpn-gui. The build computer is atm building a new
installer based on latest Git commit. This seems to include the backlash
fix.

I'll release the fixed build later today.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


