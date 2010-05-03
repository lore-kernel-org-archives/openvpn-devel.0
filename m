Message-ID: <4BDE8633.90809@...1294...>
Date: Mon, 03 May 2010 10:15:47 +0200
From: Eike Lohmann <e.lohmann@...1294...>
MIME-Version: 1.0
References: <4BDACA9A.8040806@...1294...>
	<r2xa43edf1b1004300905nb192fd6dj423a222f6db2e5d4@...278...>
In-Reply-To: <r2xa43edf1b1004300905nb192fd6dj423a222f6db2e5d4@...278...>
Subject: Re: [Openvpn-devel] push routes openvpn on Motorola Milestone /
	Droid
Reply-To: e.lohmann@...1294...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Billy Crook <billycrook@...277...>


You have a Droid with other carrier settings etc. so search for manuals
regarding your phone in your country.
Make a backup to your SD Card!

A good page with all tools/drivers but no manuals is:
http://and-developers.com

Short Overview:

- with Droid 2.1 you have to enable the recovery mode.
  - flash SHOLS_U2_01.14.0_recovery_only.zip with RSDLite

after this step you can use the manuals regarding 2.01 or more early.

- then you have to flash a update.zip wich enables the 'superuser whitelist'

- Now download and install the Android SDK with tools from google
  - with 'adb shell' you can now connect to your phone in USB debugmode.

- install busybox (google for it or build it)
- install tun.ko ( -||-)

- From the market install OpenVPN Installer and OpenVPN Settings
 
- If you need a local shell on your phone, I like ConnectBot from the market


You will need 2-3 hours for that, it's not very diffcult but bad
documented. :)

If you made something wrong and your moto wont boot anymore
ADBrecovery.zip is your friend.


Am 30.04.2010 18:05, schrieb Billy Crook:
> On Fri, Apr 30, 2010 at 07:18, Eike Lohmann <e.lohmann@...1294...> wrote:
>   
>> D/OpenVPN-DaemonMonitor[/sdcard/openvpn/ic3s.ovpn]-daemon-stdout( 7158):
>> Fri Apr 30 14:00:08 2010 us=851287 Options error: Unrecognized option or
>> missing parameter(s) in [PUSH-OPTIONS]:4: route (2.1.1)
>> D/OpenVPN-DaemonMonitor[/sdcard/openvpn/ic3s.ovpn]-daemon-stdout( 7158):
>> Fri Apr 30 14:00:08 2010 us=851623 Options error: Unrecognized option or
>> missing parameter(s) in [PUSH-OPTIONS]:5: route (2.1.1)
>>
>> Hi, I try to push routes from the server to the client, if I connect
>> with windows or linux on a pc it works fine but not with openvpn on my
>> Motorola Milestone / Droid.
>>     
> I would love to try the same thing on my Droid!  I'd been planning to
> (and dragging my feet on) setting up an IPSEC vpnserver at home to
> support my Droid.  If you let me know how you set up what you have so
> far on your droid, I will reproduce it, and attempt to fix the error
>   

