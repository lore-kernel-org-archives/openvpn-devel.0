Message-ID: <f3b7fa32-0e9c-f6e6-6079-5e942f50a600@...1227...>
Date: Mon, 14 Nov 2022 16:41:15 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <CAD3upLv_mr3DXJinqHdxPivkhdHWrBkpZ3xNjcNtHkzERGbCPw@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAD3upLv_mr3DXJinqHdxPivkhdHWrBkpZ3xNjcNtHkzERGbCPw@...278...>
Subject: Re: [Openvpn-devel] Do most commercial firewall appliances and VPN
 routers have OpenVPN-powered SSL VPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Turritopsis Dohrnii Teo En Ming <tdtemccnp@...277...>, openvpn-devel@lists.sourceforge.net
Cc: ceo@...2703...

Am 14.11.22 um 16:03 schrieb Turritopsis Dohrnii Teo En Ming:
> Subject: Do most commercial firewall appliances and VPN routers have 
> OpenVPN-powered SSL VPN?
> 
> Good day from Singapore,
> 
> On 10 Nov 2022, I saw the logs from Sophos XG210 Firewall SSL VPN client 
> for Windows. Below are a few lines from the logs.
> 
> 2022-11-10 14:10:03 WARNING: Compression for receiving enabled. 
> Compression has been used in the past to break encryption. Sent packets 
> are not compressed unless "allow-compression yes" is also set.
> 2022-11-10 14:10:03 DEPRECATED OPTION: --cipher set to 'AES-128-CBC' but 
> missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN 
> version will ignore --cipher for cipher negotiations. Add 'AES-128-CBC' 
> to --data-ciphers or change --cipher 'AES-128-CBC' to 
> --data-ciphers-fallback 'AES-128-CBC' to silence this warning.
> 2022-11-10 14:10:03 OpenVPN 2.5.6 Windows-MSVC [SSL (OpenSSL)] [LZO] 
> [LZ4] [PKCS11] [AEAD] built on Apr 22 2022
> 2022-11-10 14:10:03 Windows version 10.0 (Windows 10 or greater) 64bit
> 2022-11-10 14:10:03 library versions: OpenSSL 1.1.1n  15 Mar 2022, LZO 2.10
> 
> Without question, this goes to show that the SSL VPN Server in Sophos 
> XG210 firewall appliance is powered by OpenVPN.
> 
> Do most commercial firewall appliances and VPN routers have 
> OpenVPN-powered SSL VPN? Is there an official list?

This is the developers' mailing list and not for user question. And yes 
there are many commercial appliances that use OpenVPN but there is no 
official list and also OpenVPN Inc (the company) will probably not 
maintaining an official one as these products are competing with their 
own offerings.

If you are looking to support companies that contribute to the OpenVPN 
open source itself then Sophos did that in the past but does no longer 
(branch of that company that did that was closed) and quite recently 
netgate (pfsense) and of course OpenVPN Inc itself (sorry if I forgot 
somebody)

Arne


