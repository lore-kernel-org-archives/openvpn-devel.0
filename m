From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
 <ef6133bb-cb4a-d70a-c0b4-1b9466fc19fd@...515...>
 <FF8443AE-D430-496D-881A-C75171649BA6@...2293...>
 <66e96fe1-46ef-ba52-8db3-ae575f105d1d@...515...>
 <e1a67659-043d-9ddd-1f5d-f4461e056aae@...515...>
Message-ID: <261da5e7-6997-7a37-2ce6-b1a408aaebee@...515...>
Date: Tue, 25 Jun 2019 11:55:47 +0300
MIME-Version: 1.0
In-Reply-To: <e1a67659-043d-9ddd-1f5d-f4461e056aae@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Summary of the community meeting (20th June
 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I got the Static Driver Verifier to run with help from Stephen. The
correct (command-line) procedure is now documented here:

<https://community.openvpn.net/openvpn/wiki/HLKTesting#StaticToolsLogoTest>

So it was bad usability after all. The tests are now running and
hopefully I can create the merged test result package from SDV and Code
Analysis today.

Meanwhile I'll make the HLK client work for its money by running the
other tests.

Samuli

Il 24/06/19 21:13, Samuli Seppänen ha scritto:
> Hi,
> 
> Il 24/06/19 14:33, Samuli Seppänen ha scritto:
>> Hi Simon,
>>
>> Thanks for the info again!
>>
>> Il 21/06/19 18:59, Simon Rozman ha scritto:
>>> (21:04:58) mattock: assuming Microsoft's systems are happy with the test submission package, that is
>>> (21:05:12) mattock: they _should_ be, but we have not tested submitting anything yes
>>>
>>> 1. Do the SDV and DVL to get tap901.DVL.xml.
>>
>> I'm working on this right now. Based on brief practical testing EWDK may
>> not be able to do this, even though it is apparently possible to produce
>> SDV logs from the command-line:>
>> https://docs.microsoft.com/en-us/windows-hardware/drivers/develop/creating-a-log-file-for-static-driver-verifier
>>
>> It _seems_ that EWDK might not have all the necessary pieces for
>> producing SDV log files. MS does briefly mention that EWDK is not
>> suitable for doing driver testing, whatever that means. So, to play it
> 
> Actually it is probably possible to use the EWDK for running Static
> Driver Verifier:
> 
> <https://github.com/MicrosoftDocs/windows-driver-docs/blob/staging/windows-driver-docs-pr/develop/creating-a-driver-verification-log.md>
> <https://docs.microsoft.com/it-it/windows-hardware/drivers/devtest/static-driver-verifier>
> 
>> safe, I'm installing Visual Studio 2019 plus the "normal" Windows Driver
>> Kit on my tapbuilder VM.
> 
> So, I took a stab at producing the Static Driver Verifier logs in Visual
> Studio 2019 ("Extensions" -> "Static Driver Verifier"), but it just
> complains about
> 
> "Please select a driver project for sdv to verify"
> 
> I wonder if I just hit a usability problem, or if something is actually
> missing from tap-windows6?
> 
> Attempting to run SDV from the command-line (adapted from first link
> above) fails as well. The /clean part works fine, but running SDV fails:
> 
> PS> msbuild.exe src\tap-windows6.vcxproj /p:Configuration="Release"
> /p:Platform=x64 /target:sdv /p:inputs="/clean"
> 
> --- snip ---
> 
> PS> msbuild.exe src\tap-windows6.vcxproj /p:Configuration="Release"
> /p:Platform=x64 /target:sdv /p:inputs="/check:default.sdv"
> 
>   [INFO] Validating XML against schema: C:\Program Files (x86)\Windows
> Kits\10\TOOLS\SDV\smv\bin\Config.xsd
>   [INFO] Running local scheduler with 2 threads
>   [FATAL ERROR] Unrecoverable error in NormalBuild stage.
> C:\Program Files (x86)\Windows
> Kits\10\build\windowsdriver.Sdv.targets(136,9): error MSB3073: The
> command "staticdv /ch
> eck:default.sdv" exited with code -1.
> [C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj]
> Done Building Project
> "C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj" (sdv
> target(s)) -- FAILED.
> 
> 
> Build FAILED.
> 
> "C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj" (sdv target)
> (1) ->
> (sdv target) ->
>   C:\Program Files (x86)\Windows
> Kits\10\build\windowsdriver.Sdv.targets(136,9): error MSB3073: The
> command "staticdv /
> check:default.sdv" exited with code -1.
> [C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj]
> 
>     0 Warning(s)
>     1 Error(s)
> 
> Time Elapsed 00:00:02.65
> 
> ---
> 
> Am I missing something [that is obvious to a Windows developer]?
> 
> Samuli
> 
> [*] Adapting the instructions of the first link, above
> 
>>
>>> 2. Compile the driver and EV sign it. Save PDBs too.
>>
>> I assume this is not really necessary if I'm using WDKTest certificates
>> and have enabled test-signing?
>>
>>> 3. Deploy the driver on test computers (including tap901.DVL.xml, remember?).
>>> 4. Do the WHLK.
>>> 5. When creating submission package, add the driver binaries and PDBs (on HLK Studio submission page).
>>> 6. Submit the driver to Microsoft WHQL.
>>> 7. Miscrosoft should return you a WHQL signed driver in about 10 minutes.
>>>
>>> (21:07:09) mattock: worst case scenario is that I have to reinstall the HLK client as Windows Server 2019 core _if_ Microsoft is not happy with the "Operate in Server Core" having been run on a virtual machine, or on some old i5 laptop which does not have the required 4 physical processor cores
>>>
>>> Microsoft is fine with that test being run on a virtual Windows Server 2019 Core in Wintun case. And this test is pretty straight forward - just checks that driver loads and adapter responds, it doesn't need to be connected and have traffic. Use devcon to make a single TAP adapter on the Server Core. No need to have a running OpenVPN connection for this test to pass.
>>
>> This is good news. I can just use a Virtualbox VM then. This test used
>> to pass even on EC2 Windows instances.
>>
>>> (21:14:42) mattock: I also finally ate our own dogfood and installer OpenVPN on the virtual host running the HLK controller so that I can access the HLK controller and clients remotely, which speeds the testing up quite a bit
>>>
>>> Not a good idea, as WHLK tests can and will interfere with all TAP-Windows6 adapters on test computers. Not just the one that is being tested. Expect OpenVPN connections to flicker or die. Just use it to access controller server only. I never experienced any issues requiring intervention on test computers.
>>
>> The OpenVPN client I'm talking about is installed on a Linux laptop that
>> works as a Virtualbox host. The HLK controller is a VM on that host.
>> None of the HLK computers know about its existence.
>>
>> The HLK test client and support machine do have OpenVPN setup, but that
>> is a completely separate p2p bridged setup used to allow the two-machine
>> NDIS tests pass. And it works well for that purpose.
>>
> 


-- 
Samuli Seppänen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

