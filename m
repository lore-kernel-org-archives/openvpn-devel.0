References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
	<20160629081109.GU78279@...1296...>
	<CAFHpkQGD10-N=fX6osaMKE4SN+S55A8EN+8byw6aTM9Aosd1Mw@...278...>
	<20160629090025.GV78279@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <51c19384-4814-c63e-f515-ea0f3ce8791e@...515...>
Date: Wed, 29 Jun 2016 12:11:24 +0300
MIME-Version: 1.0
In-Reply-To: <20160629090025.GV78279@...1296...>
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Wed, Jun 29, 2016 at 01:57:14PM +0500, ???????? ?????????????? wrote:
>> ok, if so, we need to modify installer to detect that.
>
> Right, "master" installers should refuse cooperation on XP.
>
> Samuli, you're listening? ;-)
>
> gert
>

Yes. Do we still want to bloat "master" installers with tap-windows?

Afaics that would only be useful _if_ somebody is having problems with 
tap-windows6 and needs to revert to tap-windows. However, in that case 
we'd need checkbox, not automatic tap-driver selection based on the OS.

Samuli

