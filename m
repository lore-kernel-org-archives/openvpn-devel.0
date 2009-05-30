Message-ID: <4A210AB1.2050901@...41...>
Date: Sat, 30 May 2009 04:30:09 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20090529110957.111780@...95...>
	<9e0cf0bf0905290425x396bb7f4o1c68c00a2f12ba0c@...278...>
In-Reply-To: <9e0cf0bf0905290425x396bb7f4o1c68c00a2f12ba0c@...278...>
Subject: Re: [Openvpn-devel] Reporting issue with v2.1 rc16
	and	--cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I would rather not have touched cryptoapi.c for rc16, but it wouldn't
build with MinGW 5.1.4 (the .h files in this version of MinGW define the
symbol CryptAcquireCertificatePrivateKey which conflicts with the symbol
of the same definition in cryptoapi.c).  So I did try to work around the
issue, but perhaps I broke something in the process.

It would be great if one of the developers that uses the crypto API
feature could take a look at it.  We will certainly accept a patch that
fixes any introduced breakage.

James

Alon Bar-Lev wrote:
> True.
> I already reported this to James.
> There were too many change-replace at the cryptoapi.c in this version.
> 
> On Fri, May 29, 2009 at 2:09 PM, Markus Bickel <ZeroCool.2001@...68...> wrote:
>> Dear developers,
>>
>> I'm currently installing and testing OpenVPN 2.1 on windows environment and have seen that there's a newer version rc16.
>>
>> Since this version I cannot use the parameter:
>>
>> --cryptoapicert "Thumb:xx xx xx xx xx"
>>
>> Error message:
>>
>> cannot load certificate "Thumb:xx xx xx xx .... " from Microsoft Certificate Store:
>> error:C506C064:microsoft cryptoapi:GetProcAddress:The specified procedure could not be found.
>>
>>
>> This behaviour is the same on server or client sides.
>> With rc15 this worked well.
>>
>> Maybe this is a small bug.
>> So I want to report this issue to you.
>>
>> Would it be fixed in rc17?
>>
>> Thanks in Adanvce,
>>
>> Markus
>>
>> --
>> Nur bis 31.05.: GMX FreeDSL Komplettanschluss mit DSL 6.000 Flatrate und
>> Telefonanschluss nur 17,95 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02
>>
>> ------------------------------------------------------------------------------
>> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
>> is a gathering of tech-side developers & brand creativity professionals. Meet
>> the minds behind Google Creative Lab, Visual Complexity, Processing, &
>> iPhoneDevCamp as they present alongside digital heavyweights like Barbarian
>> Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
> 
> ------------------------------------------------------------------------------
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
> is a gathering of tech-side developers & brand creativity professionals. Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, & 
> iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
> Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


