References: <1451931920-4248-1-git-send-email-samuli@...515...>
	<20160108135150.GG24952@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <569368FF.6070005@...515...>
Date: Mon, 11 Jan 2016 10:34:07 +0200
MIME-Version: 1.0
In-Reply-To: <20160108135150.GG24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCHv2] Update INSTALL-win32.txt for OpenVPN
 2.3.10
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
Cc: openvpn-devel@lists.sourceforge.net


> Hi,
>
> On Mon, Jan 04, 2016 at 08:25:20PM +0200, samuli@...515... wrote:
>> From: Samuli Sepp=E4nen <samuli@...515...>
>>
>> OpenVPN 2.3.10 includes an OpenVPN-GUI which automatically requests elev=
ation of
>> privileges using UAC. Modified INSTALL-win32.txt to reflect this behavio=
r.
>
> I wonder if these bits should not be removed from the INSTALL-win32.txt
> we ship in the main openvpn repo - since this is a gui thing and happens
> totally outside the main repo...  move it to the windows build tree,
> maybe, and show it from the installer upon installation?
>
> gert

Hi,

Looking at the the full contents of INSTALL-win32.txt your suggestion=20
makes sense. I'll migrate the file to openvpn-build and then send a=20
removal patch for openvpn/INSTALL-win32.txt.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

