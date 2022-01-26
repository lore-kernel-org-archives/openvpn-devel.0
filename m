Message-ID: <00064007-a592-772b-0cbd-20335323bd40@...1227...>
Date: Wed, 26 Jan 2022 17:29:50 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220126151128.5078-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220126151128.5078-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] crypto.c: remove (dead) OpenSSL
 specific code
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

Am 26.01.22 um 16:11 schrieb Antonio Quartulli:
> Originally we wanted to move this OpenSSL specific code to its own
> backend and use a proper abstraction in the crypto.c code.
> 
> However, tests have revealed that OpenVPN will never try to print a
> cipher that is not supported by FIPS (assuming FIPS is enabled), because
> along the chain of calls we already call cipher_get() which returns NULL
> for FIPS-disabled ciphers.
> 
> For this reason, we can just remove any FIPS specific code from
> print_cipher() and be done with it.
> 

Acked-By: Arne Schwabe <arne@...1227...>

