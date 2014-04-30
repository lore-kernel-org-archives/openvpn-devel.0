Message-ID: <5360E962.3010509@...515...>
Date: Wed, 30 Apr 2014 15:15:30 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <mailman.136280.1398841893.2178.openvpn-devel@lists.sourceforge.net>
	<mailman.136280.1398841893.2178.openvpn-devel.{0dae5f05-5c86-4434-9a1f-0755a01b1752}.0@lists.sourceforge.net>
	<53600550.1000905@...515...> <5360E5F1.2010908@...1420...>
In-Reply-To: <5360E5F1.2010908@...1420...>
Subject: Re: [Openvpn-devel] Help with testing OpenVPN 2.3.3 installers with
 tap-windows6? (Openvpn-devel Digest, Vol 95, Issue 44)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Christian Rank <christian.rank@...1420...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On 04/29/2014 10:02 PM, Samuli Sepp?nen wrote:
>> Hi all,
>>
>> I built OpenVPN 2.3.3 installers that contain tap-windows6 (NDIS 6) driv=
ers:
>>
>> <http://build.openvpn.net/downloads/temp/ndis6>
>>
>> Note the build number, "605", where the first digit ("6") means "comes
>> with an NDIS 6 driver".
>>
>> I tested the 64-bit version on Win7 64-bit and it seemed to work ok, but
>> my testing was anything but extensive.  So, if [some of] you happen to
>> have a non-critical Windows box(es) lying around it'd be great if you
>> could test whether the new driver works ok in your environment. I
>> suggest removing any previous OpenVPN installations, installing the new
>> package and then verifying the driver version using the Device Manager;
>> the NDIS 5 driver version is 9.9.2, whereas this new driver is 9.21.0
>>
>> Note that as tap-windows6 is still an unproven driver it can BSOD. We
>> haven't experienced any problems with it, but it's best too keep that
>> possibility in mind.
>>
>> We will soon start offering the OpenVPN installer with NDIS 6-driver as
>> an option and hopefully soon afterwards make them the default option for
>> Windows Vista and above.
>>
> Hello,
>
> I've just done some testing on Win7 64-bit (german localization) and
> didn't notice any problems. However, driver assembly version is
> indicated as "9.0.0.21", not "9.21.0". (?)
>
> Regards,
> 	Christian
>
Thanks for testing, Christian!

I believe that odd version number is to be expected, and really boils
down to formatting differences. Similarly the old tap-windows (NDIS 5)
driver will report 9.0.0.9 as it's version - in our parlance that
translates to 9.9.x.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


