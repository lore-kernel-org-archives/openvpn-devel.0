References: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
 <99D61A626FDA8A4B90A270669121BE10862C1C09@...2294...>
 <a2e0b87d-19bc-3b7b-4873-b211edab78a0@...515...>
 <CAKuzo_gTpFDQ9YV70WDD_EEMiScAJL+eQ9wZWyT2REg43yHGCg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <32e0ce4f-014c-2804-b005-044c4d44f752@...515...>
Date: Wed, 18 Apr 2018 20:46:52 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gTpFDQ9YV70WDD_EEMiScAJL+eQ9wZWyT2REg43yHGCg@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] New tap-windows6 driver (9.21.3) available for
 testing
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Il 18/04/2018 20:22, Selva Nair ha scritto:
> 
> Hi,
> 
> On Tue, Apr 17, 2018 at 3:01 AM, Samuli Seppänen <samuli@...515...
> <mailto:samuli@...515...>> wrote:
> 
> 
> 
>     Excellent and thanks for testing! This gives me a lot more confidence in
>     the Authenticode signature.
> 
> 
> I don't want to question that as none of my Windows hosts complains
> about the signature. But the driver details tab shows the file as not
> digitally signed. That's as in, adapter properties -> driver -> driver
> details. One level before that it shows Digital signer: OpenVPN Tech..
> Go figure.. And likely this "problem" existed in previous version too.
> This is on Windows 7.

This has always been the same afaik. I think it is an inconsistency in
how Windows checks the signature.

> Looking into this further using pnputil and sigverify:
> 
> C:\Windows\System32>pnputil -e
> Microsoft PnP Utility
> 
> .. snipped...
> 
> Published name :            oem13.inf
> Driver package provider :   Microsoft
> Class :                     Printers
> Driver date and version :   05/28/2012 15.0.4128.4000
> Signer name :               Microsoft Windows Hardware Compatibility
> Publisher
> 
> Published name :            oem14.inf
> Driver package provider :   TAP-Windows Provider V9
> Class :                     Network adapters
> Driver date and version :   04/13/2018 9.00.00.21
> Signer name :
> 
> ...snipped...
> 
> C:\Windows\System32\catroot>  sigverify
> 
> This also lists tap0901.sys as unsigned.
> 
> Is this a known Windows 7 issue? Will check Windows 10 later tonight.
> 
> Selva

I believe it is enough if the catalog file is signed. If my memory
serves me correctly the sys file could be signed at some point in the
history of Windows.

If you can test 64-bit Windows 10 with Secure boot enabled which is not
an upgrade from Windows 7/8 that would be optimal. I've been told that
combo is the most picky about signatures.

-- 
Samuli Seppänen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

