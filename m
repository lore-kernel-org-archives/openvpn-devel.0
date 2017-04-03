References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
	<95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
	<a0821983-407a-dd9f-dbac-47f94a18c4dd@...515...>
	<ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
From: debbie10t <debbie10t@...277...>
Message-ID: <3ee960b5-c8f0-77ea-04bf-b68828ea45e2@...277...>
Date: Mon, 3 Apr 2017 16:24:23 +0100
MIME-Version: 1.0
In-Reply-To: <ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net



On 03/04/17 15:12, Jan Just Keijser wrote:
> Hi Samuli,
>
> On 03/04/17 15:53, Samuli Seppänen wrote:

>>
>> I tested these changes on Debian 8 which has OpenSSL-1.0.1. Key size was
>> set to 4096-bits and signature algorithm to SHA256WithRSAEncryption.
>>
>> The only real issue was DH parameter generation: it took ~25 minutes on
>> my Intel i5 laptop. Is that acceptable default behavior?
>>

> what kind of i5 is this? on my i7-4810 it took 5 minutes. Can you give the full CPUID string (from /proc/cpuinfo) ?  then I can
> guestimate whether the 25 minutes is realistic for slower hardware.
>

I have a selection of dh-4096b.pem files generated on my i5-2450 @2.5ghz
The time taken to generate each ranged from only a couple of minutes to 
a little over an hour.  I wrote a little batch file to record the actual
time taken for each.  So, I would say 25mins is perfectly normal.

Regards

