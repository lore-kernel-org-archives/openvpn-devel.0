Message-ID: <4F9A7FCF.6040101@...515...>
Date: Fri, 27 Apr 2012 14:15:27 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
	<1332621070-28464-1-git-send-email-alon.barlev@...277...>
	<4F9A5EB7.902@...515...> <2620278.PZKTmmtf1E@...1526...>
In-Reply-To: <2620278.PZKTmmtf1E@...1526...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: windows: convert argv (UCS-2
 to UTF-8) at earliest
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On Friday 27 April 2012 09:54:15 Samuli Sepp=E4nen wrote:
>> Anyways, I cross-compiled latest "master" with this patch applied and
>> "bin" and "lib" directories on top of an existing openvpn-2.3-alpha1
>> install. The old "bin" directory was renamed to make sure none of it was
>> used. I then renamed "openvpn.ovpn" to "=E4=E4li=F6.ovpn" and "ta.key" to
>> "=E4=E4li=F6.key" using Windows Explorer. Then I updated the configurati=
on
>> file to point to these files using Notepad (and later Wordpad).
> Notepad saves UTF-8 files with BOM, which is very uncommon. Maybe that wa=
s the=20
> problem. I ran into that when I was testing my patch. You might want to t=
ry=20
> using Notepad++ and save it as UTF-8 without BOM.
>
> HTH
> Heiko
I'll give Notepad++ a try, thanks!

Samuli

