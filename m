Message-ID: <5628F3C8.9040808@...1147...>
Date: Thu, 22 Oct 2015 16:33:44 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1445519360-24866-1-git-send-email-lstipakov@...277...>	<20151022132635.GF22054@...1296...>	<1445521155.4113.71.camel@...1866...>	<CA+UdHn9f9reNrCCdtw8+Ei2KZ9_2beDPCL9Vb-JGs2jJ5nnrXw@...278...>	<20151022135158.GG22054@...1296...>	<1445522144.4113.79.camel@...1866...>	<20151022135935.GH22054@...1296...>	<1445522997.4113.84.camel@...1866...>	<20151022141709.GI22054@...1296...>
	<1445523893.4113.92.camel@...1866...>
In-Reply-To: <1445523893.4113.92.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@...1866...>, Gert Doering <gert@...1296...>
Cc: Martin Pauly <pauly@...2079...>, =?windows-1252?Q?Olli_M=E4?=, openvpn-devel@lists.sourceforge.net, =?windows-1252?Q?nnist=F6?= <olmannisto@...277...>

Hi *,

On 22/10/15 16:24, David Woodhouse wrote:
> On Thu, 2015-10-22 at 16:17 +0200, Gert Doering wrote:
>> Hi,
>>
>> On Thu, Oct 22, 2015 at 03:09:57PM +0100, David Woodhouse wrote:
>>> So Olli and Lev would appear to be saying. For OpenConnect I
>>> haven't
>>> actually tested this hypothesis. Unfortunately I'd need to
>>> reimplement
>>> the get_adapter_index stuff under LGPL first...
>> Looking at our tun.c I wish I hadn't done that... but it seems that
>> using GetAdaptersinfo() should get you pretty far (which is what
>> get_adapter_index_method_2() uses under the hood)...
>>
>> But indeed, this direction seems to be non trivial...
> It's not *that* hard. But I need to properly *understand* the how to do
> it so that I can write my own version from scratch and make 100% sure
> I'm not committing any cut-and-paste crimes, even via eyes and fingers
> and keyboard.
>
> And that means I need to understand the logic behind the two different
> get_adapter_index_methods, which is notably absent from the 2005 commit
> message which added get_adapter_index_method_2().
>
> I don't understand why you're feeding get_adapter_index_method_1() a
> GUID prefixed with \DEVICE\TCPIP_ instead of a name, either, since the
> MSDN documentation for GetAdapterIndex() suggests that it takes the
> interface name. Hey, maybe that's why it didn't work and you had to
> invent a new method? Maybe I'm best not looking at your code at all :)
>
> But still, I'm not booting Windows today. Not for all the tea in China.
>
>
history, most likely. Before Vista the recommended way to develop and 
use a Windows driver was the TDI ( Transport Driver Interface).

Read e.g. http://codemachine.com/article_tdi.html for some details.

It might be worthwhile to investigate if we can safely drop all TDI 
stuff and use a more modern interface , but the again, if you read stuff 
like this (from the site listed):

"Starting with Windows Vista, Microsoft has made several attempts to 
remove the support for TDI drivers from the operating system. This would 
have resulted in all legacy TDI clients and TDI filters becoming 
non-functional on subsequent versions of Windows. Although industry 
pressure on Microsoft has prevented this from happening so far, it is 
bound to happen eventually. Since TDI is on the path of deprecation, the 
windows networking stack provides new technologies that replace TDI, 
which developers are encouraged to adopt. Drivers on Vista and later 
versions of Windows that need to implement TDI client functionality 
should use the Windows Socket Kernel (WSK) interface and drivers that 
need to implement TDI filtering functionality should use Windows 
Filtering Platform (WFP) interface.

Due to the re-architecture of the networking stack in Vista, TDI is no 
longer the interface that AFD.sys uses to communicate with TCPIP.sys. 
Instead, AFD.sys uses a new undocumented interface called Transport 
Layer Network Provider Interface (TLNPI) to communicate with TCPIP.sys. 
However, in order to support legacy TDI clients and TDI filters, 
Microsoft provides a new driver called TDX.sys, which internally use 
TLNPI to communicate with TCPIP.sys. It also creates all the device 
objects that TCPIP used to create, in order to maintain backward 
compatibility with legacy TDI drivers. The figure below shows the 
relationship between the components mentioned above on Vista and later 
versions of Windows. When Windows detects the presence of TDI filter in 
the system, all traffic between AFD.sys and TCPIP.sys is automatically 
routed through the TDX driver. The TDX driver makes use of the TDI API 
in TDI.sys and uses the Network Module Registrar (NMR) API in NETIO.sys 
to implement its functionality. TDX is supported on Vista, Server 2008 
and Windows 7. TDX handles TDI requests from legacy TDI drivers and maps 
them to TLNPI calls."

then I also no longer want to boot Windows anymore ;)

JJK


