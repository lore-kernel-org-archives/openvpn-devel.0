References: <DM5PR0101MB30672C1970AEC75A65A56D11B29F9@...2597...>
 <DM5PR0101MB306767258789F6F7BAAEAC5BB29E9@...2597...>
 <783db8bb-028b-4235-5a4d-b804ab7bf96f@...2299...>
 <c0f49f3c-4fad-d2a9-61e2-bfcd977fd1e7@...2299...>
 <9111e0f8-b8a3-a41b-806a-7e959ae60092@...2299...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <2566a70f-62ee-3dae-2abb-81d08d33ab4e@...277...>
Date: Tue, 2 Mar 2021 15:55:48 +0000
MIME-Version: 1.0
In-Reply-To: <9111e0f8-b8a3-a41b-806a-7e959ae60092@...2299...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [vbox-dev] Oracle VirtualBox v6.1.19 Test Build
 142917 - Not working on Windows 10 Insider Dev builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Copying to openvpn

I'm not sure if this will effect you, just something to look into..

The ticket is: https://www.virtualbox.org/ticket/20226

On 02/03/2021 15:50, Klaus Espenlaub wrote:
> well, the mystery has been resolved (see the ticket). Thanks fth0 for=20
> looking closer than Microsoft's signature checking tools.
>=20
> The latest dev build should work again, but the change in signing cert=20
> usage just buys about 6 weeks of time. After that we'll be in the same=20
> situation, because Microsoft dropped the cross-signing approach to sign=20
> kernel drivers. After that I fear the only way to make use of test=20
> builds is to set up test mode... really a pain, but outside our control.
>=20
> Klaus
>=20
> On 2021-02-26 22:22, Klaus Espenlaub wrote:
>> getting only more mysterious: https://www.virtualbox.org/ticket/20226
>>
>> No mention there of Windows 10 Insider.
>>
>> Klaus
>>
>> On 2021-02-26 19:00, Klaus Espenlaub wrote:
>>> very mysterious... we didn't change anything regarding code signing=20
>>> for VirtualBox 6.1 yet (it will come, the SHA2 cert is expiring in=20
>>> about 3 weeks.
>>>
>>> Can you check/compare the installer signatures (using Explorer=20
>>> "Properties")? Both installers you're using the working and=20
>>> non-working one) should be dual signed with exactly the same certs.
>>>
>>> Worst case I could provide you all 6.1 builds between r142777 and=20
>>> r142917. Just 8 builds, and all of the changes actually rather harmless.
>>>
>>> Klaus
>>>
>>> On 2021-02-26 00:09, Jacob Klein wrote:
>>>> Oracle VirtualBox v6.1.19 Test Build 142946 on Windows 10 Insider=20
>>>> Dev Build 21322
>>>> ... is having the same "Not valid kernel code signature." error.
>>>> Logs below.
>>>>
>>>> Please advise, if able. I may test a "Windows 10 Release" install at=20
>>>> some point. Thank you.
>>>>
>>>> 24ec.79c: SUPR3HardenedMain: Load Runtime...
>>>> 24ec.79c: \Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VBoxRT.dll: Signature #1/2: info status: 24202
>>>> 24ec.79c: \Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VBoxRT.dll: Signature #2/2: Unknown Status=20
>>>> -5659 (0xffffe9e5) w/ timestamp=3D0x60379419/link.
>>>> 24ec.79c: supR3HardenedMonitor_LdrLoadDll: returns rcNt=3D0x0=20
>>>> hMod=3D00007ff9c7ce0000 'C:\WINDOWS\system32\rsaenh.dll'
>>>> 24ec.79c: supHardenedWinVerifyImageByHandle: -> -5659=20
>>>> (\Device\HarddiskVolume4\Program Files\Oracle\VirtualBox\VBoxRT.dll)=20
>>>> WinVerifyTrust
>>>> 24ec.79c: Error (rc=3D0):
>>>> 24ec.79c: supR3HardenedScreenImage/LdrLoadDll: rc=3DUnknown Status=20
>>>> -5659 (0xffffe9e5) fImage=3D1 fProtect=3D0x0 fAccess=3D0x0=20
>>>> \Device\HarddiskVolume4\Program Files\Oracle\VirtualBox\VBoxRT.dll:=20
>>>> Signature #2/2: Not valid kernel code signature.:=20
>>>> \Device\HarddiskVolume4\Program Files\Oracle\VirtualBox\VBoxRT.dll
>>>> 24ec.79c: supR3HardenedWinVerifyCacheInsert:=20
>>>> \Device\HarddiskVolume4\Program Files\Oracle\VirtualBox\VBoxRT.dll
>>>> 24ec.79c: Error (rc=3D0):
>>>> 24ec.79c: supR3HardenedMonitor_LdrLoadDll: rejecting 'C:\Program=20
>>>> Files\Oracle\VirtualBox\VBoxRT.dll' (C:\Program=20
>>>> Files\Oracle\VirtualBox\VBoxRT.dll): rcNt=3D0xc0000190
>>>> 24ec.79c: supR3HardenedMonitor_LdrLoadDll: returns rcNt=3D0xc0000190=20
>>>> 'C:\Program Files\Oracle\VirtualBox\VBoxRT.dll'
>>>> 24ec.79c: Error -610 in supR3HardenedMainInitRuntime! (enmWhat=3D4)
>>>> ----------------------------------------------------------------------=
--=20
>>>>
>>>> *From:* Jacob Klein
>>>> *Sent:* Wednesday, February 24, 2021 5:39 PM
>>>> *To:* vbox-dev@...2596... <vbox-dev@...2596...>
>>>> *Subject:* Oracle VirtualBox v6.1.19 Test Build 142917 - Not working=20
>>>> on Windows 10 Insider Dev builds
>>>> Hello,
>>>>
>>>> Oracle VirtualBox v6.1.19 Test Build 142917
>>>> ... gets an error trying to start a VM after using Import Appliance,=20
>>>> on Windows 10 Insider Dev builds.
>>>>
>>>> The problem might be specific to changes in the Test Builds of your=20
>>>> app:
>>>> Oracle VirtualBox v6.1.19 Test Build 142917 - Problem happens.
>>>> Oracle VirtualBox v6.1.19 Test Build 142777 - Problem does NOT happen.
>>>>
>>>> I realize I'm using an Insider build, but because it was an upgrade=20
>>>> of the VirtualBox Test Build (and Extension Pack) that made the=20
>>>> problem start happening, I felt obligated to inform you. I don't=20
>>>> expect an immediate fix. Again, I wanted to inform.
>>>>
>>>> The error is:
>>>> Failed to open a session for the virtual machine MSEdge - Win10.
>>>> The virtual machine 'MSEdge - Win10' has terminated unexpectedly=20
>>>> during startup with exit code 1 (0x1). =A0More details may be=20
>>>> available in 'E:\VirtualBox VMs\MSEdge - Win10\Logs\VBoxHardening.log'.
>>>>
>>>> VBoxHardening says the following:
>>>> 27d8.39f0: SUPR3HardenedMain: Load Runtime...
>>>> 27d8.39f0: \Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VBoxRT.dll: Signature #1/2: info status: 24202
>>>> 27d8.39f0: \Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VBoxRT.dll: Signature #2/2: Unknown Status=20
>>>> -5659 (0xffffe9e5) w/ timestamp=3D0x60353c8e/link.
>>>> 27d8.39f0: supR3HardenedMonitor_LdrLoadDll: returns rcNt=3D0x0=20
>>>> hMod=3D00007ff9c7ce0000 'C:\WINDOWS\system32\rsaenh.dll'
>>>> 27d8.39f0: supHardenedWinVerifyImageByHandle: -> -5659=20
>>>> (\Device\HarddiskVolume4\Program Files\Oracle\VirtualBox\VBoxRT.dll)=20
>>>> WinVerifyTrust
>>>> 27d8.39f0: Error (rc=3D0):
>>>> 27d8.39f0: supR3HardenedScreenImage/LdrLoadDll: rc=3DUnknown Status=20
>>>> -5659 (0xffffe9e5) fImage=3D1 fProtect=3D0x0 fAccess=3D0x0=20
>>>> \Device\HarddiskVolume4\Program Files\Oracle\VirtualBox\VBoxRT.dll:=20
>>>> Signature #2/2: Not valid kernel code signature.:=20
>>>> \Device\HarddiskVolume4\Program Files\Oracle\VirtualBox\VBoxRT.dll
>>>> 27d8.39f0: supR3HardenedWinVerifyCacheInsert:=20
>>>> \Device\HarddiskVolume4\Program Files\Oracle\VirtualBox\VBoxRT.dll
>>>> 27d8.39f0: Error (rc=3D0):
>>>> 27d8.39f0: supR3HardenedMonitor_LdrLoadDll: rejecting 'C:\Program=20
>>>> Files\Oracle\VirtualBox\VBoxRT.dll' (C:\Program=20
>>>> Files\Oracle\VirtualBox\VBoxRT.dll): rcNt=3D0xc0000190
>>>> 27d8.39f0: supR3HardenedMonitor_LdrLoadDll: returns rcNt=3D0xc0000190 =

>>>> 'C:\Program Files\Oracle\VirtualBox\VBoxRT.dll'
>>>> 27d8.39f0: Error -610 in supR3HardenedMainInitRuntime! (enmWhat=3D4)
>>>> 27d8.39f0: LoadLibrary "C:\Program=20
>>>> Files\Oracle\VirtualBox/VBoxRT.dll" failed (rc=3D1790)
>>>> 27d8.39f0: \Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VirtualBoxVM.dll: Signature #1/2: info=20
>>>> status: 24202
>>>> 27d8.39f0: \Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VirtualBoxVM.dll: Signature #2/2: Unknown=20
>>>> Status -5659 (0xffffe9e5) w/ timestamp=3D0x60353ca4/link.
>>>> 27d8.39f0: supR3HardenedMonitor_LdrLoadDll: returns rcNt=3D0x0=20
>>>> hMod=3D00007ff9c7ce0000 'C:\WINDOWS\system32\rsaenh.dll'
>>>> 27d8.39f0: supHardenedWinVerifyImageByHandle: -> -5659=20
>>>> (\Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VirtualBoxVM.dll) WinVerifyTrust
>>>> 27d8.39f0: Error (rc=3D0):
>>>> 27d8.39f0: supR3HardenedScreenImage/LdrLoadDll: rc=3DUnknown Status=20
>>>> -5659 (0xffffe9e5) fImage=3D1 fProtect=3D0x0 fAccess=3D0x0=20
>>>> \Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VirtualBoxVM.dll: Signature #2/2: Not valid=20
>>>> kernel code signature.: \Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VirtualBoxVM.dll
>>>> 27d8.39f0: supR3HardenedWinVerifyCacheInsert:=20
>>>> \Device\HarddiskVolume4\Program=20
>>>> Files\Oracle\VirtualBox\VirtualBoxVM.dll
>>>> 27d8.39f0: Error (rc=3D0):
>>>> 27d8.39f0: supR3HardenedMonitor_LdrLoadDll: rejecting 'C:\Program=20
>>>> Files\Oracle\VirtualBox\VirtualBoxVM.dll' (C:\Program=20
>>>> Files\Oracle\VirtualBox\VirtualBoxVM.dll): rcNt=3D0xc0000190
>>>> 27d8.39f0: supR3HardenedMonitor_LdrLoadDll: returns rcNt=3D0xc0000190 =

>>>> 'C:\Program Files\Oracle\VirtualBox\VirtualBoxVM.dll'
>>>> 259c.2a9c: supR3HardNtChildWaitFor[2]: Quitting: ExitCode=3D0x1=20
>>>> (rcNtWait=3D0x0, rcNt1=3D0x0, rcNt2=3D0x103, rcNt3=3D0x103, 516 ms, th=
e end);
>>>> 3a6c.3108: supR3HardNtChildWaitFor[1]: Quitting: ExitCode=3D0x1=20
>>>> (rcNtWait=3D0x0, rcNt1=3D0x0, rcNt2=3D0x103, rcNt3=3D0x103, 934 ms, th=
e end);
>>>>
>>>> Thanks for anything you can do to resolve this,
>>>> Jacob Klein
> _______________________________________________
> vbox-dev mailing list
> vbox-dev@...2596...
> https://www.virtualbox.org/mailman/listinfo/vbox-dev

