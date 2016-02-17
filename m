References: <56C3205A.6050408@...515...>
	<20160216141118.GB24952@...1296...> <56C49349.9090102@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56C49C65.8000100@...515...>
Date: Wed, 17 Feb 2016 18:14:29 +0200
MIME-Version: 1.0
In-Reply-To: <56C49349.9090102@...515...>
Subject: Re: [Openvpn-devel] Always including tap-windows6,
 openvpn-gui and easy-rsa in openvpn-build -generated Windows
 installers?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>
>> Hi,
>>
>> On Tue, Feb 16, 2016 at 03:12:58PM +0200, Samuli Sepp=E4nen wrote:
>>> Currently openvpn-build allows producing installers which do not
>>> _contain_ tap-windows6, openvpn-gui or easy-rsa at all. On top of this
>>> one can - at install time - select which of the contained components are
>>> intalled.
>>>
>>> Let me know if you have good arguments on why we should have the option
>>> to generate installers without the said components. If nobody speaks up,
>>> I'll remove the conditional code from openvpn.nsi while preparing for
>>> the OpenVPN 2.4 release.
>>
>> I do not think maintaining these options makes much sense - at install
>> time, yes!, but at build-time - this stuff should have what we want
>> *our* installers to contain.  The rest could go to comments in the
>> code maybe ("if you want to make this optional, remove the following
>> lines") or so.
>
> I will remove this functionality in my next batch of modifications to
> openvpn.nsi.
>

I was quicker than I thought:

<https://github.com/OpenVPN/openvpn-build/pull/19>

All the details in the pull request.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

