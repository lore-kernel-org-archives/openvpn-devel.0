Message-ID: <73098c08-e805-4911-b567-74c567856ffd@...2181...>
Date: Wed, 3 Jan 2024 09:41:08 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <_JwMhmIl97rEu0p4ikaDALvq5eHIkmqMGLjeh7XhvqYSiD5p5NlxvWlieMFuc8R83p1uJ64FRLUeh6Ds5vDGvAnfg7p1OEYLyxPRn0dQy_Q=@proton.me>
 <745a4197-9d4c-43f1-a60c-3fb7af17bcbc@...2181...>
 <mT-aMlECumRjbVW6vrwomRSM33ZS8zWjViqNe6KFfgOi5oBUMzQzaqZbDJKHDEFEodUTZAp-F8UuNyMIvCV_4rkLpN5rRoxqrMmzD9XhcPY=@proton.me>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <mT-aMlECumRjbVW6vrwomRSM33ZS8zWjViqNe6KFfgOi5oBUMzQzaqZbDJKHDEFEodUTZAp-F8UuNyMIvCV_4rkLpN5rRoxqrMmzD9XhcPY=@proton.me>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN and outside clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Peter Davis <peter.davis1990@...2783...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 03/01/2024 09:14, Peter Davis wrote:
> Hello,
> I changed the IP address in the client configuration file, but I can't connect to the server. I got the following error:
> 
> Wed Jan  3 10:32:32 2024 TLS Error: TLS key negotiation failed to occur within 60 seconds (check your network connectivity)
> Wed Jan  3 10:32:32 2024 TLS Error: TLS handshake failed
> 
> I checked the OpenVPN log file too, but there was nothing there:
> # cat /var/log/openvpn/openvpn.log

This is a clear indication that your connection attempt is not reaching 
the VPN server at all.

This is a problem with whatever is in the middle, i.e. gateway/firewall.

* Have you properly configured the port forwarding on the gateway/firewall?
* Have you allowed the right ports on the gateway/firewall?
* Is there any firewall on the VPN server which may be preventing 
connections from outside the LAN?

Note: this is unrelated to OpenVPN, but just a generic network 
configuration issue.

Regards,

-- 
Antonio Quartulli

