Message-ID: <4C6AB2F2.30501@...1114...>
Date: Tue, 17 Aug 2010 18:04:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C6869BA.3010309@...41...>
	<20100816132917.GM2804@...1281...>	<20100816133454.GN2804@...1281...>	<20100817145115.GI2804@...1281...>
	<20100817151232.GJ2804@...1281...>
In-Reply-To: <20100817151232.GJ2804@...1281...>
Subject: Re: [Openvpn-devel] OpenVPN version 2.1.2 released /	tapinstall.exe
 fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@...124...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 17/08/10 17:12, Pasi Kärkkäinen wrote:
> On Tue, Aug 17, 2010 at 05:51:15PM +0300, Pasi Kärkkäinen wrote:
>> On Mon, Aug 16, 2010 at 04:34:54PM +0300, Pasi Kärkkäinen wrote:
>>> On Mon, Aug 16, 2010 at 04:29:17PM +0300, Pasi Kärkkäinen wrote:
>>>>
>>>> Hello,
>>>>
>>>> When running the openvpn 2.1.2 installer on Windows 7 (x64) I noticed this error:
>>>> http://pasik.reaktio.net/openvpn212-setup-error-opening-file-for-writing.jpg
>>>>
>>>> ie. the installer cannot overwrite the existing files from openvpn 2.1.1 installation.
>>>> I get that error for the following files:
>>>>
>>>> C:\Program Files (x86)\OpenVPN\bin\openvpn-gui-1.0.3.exe
>>>> C:\Program Files (x86)\OpenVPN\bin\libeay32.dll
>>>>
>>>> And after finishing the installation windows "Program Combatibility Assistant" pops up,
>>>> and asks if the program installed correctly, or if I wanted to "Reinstall using recommended settings".
>>>>
>>>> http://pasik.reaktio.net/openvpn212-setup-might-not-have-installed-correctly.jpg
>>>>
>>>> I chose it installed OK and then rebooted the machine.
>>>>
>>>> After reboot I noticed the TAP network device is missing from Windows,
>>>> and thus openvpn connections cannot be started..
>>>>
>>>> Running the "Add a new TAP virtual ethernet adapter" doesn't seem to work either..
>>>>
>>>
>>> And here's a screenshot of the failing tapinstall.exe:
>>> http://pasik.reaktio.net/openvpn212-tapinstall-failed.jpg
>>>
>>
>> Any tips how to troubleshoot this? 
>>
> 
> I just verified: openvpn 2.1.1 installs and works without problems on this win7 (x64) laptop.
> 
> no matter what I try openvpn 2.1.2 doesn't create the tap device..
> 
> I tried running the addtap.bat in various compatibility modes
> but it just doesn't add the tap interface to windows..
> 
> executing addtap.bat with "run as administrator" makes it say it installs ok,
> but in reality the tap interface is NOT added to windows.

It sounds like there are some issues with the v2.1.2 release.  Most
probably it is related to the TAP driver not being signed correctly.
Somehow I got a feeling James is investigating this now.

I'm sure James will update us on this issue when it has been solved.


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxqsvAACgkQDC186MBRfroEYQCgh1ojen3eLmSmQhHvJDYACIV3
s4cAn1tFLlBIm9RnOVR9uXeZ9JX/6/CT
=mwfn
-----END PGP SIGNATURE-----

