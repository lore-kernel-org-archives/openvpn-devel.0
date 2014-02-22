Message-ID: <530917A4.4050905@...1528...>
Date: Sat, 22 Feb 2014 22:33:24 +0100
From: michael-dev@...1528...
MIME-Version: 1.0
References: <5302AADC.80801@...277...>
	<20140218085500.GU16637@...1296...>	<530340C4.5060702@...277...>	<20140218115015.GW16637@...1296...>
	<5304AFE4.2050702@...277...>
In-Reply-To: <5304AFE4.2050702@...277...>
Subject: Re: [Openvpn-devel] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

thanks for writing the patch.

I'd like to propose to add a comment to the readme regarding the use of
ECDH instead of DH without using an EC certificate, because that
currently is not mentioned in it.

Thanks,
 M. Braun

Am 19.02.2014 14:21, schrieb pietrek --:
> On 02/18/14 12:50, Gert Doering wrote:
>> Hi,
>>
>> On Tue, Feb 18, 2014 at 12:15:16PM +0100, pietrek -- wrote:
>>>> Which parts of the key handshake does it cover? 
>>>> Signature/Certificates,
>>>> or *only* DH?
>>> Handshake only, EC certificates worked for me without doing anything.
>>> Also, DH didn't work with EC certificates( no such cipher ).
>> I see.
>>
>> Seems what we need as well is a README file that explains about EC
>> crypto,
>> as in
>>
>>   - how do I generate and use an EC certificate?
>>   - how do I use an EC curve for DH?
>>   - how do I use EC for session keying?
>>
>> because otherwise our users will be even more confused than I am.
>>
>> gert
>>
> Hi,
> I added README.ec to my patch
>    Piotr Jarosz
> 
> 
> 
> ------------------------------------------------------------------------------
> Managing the Performance of Cloud-Based Applications
> Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
> Read the Whitepaper.
> http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


