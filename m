References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
 <ef6133bb-cb4a-d70a-c0b4-1b9466fc19fd@...515...>
 <FF8443AE-D430-496D-881A-C75171649BA6@...2293...>
 <66e96fe1-46ef-ba52-8db3-ae575f105d1d@...515...>
 <e1a67659-043d-9ddd-1f5d-f4461e056aae@...515...>
 <261da5e7-6997-7a37-2ce6-b1a408aaebee@...515...>
 <99D61A626FDA8A4B90A270669121BE10ABF67DFF@...2294...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <fe9506e7-2185-0843-539f-a20a149b8376@...515...>
Date: Fri, 5 Jul 2019 12:04:42 +0300
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10ABF67DFF@...2294...>
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

Hi Simon,

Il 04/07/19 16:08, Simon Rozman ha scritto:
> Hi,
> 
> I just got from vacation and struggling to catch up on things...
> 
>> I got the Static Driver Verifier to run with help from Stephen. The
>> correct (command-line) procedure is now documented here:
>>
>> <https://community.openvpn.net/openvpn/wiki/HLKTesting#StaticToolsLogoTe
>> st>
>>
>> So it was bad usability after all. The tests are now running and
>> hopefully I can create the merged test result package from SDV and Code
>> Analysis today.

The bad usability was referring to the GUI method of launching the SDV
(which I did not manage to get working).

> Reading your documentation, I found something odd.
> 
> I can just "cd src" and run:
> 
> msbuild tap-windows6.vcxproj /target:DVL /p:Configuration=Release;Platform=x64

Thanks! I added this to the documentation:

<https://community.openvpn.net/openvpn/wiki/HLKTesting#StaticToolsLogoTest>

> 
> And it produces tap0901.DVL.XML just fine. No need to jump into IDE and 
> click-click-click to build it.
> 
> Regards,
> Simon
> 


-- 
Samuli Seppänen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

