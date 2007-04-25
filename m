Message-ID: <462F9873.5090605@...41...>
Date: Wed, 25 Apr 2007 12:05:39 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <462C562F.1050107@...41...>	<002501c78574$e1322950$0201a8c0@...1010...>	<462C802F.6090007@...41...>
	<99692811.20070423123916@...449...>
In-Reply-To: <99692811.20070423123916@...449...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?Q2Fyc3RlbiBLcsO8Z2Vy?= <C.Krueger@...448...>
Cc: Openvpn-devel@lists.sourceforge.net

Carsten Krüger wrote:
> Hello James,
>
>   
>> On Vista x64, my understanding is that the TAP driver
>> would need to be signed by Microsoft themselves.
>>     
>
> wrong
>
> Digital Signatures for Kernel Modules on x64-based Systems Running Windows Vista
> http://www.microsoft.com/whdc/system/platform/64bit/kmsigning.mspx
>
> How to Obtain a Software Publishing Certificate (64bitDriverSigning.doc)
>
> Use the following steps to obtain an SPC for signing your kernel-mode
> software that meets the mandatory kernel-mode code-signing policy:
> 1.      Obtain an SPC from a commercial CA that issues digital
>         certificates for signing kernel-mode code. The list of CAs who
>         provide SPCs (or code-signing certificates) that can be used
>         for kernel-mode code signing is available at the �Microsoft
>         Cross-certificates for Windows Vista Kernel Mode Code Signing�
>         Web page listed in �Resource� at the end of this paper.
>
>   

You know, you are absolutely right. The process for signing is rather 
convoluted, and after taking a second look at the procedure, I realized 
that I needed to manually add a specific intermediate certificate to 
complete the chain. Now everything works. The TAP driver loads and runs 
on Vista x64. Cool!

James


