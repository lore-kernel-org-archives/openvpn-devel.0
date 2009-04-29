Message-ID: <49F7F1B0.9080600@...1032...>
Date: Wed, 29 Apr 2009 09:20:32 +0300
From: =?ISO-8859-1?Q?Siim_P=F5der?= <siim@...1032...>
MIME-Version: 1.0
References: <49F1B322.6030705@...1032...>	<1240630761l.7894l.0l@...1207...>	<49F34D62.4000302@...1114...>	<m3zle2cwmx.fsf@...1176...>	<1240846947l.13043l.1l@...1207...>	<49F6FA03.6070608@...1032...>
	<1240944303l.12737l.0l@...1207...> <49F75BBB.6000601@...1032...>
	<49F78D72.3030104@...1114...>
In-Reply-To: <49F78D72.3030104@...1114...>
Subject: Re: [Openvpn-devel] linux openvpn development job
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net, Benny Amorsen <benny+usenet@...1175...>

Hi

David Sommerseth wrote:
> The HW accelerator will not have that extreme processing power as an HSM,
> but as they are working on the same internal bus as the rest of the
> hardware and closer to the encryption/decryption needing software, it can
> transfer smaller packages much more quickly and process smaller packages
> quicker than an HSM.  I believe many of the accelerators also supports
> DMA, which practically gives it instant access to the user memory region
> where the payload is stored, without giving the CPU too much extra work.

Are you sure crypto accelerators allow DMA from user memory? I don't
know for sure either, but I would suspect that they would work like any
other device: copy to kernel, DMA to device, DMA back to kernel, copy to
user.

Siim

